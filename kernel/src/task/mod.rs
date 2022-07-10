use core::arch::global_asm;

use alloc::collections::VecDeque;
use alloc::slice;
use alloc::string::String;
use alloc::sync::Arc;
use alloc::vec::Vec;
use xmas_elf::program::Type;
use crate::elf::{self, ElfExtra};
use crate::fs::filetree::FileTreeNode;
use crate::interrupt::{Context, TICKS};

use crate::interrupt::timer::{NEXT_TICKS, TMS, LAST_TICKS};
use crate::memory::addr::{get_pages_num, get_buf_from_phys_page, get_buf_from_phys_addr};
use crate::memory::page::{alloc, alloc_more};
use crate::memory::page_table::PagingMode;
use crate::runtime_err::RuntimeError;
use crate::sync::mutex::Mutex;
use crate::{memory::{page_table::{PageMappingManager, PTEFlags}, addr::{PAGE_SIZE, VirtAddr, PhysAddr, PhysPageNum}, page::PAGE_ALLOCATOR}, fs::filetree::FILETREE};

use self::pipe::PipeBuf;
use self::stack::UserStack;
use self::task_queue::load_next_task;

pub mod pipe;
pub mod task_queue;
pub mod stack;

pub const STDIN: usize = 0;
pub const STDOUT: usize = 1;
pub const STDERR: usize = 2;

#[derive(Clone, Copy, PartialEq)]
// 任务状态
pub enum TaskStatus {
    READY   = 0,
    RUNNING = 1,
    PAUSE   = 2,
    STOP    = 3,
}

#[allow(dead_code)]
// 用户heap
pub struct UserHeap {
    start: PhysPageNum, 
    pointer: usize,
    size: usize
}

// 文件描述符类型
pub enum FileDescEnum {
    File(FileTreeNode),
    Pipe(PipeBuf),
    Device(String)
}

// 文件描述符
pub struct FileDesc {
    pub target: FileDescEnum,
    pub readable: bool,
    pub writable: bool
}

impl FileDesc {
    // 创建文件描述符
    pub fn new(target: FileDescEnum) -> Self {
        FileDesc {
            target,
            readable: true,
            writable: true
        }
    }

    // 创建pipe
    pub fn new_pipe() -> (Self, Self) {
        let buf = PipeBuf::new();
        let read_pipe = FileDesc {
            target: FileDescEnum::Pipe(buf.clone()),
            readable: true,
            writable: false
        };
        let write_pipe = FileDesc {
            target: FileDescEnum::Pipe(buf.clone()),
            readable: false,
            writable: true
        };
        (read_pipe, write_pipe)
    }
}

// PID生成器
pub struct PidGenerater(usize);

impl PidGenerater {
    // 创建进程id生成器
    pub fn new() -> Self {
        PidGenerater(1000)
    }
    // 切换到下一个pid
    pub fn next(&mut self) -> usize {
        let n = self.0;
        self.0 = n + 1;
        n
    }
}

extern "C" {
    // 改变任务
    fn change_task(pte: usize, stack: usize);
}

lazy_static! {
    // 任务管理器和pid生成器
    pub static ref TASK_CONTROLLER_MANAGER: Mutex<TaskControllerManager> = Mutex::new(TaskControllerManager::new());
    pub static ref NEXT_PID: Mutex<PidGenerater> = Mutex::new(PidGenerater::new());
}

// 任务控制器管理器
pub struct TaskControllerManager {
    current: Option<Arc<Mutex<TaskController>>>,        // 当前任务
    ready_queue: VecDeque<Arc<Mutex<TaskController>>>,  // 准备队列
    wait_queue: Vec<WaitQueueItem>,                     // 等待队列
    killed_queue: Vec<Arc<Mutex<TaskController>>>,      // 僵尸进程队列
    is_run: bool                                        // 任务运行标志
}

impl TaskControllerManager {
    // 创建任务管理器
    pub fn new() -> Self {
        TaskControllerManager {
            current: None,
            ready_queue: VecDeque::new(),
            wait_queue: vec![],
            killed_queue: vec![],
            is_run: false
        }
    }

    // 添加任务
    pub fn add(&mut self, task: TaskController) {
        if let Some(_) = self.current {
            self.ready_queue.push_back(Arc::new(Mutex::new(task)));
        } else {
            let task = Arc::new(Mutex::new(task));
            task.force_get().pmm.change_satp();
            self.current = Some(task);
        }
    }

    // 删除当前任务
    pub fn kill_current(&mut self) {
        let self_wrap = self.current.clone().unwrap();
        let self_task = self_wrap.force_get();
        let ppid = self_task.ppid;
        let pid = self_task.pid;
        // 如果当前任务的父进程不是内核 则考虑唤醒进程
        if ppid != 1 {
            // 子进程处理
            let mut wait_queue_index = -1 as isize as usize;
            // 判断是否在等待任务中存在
            for i in 0..self.wait_queue.len() {
                let x = self.wait_queue[i].clone();
                if x.task.force_get().pid == ppid && (x.wait == (-1 as isize as usize) || x.wait == pid) {
                    // 加入等待进程
                    let ready_task = x.task.clone();
                    ready_task.lock().context.x[10] = self_task.pid;
                    unsafe {x.callback.write((self_task.context.x[10] << 8) as u16)};
                    self.ready_queue.push_back(ready_task);
                    wait_queue_index = i;
                    break;
                }
            }
            // 如果存在移出 不存在则加入killed_queue
            if wait_queue_index == -1 as isize as usize {
                self.killed_queue.push(self_wrap.clone())
            } else {
                self.wait_queue.remove(wait_queue_index);
            }
        } else {
            // 如果是父进程是内核  则清空相关进程树
        }
        self.current = None;
    }

    // 切换到下一个任务
    pub fn switch_to_next(&mut self) {
        if let Some(current_task) = self.current.clone() {
            current_task.force_get().update_status(TaskStatus::READY);
            self.current = None;
            self.ready_queue.push_back(current_task);
        }
        if let Some(next_task) = self.ready_queue.pop_front() {
            next_task.force_get().update_status(TaskStatus::RUNNING);
            next_task.force_get().pmm.change_satp();
            self.current = Some(next_task.clone());
        } else {
            // 当无任务时加载下一个任务
            load_next_task();
            // panic!("无任务");
        }
    }

    // 获取当前的进程
    pub fn get_current_processor(&self) -> Option<Arc<Mutex<TaskController>>> {
        self.current.clone()
    }

    // 当前进程等待运行
    pub fn wait_pid(&mut self, callback: *mut u16,pid: usize) {
        // 将 当前任务加入等待队列
        let task = self.current.clone().unwrap();
        // 判断killed_queue中是否存在任务
        let mut killed_index = -1 as isize as usize;
        for i in 0..self.killed_queue.len() {
            let ctask = self.killed_queue[i].force_get();
            if ctask.ppid == task.lock().pid && (pid == -1 as isize as usize || ctask.pid == pid) {
                killed_index = i;
                break;
            }
        }
        // 如果没有任务 则加入wait list
        if killed_index == -1 as isize as usize {
            let wait_item = WaitQueueItem::new(task.clone(), callback, pid);
            self.wait_queue.push(wait_item);
            // 清除当前任务
            self.current = None;
            self.switch_to_next();
        } else {
            // 从killed列表中获取任务
            let killed_task_wrap = self.killed_queue[killed_index].clone();
            let killed_task = killed_task_wrap.lock();
            self.killed_queue.remove(killed_index);
            
            unsafe {callback.write((killed_task.context.x[10] << 8) as u16)};
            task.lock().context.x[10] = killed_task.pid;
        }
    }

    // 开始运行任务
    pub fn run(&mut self) {
        unsafe {
            LAST_TICKS = TICKS;
        }
        loop {
            if let Some(current_task) = self.current.clone() {
                self.is_run = true;
                current_task.force_get().run_current();
                break;
            } else {
                // 当无任务时加载下一个任务
                load_next_task();
            }
        }
    }
}

impl UserHeap {
    // 创建heap
    pub fn new() -> Result<Self, RuntimeError> {
        let phy_start = PAGE_ALLOCATOR.lock().alloc()?;
        // 申请页表作为heap
        Ok(UserHeap {
            start: phy_start,
            pointer: 0,
            size: PAGE_SIZE
        })
    }

    // 获取堆开始的地址
    pub fn get_addr(&self) -> PhysAddr {
        self.start.into()
    }
}

#[derive(Clone)]
// 等待队列
pub struct WaitQueueItem {
    pub task: Arc<Mutex<TaskController>>,
    pub callback: *mut u16,
    pub wait: usize
}

impl WaitQueueItem {
    // 创建等待队列项
    pub fn new(task: Arc<Mutex<TaskController>>, callback: *mut u16,wait: usize) -> Self {
        WaitQueueItem {
            task,
            callback,
            wait
        }
    }
}

#[allow(dead_code)]
// 任务控制器
pub struct TaskController {
    pub pid: usize,                                     // 进程id
    pub ppid: usize,                                    // 父进程id
    pub entry_point: VirtAddr,                          // 入口地址
    pub pmm: PageMappingManager,                        // 页表映射控制器
    pub status: TaskStatus,                             // 任务状态
    pub stack: UserStack,                               // 栈地址
    pub heap: UserHeap,                                 // 堆地址
    pub context: Context,                               // 寄存器上下文
    pub home_dir: FileTreeNode,                         // 家地址
    pub fd_table: Vec<Option<Arc<Mutex<FileDesc>>>>,    // 任务描述符地址
    pub tms: TMS                                        // 时间地址
}

impl TaskController {
    // 创建任务控制器
    pub fn new(pid: usize) -> Result<Self, RuntimeError> {
        let pmm = PageMappingManager::new();
        let heap = UserHeap::new()?;
        let pte = pmm.clone().pte;
        let mut task = TaskController {
            pid,
            ppid: 1,
            entry_point: 0usize.into(),
            pmm,
            status: TaskStatus::READY,
            heap,
            stack: UserStack::new(pte),
            home_dir: FILETREE.force_get().open("/")?.clone(),
            context: Context::new(),
            fd_table: vec![
                Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::Device(String::from("STDIN")))))),
                Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::Device(String::from("STDOUT")))))),
                Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::Device(String::from("STDERR"))))))
            ],
            tms: TMS::new()
        };
        task.pmm.init_pte();
        Ok(task)
    }

    // 更新用户状态
    pub fn update_status(&mut self, status: TaskStatus) {
        self.status = status;
    }

    pub fn set_entry_point(&mut self, entry_point: usize) {
        self.context.sepc = entry_point;
    }

    // 申请堆地址
    pub fn alloc_heap(&mut self, size: usize) -> usize {
        let top = self.heap.pointer;
        self.heap.pointer = top + size;
        top
    }

    // 设置堆顶地址
    pub fn set_heap_top(&mut self, top: usize) -> usize {
        let origin_top = self.heap.pointer;
        self.heap.pointer = top;
        origin_top
    }

    // 获取heap大小
    pub fn get_heap_size(&self) -> usize {
        self.heap.pointer
    }

    // 申请文件描述符
    pub fn alloc_fd(&mut self) -> usize {
        if let Some(fd) = (0..self.fd_table.len()).find(|fd| self.fd_table[*fd].is_none()) {
            fd
        } else {
            self.fd_table.push(None);
            self.fd_table.len() - 1
        }
    }

    // 申请固定大小的文件描述符
    pub fn alloc_fd_with_size(&mut self, new_size: usize) -> usize {
        if self.fd_table.len() > new_size {
            if self.fd_table[new_size].is_none() {
                new_size
            } else {
                -1 as isize as usize
            }
        } else {
            let alloc_size = new_size + 1 - self.fd_table.len();
            for _ in 0..alloc_size {
                self.fd_table.push(None);
            }
            new_size
        }
    }

    // 运行当前任务
    pub fn run_current(&mut self) {
        // 切换satp
        self.pmm.change_satp();

        // 切换为运行状态
        self.status = TaskStatus::RUNNING;
        
        // 恢复自身状态
        unsafe { change_task((PagingMode::Sv39 as usize) << 60 | usize::from(PhysPageNum::from(PhysAddr::from(self.pmm.get_pte()))), &self.context as *const Context as usize) };
    }
}

// 获取pid
pub fn get_new_pid() -> usize {
    NEXT_PID.lock().next()
}

// 执行一个程序 path: 文件名 思路：加入程序准备池  等待执行  每过一个时钟周期就执行一次
// TODO: 更新exec 添加envp 和 auxiliary vector
pub fn exec(path: &str) -> Result<(), RuntimeError> {
    // 如果存在write
    let program = FILETREE.lock().open(path)?;

    // 读取文件到内存
    // 申请页表存储程序
    let elf_pages = get_pages_num(program.get_file_size());

    // 申请页表
    let elf_phy_start = alloc_more(elf_pages)?;

    // 获取缓冲区地址并读取
    let buf = get_buf_from_phys_page(elf_phy_start, elf_pages);
    program.read_to(buf);

    // 读取elf信息
    let elf = xmas_elf::ElfFile::new(buf).unwrap();
    let elf_header = elf.header;    
    let magic = elf_header.pt1.magic;

    let entry_point = elf.header.pt2.entry_point() as usize;
    assert_eq!(magic, [0x7f, 0x45, 0x4c, 0x46], "invalid elf!");

    // 获取文件大小
    let stack_num_index = alloc()?;
    
    // 创建新的任务控制器 并映射栈
    let mut task_controller = TaskController::new(get_new_pid())?;
    let stack_addr = PhysAddr::from(stack_num_index);
    task_controller.pmm.add_mapping(stack_addr, 0xf0000000usize.into(), PTEFlags::VRWX | PTEFlags::U)?;
    task_controller.set_entry_point(entry_point);     // 设置入口地址
    
    // 设置内存管理器
    let pmm = &mut task_controller.pmm;

    // 重新映射内存 并设置头
    let ph_count = elf_header.pt2.ph_count();
    for i in 0..ph_count {
        let ph = elf.program_header(i).unwrap();
        if ph.get_type().unwrap() == xmas_elf::program::Type::Load {
            let start_va: VirtAddr = ph.virtual_addr().into();
            let alloc_pages = get_pages_num(ph.mem_size() as usize);
            let phy_start = alloc_more(alloc_pages)?;

            let offset = ph.offset() as usize;
            let read_size = ph.file_size() as usize;
            info!("读取大小 read_size: {}", read_size);
            let temp_buf = get_buf_from_phys_page(phy_start, alloc_pages);

            let vr_start = ph.virtual_addr() as usize % 0x1000;
            let vr_end = vr_start + read_size;
            temp_buf[vr_start..vr_end].copy_from_slice(&buf[offset..offset+read_size]);

            pmm.add_mapping_range(PhysAddr::from(phy_start) + PhysAddr::from(ph.offset()), 
                start_va, ph.mem_size() as usize, PTEFlags::VRWX | PTEFlags::U)?;

            // read flags
            // let ph_flags = ph.flags();
            // ph_flags.is_read() readable
            // ph_flags.is_write() writeable
            // ph_flags.is_execute() executeable
        }
        
    }

    // 添加参数
    let stack = &mut task_controller.stack;
    let platform_ptr = stack.push_str("alexbd");
    let exec_ptr = stack.push_str("riscv");
    
    info!("elf header: {:#x?}", elf_header.pt2);

    // auxv top
    stack.push(0);
    
    stack.push(platform_ptr);
    stack.push(elf::AT_PLATFORM);

    stack.push(exec_ptr);
    stack.push(elf::AT_EXECFN);

    stack.push(elf_header.pt2.ph_count() as usize);
    stack.push(elf::AT_PHNUM);

    stack.push(PAGE_SIZE);
    stack.push(elf::AT_PAGESZ);

    stack.push(entry_point);
    stack.push(elf::AT_ENTRY);

    stack.push(elf_header.pt2.ph_entry_size() as usize);
    stack.push(elf::AT_PHENT);

    // 读取phdr
    let mut ph_addr = 0;
    if let Some(phdr) = elf.program_iter()
            .find(|ph| ph.get_type() == Ok(Type::Phdr))
    {
        // if phdr exists in program header, use it
        ph_addr = phdr.virtual_addr();
    } else if let Some(elf_addr) = elf
        .program_iter()
        .find(|ph| ph.get_type() == Ok(Type::Load) && ph.offset() == 0)
    {
        // otherwise, check if elf is loaded from the beginning, then phdr can be inferred.
        ph_addr = elf_addr.virtual_addr() + elf.header.pt2.ph_offset();
    } else {
        warn!("elf: no phdr found, tls might not work");
        return Err(RuntimeError::NoMatchedAddr);
    };
    info!("ph_addr {:#x}", ph_addr);
    stack.push(ph_addr as usize);
    stack.push(elf::AT_PHDR);

    // envp top
    stack.push(0);

    // argv top
    stack.push(0);

    // args
    stack.push(0);
    stack.push(1);
    
    // 设置sp top
    task_controller.context.x[2] =task_controller.stack.get_stack_top();

    // 映射堆
    pmm.add_mapping(task_controller.heap.get_addr(), 0xf0010000usize.into(), PTEFlags::VRWX | PTEFlags::U)?;

    // 释放读取的文件
    PAGE_ALLOCATOR.lock().dealloc_more(elf_phy_start, elf_pages);

    // 任务管理器添加任务
    TASK_CONTROLLER_MANAGER.lock().add(task_controller);
    Ok(())
}

// 等待当前任务并切换到下一个任务
pub fn suspend_and_run_next() {
    if !TASK_CONTROLLER_MANAGER.force_get().is_run {
        return;
    }
    // 刷新下一个调度的时间
    NEXT_TICKS.force_get().refresh();
    TASK_CONTROLLER_MANAGER.force_get().switch_to_next();
}

// 运行第一个任务
pub fn run_first() {
    TASK_CONTROLLER_MANAGER.force_get().run();
}

// 获取当前任务
pub fn get_current_task() ->Option<Arc<Mutex<TaskController>>> {
    TASK_CONTROLLER_MANAGER.force_get().current.clone()
}

// 等待任务
pub fn wait_task(pid: usize, status: *mut u16, _options: usize) {
    TASK_CONTROLLER_MANAGER.force_get().wait_pid(status, pid );
    // TASK_CONTROLLER_MANAGER.force_get().switch_to_next();
}

// 杀死当前任务
pub fn kill_current_task() {
    TASK_CONTROLLER_MANAGER.force_get().kill_current();
    TASK_CONTROLLER_MANAGER.force_get().switch_to_next();
}

// clone任务
pub fn clone_task(task_controller: &mut TaskController) -> Result<TaskController, RuntimeError> {
    // 创建任务并复制文件信息
    let mut task = TaskController::new(get_new_pid())?;
    let mut pmm = task.pmm.clone();

    // 设置任务信息
    task.context.clone_from(&mut task_controller.context);
    task.entry_point = task_controller.entry_point;
    task.ppid = task_controller.pid;
    task.fd_table = task_controller.fd_table.clone();

    // 获取任务对应地址和栈对应地址
    let start_addr: PhysAddr = task_controller.pmm.get_phys_addr(0x0usize.into()).unwrap();
    let stack_addr: PhysAddr = task_controller.pmm.get_phys_addr(0xf0000000usize.into()).unwrap();

    // 获取任务占用的页表数量
    let pages = (usize::from(stack_addr) - usize::from(start_addr)) / PAGE_SIZE;
    
    // 申请页表
    let phy_start = PAGE_ALLOCATOR.force_get().alloc_more(pages + 1)?;

    // 复制任务信息
    let new_buf = unsafe { slice::from_raw_parts_mut(usize::from(PhysAddr::from(phy_start)) as *mut u8,(pages + 1) * PAGE_SIZE) };
    let old_buf = unsafe { slice::from_raw_parts_mut(usize::from(PhysAddr::from(start_addr)) as *mut u8, (pages + 1) * PAGE_SIZE) };
    new_buf.copy_from_slice(old_buf);

    for i in 0..pages {
        pmm.add_mapping(PhysAddr::from(PhysPageNum::from(usize::from(phy_start) + i)), 
            VirtAddr::from(i*0x1000), PTEFlags::VRWX | PTEFlags::U)?;
    }

    // 映射栈 
    pmm.add_mapping(PhysAddr::from(PhysPageNum::from(usize::from(phy_start) + pages)), 
    0xf0000000usize.into(), PTEFlags::VRWX | PTEFlags::U)?;

    // 映射堆
    pmm.add_mapping(task_controller.heap.get_addr(), 0xf0010000usize.into(), PTEFlags::VRWX | PTEFlags::U)?;
    Ok(task)
}


// 包含更换任务代码
global_asm!(include_str!("change_task.asm"));

// 初始化多任务系统
pub fn init() {
    info!("多任务初始化");
    run_first();
}
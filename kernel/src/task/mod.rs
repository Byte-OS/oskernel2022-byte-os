use core::{slice::from_raw_parts_mut, arch::global_asm};

use alloc::collections::VecDeque;
use alloc::slice;
use alloc::string::String;
use alloc::sync::Arc;
use alloc::vec::Vec;
use crate::fs::filetree::FileTreeNode;
use crate::interrupt::{Context, TICKS};

use crate::interrupt::timer::{NEXT_TICKS, TMS, LAST_TICKS};
use crate::memory::page_table::PagingMode;
use crate::sync::mutex::Mutex;
use crate::{memory::{page_table::{PageMappingManager, PTEFlags}, addr::{PAGE_SIZE, VirtAddr, PhysAddr, PhysPageNum}, page::PAGE_ALLOCATOR}, fs::filetree::FILETREE};

use self::pipe::PipeBuf;
use self::task_queue::load_next_task;

pub mod pipe;
pub mod task_queue;

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
    pub fn new() -> Self {
        // 申请页表作为heap
        if let Some(phy_start) = PAGE_ALLOCATOR.lock().alloc() { 
            UserHeap {
                start: phy_start,
                pointer: 0,
                size: PAGE_SIZE
            }
        } else {
            UserHeap {
                start: PhysPageNum::from(0),
                pointer: 0,
                size: PAGE_SIZE
            }
        }
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
    pub stack: VirtAddr,                                // 栈地址
    pub heap: UserHeap,                                 // 堆地址
    pub context: Context,                               // 寄存器上下文
    pub home_dir: FileTreeNode,                         // 家地址
    pub fd_table: Vec<Option<Arc<Mutex<FileDesc>>>>,    // 任务描述符地址
    pub tms: TMS                                        // 时间地址
}

impl TaskController {
    // 创建任务控制器
    pub fn new(pid: usize) -> Self {
        let mut task = TaskController {
            pid,
            ppid: 1,
            entry_point: VirtAddr::from(0),
            pmm: PageMappingManager::new(),
            status: TaskStatus::READY,
            heap: UserHeap::new(),
            stack: VirtAddr::from(0),
            home_dir: FILETREE.force_get().open("/").unwrap().clone(),
            context: Context::new(),
            fd_table: vec![
                Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::Device(String::from("STDIN")))))),
                Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::Device(String::from("STDOUT")))))),
                Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::Device(String::from("STDERR"))))))
            ],
            tms: TMS::new()
        };
        task.pmm.init_pte();
        task
    }

    // 更新用户状态
    pub fn update_status(&mut self, status: TaskStatus) {
        self.status = status;
    }

    // 初始化任务
    pub fn init(&mut self) {
        self.context.sepc = 0x1000;
        self.context.x[2] = 0xf0000fe0;
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
pub fn exec(path: &str) {
    // 如果存在write
    if let Ok(program) = FILETREE.lock().open(path) {
        let mut task_controller = TaskController::new(get_new_pid());
        // 初始化项目
        task_controller.init();

        // 申请页表存储程序 申请多一页作为栈
        let pages = (program.get_file_size() - 1 + PAGE_SIZE) / PAGE_SIZE;
        if let Some(phy_start) = PAGE_ALLOCATOR.lock().alloc_more(pages + 1) {
            unsafe {
                PAGE_ALLOCATOR.force_unlock()
            };
            // 获取缓冲区地址并读取
            let buf = unsafe {
                from_raw_parts_mut(usize::from(phy_start.to_addr()) as *mut u8, pages*PAGE_SIZE)
            };
            program.read_to(buf);
            
            let pmm = &mut task_controller.pmm;

            for i in 0..pages {
                pmm.add_mapping(PhysAddr::from(PhysPageNum::from(usize::from(phy_start) + i)), 
                    VirtAddr::from(i*0x1000), PTEFlags::VRWX | PTEFlags::U);
            }

            let stack_addr = PhysAddr::from(PhysPageNum::from(usize::from(phy_start) + pages));

            // 添加参数
            let argc_ptr = (usize::from(stack_addr) + 0xff0) as *mut usize;
            unsafe {
                argc_ptr.write(0);
                argc_ptr.add(1).write(0);
            };

            // 映射栈 
            pmm.add_mapping(stack_addr, VirtAddr::from(0xf0000000), PTEFlags::VRWX | PTEFlags::U);

            // 映射堆
            pmm.add_mapping(task_controller.heap.get_addr(), VirtAddr::from(0xf0010000), PTEFlags::VRWX | PTEFlags::U);
        }
        TASK_CONTROLLER_MANAGER.lock().add(task_controller);

    } else {
        info!("未找到文件!");
    }
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
pub fn clone_task(task_controller: &mut TaskController) -> TaskController {
    // 创建任务并复制文件信息
    let mut task = TaskController::new(get_new_pid());
    let mut pmm = task.pmm.clone();
    task.context.clone_from(&mut task_controller.context);
    task.entry_point = task_controller.entry_point;
    task.ppid = task_controller.pid;
    task.fd_table = task_controller.fd_table.clone();

    let start_addr: PhysAddr = task_controller.pmm.get_phys_addr(VirtAddr::from(0x0)).unwrap();
    let stack_addr: PhysAddr = task_controller.pmm.get_phys_addr(VirtAddr::from(0xf0000000)).unwrap();

    // 获取任务占用的页表数量
    let pages = (usize::from(stack_addr) - usize::from(start_addr)) / PAGE_SIZE;
    
    // 申请页表
    if let Some(phy_start) = PAGE_ALLOCATOR.force_get().alloc_more(pages + 1) {
        // 复制任务信息
        let new_buf = unsafe { slice::from_raw_parts_mut(usize::from(PhysAddr::from(phy_start)) as *mut u8,(pages + 1) * PAGE_SIZE) };
        let old_buf = unsafe { slice::from_raw_parts_mut(usize::from(PhysAddr::from(start_addr)) as *mut u8, (pages + 1) * PAGE_SIZE) };
        new_buf.copy_from_slice(old_buf);

        for i in 0..pages {
            pmm.add_mapping(PhysAddr::from(PhysPageNum::from(usize::from(phy_start) + i)), 
                VirtAddr::from(i*0x1000), PTEFlags::VRWX | PTEFlags::U);
        }

        // 映射栈 
        pmm.add_mapping(PhysAddr::from(PhysPageNum::from(usize::from(phy_start) + pages)), 
                VirtAddr::from(0xf0000000), PTEFlags::VRWX | PTEFlags::U);

        // 映射堆
        pmm.add_mapping(task_controller.heap.get_addr(), VirtAddr::from(0xf0010000), PTEFlags::VRWX | PTEFlags::U);
    }
    task
}


// 包含更换任务代码
global_asm!(include_str!("change_task.asm"));

// 初始化多任务系统
pub fn init() {
    info!("多任务初始化");
    // exec("brk");
    // exec("write");
    run_first();
}
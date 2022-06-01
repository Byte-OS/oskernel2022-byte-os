use core::borrow::BorrowMut;
use core::cell::{RefCell, Ref};
use core::panic;
use core::{slice::from_raw_parts_mut, arch::global_asm};

use alloc::collections::VecDeque;
use alloc::sync::Arc;
use alloc::vec::Vec;
use crate::interrupt::Context;

use crate::sync::mutex::Mutex;
use crate::{memory::{page_table::{PageMappingManager, PTEFlags}, addr::{PAGE_SIZE, VirtAddr, PhysAddr, PhysPageNum}, page::PAGE_ALLOCATOR}, fs::filetree::FILETREE};

pub const STDIN: usize = 0;
pub const STDOUT: usize = 1;
pub const STDERR: usize = 2;

#[derive(Clone, Copy, PartialEq)]
pub enum TaskStatus {
    READY   = 0,
    RUNNING = 1,
    PAUSE   = 2,
    STOP    = 3,
}

pub struct UserHeap {
    start: PhysPageNum, 
    pointer: usize,
    size: usize
}

extern "C" {
    fn change_task(pte: usize, stack: usize);
}

lazy_static! {
    pub static ref TASK_CONTROLLER_MANAGER: Mutex<TaskControllerManager> = Mutex::new(TaskControllerManager::new());
}

pub struct TaskControllerManager {
    current: Option<Arc<Mutex<TaskController>>>,
    ready_queue: VecDeque<Arc<Mutex<TaskController>>>,
    is_run: bool
}

impl TaskControllerManager {
    pub fn new() -> Self {
        TaskControllerManager {
            current: None,
            ready_queue: VecDeque::new(),
            is_run: false
        }
    }

    // 添加任务
    pub fn add(&mut self, task: TaskController) {
        if let Some(_) = self.current {
            self.ready_queue.push_back(Arc::new(Mutex::new(task)));
        } else {
            self.current = Some(Arc::new(Mutex::new(task)));
        }
    }

    // 切换到下一个任务
    pub fn switch_to_next(&mut self) {
        if let Some(current_task) = self.current.clone() {
            current_task.lock().update_status(TaskStatus::READY);
            self.current = None;
            self.ready_queue.push_back(current_task);
        }
        if let Some(next_task) = self.ready_queue.pop_front() {
            next_task.force_get().update_status(TaskStatus::RUNNING);
            self.current = Some(next_task.clone());
            // 运行任务
            next_task.force_get().run_current();
        } else {
            panic!("当前无任务");
        }
    }

    // 获取当前的进程
    pub fn get_current_processor(&self) -> Option<Arc<Mutex<TaskController>>> {
        self.current.clone()
    }

    // 开始运行任务
    pub fn run(&mut self) {
        self.is_run = true;
        if let Some(current_task) = self.current.clone() {
            current_task.force_get().run_current();
        } else {
            panic!("无任务可执行");
        }
    }
}

impl UserHeap {
    pub fn new() -> Self {
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

#[allow(dead_code)]
pub struct TaskController {
    pid: usize,
    entry_point: VirtAddr,
    pmm: PageMappingManager,
    status: TaskStatus,
    stack: VirtAddr,
    heap: UserHeap,
    context: Context,
    pipline: Vec<usize>
}

impl TaskController {
    pub fn new(pid: usize) -> Self {
        TaskController {
            pid,
            entry_point: VirtAddr::from(0),
            pmm: PageMappingManager::new(),
            status: TaskStatus::READY,
            heap: UserHeap::new(),
            stack: VirtAddr::from(0),
            context: Context::new(),
            pipline: vec![
                STDIN,
                STDOUT,
                STDERR
            ]
        }
    }

    pub fn update_status(&mut self, status: TaskStatus) {
        self.status = status;
    }

    pub fn init(&mut self) {
        self.context.sepc = 0x1000;
        self.context.x[2] = 0xf0000ff0;
    }

    pub fn run_current(&mut self) {
        // 切换satp
        self.pmm.change_satp();
        // 切换为运行状态
        self.status = TaskStatus::RUNNING;
        // 恢复自身状态
        unsafe { change_task(self.pmm.get_pte(), &self.context as *const Context as usize) };
    }
}

pub fn get_new_pid() -> usize {
    1
}

// 执行一个程序 path: 文件名 思路：加入程序准备池  等待执行  每过一个时钟周期就执行一次
pub fn exec(path: &str) {
    // 如果存在write
    if let Ok(program) = FILETREE.lock().open(path) {
        let mut task_controller = TaskController::new(get_new_pid());
        // 初始化项目
        task_controller.init();

        // 读取文件信息
        let program = program.to_file();
        // 申请页表存储程序 申请多一页作为栈
        let pages = (program.size - 1 + PAGE_SIZE) / PAGE_SIZE;
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

            pmm.init_pte();

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
        TASK_CONTROLLER_MANAGER.lock().add(task_controller);

    } else {
        info!("未找到文件!");
    }
}

pub fn suspend_and_run_next(current_context: &mut Context) {
    if !TASK_CONTROLLER_MANAGER.force_get().is_run {
        return;
    }
    TASK_CONTROLLER_MANAGER.force_get().get_current_processor().unwrap().lock().context.clone_from(current_context);
    TASK_CONTROLLER_MANAGER.force_get().switch_to_next();
}

pub fn run_first() {
    TASK_CONTROLLER_MANAGER.force_get().run();
}

pub fn get_current_task() ->Option<Arc<Mutex<TaskController>>> {
    TASK_CONTROLLER_MANAGER.force_get().current.clone()
}

pub fn kill_current_task() {
    TASK_CONTROLLER_MANAGER.force_get().current = None;
    TASK_CONTROLLER_MANAGER.force_get().switch_to_next();
}

// 包含更换任务代码
global_asm!(include_str!("change_task.asm"));

// 初始化多任务系统
pub fn init() {
    info!("多任务初始化");
    exec("brk");
    exec("write");
    run_first();
}
use core::{slice::from_raw_parts_mut, arch::global_asm};

use alloc::vec::Vec;
use riscv::paging::PTE;
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

pub struct TaskControllerManager(Vec<TaskController>);

impl TaskControllerManager {
    pub fn new() -> Self {
        TaskControllerManager(vec![])
    }

    pub fn add(&mut self, task: TaskController) {
        self.0.push(task);
    }

    pub fn switch_to_next(&mut self) {
        let mut i = 0;
        let mut is_get_run = false;
        loop {
            if is_get_run {
                // 切换为运行状态
                if self.0[i].status == TaskStatus::READY {
                    self.0[i].status = TaskStatus::RUNNING;
                }
            } else {
                // 切换当前状态为准备运行
                if self.0[i].status == TaskStatus::RUNNING {
                    self.0[i].status = TaskStatus::READY;
                    is_get_run = true;
                }
            }
            // 作为循环切换到下一个
            i=(i+1)%self.0.len();
        }
    }

    // 获取当前的进程
    pub fn get_current_processor(&self) -> &mut TaskController {
        let mut tcm = TASK_CONTROLLER_MANAGER.lock().0.as_mut();
        for i in tcm {
            if i.status == TaskStatus::RUNNING {
                return i;
            }
        }
        &mut TASK_CONTROLLER_MANAGER.lock().0[0]
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

    pub fn run_current(&mut self) {
        // 切换satp
        self.pmm.change_satp();
        // 切换为运行状态
        self.status = TaskStatus::RUNNING;
        // 恢复自身状态
        unsafe { change_task(self.pmm.get_pte(), 0xf0000ff0) };
    }
}

pub fn get_new_pid() -> usize {
    1
}

// 执行一个程序 path: 文件名
pub fn exec(path: &str) {
    // 如果存在write
    if let Ok(program) = FILETREE.lock().open("write") {
        let mut task_controller = TaskController::new(get_new_pid());
        
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
            // 打印内存
            // for i in (0..0x200).step_by(16) {
            //     info!("{:#05x}  {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x}", 
            //     i, buf[i], buf[i+1],buf[i+2], buf[i+3],buf[i+4], buf[i+5],buf[i+6], buf[i+7], 
            //     buf[i+8], buf[i+9],buf[i+10], buf[i+11],buf[i+12], buf[i+13],buf[i+14], buf[i+15]);
            // }
        }
        TASK_CONTROLLER_MANAGER.lock().add(task_controller);
    } else {
        info!("未找到文件!");
    }
}

pub fn suspend_and_run_next() {
    
}

// 包含更换任务代码
global_asm!(include_str!("change_task.asm"));

// 初始化多任务系统
pub fn init() {
    info!("多任务初始化");
    exec("write");
}
use core::{slice::{from_raw_parts_mut, self}, arch::{global_asm, asm}, mem::size_of};

use alloc::vec::Vec;
use crate::interrupt::Context;

use crate::{memory::{page_table::{PageMappingManager, PTEFlags, KERNEL_PAGE_MAPPING, refresh_addr}, addr::{PAGE_SIZE, VirtAddr, PhysAddr, PhysPageNum}, page::PAGE_ALLOCATOR}, fs::filetree::FILETREE};

pub const STDIN: usize = 0;
pub const STDOUT: usize = 1;
pub const STDERR: usize = 2;

#[derive(Clone, Copy)]
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
}

struct TaskController {
    pid: usize,
    pmm: PageMappingManager,
    status: TaskStatus,
    heap: UserHeap,
    context: Context,
    pipline: Vec<usize>
}

impl TaskController {
    pub fn new(pid: usize) -> Self {
        TaskController {
            pid,
            pmm: PageMappingManager::new(),
            status: TaskStatus::READY,
            heap: UserHeap::new(),
            context: Context::new(),
            pipline: vec![
                STDIN,
                STDOUT,
                STDERR
            ]
        }
    }

    pub fn run_current(&mut self) {
        // self.status = 
    }
}

pub fn exec(path: &str) {
    
}

// 包含更换任务代码
global_asm!(include_str!("change_task.asm"));

// 初始化多任务系统
pub fn init() {
    info!("多任务初始化");
    extern "C" {
        fn change_task(pte: usize, stack: usize);
    }

    // 如果存在write
    if let Ok(program) = FILETREE.lock().open("write") {
        let program = program.to_file();
        let pages = (program.size - 1 + PAGE_SIZE) / PAGE_SIZE;
        if let Some(phy_start) = PAGE_ALLOCATOR.lock().alloc_more(pages + 1) {
            unsafe {
                PAGE_ALLOCATOR.force_unlock()
            };
            let buf = unsafe {
                from_raw_parts_mut(usize::from(phy_start.to_addr()) as *mut u8, pages*PAGE_SIZE)
            };
            program.read_to(buf);

            let mut pmm = PageMappingManager::new();

            pmm.init_pte();

            for i in 0..pages {
                pmm.add_mapping(PhysAddr::from(PhysPageNum::from(usize::from(phy_start) + i)), 
                    VirtAddr::from(i*0x1000), PTEFlags::VRWX | PTEFlags::U);
            }

            // 映射栈 
            pmm.add_mapping(PhysAddr::from(PhysPageNum::from(usize::from(phy_start) + pages)), 
                    VirtAddr::from(0xf0000000), PTEFlags::VRWX | PTEFlags::U);

            // KERNEL_PAGE_MAPPING.lock().change_satp();

            // 打印内存
            // for i in (0..0x200).step_by(16) {
            //     info!("{:#05x}  {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x} {:02x}", 
            //     i, buf[i], buf[i+1],buf[i+2], buf[i+3],buf[i+4], buf[i+5],buf[i+6], buf[i+7], 
            //     buf[i+8], buf[i+9],buf[i+10], buf[i+11],buf[i+12], buf[i+13],buf[i+14], buf[i+15]);
            // }

            pmm.change_satp();

            unsafe { change_task(pmm.get_pte(), 0xf0000ff0) };
            
            info!("读取到内容: {}", program.size);
        }
    } else {
        info!("未找到文件!");
    }
    
}
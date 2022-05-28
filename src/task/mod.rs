use core::{slice::from_raw_parts_mut, arch::{global_asm, asm}};

use alloc::vec::Vec;

use crate::{memory::{page_table::{PageMappingManager, PTEFlags, KERNEL_PAGE_MAPPING}, addr::{PAGE_SIZE, VirtAddr, PhysAddr, PhysPageNum}, page::PAGE_ALLOCATOR}, fs::filetree::FILETREE};

pub const STDIN: usize = 0;
pub const STDOUT: usize = 1;
pub const STDERR: usize = 2;


struct TaskController {
    pid: usize,
    pmm: PageMappingManager,
    pipline: Vec<usize>
}

pub fn exec() {
    
}

// 包含更换任务代码
global_asm!(include_str!("change_task.asm"));

pub fn init() {
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

            for i in 0..pages {
                KERNEL_PAGE_MAPPING.lock().add_mapping(PhysAddr::from(PhysPageNum::from(usize::from(phy_start) + i)), 
                    VirtAddr::from(i*0x1000), PTEFlags::VRWX | PTEFlags::U);
                // pmm.add_mapping(PhysAddr::from(PhysPageNum::from(usize::from(phy_start) + i)), 
                    // VirtAddr::from(i*0x1000), PTEFlags::VRWX);
            }

            // 映射栈 
            KERNEL_PAGE_MAPPING.lock().add_mapping(PhysAddr::from(PhysPageNum::from(usize::from(phy_start) + pages)), 
                    VirtAddr::from(0xf0000000), PTEFlags::VRWX | PTEFlags::U);

            let ptr = unsafe { 0x1000 as *const u8};

            // sp -> user stack top -2 add two arguments
            unsafe { change_task(pmm.get_pte(), 0xf0000ff8) };
            
            info!("读取到内容: {}", program.size);
        }
    } else {
        info!("未找到文件!");
    }
    
}
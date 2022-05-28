use alloc::{sync::Arc, vec::Vec};

use crate::{memory::{page_table::PageMappingManager, addr::PAGE_SIZE, page::PAGE_ALLOCATOR}, fs::filetree::{FileTree, FILETREE}};

pub const STDIN: usize = 0;
pub const STDOUT: usize = 1;
pub const STDERR: usize = 2;


struct TaskController {
    pid: usize,
    memory_manager: PageMappingManager,
    pipline: Vec<usize>
}

pub fn exec() {
    
}

pub fn init() {
    info!("开始初始化!");
    // 如果存在write
    if let Ok(program) = FILETREE.lock().open("write") {
        info!("读取文件!");
        let program = program.to_file();
        let pages = (program.size - 1 + PAGE_SIZE) / PAGE_SIZE;
        if let Some(phy_start) = PAGE_ALLOCATOR.lock().alloc_more(pages) {
            info!("申请内存!");
            let mut buf = unsafe {
                Vec::from_raw_parts(usize::from(phy_start.to_addr()) as *mut u8, pages*PAGE_SIZE, pages*PAGE_SIZE)
            };
            info!("转换内存");
            program.read_to(&mut buf);
            info!("读取到内容: {}", program.size);
        }
        info!("读取到内容: {}", program.size);
    } else {
        info!("未找到文件!");
    }
    
}
use alloc::vec::Vec;

use crate::{sync::mutex::Mutex, memory::page::PAGE_ALLOCATOR};

use super::exec;

lazy_static! {
    pub static ref TASK_QUEUE: Mutex<Vec<&'static str>> = Mutex::new(vec![
        "./runtest.exe -w entry-static.exe argv"
        // "runtest.exe"
        // "entry-static.exe"
        // "entry-dynamic.exe"
    ]);
}

pub fn exec_by_str(str: &str) {
    let args: Vec<&str> = str.split(" ").collect();
    exec(args[0], args[0..].to_vec());
}

// 加载下一个任务
pub fn load_next_task() {
    if let Some(pro_name) = TASK_QUEUE.lock().pop() {
        exec_by_str(pro_name)
    } else {
        let mut last_pages = 0;
        for i in PAGE_ALLOCATOR.lock().pages.clone() {
            if !i {
                last_pages=last_pages+1;
            }
        }
        info!("剩余页表: {}", last_pages);
        panic!("已无任务");
    }
}
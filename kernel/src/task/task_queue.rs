use alloc::vec::Vec;

use crate::{sync::mutex::Mutex, memory::page::{PAGE_ALLOCATOR, get_free_page_num}};

use super::exec;

lazy_static! {
    pub static ref TASK_QUEUE: Mutex<Vec<&'static str>> = Mutex::new(vec![
        "runtest.exe -w entry-static.exe argv",
        // "runtest.exe"
        "entry-static.exe argv",
        // "entry-dynamic.exe"
    ]);
}

pub fn exec_by_str(str: &str) {
    let args: Vec<&str> = str.split(" ").collect();
    info!("执行任务: {}", str);
    exec(args[0], args[0..].to_vec());
}

// 加载下一个任务
pub fn load_next_task() {
    if let Some(pro_name) = TASK_QUEUE.lock().pop() {
        exec_by_str(pro_name)
    } else {
        info!("剩余页表: {}", get_free_page_num());
        panic!("已无任务");
    }
}
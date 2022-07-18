use alloc::vec::Vec;

use crate::{sync::mutex::Mutex, memory::page::get_free_page_num, task::task_scheduler::add_task_to_scheduler};


use super::exec;

lazy_static! {
    pub static ref TASK_QUEUE: Mutex<Vec<&'static str>> = Mutex::new(vec![
        "runtest.exe -w entry-static.exe argv",
        // "runtest.exe -w entry-static.exe basename",
        // "runtest.exe"
        // "entry-static.exe argv",
        // "entry-dynamic.exe"
    ]);
}

pub fn exec_by_str(str: &str) {
    let args: Vec<&str> = str.split(" ").collect();
    info!("执行任务: {}", str);
    if let Ok(task) = exec(args[0], args[0..].to_vec()) {
        add_task_to_scheduler(task);
    }
}

// 加载下一个任务
pub fn load_next_task() -> bool {
    if let Some(pro_name) = TASK_QUEUE.lock().pop() {
        exec_by_str(pro_name);
        true
    } else {
        info!("剩余页表: {}", get_free_page_num());
        false
    }
}

// 注意 后面的机会 是对Task实现Syscall 
// 这样在 可以在impl 内部使用self 作为task 
// 但是需要一个task外的函数 作为调度 可以顺利抛出函数
// 使用change_task 返回函数主体， 可以让过程更加完善 更像写一个程序 而不是分离开
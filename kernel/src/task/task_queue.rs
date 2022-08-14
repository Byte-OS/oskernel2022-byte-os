use alloc::{vec::Vec, collections::VecDeque};
use k210_soc::sleep::usleep;

use crate::{sync::mutex::Mutex, memory::page::get_free_page_num, task::task_scheduler::add_task_to_scheduler};


use super::exec;

lazy_static! {
    pub static ref TASK_QUEUE: Mutex<VecDeque<&'static str>> = Mutex::new(VecDeque::from(vec![
        "busybox sh busybox_testcode.sh",
        "busybox sh test.sh date.lua",
        "busybox sh test.sh file_io.lua",
        "busybox sh test.sh max_min.lua",
        "busybox sh test.sh random.lua",
        "busybox sh test.sh remove.lua",
        "busybox sh test.sh round_num.lua",
        "busybox sh test.sh sin30.lua",
        "busybox sh test.sh sort.lua",
        "busybox sh test.sh strings.lua",
        
        // sleep

        // lmbench_all
        "busybox echo latency measurements",
        "sleep",
        "lmbench_all lat_syscall -P 1 null",
        "lmbench_all lat_syscall -P 1 read",
        "lmbench_all lat_syscall -P 1 write",

    ]));
}


pub fn exec_by_str(str: &str) {
    debug!("执行任务: {}", str);
    let args: Vec<&str> = str.split(" ").collect();
    if let Ok(task) = exec(args[0], args[0..].to_vec()) {
        task.before_run();
        add_task_to_scheduler(task);
    }
}

// 加载下一个任务
pub fn load_next_task() -> bool {
    loop {
        if let Some(pro_name) = TASK_QUEUE.lock().pop_front() {
            if pro_name == "sleep" {
                usleep(100000);
                continue;
            }
            info!("剩余页表: {}", get_free_page_num());
            exec_by_str(pro_name);
            break true
        } else {
            info!("剩余页表: {}", get_free_page_num());
            break false
        }
    }
}


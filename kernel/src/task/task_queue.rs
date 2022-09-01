use core::arch::asm;

use alloc::{vec::Vec, collections::VecDeque};

use crate::sync::mutex::Mutex;
use crate::memory::page::get_free_page_num;
use crate::task::interface::add_task_to_scheduler;


use super::exec;

lazy_static! {
    pub static ref TASK_QUEUE: Mutex<VecDeque<&'static str>> = Mutex::new(VecDeque::from(vec![
        // 调试信息
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
    ]));
}

#[no_mangle]
pub fn exec_by_str(str: &'static str) {
    // TIP: 这里为什么需要显示东西
    // println!("执行任务: {}", str);
    let args: Vec<&str> = str.split(" ").collect();
    unsafe {
        for _ in 0..0x10000 {
            asm!("nop");
        }
    }
    // println!("{:?}", args);
    // let len = args.len();
    if let Ok(task) = exec(args[0], args[0..].to_vec()) {
        task.before_run();
        unsafe { add_task_to_scheduler(task); }
    }
}


// 加载下一个任务
pub fn load_next_task() -> bool {
    if let Some(pro_name) = TASK_QUEUE.lock().pop_front() {
        info!("剩余页表: {}", get_free_page_num());
        exec_by_str(pro_name);
        true
    } else {
        info!("剩余页表: {}", get_free_page_num());
        false
    }
}

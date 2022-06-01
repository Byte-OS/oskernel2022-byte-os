use alloc::vec::Vec;

use crate::sync::mutex::Mutex;

use super::exec;

lazy_static! {
    pub static ref TASK_QUEUE: Mutex<Vec<&'static str>> = Mutex::new(vec![
        "open","write", "brk"
    ]);
}

pub fn load_next_task() {
    if let Some(pro_name) = TASK_QUEUE.lock().pop() {
        exec(pro_name);
    } else {
        panic!("已无任务");
    }
}
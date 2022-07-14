use alloc::rc::Weak;

use crate::interrupt::Context;

use super::process::Process;

#[derive(Clone, Copy, PartialEq)]
// 任务状态
pub enum TaskStatus {
    READY   = 0,
    RUNNING = 1,
    PAUSE   = 2,
    STOP    = 3,
}


pub struct Task {
    tid: usize,
    context: Context,
    process: Weak<Process>,
    status: TaskStatus
}
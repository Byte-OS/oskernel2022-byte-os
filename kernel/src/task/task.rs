use core::cell::RefCell;

use alloc::{rc::{Weak, Rc}, sync::Arc};

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

pub struct TaskInner {
    pub context: Context,
    pub process: Weak<Process>,
    pub status: TaskStatus
}

#[derive(Clone)]
pub struct Task {
    pub tid: usize,
    pub inner: Rc<RefCell<TaskInner>>
}

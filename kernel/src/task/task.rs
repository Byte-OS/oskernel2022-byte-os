use core::cell::RefCell;

use alloc::rc::Rc;


use crate::{interrupt::Context, memory::page_table::PagingMode};
use crate::task::task_scheduler::kill_task;

use super::process::Process;

#[derive(Clone, Copy, PartialEq)]
// 任务状态
pub enum TaskStatus {
    READY   = 0,
    RUNNING = 1,
    PAUSE   = 2,
    STOP    = 3,
    EXIT    = 4,
    WAITING = 5,
}

pub struct TaskInner {
    pub context: Context,
    pub process: Rc<RefCell<Process>>,
    pub status: TaskStatus
}

#[derive(Clone)]
pub struct Task {
    pub tid: usize,
    pub pid: usize,
    pub clear_child_tid: RefCell<usize>,
    pub inner: Rc<RefCell<TaskInner>>
}

impl Task {
    // 创建进程
    pub fn new(tid: usize, process: Rc<RefCell<Process>>) -> Rc<Self> {
        let pid = process.borrow().pid;
        Rc::new(Self {
            tid,
            pid,
            clear_child_tid: RefCell::new(0),
            inner: Rc::new(RefCell::new(TaskInner { 
                context: Context::new(), 
                process, 
                status: TaskStatus::READY
            }))
        })
    }

    // 退出进程
    pub fn exit(&self) {
        kill_task(self.pid, self.tid);
    }

    // 设置 tid ptr
    pub fn set_tid_address(&self, tid_ptr: usize) {
        *self.clear_child_tid.borrow_mut() = tid_ptr;
    }

    // 运行当前任务
    pub fn run(&self) {
        extern "C" {
            // 改变任务
            fn change_task(pte: usize, stack: usize);
        }
        let inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        // 可能需要更换内存
        // usleep(1000);
        let pte_ppn = process.pmm.get_pte() >> 12;
        let context_ptr = &inner.context as *const Context as usize;
        warn!("恢复任务");
        // 释放资源
        drop(process);
        drop(inner);
        unsafe {
            change_task((PagingMode::Sv39 as usize) << 60 | pte_ppn, context_ptr)
        };
    }
}

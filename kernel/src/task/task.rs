use core::cell::RefCell;

use alloc::rc::Rc;

use crate::{interrupt::Context, memory::page_table::PagingMode};

use super::{process::Process, task_scheduler::kill_pid};

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
    pub inner: Rc<RefCell<TaskInner>>
}

impl Task {
    // 创建进程
    pub fn new(tid: usize, process: Rc<RefCell<Process>>) -> Rc<Self> {
        let pid = process.borrow().pid;
        Rc::new(Self {
            tid,
            pid, 
            inner: Rc::new(RefCell::new(TaskInner { 
                context: Context::new(), 
                process, 
                status: TaskStatus::READY
            }))
        })
    }

    // 退出进程
    pub fn exit(&self) {
        let mut inner = self.inner.borrow_mut();
        inner.status = TaskStatus::EXIT;
        drop(inner);
        // 如果是tid 为 0 回收process资源 
        // 暂不处理线程退出
        if self.tid == 0 {
            kill_pid(self.pid);
        }
    }

    // 运行当前任务
    pub fn run(&self) {
        extern "C" {
            // 改变任务
            fn change_task(pte: usize, stack: usize);
        }
        let inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 切换satp
        process.pmm.change_satp();
        
        let pte_ppn = process.pmm.get_pte() >> 12;
        let context_ptr = &inner.context as *const Context as usize;
        // 释放资源
        drop(process);
        drop(inner);
        unsafe {
            change_task((PagingMode::Sv39 as usize) << 60 | pte_ppn, context_ptr)
        };
    }
}

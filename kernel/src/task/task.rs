use core::cell::{RefCell, RefMut};

use alloc::rc::Rc;


use crate::memory::addr::UserAddr;
use crate::memory::page_table::PageMappingManager;
use crate::{interrupt::Context, memory::page_table::PagingMode};
use crate::task::task_scheduler::kill_task;

use super::process::Process;
use super::signal::SigSet;

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
    pub status: TaskStatus,
    pub wake_time: usize,
    pub sig_mask: SigSet
}

#[derive(Clone)]
pub struct Task {
    pub tid: usize,
    pub pid: usize,
    pub clear_child_tid: RefCell<UserAddr<u32>>,
    pub inner: Rc<RefCell<TaskInner>>
}

impl Task {
    // 创建进程
    pub fn new(tid: usize, process: Rc<RefCell<Process>>) -> Rc<Self> {
        let mut process_mut = process.borrow_mut();
        let pid = process_mut.pid;
        let task = Rc::new(Self {
            tid,
            pid,
            clear_child_tid: RefCell::new(0.into()),
            inner: Rc::new(RefCell::new(TaskInner {
                context: Context::new(), 
                process: process.clone(), 
                status: TaskStatus::READY,
                wake_time: 0,
                sig_mask: SigSet::new(0)
            }))
        });
        process_mut.tasks.push(Rc::downgrade(&task));
        task
    }

    // 退出进程
    pub fn exit(&self) {
        kill_task(self.pid, self.tid);
    }

    // 设置 tid ptr
    pub fn set_tid_address(&self, tid_ptr: UserAddr<u32>) {
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

    // 获取pmm
    pub fn get_pmm(&self) -> Rc<PageMappingManager> {
        self.inner.borrow().process.borrow().pmm.clone()
    }

    // 获取process
    pub fn get_process(&self) -> Rc<RefCell<Process>> {
        self.inner.borrow_mut().process.clone()
    }
}

use core::{cell::RefCell};

use alloc::{collections::VecDeque, rc::Rc, vec::Vec, sync::Arc};
use riscv::register::{stval, scause::{Scause, self}};

use crate::{sync::mutex::Mutex, task::pid::PidGenerater, memory::page_table::switch_to_kernel_page, interrupt::{timer::task_time_refresh, Context, interrupt_callback}};

use super::{task::{Task, TaskStatus}, task_queue::load_next_task, get_current_task, process::Process};

// 任务控制器管理器
pub struct TaskScheduler {
    pub current: Option<Rc<Task>>,          // 当前任务
    pub queue: VecDeque<Rc<Task>>,          // 准备队列
    pub is_run: bool                    // 任务运行标志
}

impl TaskScheduler {
    // 创建Task调度器
    pub fn new() -> Self {
        Self {
            current: None,
            queue: VecDeque::new(),
            is_run: false
        }
    }

    // 添加任务调度器
    pub fn add_task(&mut self, task: Rc<Task>) {
        let mut task_inner = task.inner.borrow_mut();
        if self.current.is_none() {
            task_inner.status = TaskStatus::RUNNING;
            let process = task_inner.process.borrow();
            process.pmm.change_satp();
            self.current = Some(task.clone());
        } else {
            task_inner.status = TaskStatus::READY;
            self.queue.push_back(task.clone());
        }
    }

    // 执行下一个任务
    pub fn run_next(&mut self) {
        let mut index = 0;
        let len = self.queue.len();

        let task = loop {
            if index >= len { break None; }

            if let Some(task) = self.queue.pop_front() {
                let mut task_inner = task.inner.borrow_mut();
                if task_inner.status == TaskStatus::READY {
                    task_inner.status = TaskStatus::RUNNING;
                    let process = task_inner.process.borrow();
                    process.pmm.change_satp();
                    break Some(task.clone());
                } else {
                    index += 1;
                    continue;
                }
            } else {
                break None;
            }
        };

        if let Some(task) = task {
            self.current = Some(task);
        } else {
            load_next_task(); 
        }
    }

    // 执行第一个任务
    pub fn start(&mut self) {
        loop {
            if self.current.is_none() {
                self.run_next();
            }
            let task = self.current.clone().unwrap();
            self.is_run = true;
            task.run();
            let task_inner = task.inner.borrow_mut();
            let context = &task_inner.context as *const Context as usize as 
                *mut Context;
            drop(task_inner);
            let context = unsafe { &mut *(context) };
            interrupt_callback(context, scause::read(), stval::read());
        }
    }

    // 关闭当前任务
    pub fn kill_current(&mut self) {
        if let Some(current_task) = self.current.clone() {
            current_task.exit();
        }
        self.current = None;
        self.run_next();
    }

    // 暂停当前任务
    pub fn suspend_current(&mut self) {
        match &self.current {
            Some(task) => {
                let mut task_inner = task.inner.borrow_mut();
                task_inner.status = TaskStatus::READY;
                self.queue.push_back(task.clone());
            }
            None => {}
        }
        self.current = None;
    }

    // 关闭进程
    pub fn kill_pid(&mut self, pid: usize) {
        self.queue = self.queue.clone().into_iter().filter(|x| x.pid != pid).collect();
    }
}

lazy_static! {
    // 任务管理器和pid生成器
    pub static ref TASK_SCHEDULER: Mutex<TaskScheduler> = Mutex::new(TaskScheduler::new());
    pub static ref NEXT_PID: Mutex<PidGenerater> = Mutex::new(PidGenerater::new());
}

pub fn start_tasks() {
    extern "C" {
        // 改变任务
        fn change_task(pte: usize, stack: usize);
    }
    // 刷新下一个调度时间
    // info!("开始任务");
    task_time_refresh();
    let mut task_scheduler = TASK_SCHEDULER.force_get();
    task_scheduler.start();
    info!("恢复任务");
}

pub fn add_task_to_scheduler(task: Rc<Task>) {
    TASK_SCHEDULER.force_get().add_task(task);
}

pub fn get_current_process() -> Rc<RefCell<Process>> {
    let current_task = get_current_task().unwrap();
    let task_inner = current_task.inner.borrow_mut();
    task_inner.process.clone()
}
 
// 当前任务进入调度
pub fn scheduler_to_next() {
    let mut scheduler = TASK_SCHEDULER.force_get();
    scheduler.suspend_current();
    scheduler.run_next();
}

pub fn kill_pid(pid: usize) {
    TASK_SCHEDULER.force_get().kill_pid(pid);
}

pub fn get_tasks_len() -> usize {
    TASK_SCHEDULER.force_get().queue.len()
}
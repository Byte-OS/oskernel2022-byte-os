use alloc::collections::VecDeque;

use crate::{sync::mutex::Mutex, task::pid::PidGenerater};

use super::{task::{Task, TaskStatus}, task_queue::load_next_task};

// 任务控制器管理器
pub struct TaskScheduler {
    pub current: Option<Task>,          // 当前任务
    pub queue: VecDeque<Task>,          // 准备队列
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
    pub fn add_task(&mut self, task: Task) {
        let mut task_inner = task.inner.borrow_mut();
        if self.current.is_none() {
            task_inner.status = TaskStatus::RUNNING;
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
        let task: Option<Task> = loop {
            if index >= len { break None; }

            if let Some(task) = self.queue.pop_front() {
                let mut task_inner = task.inner.borrow_mut();
                if task_inner.status == TaskStatus::READY {
                    task_inner.status = TaskStatus::RUNNING;
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
    pub fn run_first(&mut self) {
        if self.current.is_none() {
            self.run_next();
        }

        let task = self.current.clone().unwrap();

        task.run();
    }
}

lazy_static! {
    // 任务管理器和pid生成器
    pub static ref TASK_SCHEDULER: Mutex<TaskScheduler> = Mutex::new(TaskScheduler::new());
    pub static ref NEXT_PID: Mutex<PidGenerater> = Mutex::new(PidGenerater::new());
}

pub fn start_tasks() {
    TASK_SCHEDULER.force_get().run_first();
}

pub fn add_task_to_scheduler(task: Task) {
    TASK_SCHEDULER.force_get().add_task(task);
}
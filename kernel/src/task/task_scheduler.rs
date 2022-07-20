use alloc::{collections::VecDeque, rc::Rc};
use crate::{sync::mutex::Mutex, task::pid::PidGenerater, interrupt::timer::task_time_refresh};
use super::{task::{Task, TaskStatus}, task_queue::load_next_task};

// 任务控制器管理器
pub struct TaskScheduler {
    pub queue: VecDeque<Rc<Task>>,          // 准备队列
    pub is_run: bool                    // 任务运行标志
}

impl TaskScheduler {
    // 创建Task调度器
    pub fn new() -> Self {
        Self {
            queue: VecDeque::new(),
            is_run: false
        }
    }

    // 添加任务调度器
    pub fn add_task(&mut self, task: Rc<Task>) {
        self.queue.push_back(task.clone());
    }

    // 执行下一个任务
    pub fn switch_next(&mut self) {
        if let Some(task) = self.queue.pop_front() {
            task.inner.borrow_mut().status = TaskStatus::READY;
            self.queue.push_back(task);
        }
    }

    // 执行第一个任务
    pub fn start(&mut self) {
        loop {
            if self.queue.len() == 0 {
                if !load_next_task() {
                    break;
                }
            }
            let task = self.queue[0].clone();
            self.is_run = true;
            task.run();
            info!("执行pid: {}", task.pid);
            task.catch();
        }
    }

    // 关闭进程
    pub fn kill_process(&mut self, pid: usize) {
        self.queue = self.queue.clone().into_iter().filter(|x| x.pid != pid).collect();
    }

    // 关闭进程
    pub fn kill_task(&mut self, pid: usize, tid: usize) {
        self.queue = self.queue.clone().into_iter().filter(|x| x.pid != pid || x.tid != tid).collect();
    }
}

lazy_static! {
    // 任务管理器和pid生成器
    pub static ref TASK_SCHEDULER: Mutex<TaskScheduler> = Mutex::new(TaskScheduler::new());
    pub static ref NEXT_PID: Mutex<PidGenerater> = Mutex::new(PidGenerater::new());
}

pub fn start_tasks() {
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

pub fn kill_process(pid: usize) {
    TASK_SCHEDULER.force_get().kill_process(pid);
}

pub fn kill_task(pid: usize, tid: usize) {
    TASK_SCHEDULER.force_get().kill_task(pid, tid);
}

pub fn switch_next() {
    TASK_SCHEDULER.force_get().switch_next();
}
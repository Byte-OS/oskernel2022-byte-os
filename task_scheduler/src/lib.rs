#![no_std]
extern crate alloc;
#[macro_use]
extern crate output;
#[macro_use]
extern crate lazy_static; 

mod pid;

use alloc::collections::VecDeque;
use alloc::rc::Rc;
use kernel::interrupt::timer::task_time_refresh;
use kernel::memory::page_table::switch_to_kernel_page;
use kernel::sync::mutex::Mutex;
use kernel::task::task::Task;
use kernel::task::task::TaskStatus;
use kernel::task::task_queue::load_next_task;
use linux_syscall::catch;

use crate::pid::PidGenerater;

// 任务控制器管理器
pub struct TaskScheduler {
    pub queue: VecDeque<Rc<Task>>,          // 准备队列
}

impl TaskScheduler {
    // 创建Task调度器
    pub fn new() -> Self {
        Self {
            queue: VecDeque::new(),
        }
    }
}

lazy_static! {
    // 任务管理器和pid生成器
    pub static ref TASK_SCHEDULER: Mutex<TaskScheduler> = Mutex::new(TaskScheduler::new());
    pub static ref NEXT_PID: Mutex<PidGenerater> = Mutex::new(PidGenerater::new());
}

/// 开始任务调度
/// 
/// 开始进行任务调度 直到任务全部执行完毕会退出
#[no_mangle]
pub fn start_tasks() {
    // 刷新下一个调度时间
    task_time_refresh();

    // 此处用force_get， 防止占用后得不到释放导致其他地方无法使用发生死锁
    let task_scheduler = TASK_SCHEDULER.force_get();

    // 调度开始 直到所有任务执行完毕
    loop {
        // 没有任务时从任务队列取出任务
        if task_scheduler.queue.len() == 0 {
            if !load_next_task() {
                break;
            }
        }
        // TODO: 判断是否存在等待中的任务 如果存在就切换任务
        let task = task_scheduler.queue[0].clone();
        
        warn!("执行pid: {}   tid: {}   tasks len: {}", task.pid, task.tid, self.queue.len());
        task.run();
        catch(task);
    }

    // 任务执行完毕 切换到内核页表 继续内核主线程
    switch_to_kernel_page();
}

/// 添加任务到调度器
/// 
/// 将`task`添加到调度器，且优先级应当为当前的最低值
#[no_mangle]
pub fn add_task_to_scheduler(task: Rc<Task>) {
    TASK_SCHEDULER.lock().queue.push_back(task);
}

/// 删除线程
/// 
/// 根据pid将调度器中属于某个线程的所有任务删除，不再执行
#[no_mangle]
pub fn kill_process(pid: usize) {
    TASK_SCHEDULER.lock().queue.retain(|x| x.pid != pid);
}

/// 删除任务
/// 
/// 根据pid和tid将任务从调度器移除，不再执行
#[no_mangle]
pub fn kill_task(pid: usize, tid: usize) {
    TASK_SCHEDULER.lock().queue.retain(|x| x.pid != pid || x.tid != tid);
}

/// 切换到下一个任务
/// 
/// 进行任务调度，切换到下一个需要执行的任务，并为任务指定相应的时间片
#[no_mangle]
pub fn switch_next() {
    let queue = &mut TASK_SCHEDULER.lock().queue;
    if let Some(task) = queue.pop_front() {
        task.inner.borrow_mut().status = TaskStatus::READY;
        queue.push_back(task);
        queue[0].before_run();
    }
    task_time_refresh();
}

/// 获取当前正在执行的任务
/// 
/// 放回当前正在执行的任务，由于当前任务总是任务队列的第一个，因此也是返回第一个任务
/// 如果没有任务则返回Option::None
#[no_mangle]
pub fn get_current_task() -> Option<Rc<Task>> {
    match TASK_SCHEDULER.force_get().queue.front() {
        Some(task) => Some(task.clone()),
        None => None
    }
}

/// 获取任务
/// 
/// 根据任务的pid和tid寻找任务，寻找到则返回任务，未寻找到则返回Option::None
#[no_mangle]
pub fn get_task(pid: usize, tid: usize) -> Option<Rc<Task>> {
    let task_scheduler = TASK_SCHEDULER.force_get();
    for i in 0..task_scheduler.queue.len() {
        let task = task_scheduler.queue[i].clone();
        if task.pid == pid && task.tid == tid {
            return Some(task.clone());
        }
    }
    None
}

/// 切换到指定的任务
/// 
/// 指定任务的pid和tid，找到相应的任务后并进行切换。如果没找到则不切换
#[no_mangle]
pub fn switch_to_task(pid: usize, tid: usize) {
    let mut task_scheduler = TASK_SCHEDULER.force_get();

    while let Some(task) = task_scheduler.queue.pop_front() {
        let ctask = task.clone();
        task_scheduler.queue.push_back(task);
        if ctask.tid == tid && ctask.pid == pid {
            break;
        }
    }
}

/// 获取当前的任务数量
/// 
/// 返回当前调度器中队列的长度
pub fn get_task_num() -> usize {
    TASK_SCHEDULER.lock().queue.len()
}
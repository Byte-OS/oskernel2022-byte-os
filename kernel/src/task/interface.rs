use alloc::rc::Rc;

use super::task::Task;

extern "C" {
    pub fn kill_process(pid: usize);
    pub fn kill_task(pid: usize, tid: usize);
    pub fn add_task_to_scheduler(task: Rc<Task>);
    pub fn get_new_pid() -> usize;
    pub fn switch_next();
    pub fn get_task(pid: usize, tid: usize) -> Option<Rc<Task>>;
}
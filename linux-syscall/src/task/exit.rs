use kernel::memory::page::get_free_page_num;
use kernel::{
    task::task_scheduler::get_task, 
    runtime_err::RuntimeError};
use crate::{remove_vfork_wait, SYS_CALL_ERR, signal};


use crate::SyscallTask;

/// 退出当前任务 
pub fn sys_exit(task: SyscallTask, exit_code: usize) -> Result<(), RuntimeError> {
    let inner = task.inner.borrow();
    if task.tid == 0 {
        inner.process.borrow_mut().exit(exit_code);
    } else {
        task.exit();
    }

    let clear_child_tid = task.clear_child_tid.borrow().clone();
    if clear_child_tid.is_valid() {
        *clear_child_tid.transfer() = 0;
    }
    Err(RuntimeError::KillCurrentTask)
}

// 退出当前进程？ eg: 功能也许有待完善
pub fn sys_exit_group(task: SyscallTask, exit_code: usize) -> Result<(), RuntimeError> {
    let inner = task.inner.borrow_mut();
    let mut process = inner.process.borrow_mut();
    process.exit(exit_code);
    match &process.parent {
        Some(parent) => {
            let parent = parent.upgrade().unwrap();
            let parent = parent.borrow();
            remove_vfork_wait(parent.pid);

            // let end: UserAddr<TimeSpec> = 0x10bb78.into();
            // let start: UserAddr<TimeSpec> = 0x10bad0.into();

            // println!("start: {:?}   end: {:?}",start.transfer(), end.transfer());

            // let target_end: UserAddr<TimeSpec> = parent.pmm.get_phys_addr(0x10bb78usize.into())?.0.into();
            // let target_start: UserAddr<TimeSpec> = parent.pmm.get_phys_addr(0x10bad0usize.into())?.0.into();
            // *target_start.transfer() = *start.transfer();
            // *target_end.transfer() = *end.transfer();

            // let task = parent.tasks[0].clone().upgrade().unwrap();
            // drop(parent);
            // // 处理signal 17 SIGCHLD
            // task.signal(17);
        }
        None => {}
    }
    debug!("剩余页表: {}", get_free_page_num());
    debug!("exit_code: {:#x}", exit_code);
    Err(RuntimeError::ChangeTask)
}

// kill task
pub fn sys_kill(task: SyscallTask, _pid: usize, _signum: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    debug!(
        "kill: thread {} kill process {} with signal {:?}",
        0,
        _pid,
        _signum
    );

    inner.context.x[10] = 0;
    Ok(())
}

// kill task
pub fn sys_tkill(task: SyscallTask, tid: usize, signum: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    inner.context.x[10] = 0;
    let signal_task = get_task(task.pid, tid);
    debug!("signum: {}", signum);
    if let Some(signal_task) = signal_task {
        drop(inner);
        signal(signal_task, signum)?;
    }
    Ok(())
}

pub fn sys_tgkill(task: SyscallTask, tgid: usize, tid: usize, signum: usize) -> Result<(), RuntimeError> {
    debug!("tgkill: tgid: {}  tid: {}  signum {}", tgid, tid, signum);
    if let Some(task) = get_task(tgid, tid) {
        signal(task, signum)?;
    } else {
        task.update_context(|x| x.x[10] = SYS_CALL_ERR);
    }
    Ok(())
}
use crate::{runtime_err::RuntimeError, task::{task_scheduler::get_current_process, suspend_and_run_next, get_current_task}, interrupt::{TICKS, timer::{TimeSpec, TMS}}};

pub fn sys_nanosleep(req_ptr: usize, rem_ptr: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process();
    let process = process.borrow_mut();
    let task = get_current_task().unwrap();
    let mut task_inner = task.inner.borrow_mut();

    // 获取文件参数
    let req_ptr = usize::from(process.pmm.get_phys_addr(req_ptr.into()).unwrap()) as *mut TimeSpec;
    let req = unsafe { req_ptr.as_mut().unwrap() };
    let rem_ptr = usize::from(process.pmm.get_phys_addr(rem_ptr.into()).unwrap()) as *mut TimeSpec;
    let rem = unsafe { rem_ptr.as_mut().unwrap() };
    // 如果 nsec < 0则此任务已被处理 nsec = - remain_ticks
    if rem.tv_nsec < 0 {
        let remain_ticks = (-rem.tv_nsec) as usize;
        if remain_ticks <= unsafe {TICKS} {
            Ok(0)
        } else {
            // 减少spec进行重复请求 然后切换任务
            task_inner.context.sepc = task_inner.context.sepc - 4;
            suspend_and_run_next();
            Ok(0)
        }
    } else {
        // 1秒100个TICKS  1ns = 1/1000ms = 1/10000TICKS
        let wake_ticks = req.tv_sec * 100 + req.tv_nsec as u64 / 10000;
        let remain_ticks = wake_ticks + unsafe {TICKS as u64};

        rem.tv_nsec = - (remain_ticks as i64);
        // 减少spec进行重复请求 然后切换任务
        task_inner.context.sepc = task_inner.context.sepc - 4;
        suspend_and_run_next();
        Ok(0)
    }
}

pub fn sys_times(tms_ptr: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process();
    let process = process.borrow_mut();
    // 等待添加
    let tms = usize::from(process.pmm.get_phys_addr(tms_ptr.into()).unwrap()) 
        as *mut TMS;
    let tms = unsafe { tms.as_mut().unwrap() };

    // 写入文件时间
    tms.tms_cstime = process.tms.tms_cstime;
    tms.tms_cutime = process.tms.tms_cutime;
    Ok(unsafe {TICKS})
}

pub fn sys_gettimeofday(ptr: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process();
    let process = process.borrow_mut();

    let timespec = usize::from(process.pmm.get_phys_addr(ptr.into()).unwrap()) as *mut TimeSpec;
    unsafe { timespec.as_mut().unwrap().get_now() };
    Ok(0)
}
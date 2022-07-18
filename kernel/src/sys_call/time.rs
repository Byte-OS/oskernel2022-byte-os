use crate::{runtime_err::RuntimeError, task::{suspend_and_run_next, task::Task}, interrupt::timer::{TimeSpec, TMS}};
use crate::interrupt::timer::get_ticks;

impl Task {
    pub fn sys_nanosleep(&self, req_ptr: usize, rem_ptr: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 获取文件参数
        let req_ptr = usize::from(process.pmm.get_phys_addr(req_ptr.into()).unwrap()) as *mut TimeSpec;
        let req = unsafe { req_ptr.as_mut().unwrap() };
        let rem_ptr = usize::from(process.pmm.get_phys_addr(rem_ptr.into()).unwrap()) as *mut TimeSpec;
        let rem = unsafe { rem_ptr.as_mut().unwrap() };

        drop(process);

        // 如果 nsec < 0则此任务已被处理 nsec = - remain_ticks
        inner.context.x[10] = if rem.tv_nsec < 0 {
            let remain_ticks = (-rem.tv_nsec) as usize;
            if remain_ticks <= get_ticks() {
                0
            } else {
                // 减少spec进行重复请求 然后切换任务
                inner.context.sepc -= 4;
                suspend_and_run_next();
                0
            }
        } else {
            // 1秒100个TICKS  1ns = 1/1000ms = 1/10000TICKS
            let wake_ticks = req.tv_sec * 100 + req.tv_nsec as u64 / 10000;
            let remain_ticks = wake_ticks + get_ticks() as u64;
    
            rem.tv_nsec = - (remain_ticks as i64);
            // 减少spec进行重复请求 然后切换任务
            inner.context.sepc -= 4;
            suspend_and_run_next();
            0
        };
        Ok(())
    }
    
    pub fn sys_times(&self, tms_ptr: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        // 等待添加
        let tms = usize::from(process.pmm.get_phys_addr(tms_ptr.into()).unwrap()) 
            as *mut TMS;
        let tms = unsafe { tms.as_mut().unwrap() };
    
        // 写入文件时间
        tms.tms_cstime = process.tms.tms_cstime;
        tms.tms_cutime = process.tms.tms_cutime;
        drop(process);

        inner.context.x[10] = get_ticks();
        Ok(())
    }
    
    pub fn sys_gettimeofday(&self, ptr: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
    
        let timespec = usize::from(process.pmm.get_phys_addr(ptr.into()).unwrap()) as *mut TimeSpec;
        unsafe { timespec.as_mut().unwrap().get_now() };
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
}
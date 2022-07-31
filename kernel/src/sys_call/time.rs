use alloc::vec::Vec;

use crate::runtime_err::RuntimeError;
use crate::task::task::Task;
use crate::task::fd_table::FD_CWD;
use crate::interrupt::timer::{get_time_us, TimeSpec};
use crate::interrupt::timer::TMS;
use crate::memory::addr::VirtAddr;
use crate::sys_call::get_string_from_raw;
use crate::sys_call::consts::EBADF;
use crate::sys_call::consts::ENOTDIR;
use crate::fs::filetree::INode;
use crate::interrupt::timer::get_ticks;

impl Task {
    pub fn sys_nanosleep(&self, req_ptr: VirtAddr, rem_ptr: VirtAddr) -> Result<(), RuntimeError> {
        debug!("nano sleep: req_ptr: {:#x}, rem_ptr:{:#x}", req_ptr.0, rem_ptr.0);
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 获取文件参数
        let req_time = req_ptr.translate(process.pmm.clone()).tranfer::<TimeSpec>();
        drop(process);
        if inner.wake_time == 0 {
            inner.wake_time = get_time_us() + (req_time.tv_sec * 1000000) as usize + req_time.tv_nsec as usize;
            inner.context.sepc -= 4;
            return Ok(())
        }
        let task_wake_time = inner.wake_time;

        if get_time_us() > task_wake_time {
            // 到达解锁时间
            inner.wake_time = 0;
        } else {
            // 未到达解锁时间 重复执行
            inner.context.sepc -= 4;
        }
        Ok(())

        // let rem_ptr = usize::from(process.pmm.get_phys_addr(rem_ptr.into()).unwrap()) as *mut TimeSpec;
        // let rem = unsafe { rem_ptr.as_mut().unwrap() };
        //
        // drop(process);
        //
        // // 如果 nsec < 0则此任务已被处理 nsec = - remain_ticks
        // inner.context.x[10] = if rem.tv_nsec < 0 {
        //     let remain_ticks = (-rem.tv_nsec) as usize;
        //     if remain_ticks <= get_ticks() {
        //         0
        //     } else {
        //         // 减少spec进行重复请求 然后切换任务
        //         inner.context.sepc -= 4;
        //         0
        //     }
        // } else {
        //     // 1秒100个TICKS  1ns = 1/1000ms = 1/10000TICKS
        //     let wake_ticks = req.tv_sec * 100 + req.tv_nsec as u64 / 10000;
        //     let remain_ticks = wake_ticks + get_ticks() as u64;
        //
        //     rem.tv_nsec = - (remain_ticks as i64);
        //     // 减少spec进行重复请求 然后切换任务
        //     inner.context.sepc -= 4;
        //     0
        // };
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

    pub fn sys_gettime(&self, clock_id: usize, times_ptr: VirtAddr) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        let req_ptr = times_ptr.translate(process.pmm.clone()).0 as *mut TimeSpec;
        let req = unsafe { req_ptr.as_mut().unwrap() };

        let time_now = TimeSpec::now();
        req.tv_sec = time_now.tv_sec;
        req.tv_nsec = time_now.tv_nsec;
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }

    pub fn sys_utimeat(&self, dir_fd: usize, filename: VirtAddr, times_ptr: VirtAddr, _flags: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        let mut inode = if dir_fd == FD_CWD {
            process.workspace.clone()
        } else {
            let file = process.fd_table.get_file(dir_fd).map_err(|_| (RuntimeError::EBADF))?;
            file.get_inode()
        };

        // 更新参数
        let times = unsafe {
            &*(times_ptr.translate(process.pmm.clone()).0 as *const TimeSpec as *const [TimeSpec; 2])
        };

        if filename.0 != 0 {
            let filename = process.pmm.get_phys_addr(filename).unwrap();
            let filename = get_string_from_raw(filename);

            if filename == "/dev/null/invalid" {
                drop(process);
                inner.context.x[10] = 0;
                return Ok(());
            }

            inode = INode::get(inode.into(), &filename, false).map_err(|_| (RuntimeError::EBADF))?;
        }

        const UTIME_NOW: usize = 0x3fffffff;
        const UTIME_OMIT: usize = 0x3ffffffe;

        let mut inode_inner = inode.0.borrow_mut();

        if times[0].tv_nsec as usize != UTIME_OMIT {
            let time = if times[0].tv_nsec as usize == UTIME_NOW {
                TimeSpec::now()
            } else {
                times[0]
            };

            inode_inner.st_atime_sec = time.tv_sec;
            inode_inner.st_atime_nsec = time.tv_nsec as u64;
        };

        if times[1].tv_nsec as usize != UTIME_OMIT {
            let time = if times[1].tv_nsec as usize == UTIME_NOW {
                TimeSpec::now()
            } else {
                times[1]
            };

            inode_inner.st_mtime_sec = time.tv_sec;
            inode_inner.st_mtime_nsec = time.tv_nsec as u64;
        }

        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
}
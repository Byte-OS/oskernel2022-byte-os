use kernel::runtime_err::RuntimeError;
use kernel::task::fd_table::FD_CWD;
use kernel::interrupt::timer::{TimeSpec, NSEC_PER_SEC, get_time_ns};
use kernel::interrupt::timer::TMS;
use kernel::memory::addr::{VirtAddr, UserAddr};
use kernel::fs::filetree::INode;
use kernel::interrupt::timer::get_ticks;

use crate::SyscallTask;

/// 任务睡眠一段时间
/// 
/// 任务睡眠一段时间 目前采用不断循环的方式直到到达唤醒时间 （后面一定要改）
/// 中间会进行任务切换，而不是让CPU闲置
pub fn sys_nanosleep(task: SyscallTask, req_ptr: UserAddr<TimeSpec>, _rem_ptr: VirtAddr) -> Result<(), RuntimeError> {
    let req_time = req_ptr.transfer();
    let mut inner = task.inner.borrow_mut();

    // 如果任务没有被唤醒过
    if inner.wake_time == 0 {
        // 唤醒时间 = 当前时间 + 需要等待的时间 目前以ns为单位 
        inner.wake_time = get_time_ns() + (req_time.tv_sec * NSEC_PER_SEC) as usize + req_time.tv_nsec as usize;
    }

    if get_time_ns() > inner.wake_time {
        // 到达解锁时间
        inner.wake_time = 0;
        Ok(())
    } else {
        // 未到达解锁时间 重复执行
        inner.context.sepc -= 4;
        return Err(RuntimeError::ChangeTask)
    }
}

/// 获取任务消耗的时间
/// 
/// 获取任务消耗的时间 包含内核态执行时间和用户态执行时间
pub fn sys_times(task: SyscallTask, tms_ptr: UserAddr<TMS>) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    let process = inner.process.borrow_mut();

    // 获取时间结构引用
    let tms = tms_ptr.transfer();

    // 写入进程使用的时间
    tms.tms_cstime = process.tms.tms_cstime;
    tms.tms_cutime = process.tms.tms_cutime;
    drop(process);

    // 更新context
    inner.context.x[10] = get_ticks();
    Ok(())
}

/// 获取时间
/// 
/// 获取当前时间 并写入 `time_ptr`
pub fn sys_gettimeofday(task: SyscallTask, time_ptr: UserAddr<TimeSpec>) -> Result<(), RuntimeError> {
    *time_ptr.transfer() = TimeSpec::now();

    task.update_context(|ctx| ctx.x[10] = 0);
    Ok(())
}


/// 获取时间
/// 
/// 获取时间 目前不考虑clock_id这个参数 sys_gettimeofday相似
pub fn sys_gettime(task: SyscallTask, _clock_id: usize, time_ptr: UserAddr<TimeSpec>) -> Result<(), RuntimeError> {
    *time_ptr.transfer() = TimeSpec::now();

    task.update_context(|ctx| ctx.x[10] = 0);
    Ok(())
}

/// 更改文件的最后访问和修改时间
/// 
/// 详细描述地址: https://man7.org/linux/man-pages/man2/utime.2.html
/// 
pub fn sys_utimeat(task: SyscallTask, dir_fd: usize, filename: UserAddr<u8>, 
    times_ptr: UserAddr<TimeSpec>, _flags: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    let process = inner.process.borrow_mut();

    let mut inode = if dir_fd == FD_CWD {
        // process.workspace.clone()
        // INode::get(None, &process.workspace)?
        process.workspace.clone()
    } else {
        let file = process.fd_table.get_file(dir_fd).map_err(|_| (RuntimeError::EBADF))?;
        file.get_inode()
    };

    // 更新参数
    let times = times_ptr.transfer_vec(2);

    if filename.bits() != 0 {
        let filename = filename.read_string();

        if &filename == "/dev/null/invalid" {
            drop(process);
            inner.context.x[10] = 0;
            return Ok(());
        }

        inode = INode::get(inode.into(), &filename)?;
    }

    const UTIME_NOW: usize = 0x3fffffff;
    const UTIME_OMIT: usize = 0x3ffffffe;

    let _inode_inner = inode.0.borrow_mut();

    if times[0].tv_nsec as usize != UTIME_OMIT {
        let _time = if times[0].tv_nsec as usize == UTIME_NOW {
            TimeSpec::now()
        } else {
            times[0]
        };

        // inode_inner.st_atime_sec = time.tv_sec;
        // inode_inner.st_atime_nsec = time.tv_nsec as u64;
    };

    if times[1].tv_nsec as usize != UTIME_OMIT {
        let _time = if times[1].tv_nsec as usize == UTIME_NOW {
            TimeSpec::now()
        } else {
            times[1]
        };

        // inode_inner.st_mtime_sec = time.tv_sec;
        // inode_inner.st_mtime_nsec = time.tv_nsec as u64;
    }

    drop(process);
    inner.context.x[10] = 0;
    Ok(())
}
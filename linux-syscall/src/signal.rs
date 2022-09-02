use kernel::memory::addr::UserAddr;
use kernel::task::signal::SigSet;
use kernel::task::signal::SigAction;
use kernel::runtime_err::RuntimeError;

use crate::SyscallTask;

/// 遮蔽进程的信号位
/// 
/// 遮蔽进程的信号位，如果oldset指定则复制原来的位
/// set是被操作的位 how指定操作
pub fn sys_sigprocmask(task: SyscallTask, how: u32, set:  UserAddr<SigSet>, oldset: UserAddr<SigSet>,
        _sigsetsize: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();

    // 如果oldset不为0 则复制任务的sig_mask
    if oldset.is_valid() {
        *oldset.transfer() = inner.sig_mask;
    }

    // 如果set不为0 则进行设置
    if set.is_valid() {
        let sig = set.transfer();
        match how {
            0 => inner.sig_mask.block(sig),         // block
            1 => inner.sig_mask.unblock(sig),       // unblock
            2 => inner.sig_mask.copy_from(sig),  // copy
            _ => unimplemented!()
        }
    }
    inner.context.x[10] = 0;
    Ok(())
}

/// 信号处理函数
/// 
/// 根据传入的参数添加信号处理函数 signum是要处理的信号
/// act为处理信号的函数  如果oldact被指定则复制进程的act
pub fn sys_sigaction(task: SyscallTask, signum: usize, act: UserAddr<SigAction>, oldact: UserAddr<SigAction>, 
        _sigsetsize: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    let mut process = inner.process.borrow_mut();

    // 如果oldact有效则复制进程的action
    if oldact.is_valid() {
        *oldact.transfer() = process.sig_actions[signum];
    }
    // 如果act有效则设置进程相应信号的action
    if act.is_valid() {
        process.sig_actions[signum] = *act.transfer();
    }
    drop(process);
    inner.context.x[10] = 0;
    Ok(())
}

/// 信号处理完毕标志
/// 
/// 信号处理完毕后返回SigReturn，会终止信号处理 返回到原来的函数
pub fn sys_sigreturn(_task: SyscallTask) -> Result<(), RuntimeError> {
    Err(RuntimeError::SigReturn)
}
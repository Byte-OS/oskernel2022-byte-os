use kernel::fs::file::fcntl_cmd;
use kernel::runtime_err::RuntimeError;

use crate::SyscallTask;
use crate::fd::open::sys_dup;

pub fn sys_fcntl(task: SyscallTask, fd: usize, cmd: usize, _arg: usize) -> Result<(), RuntimeError> {
    debug!("val: fd {}  cmd {:#x} arg {:#x}", fd, cmd, _arg);
    // let mut inner = self.inner.borrow_mut();
    // let node = self.map.get_mut(&fd).ok_or(SysError::EBADF)?;
    if fd >= 50 {
        // 暂时注释掉 后面使用socket
        // match cmd {
        //     // 复制文件描述符
        //     1 => {
        //         inner.context.x[10] = 1;
        //     }
        //     3 => {
        //         inner.context.x[10] = 0o4000;
        //     },
        //     _n => {
        //         debug!("not imple {}", _n);
        //     },
        // };
    } else {
        match cmd {
            fcntl_cmd::DUPFD_CLOEXEC => {
                debug!("copy value");
                sys_dup(task, fd)?;
            }
            _ => {}
        }
    }
    Ok(())
}
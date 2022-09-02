use alloc::{rc::Rc, string::ToString};

use kernel::fs::file::fcntl_cmd;
use kernel::interrupt::timer::TimeSpec;
use kernel::fs::specials::dev_rtc::DevRtc;
use kernel::fs::stdio::StdNull;
use kernel::fs::filetree::INode;
use kernel::fs::specials::etc_adjtime::EtcAdjtime;
use kernel::fs::specials::proc_meminfo::ProcMeminfo;
use kernel::fs::specials::proc_mounts::ProcMounts;
use kernel::fs::stdio::StdZero;
use kernel::memory::addr::UserAddr;
use kernel::runtime_err::RuntimeError;
use kernel::task::pipe::new_pipe;
use kernel::task::fd_table::FD_NULL;
use kernel::task::fd_table::FileDesc;

use crate::SyscallTask;
use crate::consts::flags::OpenFlags;
use crate::consts::flags::PollFD;

// 复制文件描述符
pub fn sys_dup(task: SyscallTask, fd: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    let mut process = inner.process.borrow_mut();
    let fd_v = process.fd_table.get(fd)?.clone();
    // 判断文件描述符是否存在
    let new_fd = process.fd_table.push(fd_v);
    drop(process);
    inner.context.x[10] = new_fd;
    Ok(())
}
// 复制文件描述符
pub fn sys_dup3(task: SyscallTask, fd: usize, new_fd: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    let mut process = inner.process.borrow_mut();
    // 判断是否存在文件描述符
    let fd_v = process.fd_table.get(fd)?.clone();
    // if let Ok(file) = fd_v.clone().downcast::<File>() {
    //     file.lseek(0, 0);
    // }
    process.fd_table.set(new_fd, fd_v);
    drop(process);
    inner.context.x[10] = new_fd;
    Ok(())
}
// 打开文件
pub fn sys_openat(task: SyscallTask, fd: usize, filename: UserAddr<u8>, flags: usize, _open_mod: usize) -> Result<(), RuntimeError> {
    let filename = filename.read_string();
    let mut inner = task.inner.borrow_mut();
    let mut process = inner.process.borrow_mut();

    // 获取文件信息
    let flags = OpenFlags::from_bits_truncate(flags as u32);

    if filename == "/dev/zero" {
        let fd = process.fd_table.push(FileDesc::new(Rc::new(StdZero)));
        drop(process);
        inner.context.x[10] = fd;
        return Ok(())
    } else if filename == "/dev/null" {
        let fd = process.fd_table.push(FileDesc::new(Rc::new(StdNull)));
        drop(process);
        inner.context.x[10] = fd;
        return Ok(())
    } else if filename == "/proc/mounts" {
        let fd = process.fd_table.push(FileDesc::new(Rc::new(ProcMounts::new())));
        drop(process);
        inner.context.x[10] = fd;
        return Ok(())
    } else if filename == "/proc/meminfo" {
        let fd = process.fd_table.push(FileDesc::new(Rc::new(ProcMeminfo::new())));
        drop(process);
        inner.context.x[10] = fd;
        return Ok(())
    } else if filename == "/etc/adjtime" {
        let fd = process.fd_table.push(FileDesc::new(Rc::new(EtcAdjtime::new())));
        drop(process);
        inner.context.x[10] = fd;
        return Ok(())
    } else if filename == "/dev/rtc" {
        let fd = process.fd_table.push(FileDesc::new(Rc::new(DevRtc::new())));
        drop(process);
        inner.context.x[10] = fd;
        return Ok(())
    }


    // 判断文件描述符是否存在
    let current = if fd == FD_NULL {
        None
    } else {
        let file = process.fd_table.get_file(fd)?;
        Some(file.get_inode())
    };
    // 根据文件类型匹配
    let file = if flags.contains(OpenFlags::CREATE) {
        INode::open_or_create(current, &filename)?
    } else {
        INode::open(current, &filename)?
    };
    // if flags.contains(OpenFlags::WRONLY) {
    //     file.lseek(0, 2);
    // }
    let fd = process.fd_table.alloc();
    process.fd_table.set(fd, FileDesc::new(file));
    drop(process);
    inner.context.x[10] = fd;
    Ok(())
}
// 关闭文件
pub fn sys_close(task: SyscallTask, fd: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    let mut process = inner.process.borrow_mut();
    process.fd_table.dealloc(fd);
    drop(process);
    inner.context.x[10] = 0;
    Ok(())
}

pub fn sys_readlinkat(task: SyscallTask, dir_fd: usize, path: UserAddr<u8>, 
    buf: UserAddr<u8>, len: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    let path = path.read_string();
    let path = if path == "/proc/self/exe" {
        "/lmbench_all".to_string()
    } else {
        path
    };
    let path = path.as_bytes();

    let buf = buf.transfer_vec(len);
    // let inode = INode::get(None, &path)?;
    // let read_len = inode.read_to(buf)?;
    // debug!("read_len: {:#x}", read_len);
    buf[..path.len()].copy_from_slice(path);
    inner.context.x[10] = path.len();
    Ok(())
}

pub fn sys_ppoll(task: SyscallTask, fds: UserAddr<PollFD>, nfds: usize, _timeout: UserAddr<TimeSpec>) -> Result<(), RuntimeError> {
    let fds = fds.transfer_vec(nfds);
    let mut inner = task.inner.borrow_mut();
    inner.context.x[10] = 1;
    Ok(())
}

// 管道符
pub fn sys_pipe2(task: SyscallTask, req_ptr: UserAddr<u32>) -> Result<(), RuntimeError> {
    let pipe_arr =  req_ptr.transfer_vec(2);
    let mut inner = task.inner.borrow_mut();
    let mut process = inner.process.borrow_mut();
    // 创建pipe
    let (read_pipe, write_pipe) = new_pipe();
    // 写入数据
    pipe_arr[0] = process.fd_table.push(read_pipe) as u32;
    pipe_arr[1] = process.fd_table.push(write_pipe) as u32;
            
    drop(process);
    // 创建成功
    inner.context.x[10] = 0;
    Ok(())
}

/// 操作文件描述符
/// 
/// 对打开的文件描述符fd执行操作。操作由cmd决定。
/// 详细描述地址: https://man7.org/linux/man-pages/man2/fcntl.2.html
pub fn sys_fcntl(task: SyscallTask, fd: usize, cmd: usize, _arg: usize) -> Result<(), RuntimeError> {
    match cmd {
        fcntl_cmd::DUPFD_CLOEXEC => sys_dup(task, fd)?,
        _ => {}
    }
    Ok(())
}
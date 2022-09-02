use kernel::interrupt::timer::TimeVal;
use kernel::memory::addr::UserAddr;
use kernel::task::task::Rusage;
use kernel::runtime_err::RuntimeError;

use crate::SyscallTask;
use crate::consts::errors::EPERM;

// 系统信息结构
pub struct UTSname  {
    sysname: [u8;65],
    nodename: [u8;65],
    release: [u8;65],
    version: [u8;65],
    machine: [u8;65],
    domainname: [u8;65],
}

// 获取系统信息
pub fn sys_uname(task: SyscallTask, ptr: UserAddr<UTSname>) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();

    // 获取参数
    let sys_info = ptr.transfer();
    // 写入系统信息

    // let sys_name = b"ByteOS";
    // let sys_nodename = b"ByteOS";
    // let sys_release = b"release";
    // let sys_version = b"alpha 1.1";
    // let sys_machine = b"riscv k210";
    // let sys_domain = b"alexbd.cn";
    let sys_name = b"Linux";
    let sys_nodename = b"debian";
    let sys_release = b"5.10.0-7-riscv64";
    let sys_version = b"#1 SMP Debian 5.10.40-1 (2021-05-28)";
    let sys_machine = b"riscv k210";
    let sys_domain = b"alexbd.cn";

    sys_info.sysname[..sys_name.len()].copy_from_slice(sys_name);
    sys_info.nodename[..sys_nodename.len()].copy_from_slice(sys_nodename);
    sys_info.release[..sys_release.len()].copy_from_slice(sys_release);
    sys_info.version[..sys_version.len()].copy_from_slice(sys_version);
    sys_info.machine[..sys_machine.len()].copy_from_slice(sys_machine);
    sys_info.domainname[..sys_domain.len()].copy_from_slice(sys_domain);
    inner.context.x[10] = 0;
    Ok(())
}

// 获取pid
pub fn sys_getpid(task: SyscallTask) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    inner.context.x[10] = task.pid;
    Ok(())
}

// 获取父id
pub fn sys_getppid(task: SyscallTask) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    let process = inner.process.clone();
    let process = process.borrow();

    inner.context.x[10] = match &process.parent {
        Some(parent) => {
            let parent = parent.upgrade().unwrap();
            let x = parent.borrow().pid; 
            x
        },
        None => EPERM
    };

    Ok(())
}

// 获取线程id
pub fn sys_gettid(task: SyscallTask) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    inner.context.x[10] = task.tid;
    Ok(())
}

pub fn sys_getrusage(task: SyscallTask, _who: usize, usage: UserAddr<Rusage>) -> Result<(), RuntimeError>{
    let mut inner = task.inner.borrow_mut();
    let usage = usage.transfer();
    usage.ru_stime = TimeVal::now();
    usage.ru_utime = TimeVal::now();
    inner.context.x[10] = EPERM;
    Ok(())
}

// 设置 tid addr
pub fn sys_set_tid_address(task: SyscallTask, tid_ptr: UserAddr<u32>) -> Result<(), RuntimeError> {
    // 测试写入用户空间
    let tid_ptr = tid_ptr.transfer();
    let mut inner = task.inner.borrow_mut();
    let clear_child_tid = task.clear_child_tid.borrow().clone();

    *tid_ptr = if clear_child_tid.is_valid() {
        clear_child_tid.transfer().clone()
    } else {
        0
    };

    inner.context.x[10] = task.tid;
    Ok(())
}
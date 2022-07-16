use alloc::{vec::Vec, string::String};

use crate::{task::{kill_current_task, task_scheduler::get_current_process, suspend_and_run_next, exec, wait_task, get_current_task}, runtime_err::RuntimeError, memory::addr::{PhysAddr, VirtAddr}};

use super::{UTSname, write_string_to_raw, SYS_CALL_ERR, get_string_from_raw, get_usize_vec_from_raw};

pub fn sys_exit() -> Result<usize, RuntimeError> {
    kill_current_task();
    Ok(0)
}

pub fn sys_exit_group(exit_code: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process();
    let mut process = process.borrow_mut();
    process.exit(exit_code);
    drop(process);
    kill_current_task();
    let task = get_current_task().unwrap();
    let task_inner = task.inner.borrow_mut();
    info!("task spec: {:#x}", task_inner.context.sepc);
    Ok(0)
}

pub fn sys_set_tid_address(tid_ptr: usize) -> Result<usize, RuntimeError> {
    let task = get_current_task().unwrap();
    let process = get_current_process();
    let process = process.borrow_mut();
    let tid_ptr_addr = process.pmm.get_phys_addr(tid_ptr.into())?;
    let tid_ptr = tid_ptr_addr.0 as *mut u32;
    unsafe {tid_ptr.write(task.tid as u32)};
    Ok(0)
}

pub fn sys_sched_yield() -> Result<usize, RuntimeError> {
    suspend_and_run_next();
    Ok(0)
}

pub fn sys_uname(ptr: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process();
    let process = process.borrow_mut();

    // 获取参数
    let sys_info = usize::from(process.pmm.get_phys_addr(ptr.into()).unwrap()) as *mut UTSname;
    let sys_info = unsafe { sys_info.as_mut().unwrap() };
    // 写入系统信息
    write_string_to_raw(&mut sys_info.sysname, "ByteOS");
    write_string_to_raw(&mut sys_info.nodename, "ByteOS");
    write_string_to_raw(&mut sys_info.release, "release");
    write_string_to_raw(&mut sys_info.version, "alpha 1.1");
    write_string_to_raw(&mut sys_info.machine, "riscv k210");
    write_string_to_raw(&mut sys_info.domainname, "alexbd.cn");
    Ok(0)
}

pub fn sys_getpid() -> Result<usize, RuntimeError> {
    Ok(get_current_process().borrow().pid)
}

pub fn sys_getppid() -> Result<usize, RuntimeError> {
    let process = get_current_process();
    let process = process.borrow();

    Ok(match &process.parent {
        Some(parent) => parent.borrow().pid,
        None => SYS_CALL_ERR
    })
}

pub fn sys_clone(flags: usize, new_sp: usize, ptid: usize, tls: usize, ctid: usize) -> Result<usize, RuntimeError> {

    info!(
        "clone: flags={:#x}, newsp={:#x}, parent_tid={:#x}, child_tid={:#x}, newtls={:#x}",
        flags, new_sp, ptid, tls, ctid
    );

    if flags == 0x4111 || flags == 0x11 {
        // VFORK | VM | SIGCHILD
        warn!("sys_clone is calling sys_fork instead, ignoring other args");
    }
    Ok(0)
}

pub fn sys_execve(filename: usize, argv: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process();
    let process = process.borrow_mut();
    let filename = process.pmm.get_phys_addr(filename.into()).unwrap();
    let filename = get_string_from_raw(filename);
    let argv_ptr = process.pmm.get_phys_addr(argv.into()).unwrap();
    let args = get_usize_vec_from_raw(argv_ptr);
    let args: Vec<PhysAddr> = args.iter().map(
        |x| process.pmm.get_phys_addr(VirtAddr::from(x.clone())).expect("can't transfer")
    ).collect();
    let args: Vec<String> = args.iter().map(|x| get_string_from_raw(x.clone())).collect();
    let args: Vec<&str> = args.iter().map(AsRef::as_ref).collect();
    
    exec(&filename, args)?;
    // exec(&filename, vec![]);
    drop(process);
    kill_current_task();
    Ok(0)
}

pub fn sys_wait4(pid: usize, ptr: usize, options: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process();
    let process = process.borrow_mut();
    info!("wait pid: {}, current pid: {}", pid, process.pid);
    let ptr = usize::from(process.pmm.get_phys_addr(ptr.into()).unwrap()) as *mut u16;
    // wait_task中进行上下文大小
    wait_task(pid, ptr, options);
    Ok(0)
}

pub fn sys_kill(pid: usize, signum: usize) -> Result<usize, RuntimeError> {
    info!(
        "kill: thread {} kill process {} with signal {:?}",
        0,
        pid,
        signum
    );
    Ok(1)
}
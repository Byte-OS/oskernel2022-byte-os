use alloc::{vec::Vec, string::String};

use crate::{task::{kill_current_task, task_scheduler::add_task_to_scheduler, exec, wait_task, process::Process, pid::get_next_pid, task::Task}, runtime_err::RuntimeError, memory::addr::{PhysAddr, VirtAddr}};
use crate::task::task::TaskStatus;

use super::{UTSname, write_string_to_raw, SYS_CALL_ERR, get_string_from_raw, get_usize_vec_from_raw};

impl Task {
    pub fn sys_exit(&self) -> Result<(), RuntimeError> {
        kill_current_task();
        Err(RuntimeError::ChangeTask)
    }
    
    pub fn sys_exit_group(&self, exit_code: usize) -> Result<(), RuntimeError> {
        let inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        process.exit(exit_code);
        // suspend_and_run_next();
        // kill_current_task();
        Err(RuntimeError::ChangeTask)
    }
    
    pub fn sys_set_tid_address(&self, tid_ptr: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        let tid_ptr_addr = process.pmm.get_phys_addr(tid_ptr.into())?;
        let tid_ptr = tid_ptr_addr.0 as *mut u32;
        unsafe {tid_ptr.write(self.tid as u32)};
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
    
    pub fn sys_sched_yield(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.status = TaskStatus::READY;
        Err(RuntimeError::ChangeTask)
    }
    
    pub fn sys_uname(&self, ptr: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
    
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
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
    
    pub fn sys_getpid(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = self.pid;
        Ok(())
    }
    
    pub fn sys_getppid(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.clone();
        let process = process.borrow();

        inner.context.x[10] = match &process.parent {
            Some(parent) => parent.borrow().pid,
            None => SYS_CALL_ERR
        };

        Ok(())
    }
    
    pub fn sys_gettid(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = self.tid;
        Ok(())
    }
    
    pub fn sys_fork(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.clone();
        let process = process.borrow_mut();

        let (child_process, child_task) =
            Process::new(get_next_pid(), Some(inner.process.clone()))?;

        let mut child_task_inner = child_task.inner.borrow_mut();
        child_task_inner.context.clone_from(&inner.context);
        child_task_inner.context.x[10] = 0;
        drop(child_task_inner);
        add_task_to_scheduler(child_task.clone());
        let cpid = child_task.pid;
        inner.context.x[10] = cpid;
        let mut child_process = child_process.borrow_mut();
        child_process.mem_set = process.mem_set.clone_with_data()?;
        child_process.stack = process.stack.clone_with_data(child_process.pmm.clone())?;
    
        child_process.pmm.add_mapping_by_set(&child_process.mem_set)?;
        // suspend_and_run_next();
        Err(RuntimeError::ChangeTask)
    }
    
    pub fn sys_clone(&self, flags: usize, new_sp: usize, ptid: usize, tls: usize, ctid: usize) -> Result<(), RuntimeError> {
        info!(
            "clone: flags={:#x}, newsp={:#x}, parent_tid={:#x}, child_tid={:#x}, newtls={:#x}",
            flags, new_sp, ptid, tls, ctid
        );
    
        if flags == 0x4111 || flags == 0x11 {
            // VFORK | VM | SIGCHILD
            warn!("sys_clone is calling sys_fork instead, ignoring other args");
            return self.sys_fork();
        }
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = 0;
        Ok(())
    }
    
    pub fn sys_execve(&self, filename: usize, argv: usize) -> Result<(), RuntimeError> {
        let inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        let filename = process.pmm.get_phys_addr(filename.into()).unwrap();
        let filename = get_string_from_raw(filename);
        let argv_ptr = process.pmm.get_phys_addr(argv.into()).unwrap();
        let args = get_usize_vec_from_raw(argv_ptr);
        let args: Vec<PhysAddr> = args.iter().map(
            |x| process.pmm.get_phys_addr(VirtAddr::from(x.clone())).expect("can't transfer")
        ).collect();
        let args: Vec<String> = args.iter().map(|x| get_string_from_raw(x.clone())).collect();
        let args: Vec<&str> = args.iter().map(AsRef::as_ref).collect();
        drop(process);
        exec(&filename, args)?;
        kill_current_task();
        Err(RuntimeError::ChangeTask)
    }
    
    pub fn sys_wait4(&self, pid: usize, ptr: usize, options: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        info!("wait pid: {}, current pid: {}", pid, process.pid);
        let ptr = usize::from(process.pmm.get_phys_addr(ptr.into()).unwrap()) as *mut u16;
        // wait_task中进行上下文大小
        wait_task(pid, ptr, options);
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
    
    pub fn sys_kill(&self, pid: usize, signum: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        info!(
            "kill: thread {} kill process {} with signal {:?}",
            0,
            pid,
            signum
        );
        inner.context.x[10] = 1;
        Ok(())
    }
}
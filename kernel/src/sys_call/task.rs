use alloc::vec::Vec;
use alloc::string::String;
use alloc::rc::{Rc, Weak};
use hashbrown::HashMap;

use crate::task::task_scheduler::{add_task_to_scheduler, get_task, get_task_num};
use crate::task::task_scheduler::switch_next;
use crate::task::task_scheduler::get_current_task;
use crate::task::process::Process;
use crate::task::pid::get_next_pid;
use crate::task::task::Task;
use crate::task::{exec_with_process, UserHeap};
use crate::runtime_err::RuntimeError;
use crate::memory::addr::{UserAddr, write_string_to_raw};

use crate::sync::mutex::Mutex;
use crate::task::task::TaskStatus;

use super::UTSname;
use super::SYS_CALL_ERR;

bitflags! {
    struct FutexFlags: u32 {
        const WAIT      = 0;
        const WAKE      = 1;
        const REQUEUE   = 3;
        const FUTEX_WAKE_OP = 5;
        const LOCK_PI   = 6;
        const UNLOCK_PI = 7;
        const PRIVATE   = 0x80;
    }
}

impl Task {
    /// 退出当前任务 
    pub fn sys_exit(&self, exit_code: usize) -> Result<(), RuntimeError> {
        let inner = self.inner.borrow();
        if self.tid == 0 {
            inner.process.borrow_mut().exit(exit_code);
        } else {
            self.exit();
        }

        let clear_child_tid = self.clear_child_tid.borrow().clone();
        if clear_child_tid.is_valid() {
            *clear_child_tid.translate(self.get_pmm()) = 0;
        }
        Err(RuntimeError::KillCurrentTask)
    }
    
    // 退出当前进程？ eg: 功能也许有待完善
    pub fn sys_exit_group(&self, exit_code: usize) -> Result<(), RuntimeError> {
        let inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        process.exit(exit_code);
        debug!("exit_code: {:#x}", exit_code);
        Err(RuntimeError::ChangeTask)
    }
    
    // 设置 tid addr
    pub fn sys_set_tid_address(&self, tid_ptr: UserAddr<u32>) -> Result<(), RuntimeError> {
        let tid_ptr = tid_ptr.translate(self.get_pmm());
        let mut inner = self.inner.borrow_mut();
        let pmm = inner.process.borrow().pmm.clone();
        let clear_child_tid = self.clear_child_tid.borrow().clone();

        *tid_ptr = if clear_child_tid.is_valid() {
            clear_child_tid.translate(pmm).clone()
        } else {
            0
        };

        inner.context.x[10] = self.tid;
        Ok(())
    }
    
    pub fn sys_sched_yield(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.status = TaskStatus::READY;
        Err(RuntimeError::ChangeTask)
    }
    
    // 获取系统信息
    pub fn sys_uname(&self, ptr: UserAddr<UTSname>) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
    
        // 获取参数
        let sys_info = ptr.translate(inner.process.borrow().pmm.clone());
        // 写入系统信息
        write_string_to_raw(&mut sys_info.sysname, "ByteOS");
        write_string_to_raw(&mut sys_info.nodename, "ByteOS");
        write_string_to_raw(&mut sys_info.release, "release");
        write_string_to_raw(&mut sys_info.version, "alpha 1.1");
        write_string_to_raw(&mut sys_info.machine, "riscv k210");
        write_string_to_raw(&mut sys_info.domainname, "alexbd.cn");
        inner.context.x[10] = 0;
        Ok(())
    }
    
    // 获取pid
    pub fn sys_getpid(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = self.pid;
        Ok(())
    }
    
    // 获取父id
    pub fn sys_getppid(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.clone();
        let process = process.borrow();

        inner.context.x[10] = match &process.parent {
            Some(parent) => {
                let parent = parent.upgrade().unwrap();
                let x = parent.borrow().pid; 
                x
            },
            None => SYS_CALL_ERR
        };

        Ok(())
    }
    
    // 获取线程id
    pub fn sys_gettid(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = self.tid;
        Ok(())
    }
    
    // fork process
    pub fn sys_fork(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.clone();
        let mut process = process.borrow_mut();

        let (child_process, child_task) =
            Process::new(get_next_pid(), Some(Rc::downgrade(&inner.process)))?;
        process.children.push(child_process.clone());
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
        // 复制fd_table
        child_process.fd_table = process.fd_table.clone();
        // 创建新的heap
        child_process.heap = UserHeap::new(child_process.pmm.clone())?;
        child_process.pmm.add_mapping_by_set(&child_process.mem_set)?;
        drop(process);
        drop(child_process);
        drop(inner);
        Err(RuntimeError::ChangeTask)
    }
    
    // clone task
    pub fn sys_clone(&self, flags: usize, new_sp: usize, ptid: UserAddr<u32>, tls: usize, ctid_ptr: UserAddr<u32>) -> Result<(), RuntimeError> {
        if flags == 0x4111 || flags == 0x11 {
            // VFORK | VM | SIGCHILD
            warn!("sys_clone is calling sys_fork instead, ignoring other args");
            return self.sys_fork();
        }

        debug!(
            "clone: flags={:?}, newsp={:#x}, parent_tid={:#x}, child_tid={:#x}, newtls={:#x}",
            flags, new_sp, ptid.bits(), ctid_ptr.0 as usize, tls
        );

        let mut inner = self.inner.borrow_mut();
        let process = inner.process.clone();
        let process = process.borrow();
        let ptid_ref = ptid.translate(process.pmm.clone());
        
        let ctid = process.tasks.len();
        drop(process);

        let new_task = Task::new(ctid, inner.process.clone());
        let mut new_task_inner = new_task.inner.borrow_mut();
        new_task_inner.context.clone_from(&inner.context);
        new_task_inner.context.x[2] = new_sp;
        new_task_inner.context.x[4] = tls;
        new_task_inner.context.x[10] = 0;
        add_task_to_scheduler(new_task.clone());
        // 添加到process
        inner.context.x[10] = ctid;
        
        debug!("tasks: len {}", get_task_num());

        drop(new_task_inner);
        drop(inner);
        *ptid_ref = ctid as u32;
        // 执行 set_tid_address
        new_task.set_tid_address(ctid_ptr);
        // just finish clone, not change task
        Ok(())
    }

    // 执行文件
    pub fn sys_execve(&self, filename: UserAddr<u8>, argv: UserAddr<UserAddr<u8>>, 
            _envp: UserAddr<UserAddr<u8>>) -> Result<(), RuntimeError> {
        let inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        let pmm = process.pmm.clone();
        let filename = filename.read_string(pmm.clone());
        let args = argv.translate_until(pmm.clone(), |x| !x.is_valid());
        let args:Vec<String> = args.iter_mut().map(|x| x.read_string(pmm.clone())).collect();

        // 读取envp
        // let envp = argv.translate_until(pmm.clone(), |x| !x.is_valid());
        // let envp:Vec<String> = envp.iter_mut().map(|x| x.read_string(pmm.clone())).collect();

        // 获取 envp
        let task = process.tasks[self.tid].clone().upgrade().unwrap();
        process.reset()?;
        drop(process);
        let process = inner.process.clone();
        drop(inner);
        exec_with_process(process, task, &filename, args.iter().map(AsRef::as_ref).collect())?;
        Ok(())
    }
    
    // wait task
    pub fn sys_wait4(&self, pid: usize, ptr: UserAddr<i32>, _options: usize) -> Result<(), RuntimeError> {
        debug!("wait for pid: {:#x} options: {:#x}", pid, _options);
        let ptr = ptr.translate(self.get_pmm());
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.clone();
        let mut process = process.borrow_mut();
        if pid != SYS_CALL_ERR {
            let target = 
            process.children.iter().find(|&x| x.borrow().pid == pid);
        
            if let Some(exit_code) = target.map_or(None, |x| x.borrow().exit_code) {
                *ptr = exit_code as i32;
                inner.context.x[10] = pid;
                return Ok(())
            }
        } else {
            let cprocess = process.children.iter().find(|&x| x.borrow().exit_code.is_some());
            if let Some(proc) = cprocess.map_or(None, |x| Some(x.borrow())) {
                let cpid = proc.pid;
                let exit_code = proc.exit_code.unwrap();
                drop(proc);
                drop(cprocess);
                process.children.drain_filter(|x| x.borrow().pid == pid);
                *ptr = exit_code as i32;
                // inner.context.x[10] = pid;
                inner.context.x[10] = cpid;
                debug!("kill pid: {} exit_code: {}", cpid, exit_code);
                return Ok(())
            }
        }
        inner.context.sepc -= 4;
        drop(process);
        drop(inner);
        Err(RuntimeError::ChangeTask)
    }
    
    // kill task
    pub fn sys_kill(&self, _pid: usize, _signum: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        debug!(
            "kill: thread {} kill process {} with signal {:?}",
            0,
            _pid,
            _signum
        );
        inner.context.x[10] = 1;
        Ok(())
    }

    // wait for futex
    pub fn sys_futex(&self, uaddr: UserAddr<i32>, op: u32, value: i32, value2: usize, value3: usize) -> Result<(), RuntimeError> {
        debug!("sys_futex uaddr: {:#x} op: {:#x} value: {:#x}", uaddr.bits(), op, value);
        let uaddr_ref = uaddr.translate(self.get_pmm());
        let op = FutexFlags::from_bits_truncate(op);
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        let op = op - FutexFlags::PRIVATE;
        debug!(
            "Futex uaddr: {:#x}, op: {:?}, val: {:#x}, val2(timeout_addr): {:x}",
            uaddr.bits(), op, value, value2,
        );
        match op {
            FutexFlags::WAIT => {
                if *uaddr_ref == value {
                    drop(process);
                    debug!("等待进程");
                    inner.context.x[10] = 0;
                    inner.status = TaskStatus::WAITING;
                    drop(inner);
                    futex_wait(uaddr.bits());
                    switch_next();
                } else {
                    // *uaddr_value -= 1;
                    drop(process);
                    inner.context.x[10] = 0;
                }
            },
            FutexFlags::WAKE => {
                // *uaddr_value = -1;
                drop(process);
                debug!("debug for ");
                // 值为唤醒的线程数
                let count = futex_wake(uaddr.bits(), value as usize);
                inner.context.x[10] = count;
                debug!("wake count : {}", count);
                drop(inner);
                switch_next();
            }
            FutexFlags::REQUEUE => {
                drop(process);
                inner.context.x[10] = 0;

            }
            _ => todo!(),
        }
        if op.contains(FutexFlags::WAKE) {
            // *uaddr_value = 0;
            futex_requeue(uaddr.bits(), value as u32, value2, value3 as u32);
        }
        Ok(())
    }

    // kill task
    pub fn sys_tkill(&self, tid: usize, signum: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = 0;
        let signal_task = get_task(self.pid, tid);
        debug!("signum: {}", signum);
        if let Some(signal_task) = signal_task {
            drop(inner);
            signal_task.signal(signum)?;
        }
        Ok(())
    }
}

lazy_static! {
    pub static ref WAIT_MAP: Mutex<HashMap<usize, FutexWait>> = Mutex::new(HashMap::new());
}

pub struct FutexWait {
    wait_queue: Vec<Weak<Task>>
}

pub fn futex_wait(addr: usize) {
    let task = get_current_task().unwrap();
    let mut wait_map = WAIT_MAP.force_get();
    let futex_wait = wait_map.entry(addr).or_insert(FutexWait {
        wait_queue: vec![]
    });
    futex_wait.wait_queue.push(Rc::downgrade(&task));
}

pub fn futex_wake(addr: usize, count: usize) -> usize {
    let mut wait_map = WAIT_MAP.force_get();
    match wait_map.get_mut(&addr) {
        Some(tasks_queue) => {
            let mut n = 0;
            if n >= count {
                return n;
            }
            while let Some(_) = tasks_queue.wait_queue.pop() {
                n+=1;
            }
            n
        }
        None => 0
    }
}

pub fn futex_requeue(_uaddr: usize, nr_wake: u32, _uaddr2: usize, _nr_limit: u32) -> isize {


    return nr_wake as isize;
}
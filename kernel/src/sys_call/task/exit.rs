use crate::{task::{task::Task, task_scheduler::get_task}, runtime_err::RuntimeError, sys_call::{remove_vfork_wait, SYS_CALL_ERR}, memory::page::get_free_page_num};

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
            *clear_child_tid.transfer() = 0;
        }
        Err(RuntimeError::KillCurrentTask)
    }
    
    // 退出当前进程？ eg: 功能也许有待完善
    pub fn sys_exit_group(&self, exit_code: usize) -> Result<(), RuntimeError> {
        let inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        debug!("exit pid: {}", self.pid);
        process.exit(exit_code);
        match &process.parent {
            Some(parent) => {
                let parent = parent.upgrade().unwrap();
                let parent = parent.borrow();
                remove_vfork_wait(parent.pid);
                
                let task = parent.tasks[0].upgrade().unwrap().clone();
                let mut task_inner = task.inner.borrow_mut();

                task_inner.context.x[10] = -1 as isize as usize;

                debug!("parent:context:
                ra: {:#},
                sp: {:#},
                gp: {:#},
                tp: {:#},
                t0: {:#},
                t1: {:#},
                t2: {:#},
                t3: {:#},
                t4: {:#},
                t5: {:#},
                t6: {:#},
                a0: {:#},
                a1: {:#},
                a2: {:#},
                a3: {:#},
                a4: {:#},
                a5: {:#},
                a6: {:#},
                a7: {:#},
                s0: {:#},
                s1: {:#},
                s2: {:#},
                s3: {:#},
                s4: {:#},
                s5: {:#},
                s6: {:#},
                s7: {:#},
                s8: {:#},
                s9: {:#},
                s10: {:#},
                s11: {:#}",
                task_inner.context.x[1],
                task_inner.context.x[2],
                task_inner.context.x[3],
                task_inner.context.x[4],
                task_inner.context.x[5],
                task_inner.context.x[6],
                task_inner.context.x[7],
                task_inner.context.x[28],
                task_inner.context.x[29],
                task_inner.context.x[30],
                task_inner.context.x[31],
                task_inner.context.x[10],
                task_inner.context.x[11],
                task_inner.context.x[12],
                task_inner.context.x[13],
                task_inner.context.x[14],
                task_inner.context.x[15],
                task_inner.context.x[16],
                task_inner.context.x[17],
                task_inner.context.x[8],
                task_inner.context.x[9],
                task_inner.context.x[18],
                task_inner.context.x[19],
                task_inner.context.x[20],
                task_inner.context.x[21],
                task_inner.context.x[22],
                task_inner.context.x[23],
                task_inner.context.x[24],
                task_inner.context.x[25],
                task_inner.context.x[26],
                task_inner.context.x[27],
            );

                // let end: UserAddr<TimeSpec> = 0x10bb78.into();
                // let start: UserAddr<TimeSpec> = 0x10bad0.into();

                // println!("start: {:?}   end: {:?}",start.transfer(), end.transfer());

                // let target_end: UserAddr<TimeSpec> = parent.pmm.get_phys_addr(0x10bb78usize.into())?.0.into();
                // let target_start: UserAddr<TimeSpec> = parent.pmm.get_phys_addr(0x10bad0usize.into())?.0.into();
                // *target_start.transfer() = *start.transfer();
                // *target_end.transfer() = *end.transfer();

                // let task = parent.tasks[0].clone().upgrade().unwrap();
                // drop(parent);
                // // 处理signal 17 SIGCHLD
                // task.signal(17);
            }
            None => {}
        }
        debug!("剩余页表: {}", get_free_page_num());
        debug!("exit_code: {:#x}", exit_code);
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

        inner.context.x[10] = 0;
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

    pub fn sys_tgkill(&self, tgid: usize, tid: usize, signum: usize) -> Result<(), RuntimeError> {
        debug!("tgkill: tgid: {}  tid: {}  signum {}", tgid, tid, signum);
        if let Some(task) = get_task(tgid, tid) {
            task.signal(signum)?;
        } else {
            self.update_context(|x| x.x[10] = SYS_CALL_ERR);
        }
        Ok(())
    }
    
}
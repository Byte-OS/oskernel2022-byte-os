use crate::memory::addr::UserAddr;
use crate::task::task::Task;
use crate::task::signal::SigSet;
use crate::task::signal::SigAction;
use crate::runtime_err::RuntimeError;

impl Task {
    pub fn sys_sigprocmask(&self, how: u32, set:  UserAddr<SigSet>, oldset: UserAddr<SigSet>,
            _sigsetsize: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        debug!(
            "rt_sigprocmask: how={:#x}, set={:#?}, oldset={:#?}, sigsetsize={}, thread={}",
            how,
            set.bits(),
            oldset.bits(),
            _sigsetsize,
            self.tid
        );
        if oldset.is_valid() {
            oldset.translate(process.pmm.clone()).copy_from(&process.signal.mask);
        }
        if set.is_valid() {
            let sig = set.translate(process.pmm.clone());
            match how {
                // block
                0 => process.signal.mask.block(sig),
                // unblock
                1 => process.signal.mask.unblock(sig),
                // setmask
                2 => process.signal.mask.copy_from(sig),
                _ => unimplemented!()
            }
        }
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }

    pub fn sys_sigaction(&self, _signum: usize, act: UserAddr<SigAction>, oldact: UserAddr<SigAction>, 
            _sigsetsize: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        if oldact.is_valid() {
            oldact.translate(process.pmm.clone()).copy_from(&process.signal);
        }
        if act.is_valid() {
            let act = act.translate(process.pmm.clone());
            debug!(
                "rt_sigaction: signal={:?}, act={:?}, oldact={:?}, sigsetsize={}, thread={}",
                _signum,
                act,
                oldact.bits(),
                _sigsetsize,
                self.tid
            );
            process.signal.copy_from(act);
        }
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }

    pub fn sys_sigreturn(&self) -> Result<(), RuntimeError> {
        debug!("sig return");
        Err(RuntimeError::SigReturn)
    }
}
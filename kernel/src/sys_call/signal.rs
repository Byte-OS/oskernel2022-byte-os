use crate::{task::{task::Task, signal::{SigSet, SigAction}}, runtime_err::RuntimeError, memory::addr::VirtAddr};

impl Task {
    pub fn sys_sigprocmask(&self, how: u32, set: VirtAddr, oldset: VirtAddr, sigsetsize: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        debug!(
            "rt_sigprocmask: how={:#x}, set={:#?}, oldset={:#?}, sigsetsize={}, thread={}",
            how,
            set,
            oldset,
            sigsetsize,
            self.tid
        );
        if oldset.is_valid() {
            debug!("clone");
            let sig = oldset.translate(process.pmm.clone()).tranfer::<SigSet>();
            sig.copy_from(&process.signal.mask)
        }
        if set.is_valid() {
            let sig = set.translate(process.pmm.clone()).tranfer::<SigSet>();
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

    pub fn sys_sigaction(&self, signum: usize, act: VirtAddr, oldact: VirtAddr, sigsetsize: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        if oldact.is_valid() {
            let act = oldact.translate(process.pmm.clone()).tranfer::<SigAction>();
            act.copy_from(&process.signal);
        }
        if act.is_valid() {
            let act = act.translate(process.pmm.clone()).tranfer::<SigAction>();
            debug!(
                "rt_sigaction: signal={:?}, act={:?}, oldact={:?}, sigsetsize={}, thread={}",
                signum,
                act,
                oldact,
                sigsetsize,
                self.tid
            );
            process.signal.copy_from(act);
        }
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
}
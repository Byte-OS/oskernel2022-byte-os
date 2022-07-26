use crate::interrupt::Context;

#[derive(Clone, Copy, Debug)]
pub struct SigSet(u64);

impl SigSet {
    pub fn block(&mut self, set: &SigSet) {
        self.0 |= set.0;
    }

    pub fn unblock(&mut self, set: &SigSet) {
        self.0 ^= self.0 & set.0;
    }

    pub fn copy_from(&mut self, target: &Self) {
        self.0 = target.0;
    }
}

impl Default for SigSet {
    fn default() -> Self {
        Self(0)
    }
}

impl From<u64> for SigSet {
    fn from(value: u64) -> Self {
        Self (value)
    }
}

impl Into<u64> for SigSet {
    fn into(self) -> u64 {
        self.0
    }
}

#[derive(Debug)]
#[repr(C)]
pub struct SigAction {
    pub handler: usize,
    pub mask: SigSet,
    pub flags: usize,
    pub restorer: usize,
}

impl SigAction {
    pub fn new() -> Self {
        Self {
            handler: 0,
            flags: 0,
            restorer: 0,
            mask: Default::default()
        }
    }

    pub fn copy_from(&mut self, target: &Self) {
        self.handler = target.handler;
        self.flags = target.flags;
        self.restorer = target.restorer;
        self.mask.copy_from(&target.mask);
    }
}

bitflags! {
    pub struct SignalStackFlags : u32 {
        const ONSTACK = 1;
        const DISABLE = 2;
        const AUTODISARM = 0x80000000;
    }
}

#[repr(C)]
#[derive(Copy, Clone, Debug, Eq, PartialEq)]
pub struct SignalStack {
    pub sp: usize,
    pub flags: SignalStackFlags,
    pub size: usize,
}


#[repr(C)]
#[derive(Clone, Debug)]
pub struct SignalUserContext {
    pub flags: usize,
    pub link: usize,
    pub stack: SignalStack,
    pub sig_mask: SigSet,
    pub _pad: [u64; 15], // very strange, maybe a bug of musl libc
    pub context: Context,
}
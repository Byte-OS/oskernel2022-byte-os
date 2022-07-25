#[derive(Clone, Copy, Debug)]
pub struct SigSet(u64);

impl SigSet {
    pub fn block(&mut self, set: &SigSet) {
        self.0 = self.0 & !set.0;
    }

    pub fn unblock(&mut self, set: &SigSet) {
        self.0 = self.0 | set.0;
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
pub struct SigAction {
    pub handler: usize,
    pub flags: usize,
    pub restorer: usize,
    pub mask: SigSet,
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
}
use alloc::vec::Vec;

use super::mem_map::MemMap;

pub struct MemSet(pub Vec<MemMap>);

impl MemSet {
    pub fn new() -> Self {
        MemSet(vec![])
    }

    pub fn inner(&mut self) -> &mut Vec<MemMap> {
        &mut self.0
    }

    pub fn append(&mut self, target: &mut MemSet) {
        self.0.append(&mut target.0);
    }
}
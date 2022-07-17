use alloc::vec::Vec;

use crate::runtime_err::RuntimeError;

use super::mem_map::MemMap;

#[derive(Clone)]
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

    pub fn clone_with_data(&self) -> Result<Self, RuntimeError>{
        let mut mem_set = Self::new();
        let inner = mem_set.inner();
        for i in &self.0 {
            inner.push(i.clone_with_data()?);
        }
        Ok(mem_set)
    }

    // 释放占用的资源
    pub fn release(&mut self) {
        self.0.clear();
    }
}
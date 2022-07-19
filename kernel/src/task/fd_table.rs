use alloc::{sync::Arc, string::String, boxed::Box};
use hashbrown::HashMap;

use crate::{sync::mutex::Mutex, fs::{file::FileOP, stdio::{StdIn, StdOut, StdErr}}, runtime_err::RuntimeError};

use super::{FileDesc, FileDescEnum};

pub const FD_NULL: usize = 0xffffffffffffff9c;  

pub struct FDTable(HashMap<usize, Arc<dyn FileOP>>);

impl FDTable {
    pub fn new() -> Self {
        let map:HashMap<usize, Arc<dyn FileOP>> = HashMap::new();
        map.insert(0, Arc::new(StdIn));
        map.insert(1, Arc::new(StdOut));
        map.insert(2, Arc::new(StdErr));
        Self(map)
    }

    // 申请fd
    pub fn alloc(&mut self) -> usize {
        (0..).find(|fd| !self.0.contains_key(fd)).unwrap()
    }
    
    // 释放fd
    pub fn dealloc(&mut self, index: usize) {
        self.0.remove(&index);
    }

    // 获取fd内容
    pub fn get(&self, index: usize) -> Result<Arc<dyn FileOP>, RuntimeError> {
        self.0.get(&index).cloned().ok_or(RuntimeError::NoMatchedFileDesc)
    }

    // 设置fd内容
    pub fn set(&mut self, index: usize, value: Arc<dyn FileOP>) {
        self.0.insert(index, value);
    }

    // 加入描述符
    pub fn push(&mut self, value: Arc<dyn FileOP>) -> usize {
        let index = self.alloc();
        self.set(index, value);
        index
    }
}
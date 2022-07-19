use core::any::Any;

use alloc::{sync::Arc, string::String, boxed::Box, rc::Rc};
use hashbrown::HashMap;

use crate::{sync::mutex::Mutex, fs::{file::{FileOP, File}, stdio::{StdIn, StdOut, StdErr}}, runtime_err::RuntimeError};

use super::{FileDesc, FileDescEnum};

pub const FD_NULL: usize = 0xffffffffffffff9c;  

pub struct FDTable(HashMap<usize, Rc<dyn FileOP>>);

impl FDTable {
    pub fn new() -> Self {
        let map:HashMap<usize, Rc<dyn FileOP>> = HashMap::new();
        map.insert(0, Rc::new(StdIn));
        map.insert(1, Rc::new(StdOut));
        map.insert(2, Rc::new(StdErr));
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
    pub fn get(&self, index: usize) -> Result<Rc<dyn FileOP>, RuntimeError> {
        self.0.get(&index).cloned().ok_or(RuntimeError::NoMatchedFileDesc)
    }

    // 获取fd内容
    pub fn get_file(&self, index: usize) -> Result<Option<Rc<dyn FileOP>>, RuntimeError> {
        // let value = self.0.get(&index).cloned().ok_or(RuntimeError::NoMatchedFileDesc)?;
        // // Rc<dyn FileOP>::downcast::<File>(value);
        // // Rc::downcast::<File>(value);
        // let &value as &An        
        // // let value = value.downcast::<File>(value).map_or(RuntimeError::NoMatchedFileDesc);
        // todo!()
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
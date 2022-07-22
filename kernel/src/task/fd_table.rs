use alloc::rc::Rc;
use hashbrown::HashMap;
use crate::{fs::{file::{FileOP, File}, stdio::{StdIn, StdOut, StdErr}}, runtime_err::RuntimeError, memory::addr::VirtAddr, sys_call::{SYS_CALL_ERR, consts::EMFILE}};

pub const FD_NULL: usize = 0xffffffffffffff9c;
pub const FD_RANDOM: usize = usize::MAX;

#[repr(C)]
#[derive(Clone)]
pub struct IoVec {
    pub iov_base: VirtAddr,
    pub iov_len: usize
}

pub struct FDTable(HashMap<usize, Rc<dyn FileOP>>);

impl FDTable {
    pub fn new() -> Self {
        let mut map:HashMap<usize, Rc<dyn FileOP>> = HashMap::new();
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
    pub fn get_file(&self, index: usize) -> Result<Rc<File>, RuntimeError> {
        let value = self.0.get(&index).cloned().ok_or(RuntimeError::NoMatchedFileDesc)?;
        value.downcast::<File>().map_err(|_| RuntimeError::NoMatchedFile)
    }

    // 设置fd内容
    pub fn set(&mut self, index: usize, value: Rc<dyn FileOP>) {
        self.0.insert(index, value);
    }

    // 加入描述符
    pub fn push(&mut self, value: Rc<dyn FileOP>) -> usize {
        let index = self.alloc();
        if index > 41 { return EMFILE; }
        self.set(index, value);
        index
    }
}
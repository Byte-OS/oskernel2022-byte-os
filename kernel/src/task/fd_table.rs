use alloc::{vec::Vec, sync::Arc, string::String};

use crate::sync::mutex::Mutex;

use super::{FileDesc, FileDescEnum};

pub struct FDTable(Vec<Option<Arc<Mutex<FileDesc>>>>);

impl FDTable {
    pub fn new() -> Self {
        Self(vec![
            Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::Device(String::from("STDIN")))))),
            Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::Device(String::from("STDOUT")))))),
            Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::Device(String::from("STDERR"))))))
        ])
    }

    // 申请fd
    pub fn alloc(&mut self) -> usize {
        let mut index = 0;
        for i in 0..self.0.len() {
            if self.0[i].is_none() {
                index = i;
                break;
            }
        }
        if index == 0 {
            index = self.0.len();
            self.0.push(None);
        }
        index
    }

    // 申请固定的index地址
    pub fn alloc_fixed_index(&mut self, index: usize) -> usize {
        while index >= self.0.len() {
            self.0.push(None);
        }
        index
    }
    
    // 释放fd
    pub fn dealloc(&mut self, index: usize) {
        self.0[index] = None;
    }

    // 获取fd内容
    pub fn get(&self, index: usize) -> Option<Arc<Mutex<FileDesc>>> {
        self.0[index].clone()
    }

    // 设置fd内容
    pub fn set(&mut self, index: usize, value: Option<Arc<Mutex<FileDesc>>>) {
        self.0[index] = value.clone();
    }

    // 加入描述符
    pub fn push(&mut self, value: Option<Arc<Mutex<FileDesc>>>) -> usize {
        let index = self.alloc();
        self.0[index] = value;
        index
    }
}
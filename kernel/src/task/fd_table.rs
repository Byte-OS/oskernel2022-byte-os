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
}
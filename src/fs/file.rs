use alloc::{string::String, rc::Rc, sync::Arc};

use crate::sync::mutex::Mutex;

use super::fat32::{FilesystemItemOperator, FAT32};

pub struct File<'a> {
    pub fat32: Arc<Mutex<FAT32<'a>>>,
    pub filename : String,
    pub start_cluster : usize,
    pub block_idx : usize,
    pub open_cnt : usize,
    pub size : usize,
    pub flag : u8,
}

impl File<'_> {
    fn read_string(&self) -> String {
        // self.fat32.bpb.data_sector();
        todo!()
    }
}
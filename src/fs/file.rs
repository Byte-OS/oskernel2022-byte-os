use alloc::{string::String, rc::Rc};

use super::fat32::FilesystemItemOperator;

pub struct File {
    pub fat32: Rc<dyn FilesystemItemOperator>,
    pub filename : String,
    pub start_cluster : usize,
    pub block_idx : usize,
    pub open_cnt : usize,
    pub size : usize,
    pub flag : u8,
}

impl File {
    fn read_string(&self) -> String {
        // self.fat32.bpb.data_sector();
        todo!()
    }
}
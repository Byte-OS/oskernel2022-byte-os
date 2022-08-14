use alloc::string::{String, ToString};

use crate::{memory::mem_set::MemSet, interrupt::timer::TimeSpec};

use super::file::FileOP;

#[derive(Clone)]
pub struct VirtFile {
    pub filename: String,
    pub mem_set: MemSet,
    pub file_size: usize,
    pub mtime: TimeSpec,
    pub atime: TimeSpec,
    pub ctime: TimeSpec
}

impl VirtFile {
    pub fn new() -> Self {
        let now = TimeSpec::now();
        Self {  
            filename: "".to_string(),
            mem_set: MemSet::new(),
            mtime: now,
            atime: now,
            ctime: now,
            file_size: 0
        }
    }
}

impl FileOP for VirtFile {
    fn readable(&self) -> bool {
        true
    }

    fn writeable(&self) -> bool {
        true
    }

    fn read(&self, data: &mut [u8]) -> usize {
        self.read_at(0, data)
    }

    fn write(&self, data: &[u8], count: usize) -> usize {
        self.write_at(0, data, count)
    }

    fn read_at(&self, pos: usize, data: &mut [u8]) -> usize {
        todo!()
    }

    fn write_at(&self, pos: usize, data: &[u8], count: usize) -> usize {
        todo!()
    }

    fn get_size(&self) -> usize {
        self.file_size
    }
}
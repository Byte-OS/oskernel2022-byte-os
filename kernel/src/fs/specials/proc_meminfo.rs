use core::cell::RefCell;

use crate::fs::file::FileOP;

pub struct ProcMeminfo(RefCell<bool>);

impl ProcMeminfo {
    pub fn new() -> Self {
        Self(RefCell::new(true))
    }
}

impl FileOP for ProcMeminfo {
    fn readable(&self) -> bool {
        true
    }

    fn writeable(&self) -> bool {
        todo!()
    }

    fn read(&self, data: &mut [u8]) -> usize {
        let readable = *self.0.borrow_mut();
        if readable {
            let s = "MemTotal:       8024 kB";
            let bytes = s.as_bytes();
            data[..bytes.len()].copy_from_slice(bytes);
            *self.0.borrow_mut() = false;
            bytes.len()
        } else {
            0
        }
    }

    fn write(&self, data: &[u8], count: usize) -> usize {
        todo!()
    }

    fn read_at(&self, pos: usize, data: &mut [u8]) -> usize {
        todo!()
    }

    fn write_at(&self, pos: usize, data: &[u8], count: usize) -> usize {
        todo!()
    }

    fn get_size(&self) -> usize {
        todo!()
    }
}
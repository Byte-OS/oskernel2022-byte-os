use crate::console::puts;

use super::file::FileOP;

pub struct StdIn;
pub struct StdOut;
pub struct StdErr;

impl FileOP for StdIn {
    fn readable(&self) -> bool {
        true
    }

    fn writeable(&self) -> bool {
        false
    }

    fn read(&self, data: &mut [u8]) -> usize {
        todo!()
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
        0
    }
}

impl FileOP for StdOut {
    fn readable(&self) -> bool {
        false
    }

    fn writeable(&self) -> bool {
        true
    }

    fn read(&self, data: &mut [u8]) -> usize {
        0
    }

    fn write(&self, data: &[u8], count: usize) -> usize {
        puts(data);
        data.len()
    }

    fn read_at(&self, pos: usize, data: &mut [u8]) -> usize {
        0
    }

    fn write_at(&self, pos: usize, data: &[u8], count: usize) -> usize {
        puts(data);
        data.len()
    }

    fn get_size(&self) -> usize {
        todo!()
    }
}

impl FileOP for StdErr {
    fn readable(&self) -> bool {
        todo!()
    }

    fn writeable(&self) -> bool {
        todo!()
    }

    fn read(&self, data: &mut [u8]) -> usize {
        todo!()
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
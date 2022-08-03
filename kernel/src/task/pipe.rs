use core::cell::RefCell;

use alloc::{collections::VecDeque, sync::Arc, rc::Rc};

use crate::fs::file::FileOP;

#[derive(Clone)]
pub struct PipeBuf (Arc<RefCell<VecDeque<u8>>>);

impl PipeBuf {
    // 创建pipeBuf
    pub fn new() -> Self {
        PipeBuf(Arc::new(RefCell::new(VecDeque::new())))
    }
    // 读取字节
    pub fn read(&self, buf: &mut [u8]) -> usize {
        let mut read_index = 0;
        let mut queue = self.0.borrow_mut();
        loop {
            if read_index >= buf.len() {
                break;
            }
            
            if let Some(char) = queue.pop_front() {
                buf[read_index] = char;
            } else {
                break;
            }

            read_index = read_index + 1;
        }
        read_index
    }

    // 写入字节
    pub fn write(&self, buf: &[u8], count: usize) -> usize {
        let mut write_index = 0;
        let mut queue = self.0.borrow_mut();
        loop {
            if write_index >= buf.len() || write_index >= count {
                break;
            }
            
            queue.push_back(buf[write_index]);
            write_index = write_index + 1;
        }
        write_index
    }

    // 获取可获取的大小
    pub fn available(&self) -> usize {
        self.0.borrow().len()
    }
}

pub struct PipeReader(PipeBuf);
pub struct PipeWriter(PipeBuf);

impl FileOP for PipeReader {
    fn readable(&self) -> bool {
        true
    }

    fn writeable(&self) -> bool {
        false
    }

    fn read(&self, data: &mut [u8]) -> usize {
        self.0.read(data)
    }

    fn write(&self, _data: &[u8], _count: usize) -> usize {
        todo!()
    }

    fn read_at(&self, _pos: usize, data: &mut [u8]) -> usize {
        self.0.read(data)
    }

    fn write_at(&self, _pos: usize, _data: &[u8], _count: usize) -> usize {
        todo!()
    }

    fn get_size(&self) -> usize {
        self.0.available()
    }
}

impl FileOP for PipeWriter {
    fn readable(&self) -> bool {
        false
    }

    fn writeable(&self) -> bool {
        true
    }

    fn read(&self, _data: &mut [u8]) -> usize {
        todo!()
    }

    fn write(&self, data: &[u8], count: usize) -> usize {
        self.0.write(data, count)
    }

    fn read_at(&self, _pos: usize, _data: &mut [u8]) -> usize {
        todo!()
    }

    fn write_at(&self, _pos: usize, _data: &[u8], _count: usize) -> usize {
        todo!()
    }

    fn get_size(&self) -> usize {
        todo!()
    }
}

pub fn new_pipe() -> (Rc<PipeReader>, Rc<PipeWriter>) {
    let pipe_buf = PipeBuf::new();
    let pipe_reader  = Rc::new(PipeReader(pipe_buf.clone()));
    let pipe_writer = Rc::new(PipeWriter(pipe_buf.clone()));
    (pipe_reader, pipe_writer)
}
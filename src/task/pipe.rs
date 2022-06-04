use alloc::collections::VecDeque;

pub struct PipeBuf {
    buf: VecDeque<u8>
}

impl PipeBuf {
    // 读取字节
    pub fn read(&mut self, buf: &mut [u8]) -> usize {
        let mut read_index = 0;
        loop {
            if read_index >= buf.len() {
                break;
            }
            
            if let Some(char) = self.buf.pop_front() {
                buf[read_index] = char;
            } else {
                break;
            }

            read_index = read_index + 1;
        }
        read_index
    }

    // 写入字节
    pub fn write(&mut self, buf: &mut [u8], count: usize) -> usize {
        let mut write_index = 0;
        loop {
            if write_index >= buf.len() || write_index >= count {
                break;
            }
            
            self.buf.push_back(buf[write_index]);
            write_index = write_index + 1;
        }
        write_index
    }
}
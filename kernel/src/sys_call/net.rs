
use alloc::collections::BTreeMap;
use alloc::collections::VecDeque;

use alloc::rc::Rc;
use core::cell::RefCell;
use crate::fs::file::FileOP;
use crate::memory::addr::{get_buf_from_phys_addr, VirtAddr};

use crate::runtime_err::RuntimeError;
use crate::sync::mutex::Mutex;

use crate::task::task::Task;

#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
struct SaFamily(u32);
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
struct SocketAddr {
    sa_family: SaFamily,
    sa_data: [u8; 14],
}

struct SocketFile(RefCell<VecDeque<u8>>);

impl SocketFile {
    fn new() -> Rc<Self> {
        Rc::new(SocketFile(RefCell::new(VecDeque::new())))
    }
}

struct SocketDataBuffer {
    socket_buf: BTreeMap<SocketAddr, Rc<dyn FileOP>>,
}

impl SocketDataBuffer {
    const fn new() -> Self {
        SocketDataBuffer {
            socket_buf: BTreeMap::new(),
        }
    }
}

static SOCKET_BUF: Mutex<SocketDataBuffer> = Mutex::new(SocketDataBuffer::new());

impl FileOP for SocketFile {
    fn readable(&self) -> bool {
        todo!()
    }

    fn writeable(&self) -> bool {
        true
    }

    fn read(&self, buf: &mut [u8]) -> usize {
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

    fn write(&self, buf: &[u8], count: usize) -> usize {
        // println!("read_only len : {}",read_only.len());
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

    fn read_at(&self, _pos: usize, _data: &mut [u8]) -> usize {
        todo!()
    }

    fn write_at(&self, _pos: usize, _data: &[u8], _count: usize) -> usize {
        todo!()
    }

    fn get_size(&self) -> usize {
        self.0.borrow().len()
    }
}

impl Task {
    pub fn sys_socket(&self, _domain: usize, _ty: usize, _protocol: usize) -> Result<(), RuntimeError> {
        let file = SocketFile::new();
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();

        let fd = process.fd_table.push_sock(file);
        drop(process);
        inner.context.x[10] = fd;
        Ok(())
    }

    pub fn sys_bind(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = 0;
        Ok(())
    }

    pub fn sys_getsockname(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = 0;
        Ok(())
    }

    pub fn sys_setsockopt(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = 0;
        Ok(())
    }

    pub fn sys_sendto(&self, fd: usize, buf: VirtAddr, len: usize, _flags: usize,
                            sa: VirtAddr, _sa_size: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        let sa = sa.translate(process.pmm.clone()).tranfer::<SocketAddr>();
        let buf = get_buf_from_phys_addr(buf.translate(
            process.pmm.clone()), len);

        let file = process.fd_table.get(fd)?;

        let send_size = file.write(buf, buf.len());
        SOCKET_BUF.lock().socket_buf.insert(sa.clone(), file);
        drop(process);

        inner.context.x[10] = send_size;
        Ok(())
    }

    pub fn sys_recvfrom(&self, _fd: usize, buf: VirtAddr, len: usize, _flags: usize,
        sa: VirtAddr, _addr_len: usize) -> Result<(), RuntimeError> {

        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        let addr = sa.translate(process.pmm.clone()).tranfer::<SocketAddr>();
        let buf = get_buf_from_phys_addr(buf.translate(
            process.pmm.clone()), len);

        let file = SOCKET_BUF.lock().socket_buf.get(addr).unwrap().clone();

        let read_len = file.read(buf);
        drop(process);
        inner.context.x[10] = read_len;
        Ok(())
    }

    pub fn sys_listen(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = 0;
        Ok(())
    }

    pub fn sys_connect(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = 0;
        Ok(())
    }

    pub fn sys_accept(&self) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = 0;
        Ok(())
    }

    pub fn sys_fcntl(&self, fd: usize, cmd: usize, arg: usize) -> Result<(), RuntimeError> {
        debug!("val: fd {}  cmd {:#x} arg {:#x}", fd, cmd, arg);
        let mut inner = self.inner.borrow_mut();
        // let node = self.map.get_mut(&fd).ok_or(SysError::EBADF)?;
        if fd >= 50 {
            match cmd {
                // 复制文件描述符
                1 => {
                    inner.context.x[10] = 1;
                }
                3 => {
                    inner.context.x[10] = 0o4000;
                },
                n => {
                    debug!("not imple {}", n);
                },
            };
        }
        Ok(())
    }
}
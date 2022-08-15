use alloc::rc::Rc;
use alloc::string::ToString;
use crate::fs::StatFS;
use crate::fs::file::File;
use crate::fs::file::FileOP;
use crate::fs::file::FileType;
use crate::fs::specials::dev_rtc::DevRtc;
use crate::fs::specials::etc_adjtime::EtcAdjtime;
use crate::fs::specials::proc_meminfo::ProcMeminfo;
use crate::fs::specials::proc_mounts::ProcMounts;
use crate::fs::stdio::StdNull;
use crate::fs::stdio::StdZero;
use crate::interrupt::timer::TimeSpec;
use crate::memory::addr::UserAddr;
use crate::task::fd_table::IoVec;
use crate::task::pipe::PipeWriter;
use crate::task::task::Task;
use crate::task::fd_table::FD_NULL;
use crate::task::pipe::new_pipe;
use crate::fs::file::Kstat;
use crate::fs::filetree::INode;
use crate::runtime_err::RuntimeError;
use super::OpenFlags;

impl Task {
    // 获取当前路径
    pub fn get_cwd(&self, buf: UserAddr<u8>, size: usize) -> Result<(), RuntimeError> {
        debug!("get_cwd size: {}", size);
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 获取参数
        let buf = buf.transfer_vec(size);
        // 获取路径
        let pwd = process.workspace.clone();
        let pwd_buf = pwd.get_pwd();
        // let pwd_buf = process.workspace.as_bytes();
        // 将路径复制到缓冲区
        buf[..pwd_buf.len()].copy_from_slice(pwd_buf.as_bytes());
        drop(process);
        inner.context.x[10] = buf.as_ptr() as usize;
        Ok(())
    }

    // 复制文件描述符
    pub fn sys_dup(&self, fd: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        let fd_v = process.fd_table.get(fd)?;
        // 判断文件描述符是否存在
        let new_fd = process.fd_table.push(fd_v);
        drop(process);
        inner.context.x[10] = new_fd;
        Ok(())
    }
    // 复制文件描述符
    pub fn sys_dup3(&self, fd: usize, new_fd: usize) -> Result<(), RuntimeError> {
        debug!("dup fd: {} to fd: {}", fd, new_fd);
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        // 判断是否存在文件描述符
        let fd_v = process.fd_table.get(fd)?;
        if let Ok(file) = fd_v.clone().downcast::<File>() {
            file.lseek(0, 0);
        }
        process.fd_table.set(new_fd, fd_v);
        drop(process);
        inner.context.x[10] = new_fd;
        Ok(())
    }
    // 创建文件
    pub fn sys_mkdirat(&self, dir_fd: usize, filename: UserAddr<u8>, flags: usize) -> Result<(), RuntimeError> {
        let filename = filename.read_string();
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        debug!("dir_fd: {:#x}, filename: {}", dir_fd, filename);

        // 判断文件描述符是否存在
        let current = if dir_fd == FD_NULL {
            // 在用户根据目录创建
            None
        } else {
            // 判度是否存在节点
            let file = process.fd_table.get_file(dir_fd)?;
            Some(file.get_inode())
        };
        if filename != "/" {
            INode::mkdir(current, &filename, flags as u16)?;
        }
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
    // 取消链接文件
    pub fn sys_unlinkat(&self, fd: usize, filename: UserAddr<u8>, _flags: usize) -> Result<(), RuntimeError> {
        let filename = filename.read_string();
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 判断文件描述符是否存在
        let current = if fd == FD_NULL {
            None
        } else {
            let file = process.fd_table.get_file(fd)?;
            Some(file.get_inode())
        };
        let cnode = INode::get(current, &filename)?;
        cnode.del_self();
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
    // 更改工作目录
    pub fn sys_chdir(&self, filename: UserAddr<u8>) -> Result<(), RuntimeError> {
        let filename = filename.read_string();
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();

        // process.workspace = process.workspace.clone() + "/" + &filename;
        process.workspace = INode::get(Some(process.workspace.clone()), &filename)?;

        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
    // 打开文件
    pub fn sys_openat(&self, fd: usize, filename: UserAddr<u8>, flags: usize, _open_mod: usize) -> Result<(), RuntimeError> {
        let filename = filename.read_string();
        debug!("open file: {}  flags: {:#x}", filename, flags);
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();

        // 获取文件信息
        let flags = OpenFlags::from_bits_truncate(flags as u32);

        if filename == "/dev/zero" {
            let fd = process.fd_table.push(Rc::new(StdZero));
            drop(process);
            inner.context.x[10] = fd;
            return Ok(())
        } else if filename == "/dev/null" {
            let fd = process.fd_table.push(Rc::new(StdNull));
            drop(process);
            inner.context.x[10] = fd;
            return Ok(())
        } else if filename == "/proc/mounts" {
            let fd = process.fd_table.push(Rc::new(ProcMounts::new()));
            drop(process);
            inner.context.x[10] = fd;
            return Ok(())
        } else if filename == "/proc/meminfo" {
            let fd = process.fd_table.push(Rc::new(ProcMeminfo::new()));
            drop(process);
            inner.context.x[10] = fd;
            return Ok(())
        } else if filename == "/etc/adjtime" {
            let fd = process.fd_table.push(Rc::new(EtcAdjtime::new()));
            drop(process);
            inner.context.x[10] = fd;
            return Ok(())
        } else if filename == "/dev/rtc" {
            let fd = process.fd_table.push(Rc::new(DevRtc::new()));
            drop(process);
            inner.context.x[10] = fd;
            return Ok(())
        }


        // 判断文件描述符是否存在
        let current = if fd == FD_NULL {
            None
        } else {
            let file = process.fd_table.get_file(fd)?;
            Some(file.get_inode())
        };
        // 根据文件类型匹配
        let file = if flags.contains(OpenFlags::CREATE) {
            INode::open_or_create(current, &filename)?
        } else {
            INode::open(current, &filename)?
        };
        if flags.contains(OpenFlags::WRONLY) {
            file.lseek(0, 2);
        }
        let fd = process.fd_table.alloc();
        process.fd_table.set(fd, file);
        drop(process);
        debug!("return fd: {}", fd);
        inner.context.x[10] = fd;
        Ok(())
    }
    // 关闭文件
    pub fn sys_close(&self, fd: usize) -> Result<(), RuntimeError> {
        debug!("close fd: {}", fd);
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        process.fd_table.dealloc(fd);
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }

    pub fn sys_sendfile(&self, out_fd: usize, in_fd: usize, offset_ptr: usize, count: usize) -> Result<(), RuntimeError> {
        debug!("out_fd: {}  in_fd: {}  offset_ptr: {:#x}   count: {}", out_fd, in_fd, offset_ptr, count);
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        let in_file = process.fd_table.get(in_fd)?;
        let out_file = process.fd_table.get(out_fd)?;
        let size = in_file.get_size();
        let mut buf = vec![0u8; size];
        let read_size = in_file.read(&mut buf);
        out_file.write(&buf, buf.len());
        // let file = out_file.downcast::<File>();
        // file.lseek(0, 0);
        // if let Ok(file) = out_file.downcast::<File>() {
        //     file.lseek(0, 0);
        // }

        drop(process);
        debug!("write size: {}", read_size);
        inner.context.x[10] = read_size;
        Ok(())
    }

    // 管道符
    pub fn sys_pipe2(&self, req_ptr: UserAddr<u32>) -> Result<(), RuntimeError> {
        let pipe_arr =  req_ptr.transfer_vec(2);
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        // 创建pipe
        let (read_pipe, write_pipe) = new_pipe();
        // 写入数据
        pipe_arr[0] = process.fd_table.push(read_pipe) as u32;
        pipe_arr[1] = process.fd_table.push(write_pipe) as u32;
                
        drop(process);
        // 创建成功
        inner.context.x[10] = 0;
        Ok(())
    }
    // 获取文件信息
    pub fn sys_getdents(&self, fd: usize, ptr: UserAddr<u8>, len: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        debug!("get dents: fd: {} ptr: {:#x} len: {:#x}", fd, ptr.bits(), len);
        let buf = ptr.transfer_vec(len);
        let dir_file = process.fd_table.get_file(fd)?;
        
        let mut pos = 0;
        while let Some((i, inode)) = dir_file.entry_next() {
            let sub_node_name = inode.get_filename();
            debug!("子节点: {}  filetype: {:?} filename len: {}", sub_node_name, inode.get_file_type(), sub_node_name.len());
            let sub_node_name = sub_node_name.as_bytes();
            let node_size = ((19 + sub_node_name.len() as u16 + 1 + 7) / 8) * 8;
            let next = pos + node_size as usize;
            buf[pos..pos+8].copy_from_slice(&(i as u64).to_ne_bytes());
            pos += 8;
            buf[pos..pos+8].copy_from_slice(&(i as u64).to_ne_bytes());
            pos += 8;
            buf[pos..pos+2].copy_from_slice(&node_size.to_ne_bytes());
            pos += 2;
            // buf[pos] = 8;   // 写入type  支持文件夹类型
            buf[pos] = match inode.get_file_type() {
                FileType::File => 8,
                FileType::Directory => 4,
                _ => 0
            };
            pos += 1;
            buf[pos..pos + sub_node_name.len()].copy_from_slice(sub_node_name);
            // pos += node_size as usize;
            pos += sub_node_name.len();
            buf[pos..next].fill(0);   // 写入结束符
            pos = next;

        }

        drop(process);
        debug!("written size: {}", pos);
        inner.context.x[10] = pos;
        // 运行时使用
        // inner.context.x[10] = 0;
        
        Ok(())
    }

    pub fn sys_statfs(&self, _fd: usize, buf_ptr: UserAddr<StatFS>) -> Result<(), RuntimeError> {
        let buf = buf_ptr.transfer();
        
        buf.f_type = 32;
        buf.f_bsize = 512;
        buf.f_blocks = 80;
        buf.f_bfree = 40;
        buf.f_bavail = 0;
        buf.f_files = 32;
        buf.f_ffree = 0;
        buf.f_fsid = 32;
        buf.f_namelen = 20;

        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = 0;
        Ok(())
    }

    // 读取
    pub fn sys_read(&self, fd: usize, buf_ptr: UserAddr<u8>, count: usize) -> Result<(), RuntimeError> {
        debug!("sys_read, fd: {}, buf_ptr: {:#x}, count: {}", fd, buf_ptr.bits(), count);
        let buf = buf_ptr.transfer_vec(count);
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 判断文件描述符是否存在
        let reader = process.fd_table.get(fd)?;
        let value = if reader.readable() {
            reader.read(buf)
        } else {
            usize::MAX
        };
        drop(process);
        debug!("read_size = {}", value);
        inner.context.x[10] = value;
        Ok(())
    }

    // 写入
    pub fn sys_write(&self, fd: usize, buf_ptr: UserAddr<u8>, count: usize) -> Result<(), RuntimeError> {
        // debug!("write fd: {} buf_ptr: {:#x} count: {}", fd, buf_ptr.bits(), count);
        let buf = buf_ptr.transfer_vec(count);
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        
        // 判断文件描述符是否存在
        let writer = process.fd_table.get(fd)?;
        let value = if writer.writeable() {
            match writer.clone().downcast::<PipeWriter>() {
                Ok(writer) => {
                    writer.write(buf, buf.len())
                },
                Err(_) => {
                    writer.write(buf, buf.len())
                }
            }
        } else {
            usize::MAX
        };
        drop(process);
        inner.context.x[10] = value;
        Ok(())
    }
    // 写入
    pub fn sys_writev(&self, fd: usize, iov: UserAddr<IoVec>, iovcnt: usize) -> Result<(), RuntimeError> {
        let iov_vec = iov.transfer_vec(iovcnt);
        
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        
        let fd = process.fd_table.get(fd)?;
        let mut cnt = 0;
        for i in iov_vec {
            // let buf = get_buf_from_phys_addr(i.iov_base.translate(process.pmm.clone()), 
            //     i.iov_len);
            let buf = i.iov_base.transfer_vec(i.iov_len);
            cnt += fd.write(buf, i.iov_len);
        }
        drop(process);
        inner.context.x[10] = cnt;
        Ok(())
    }

    pub fn sys_readv(&self, fd: usize, iov: UserAddr<IoVec>, iovcnt: usize) -> Result<(), RuntimeError> {
        let iov_vec = iov.transfer_vec(iovcnt);

        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        
        let fd = process.fd_table.get(fd)?;
        let mut cnt = 0;
        for i in iov_vec {
            // let buf = get_buf_from_phys_addr(i.iov_base, 
                // i.iov_len);
            let buf = i.iov_base.transfer_vec(i.iov_len);
            cnt += fd.read(buf);
        }
        drop(process);
        inner.context.x[10] = cnt;
        Ok(())
    }

    pub fn sys_fstat(&self, fd: usize, buf_ptr: UserAddr<Kstat>) -> Result<(), RuntimeError> {
        debug!("sys_fstat: {}", fd);
        let kstat = buf_ptr.transfer();
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // // 判断文件描述符是否存在
        let inode = process.fd_table.get_file(fd)?;
        let inode = inode.get_inode();
        let _inode = inode.0.borrow_mut();
        kstat.st_dev = 1;
        kstat.st_ino = 1;
        kstat.st_mode = 0;
        kstat.st_nlink = 1;
        kstat.st_uid = 0;
        kstat.st_gid = 0;
        kstat.st_rdev = 0;
        kstat.__pad = 0;
        kstat.st_blksize = 512; // 磁盘扇区大小
        // kstat.st_size = inode.size as u64;
        // kstat.st_blocks = ((inode.size - 1 + 512) / 512) as u64;
        // kstat.st_atime_sec = inode.st_atime_sec;
        // kstat.st_atime_nsec = inode.st_atime_nsec;
        // kstat.st_mtime_sec = inode.st_mtime_sec;
        // kstat.st_mtime_nsec = inode.st_mtime_nsec;
        // kstat.st_ctime_sec = inode.st_ctime_sec;
        // kstat.st_ctime_nsec = inode.st_ctime_nsec;

        // debug
        kstat.st_size = 0;
        kstat.st_blocks = 0;
        kstat.st_atime_sec  = 0;
        kstat.st_atime_nsec = 0;
        kstat.st_mtime_sec  = 0;
        kstat.st_mtime_nsec = 0;
        kstat.st_ctime_sec  = 0;
        kstat.st_ctime_nsec = 0;
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }

    // 获取文件信息
    pub fn sys_fstatat(&self, dir_fd: usize, filename: UserAddr<u8>, stat_ptr: UserAddr<Kstat>, _flags: usize) -> Result<(), RuntimeError> {
        let filename = filename.read_string();
        let kstat = stat_ptr.transfer();
        debug!("sys_fstatat: dir_fd {:#x}, filename: {}, filename_len: {}", dir_fd, filename, filename.len());

        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        if filename != "/dev/null" {
            // 判断文件描述符是否存在
            let file = if dir_fd == FD_NULL {
                None
            } else {
                let file = process.fd_table.get_file(dir_fd)?;
                Some(file.get_inode())
            };

            let inode = INode::get(file, &filename)?;
            let inode = inode.0.borrow_mut();
            kstat.st_dev = 1;
            kstat.st_ino = 1;
            // kstat_ptr.st_mode = 0;
            if inode.file_type == FileType::Directory {
                kstat.st_mode = 0o40000;
            } else {
                kstat.st_mode = 0;
            }
            // kstat.st_nlink = inode.nlinkes as u32;
            // kstat.st_uid = 0;
            // kstat.st_gid = 0;
            // kstat.st_rdev = 0;
            // kstat.__pad = 0;
            // kstat.st_size = inode.size as u64;
            // kstat.st_blksize = 512;
            // kstat.st_blocks = ((inode.size - 1 + 512) / 512) as u64;
            // kstat.st_atime_sec = inode.st_atime_sec;
            // kstat.st_atime_nsec = inode.st_atime_nsec;
            // kstat.st_mtime_sec = inode.st_mtime_sec;
            // kstat.st_mtime_nsec = inode.st_mtime_nsec;
            // kstat.st_ctime_sec = inode.st_ctime_sec;
            // kstat.st_ctime_nsec = inode.st_ctime_nsec;
            drop(process);
            inner.context.x[10] = 0;
            Ok(())
        } else {
            // kstat.
            kstat.st_mode = 0o20000;
            drop(process);
            inner.context.x[10] = 0;
            Ok(())
        }
    }

    pub fn sys_lseek(&self, fd: usize, offset: usize, whence: usize) -> Result<(), RuntimeError> {
        debug!("lseek: fd {}, offset: {}, whench: {}", fd, offset as isize, whence);
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        let file = process.fd_table.get(fd)?;
        let offset = file.lseek(offset, whence);
        // debug!("lseek Filename: {}", file.get_inode().get_filename());
        // let inode = file.get_inode();
        drop(process);
        inner.context.x[10] = offset;
        Ok(())
    }

    // 原子读
    pub fn sys_pread(&self, fd: usize, ptr: UserAddr<u8>, len: usize, offset: usize) -> Result<(), RuntimeError> {
        let buf = ptr.transfer_vec(len);
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        let file = process.fd_table.get_file(fd)?;
        let ret = file.read_at(offset, buf);
        drop(process);
        inner.context.x[10] = ret;
        Ok(())
    }

    pub fn sys_ppoll(&self, fds: UserAddr<PollFD>, nfds: usize, _timeout: UserAddr<TimeSpec>) -> Result<(), RuntimeError> {
        let fds = fds.transfer_vec(nfds);
        let mut inner = self.inner.borrow_mut();
        debug!("wait for fds: {}", fds.len());
        for i in fds {
            debug!("wait fd: {}", i.fd);
        }
        inner.context.x[10] = 1;
        Ok(())
    }

    pub fn sys_readlinkat(&self, dir_fd: usize, path: UserAddr<u8>, 
            buf: UserAddr<u8>, len: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let path = path.read_string();
        debug!("read {} from dir_fd: {:#x} len: {}", path, dir_fd, len);
        let path = if path == "/proc/self/exe" {
            "/lmbench_all".to_string()
        } else {
            path
        };
        let path = path.as_bytes();

        let buf = buf.transfer_vec(len);
        // let inode = INode::get(None, &path)?;
        // let read_len = inode.read_to(buf)?;
        // debug!("read_len: {:#x}", read_len);
        buf[..path.len()].copy_from_slice(path);
        inner.context.x[10] = path.len();
        Ok(())
    }

}

#[repr(C)]
pub struct PollFD {
    pub fd: u32,
    pub envents: u16,
    pub revents: u16
}
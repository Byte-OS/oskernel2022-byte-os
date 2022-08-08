use alloc::rc::Rc;
use crate::fs::StatFS;
use crate::fs::file::FileOP;
use crate::fs::file::FileType;
use crate::fs::stdio::StdNull;
use crate::fs::stdio::StdZero;
use crate::memory::addr::UserAddr;
use crate::task::fd_table::IoVec;
use crate::task::pipe::PipeWriter;
use crate::task::task::Task;
use crate::task::fd_table::FD_NULL;
use crate::task::pipe::new_pipe;
use crate::fs::file::Kstat;
use crate::fs::filetree::INode;
use crate::runtime_err::RuntimeError;
use crate::memory::addr::get_buf_from_phys_addr;

use super::OpenFlags;

impl Task {
    // 获取当前路径
    pub fn get_cwd(&self, buf: UserAddr<u8>, size: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        // 获取参数
        let buf = buf.translate_vec(process.pmm.clone(), size);
        // 获取路径
        // let pwd = process.workspace;
        // let pwd_buf = pwd.as_bytes();
        let pwd_buf = process.workspace.as_bytes();
        // 将路径复制到缓冲区
        buf[..pwd_buf.len()].copy_from_slice(pwd_buf);
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
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        // 判断是否存在文件描述符
        let fd_v = process.fd_table.get(fd)?;
        process.fd_table.set(new_fd, fd_v);
        drop(process);
        inner.context.x[10] = new_fd;
        Ok(())
    }
    // 创建文件
    pub fn sys_mkdirat(&self, dir_fd: usize, filename: UserAddr<u8>, flags: usize) -> Result<(), RuntimeError> {
        let filename = filename.read_string(self.get_pmm());
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 判断文件描述符是否存在
        let current = if dir_fd == FD_NULL {
            // 在用户根据目录创建
            None
        } else {
            // 判度是否存在节点
            let file = process.fd_table.get_file(dir_fd)?;
            Some(file.get_inode())
        };
        INode::mkdir(current, &filename, flags as u16)?;
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
    // 取消链接文件
    pub fn sys_unlinkat(&self, fd: usize, filename: UserAddr<u8>, _flags: usize) -> Result<(), RuntimeError> {
        let filename = filename.read_string(self.get_pmm());
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
        let filename = filename.read_string(self.get_pmm());
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();

        process.workspace = process.workspace.clone() + "/" + &filename;
        // process.workspace = INode::get(Some(process.workspace.clone()), &filename, false)?;

        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
    // 打开文件
    pub fn sys_openat(&self, fd: usize, filename: UserAddr<u8>, flags: usize, _open_mod: usize) -> Result<(), RuntimeError> {
        let filename = filename.read_string(self.get_pmm());
        debug!("open file: {}", filename);
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
            INode::open(current, &filename)?
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
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        process.fd_table.dealloc(fd);
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
    // 管道符
    pub fn sys_pipe2(&self, req_ptr: UserAddr<u32>) -> Result<(), RuntimeError> {
        let pipe_arr = req_ptr.translate_vec(self.get_pmm(), 2);
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
    pub fn sys_getdents(&self, _fd: usize, _ptr: usize, _len: usize) -> Result<(), RuntimeError> {
        todo!("getdents")
    }

    pub fn sys_statfs(&self, _fd: usize, buf_ptr: UserAddr<StatFS>) -> Result<(), RuntimeError> {
        let buf = buf_ptr.translate(self.get_pmm());
        
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
        let buf = buf_ptr.translate_vec(self.get_pmm(), count);
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
        inner.context.x[10] = value;
        Ok(())
    }

    // 写入
    pub fn sys_write(&self, fd: usize, buf_ptr: UserAddr<u8>, count: usize) -> Result<(), RuntimeError> {
        let buf = buf_ptr.translate_vec(self.get_pmm(), count);
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
        let iov_vec = iov.translate_vec(self.get_pmm(), iovcnt);
        
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        
        let fd = process.fd_table.get(fd)?;
        let mut cnt = 0;
        for i in iov_vec {
            let buf = get_buf_from_phys_addr(i.iov_base.translate(process.pmm.clone()), 
                i.iov_len);
            cnt += fd.write(buf, i.iov_len);
        }
        drop(process);
        inner.context.x[10] = cnt;
        Ok(())
    }

    pub fn sys_readv(&self, fd: usize, iov: UserAddr<IoVec>, iovcnt: usize) -> Result<(), RuntimeError> {
        let iov_vec = iov.translate_vec(self.get_pmm(), iovcnt);

        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        
        let fd = process.fd_table.get(fd)?;
        let mut cnt = 0;
        for i in iov_vec {
            let buf = get_buf_from_phys_addr(i.iov_base.translate(process.pmm.clone()), 
                i.iov_len);
            cnt += fd.read(buf);
        }
        drop(process);
        inner.context.x[10] = cnt;
        Ok(())
    }

    pub fn sys_fstat(&self, _fd: usize, buf_ptr: UserAddr<Kstat>) -> Result<(), RuntimeError> {
        let _kstat = buf_ptr.translate(self.get_pmm());
        let mut inner = self.inner.borrow_mut();
        // let process = inner.process.borrow_mut();

        // // 判断文件描述符是否存在
        // let inode = process.fd_table.get_file(fd)?;
        // let inode = inode.get_inode();
        // let inode = inode.0.borrow_mut();
        // kstat.st_dev = 1;
        // kstat.st_ino = 1;
        // kstat.st_mode = 0;
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
        // drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }

    // 获取文件信息
    pub fn sys_fstatat(&self, dir_fd: usize, filename: UserAddr<u8>, stat_ptr: UserAddr<Kstat>, _flags: usize) -> Result<(), RuntimeError> {
        let filename = filename.read_string(self.get_pmm());
        let kstat = stat_ptr.translate(self.get_pmm());

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
            kstat.st_mode = 0o20000;
            drop(process);
            inner.context.x[10] = 0;
            Ok(())
        }
    }

    pub fn sys_lseek(&self, fd: usize, offset: usize, whence: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        let file = process.fd_table.get_file(fd)?;
        let offset = file.lseek(offset, whence);
        drop(process);
        inner.context.x[10] = offset;
        Ok(())
    }

    // 原子读
    pub fn sys_pread(&self, fd: usize, ptr: UserAddr<u8>, len: usize, offset: usize) -> Result<(), RuntimeError> {
        let buf = ptr.translate_vec(self.get_pmm(), len);
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        let file = process.fd_table.get_file(fd)?;
        let ret = file.read_at(offset, buf);
        drop(process);
        inner.context.x[10] = ret;
        Ok(())
    }

}
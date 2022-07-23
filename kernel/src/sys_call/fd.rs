use core::slice;

use alloc::rc::Rc;

use crate::fs::StatFS;
use crate::fs::file::FileType;
use crate::fs::stdio::StdZero;
use crate::task::fd_table::IoVec;
use crate::task::task::Task;
use crate::task::fd_table::FD_NULL;
use crate::task::pipe::new_pipe;
use crate::memory::addr::VirtAddr;
use crate::fs::file::Kstat;
use crate::fs::filetree::INode;

use crate::runtime_err::RuntimeError;
use crate::memory::addr::get_buf_from_phys_addr;

use super::get_string_from_raw;
use super::OpenFlags;

impl Task {
    // 获取当前路径
    pub fn get_cwd(&self, buf: usize, size: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        // 获取参数
        let mut buf = process.pmm.get_phys_addr(VirtAddr::from(buf)).unwrap();
        // 设置缓冲区地址
        let buf = unsafe { slice::from_raw_parts_mut(buf.as_mut_ptr(), size) };
        // 获取路径
        let pwd = process.workspace.get_pwd();
        let pwd_buf = pwd.as_bytes();
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
    pub fn sys_mkdirat(&self, dir_fd: usize, filename: usize, flags: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        let filename = process.pmm.get_phys_addr(VirtAddr::from(filename)).unwrap();
        let filename = get_string_from_raw(filename);

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
    pub fn sys_unlinkat(&self, fd: usize, filename: usize, _flags: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 获取参数
        let filename = process.pmm.get_phys_addr(VirtAddr::from(filename)).unwrap();
        let filename = get_string_from_raw(filename);

        // 判断文件描述符是否存在
        let current = if fd == FD_NULL {
            None
        } else {
            let file = process.fd_table.get_file(fd)?;
            Some(file.get_inode())
        };
        let cnode = INode::get(current, &filename, false)?;
        cnode.del_self();
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
    // 更改工作目录
    pub fn sys_chdir(&self, filename: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();

        let filename = process.pmm.get_phys_addr(VirtAddr::from(filename)).unwrap();
        let filename = get_string_from_raw(filename);

        process.workspace = INode::get(Some(process.workspace.clone()), &filename, false)?;

        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
    // 打开文件
    pub fn sys_openat(&self, fd: usize, filename: usize, flags: usize, _open_mod: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();

        // 获取文件信息
        let filename = process.pmm.get_phys_addr(VirtAddr::from(filename)).unwrap();
        let filename = get_string_from_raw(filename);
        let flags = OpenFlags::from_bits_truncate(flags as u32);

        if filename == "/dev/zero" {
            let fd = process.fd_table.push(Rc::new(StdZero));
            drop(process);
            inner.context.x[10] = fd;
            return Ok(())
        }

        debug!("读取文件: {}, flags:{:?}", filename, flags);

        // 判断文件描述符是否存在
        let current = if fd == FD_NULL {
            None
        } else {
            let file = process.fd_table.get_file(fd)?;
            Some(file.get_inode())
        };
        // 根据文件类型匹配
        let file = if flags.contains(OpenFlags::CREATE) {
            INode::open(current, &filename, true)?
        } else {
            INode::open(current, &filename, false)?
        };
        let fd = process.fd_table.alloc();
        process.fd_table.set(fd, file);
        drop(process);
        inner.context.x[10] = fd;
        Ok(())
    }
    // 关闭文件
    pub fn sys_close(&self, fd: usize) -> Result<(), RuntimeError> {
        warn!("close fd: {}",fd);
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        process.fd_table.dealloc(fd);
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
    // 管道符
    pub fn sys_pipe2(&self, req_ptr: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        // 匹配文件参数
        let req_ptr = usize::from(process.pmm.get_phys_addr(req_ptr.into()).unwrap()) as *mut u32;
        // 创建pipe
        let (read_pipe, write_pipe) = new_pipe();
        // 写入数据
        let read_fd = process.fd_table.push(read_pipe);
        let write_fd = process.fd_table.push(write_pipe);
        // 写入文件数据
        unsafe {
            req_ptr.write(read_fd as u32);
            req_ptr.add(1).write(write_fd as u32);
        };
        drop(process);
        // 创建成功
        inner.context.x[10] = 0;
        Ok(())
    }
    // 获取文件信息
    pub fn sys_getdents(&self, _fd: usize, _ptr: usize, _len: usize) -> Result<(), RuntimeError> {
        // let mut inner = self.inner.borrow_mut();
        // let process = inner.process.borrow_mut();

        // // 获取参数
        // let start_ptr = usize::from(process.pmm.get_phys_addr(VirtAddr::from(ptr)).unwrap());
        // let mut buf_ptr = start_ptr;
        // let value = if let Some(file_tree_node) = process.fd_table.get(fd) {
        //     match &mut file_tree_node.lock().target {
        //         FileDescEnum::File(file_tree_node) => {
        //             // 添加 . 和 ..
        //             {
        //                 let sub_node_name = ".";
        //                 let dirent = unsafe { (buf_ptr as *mut Dirent).as_mut().unwrap() };
        //                 // 计算大小保证内存对齐
        //                 let node_size = ((18 + sub_node_name.len() as u16 + 1 + 15) / 16) * 16;
        //                 dirent.d_ino = 0;
        //                 dirent.d_off = 0;
        //                 dirent.d_reclen = node_size;
        //                 dirent.d_type = 0;
        //                 let buf_str = unsafe {
        //                     slice::from_raw_parts_mut(&mut dirent.d_name_start as *mut u8, (node_size - 18) as usize)
        //                 };
        //                 write_string_to_raw(buf_str, sub_node_name);
        //                 buf_ptr = buf_ptr + dirent.d_reclen as usize;
        //             }
        //             {
        //                 let sub_node_name = "..";
        //                 let dirent = unsafe { (buf_ptr as *mut Dirent).as_mut().unwrap() };
        //                 // 计算大小保证内存对齐
        //                 let node_size = ((18 + sub_node_name.len() as u16 + 1 + 15) / 16) * 16;
        //                 dirent.d_ino = 0;
        //                 dirent.d_off = 0;
        //                 dirent.d_reclen = node_size;
        //                 dirent.d_type = 0;
        //                 let buf_str = unsafe {
        //                     slice::from_raw_parts_mut(&mut dirent.d_name_start as *mut u8, (node_size - 18) as usize)
        //                 };
        //                 write_string_to_raw(buf_str, sub_node_name);
        //                 buf_ptr = buf_ptr + dirent.d_reclen as usize;
        //             }
        //             // 添加目录中的其他文件
        //             let sub_nodes = file_tree_node.get_children();
        //             for i in 0..sub_nodes.len() {
        //                 let sub_node_name = sub_nodes[i].get_filename();
        //                 let dirent = unsafe { (buf_ptr as *mut Dirent).as_mut().unwrap() };
        //                 // 计算大小保证内存对齐
        //                 let node_size = ((18 + sub_node_name.len() as u16 + 1 + 15) / 16) * 16;
        //                 dirent.d_ino = (i+2) as u64;
        //                 dirent.d_off = (i+2) as u64;
        //                 dirent.d_reclen = node_size;
        //                 dirent.d_type = 0;
        //                 let buf_str = unsafe {
        //                     slice::from_raw_parts_mut(&mut dirent.d_name_start as *mut u8, (node_size - 18) as usize)
        //                 };
        //                 write_string_to_raw(buf_str, &sub_node_name);
        //                 buf_ptr = buf_ptr + dirent.d_reclen as usize;
        //                 // 保证缓冲区不会溢出
        //                 if buf_ptr - start_ptr >= len {
        //                     break;
        //                 }
        //             }
        //             buf_ptr - start_ptr
        //         },
        //         _ => {
        //             SYS_CALL_ERR
        //         }
        //     }
        // } else {
        //     SYS_CALL_ERR
        // };
        // drop(process);
        // inner.context.x[10] = value;
        // Ok(())
        todo!()
    }

    pub fn sys_statfs(&self, fd: usize, buf_ptr: VirtAddr) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        let buf_ptr = buf_ptr.translate(process.pmm.clone());
        let buf = buf_ptr.tranfer::<StatFS>();
        buf.f_type = 32;
        buf.f_bsize = 512;
        buf.f_blocks = 80;
        buf.f_bfree = 40;
        buf.f_bavail = 0;
        buf.f_files = 32;
        buf.f_ffree = 0;
        buf.f_fsid = 32;
        buf.f_namelen = 20;
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }

    // 读取
    pub fn sys_read(&self, fd: usize, buf_ptr: usize, count: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 获取参数
        let buf = process.pmm.get_phys_addr(buf_ptr.into()).unwrap();
        let buf = get_buf_from_phys_addr(buf, count);

        warn!("读取 fd: {} open size: {}", fd, count);

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
    pub fn sys_write(&self, fd: usize, buf_ptr: usize, count: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        
        // 获取参数
        let buf = process.pmm.get_phys_addr(buf_ptr.into()).unwrap();
        // 寻找物理地址
        let buf = get_buf_from_phys_addr(buf, count);

        // 判断文件描述符是否存在
        let writer = process.fd_table.get(fd)?;
        let value = if writer.writeable() {
            writer.write(buf, buf.len())
        } else {
            usize::MAX
        };
        drop(process);
        inner.context.x[10] = value;
        Ok(())
    }
    // 写入
    pub fn sys_writev(&self, fd: usize, iov: VirtAddr, iovcnt: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        
        let fd = process.fd_table.get(fd)?;
        let iov_vec = iov.translate(process.pmm.clone()).transfer_vec_count::<IoVec>(iovcnt);
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

    pub fn sys_readv(&self, fd: usize, iov: VirtAddr, iovcnt: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        
        let fd = process.fd_table.get(fd)?;
        let iov_vec = iov.translate(process.pmm.clone()).transfer_vec_count::<IoVec>(iovcnt);
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

    pub fn sys_fstat(&self, fd: usize, buf_ptr: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 获取参数
        let kstat_ptr = unsafe {
            (usize::from(process.pmm.get_phys_addr(buf_ptr.into()).unwrap()) as *mut Kstat).as_mut().unwrap()
        };
        // 判断文件描述符是否存在
        let inode = process.fd_table.get_file(fd)?;
        let inode = inode.get_inode();
        let inode = inode.0.borrow_mut();
        kstat_ptr.st_dev = 1;
        kstat_ptr.st_ino = 1;
        kstat_ptr.st_mode = 0;
        kstat_ptr.st_nlink = inode.nlinkes as u32;
        kstat_ptr.st_uid = 0;
        kstat_ptr.st_gid = 0;
        kstat_ptr.st_rdev = 0;
        kstat_ptr.__pad = 0;
        kstat_ptr.st_size = inode.size as u64;
        kstat_ptr.st_blksize = 512;
        kstat_ptr.st_blocks = ((inode.size - 1 + 512) / 512) as u64;
        kstat_ptr.st_atime_sec = inode.st_atime_sec;
        kstat_ptr.st_atime_nsec = inode.st_atime_nsec;
        kstat_ptr.st_mtime_sec = inode.st_mtime_sec;
        kstat_ptr.st_mtime_nsec = inode.st_mtime_nsec;
        kstat_ptr.st_ctime_sec = inode.st_ctime_sec;
        kstat_ptr.st_ctime_nsec = inode.st_ctime_nsec;
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }

    // 获取文件信息
    pub fn sys_fstatat(&self, dir_fd: usize, filename: VirtAddr, stat_ptr: usize, flags: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 获取参数
        let kstat_ptr = unsafe {
            (usize::from(process.pmm.get_phys_addr(stat_ptr.into()).unwrap()) as *mut Kstat).as_mut().unwrap()
        };
        // 判断文件描述符是否存在
        let filename = process.pmm.get_phys_addr(filename).unwrap();
        let filename = get_string_from_raw(filename);

        if filename != "/dev/null" {
            // 判断文件描述符是否存在
            let file = if dir_fd == FD_NULL {
                None
            } else {
                let file = process.fd_table.get_file(dir_fd)?;
                Some(file.get_inode())
            };
            
            let inode = INode::get(file, &filename, false)?;
            let inode = inode.0.borrow_mut();
            kstat_ptr.st_dev = 1;
            kstat_ptr.st_ino = 1;
            // kstat_ptr.st_mode = 0;
            if inode.file_type == FileType::Directory {
                kstat_ptr.st_mode = 0o40000;
            } else {
                kstat_ptr.st_mode = 0;
            }
            kstat_ptr.st_nlink = inode.nlinkes as u32;
            kstat_ptr.st_uid = 0;
            kstat_ptr.st_gid = 0;
            kstat_ptr.st_rdev = 0;
            kstat_ptr.__pad = 0;
            kstat_ptr.st_size = inode.size as u64;
            kstat_ptr.st_blksize = 512;
            kstat_ptr.st_blocks = ((inode.size - 1 + 512) / 512) as u64;
            kstat_ptr.st_atime_sec = inode.st_atime_sec;
            kstat_ptr.st_atime_nsec = inode.st_atime_nsec;
            kstat_ptr.st_mtime_sec = inode.st_mtime_sec;
            kstat_ptr.st_mtime_nsec = inode.st_mtime_nsec;
            kstat_ptr.st_ctime_sec = inode.st_ctime_sec;
            kstat_ptr.st_ctime_nsec = inode.st_ctime_nsec;
            drop(process);
            inner.context.x[10] = 0;
            Ok(())
        } else {
            kstat_ptr.st_mode = 0o20000;
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

}
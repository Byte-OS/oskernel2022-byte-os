use core::slice;

use alloc::sync::Arc;

use crate::{task::{FileDescEnum, FileDesc, task::Task}, memory::addr::VirtAddr, fs::{filetree::FILETREE, file::Kstat}, sync::mutex::Mutex, console::puts, runtime_err::RuntimeError};
use crate::memory::addr::get_buf_from_phys_addr;

use super::{SYS_CALL_ERR, get_string_from_raw, OpenFlags, write_string_to_raw, Dirent, sys_write_wrap};

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
        // 申请文件描述符空间
        let new_fd = process.fd_table.alloc();
        // 判断文件描述符是否存在
        let value = match process.fd_table.get(fd) {
            Some(tree_node) => {
                process.fd_table.set(new_fd, Some(tree_node));
                new_fd
            }
            None => SYS_CALL_ERR
        };
        drop(process);
        inner.context.x[10] = value;
        Ok(())
    }

    // 复制文件描述符
    pub fn sys_dup3(&self, fd: usize, new_fd: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        // 判断是否存在文件描述符
        let value = match process.fd_table.get(fd) {
            Some(tree_node) => {
                // 申请空间 判断是否申请成功
                if process.fd_table.alloc_fixed_index(new_fd) == SYS_CALL_ERR {
                    SYS_CALL_ERR
                } else {
                    process.fd_table.set(new_fd, Some(tree_node));
                    new_fd
                }
            }
            None => SYS_CALL_ERR
        };
        drop(process);
        inner.context.x[10] = value;
        Ok(())
    }

    pub fn sys_mkdirat(&self, dir_fd: usize, filename: usize, flags: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();

        let filename = process.pmm.get_phys_addr(VirtAddr::from(filename)).unwrap();
        let filename = get_string_from_raw(filename);

        // 判断文件描述符是否存在
        let value = if dir_fd == 0xffffffffffffff9c {
            // 在用户根据目录创建
            process.workspace.mkdir(&filename, flags as u16);
            0
        } else {
            // 判度是否存在节点
            if let Some(tree_node) = process.fd_table.get(dir_fd).clone() {
                // 匹配文件节点
                match &mut tree_node.lock().target {
                    FileDescEnum::File(tree_node) => {
                        tree_node.mkdir(&filename, flags as u16);
                        0
                    }, 
                    _ => {
                        SYS_CALL_ERR
                    }
                }
            } else {
                SYS_CALL_ERR
            }
        };
        drop(process);
        inner.context.x[10] = value;
        Ok(())
    }

    pub fn sys_unlinkat(&self, fd: usize, filename: usize, _flags: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 获取参数
        let filename = process.pmm.get_phys_addr(VirtAddr::from(filename)).unwrap();
        let filename = get_string_from_raw(filename);

        // 判断文件描述符是否存在
        let value = if fd == 0xffffffffffffff9c {
            if let Ok(node) = FILETREE.force_get().open(&filename) {
                let node_name = node.get_filename();

                let parent = node.get_parent().clone().unwrap();
                parent.delete(&node_name);
                0
            } else {
                SYS_CALL_ERR
            }
        } else {
            if let Some(tree_node) = process.fd_table.get(fd).clone() {
                // 匹配目标 判断文件类型
                match &mut tree_node.lock().target {
                    FileDescEnum::File(tree_node) => {
                        if let Ok(node) = tree_node.open(&filename) {
                            let node_name = node.get_filename();
        
                            let parent = node.get_parent().clone().unwrap();
                            parent.delete(&node_name);
                            0
                        } else {
                            SYS_CALL_ERR
                        }
                    }, 
                    _ => {
                        SYS_CALL_ERR
                    }
                }
            } else {
                SYS_CALL_ERR
            }
        };
        drop(process);
        inner.context.x[10] = value;
        Ok(())
    }

    pub fn sys_chdir(&self, filename: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();

        let filename = process.pmm.get_phys_addr(VirtAddr::from(filename)).unwrap();
        let filename = get_string_from_raw(filename);

        let value = if let Ok(file) = FILETREE.lock().open(&filename) {
            process.workspace = file.clone();
            0
        } else {
            SYS_CALL_ERR
        };
        drop(process);
        inner.context.x[10] = value;
        Ok(())
    }

    pub fn sys_openat(&self, fd: usize, filename: usize, flags: usize, _open_mod: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();

        // 获取文件信息
        let filename = process.pmm.get_phys_addr(VirtAddr::from(filename)).unwrap();
        let filename = get_string_from_raw(filename);
        let debug_flags = OpenFlags::from_bits(flags as u32);
        info!("flags: {:?}", debug_flags);
        let flags = OpenFlags::from_bits(flags as u32).unwrap();

        // 判断文件描述符是否存在
        let value = if fd == 0xffffffffffffff9c {
            info!("读取");
            // 根据文件类型匹配
            if flags.contains(OpenFlags::CREATE) {
                process.workspace.create(&filename)?;
            }
            if let Ok(file) = process.workspace.open(&filename) {
                let fd = process.fd_table.alloc();
                process.fd_table.set(fd, Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::File(file.clone()))))));
                fd
            } else {
                SYS_CALL_ERR
            }
        } else {
            if let Some(tree_node) = process.fd_table.get(fd).clone() {
                // 匹配文件类型
                match &mut tree_node.lock().target {
                    FileDescEnum::File(tree_node) => {
                        if flags.contains(OpenFlags::CREATE) {
                            tree_node.create(&filename)?;
                        }
                        if let Ok(file) = tree_node.open(&filename) {
                            let fd = process.fd_table.alloc();
                            process.fd_table.set(fd, Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::File(file.clone()))))));
                            fd
                        } else {
                            SYS_CALL_ERR
                        }
                    }, 
                    _ => {
                        SYS_CALL_ERR
                    }
                }
            } else {
                SYS_CALL_ERR
            }
        };
        drop(process);
        inner.context.x[10] = value;
        Ok(())
    }

    pub fn sys_close(&self, fd: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();

        let value = if process.fd_table.get(fd).is_some() {
            process.fd_table.set(fd, None);
            0
        } else {
            SYS_CALL_ERR
        };
        drop(process);
        inner.context.x[10] = value;
        Ok(())
    }

    pub fn sys_pipe2(&self, req_ptr: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        // 匹配文件参数
        let req_ptr = usize::from(process.pmm.get_phys_addr(req_ptr.into()).unwrap()) as *mut u32;
        // 创建pipe
        let (read_pipe, write_pipe) = FileDesc::new_pipe();
        // 写入数据
        let read_fd = process.fd_table.push(Some(Arc::new(Mutex::new(read_pipe))));
        let write_fd = process.fd_table.push(Some(Arc::new(Mutex::new(write_pipe))));
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

    pub fn sys_getdents(&self, fd: usize, ptr: usize, len: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 获取参数
        let start_ptr = usize::from(process.pmm.get_phys_addr(VirtAddr::from(ptr)).unwrap());
        let mut buf_ptr = start_ptr;
        let value = if let Some(file_tree_node) = process.fd_table.get(fd) {
            match &mut file_tree_node.lock().target {
                FileDescEnum::File(file_tree_node) => {
                    // 添加 . 和 ..
                    {
                        let sub_node_name = ".";
                        let dirent = unsafe { (buf_ptr as *mut Dirent).as_mut().unwrap() };
                        // 计算大小保证内存对齐
                        let node_size = ((18 + sub_node_name.len() as u16 + 1 + 15) / 16) * 16;
                        dirent.d_ino = 0;
                        dirent.d_off = 0;
                        dirent.d_reclen = node_size;
                        dirent.d_type = 0;
                        let buf_str = unsafe {
                            slice::from_raw_parts_mut(&mut dirent.d_name_start as *mut u8, (node_size - 18) as usize)
                        };
                        write_string_to_raw(buf_str, sub_node_name);
                        buf_ptr = buf_ptr + dirent.d_reclen as usize;
                    }
                    {
                        let sub_node_name = "..";
                        let dirent = unsafe { (buf_ptr as *mut Dirent).as_mut().unwrap() };
                        // 计算大小保证内存对齐
                        let node_size = ((18 + sub_node_name.len() as u16 + 1 + 15) / 16) * 16;
                        dirent.d_ino = 0;
                        dirent.d_off = 0;
                        dirent.d_reclen = node_size;
                        dirent.d_type = 0;
                        let buf_str = unsafe {
                            slice::from_raw_parts_mut(&mut dirent.d_name_start as *mut u8, (node_size - 18) as usize)
                        };
                        write_string_to_raw(buf_str, sub_node_name);
                        buf_ptr = buf_ptr + dirent.d_reclen as usize;
                    }
                    // 添加目录中的其他文件
                    let sub_nodes = file_tree_node.get_children();
                    for i in 0..sub_nodes.len() {
                        let sub_node_name = sub_nodes[i].get_filename();
                        let dirent = unsafe { (buf_ptr as *mut Dirent).as_mut().unwrap() };
                        // 计算大小保证内存对齐
                        let node_size = ((18 + sub_node_name.len() as u16 + 1 + 15) / 16) * 16;
                        dirent.d_ino = (i+2) as u64;
                        dirent.d_off = (i+2) as u64;
                        dirent.d_reclen = node_size;
                        dirent.d_type = 0;
                        let buf_str = unsafe {
                            slice::from_raw_parts_mut(&mut dirent.d_name_start as *mut u8, (node_size - 18) as usize)
                        };
                        write_string_to_raw(buf_str, &sub_node_name);
                        buf_ptr = buf_ptr + dirent.d_reclen as usize;
                        // 保证缓冲区不会溢出
                        if buf_ptr - start_ptr >= len {
                            break;
                        }
                    }
                    buf_ptr - start_ptr
                },
                _ => {
                    SYS_CALL_ERR
                }
            }
        } else {
            SYS_CALL_ERR
        };
        drop(process);
        inner.context.x[10] = value;
        Ok(())
    }

    pub fn sys_read(&self, fd: usize, buf_ptr: usize, count: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();

        // 获取参数
        let buf = process.pmm.get_phys_addr(buf_ptr.into()).unwrap();
        let buf = get_buf_from_phys_addr(buf, count);

        // 判断文件描述符是否存在
        let value = if let Some(file_tree_node) = process.fd_table.get(fd) {
            // 匹配文件目标类型
            match &mut file_tree_node.lock().target {
                FileDescEnum::File(file_tree_node) => {
                    let size = file_tree_node.read_to(buf);
                    size
                },
                FileDescEnum::Pipe(pipe) => {
                    pipe.read(buf)
                },
                _ => {
                    SYS_CALL_ERR
                }
            }
        } else {
            SYS_CALL_ERR
        };
        drop(process);
        inner.context.x[10] = value;
        Ok(())
    }

    pub fn sys_write(&self, fd: usize, buf_ptr: usize, count: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        
        // 获取参数
        let buf = process.pmm.get_phys_addr(buf_ptr.into()).unwrap();
        // 寻找物理地址
        let buf = get_buf_from_phys_addr(buf, count);

        // 判断文件描述符是否存在
        let value = if let Some(file_tree_node) = process.fd_table.get(fd) {
            // 判断文件描述符类型
            match &mut file_tree_node.lock().target {
                FileDescEnum::File(file_tree) => {
                    sys_write_wrap(file_tree.clone(),buf_ptr,count);
                    count
                },
                FileDescEnum::Device(device_name) => {
                    match device_name as &str {
                        "STDIN" => 0,
                        "STDOUT" => {
                            puts(buf);
                            buf.len()
                        },
                        "STDERR" => 0,
                        _ => {
                            info!("未找到设备!");
                            0
                        }
                    }
                },
                FileDescEnum::Pipe(pipe) => pipe.write(buf, count),
                // _ => {
                //     let result_code: isize = -1;
                //     context.x[10] = result_code as usize;
                // }
            }
        } else {
            SYS_CALL_ERR
        };
        drop(process);
        inner.context.x[10] = value;
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
        let value = if let Some(tree_node) = process.fd_table.get(fd) {
            match &mut tree_node.lock().target {
                FileDescEnum::File(tree_node) => {
                    let tree_node = tree_node.0.borrow_mut();
                    kstat_ptr.st_dev = 1;
                    kstat_ptr.st_ino = 1;
                    kstat_ptr.st_mode = 0;
                    kstat_ptr.st_nlink = tree_node.nlinkes as u32;
                    kstat_ptr.st_uid = 0;
                    kstat_ptr.st_gid = 0;
                    kstat_ptr.st_rdev = 0;
                    kstat_ptr.__pad = 0;
                    kstat_ptr.st_size = tree_node.size as u64;
                    kstat_ptr.st_blksize = 512;
                    kstat_ptr.st_blocks = ((tree_node.size - 1 + 512) / 512) as u64;
                    kstat_ptr.st_atime_sec = tree_node.st_atime_sec;
                    kstat_ptr.st_atime_nsec = tree_node.st_atime_nsec;
                    kstat_ptr.st_mtime_sec = tree_node.st_mtime_sec;
                    kstat_ptr.st_mtime_nsec = tree_node.st_mtime_nsec;
                    kstat_ptr.st_ctime_sec = tree_node.st_ctime_sec;
                    kstat_ptr.st_ctime_nsec = tree_node.st_ctime_nsec;
                    0
                }, 
                _ => {
                    SYS_CALL_ERR
                }
            }
        } else {
            SYS_CALL_ERR
        };
        drop(process);
        inner.context.x[10] = value;
        Ok(())
    }

}
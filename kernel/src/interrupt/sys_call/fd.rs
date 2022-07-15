use core::slice;

use alloc::sync::Arc;

use crate::{task::{get_current_task, task_scheduler::get_current_process, FileDescEnum, process, FileDesc}, memory::addr::VirtAddr, fs::{filetree::FILETREE, file::Kstat}, sync::mutex::Mutex, console::puts, runtime_err::RuntimeError};

use super::{SYS_CALL_ERR, get_string_from_raw, OpenFlags, write_string_to_raw, Dirent, sys_write_wrap};

// 获取当前路径
pub fn get_cwd(buf: usize, size: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();

    // 获取参数
    let mut buf = process.pmm.get_phys_addr(VirtAddr::from(buf)).unwrap();
    // 设置缓冲区地址
    let buf = unsafe { slice::from_raw_parts_mut(buf.as_mut_ptr(), size) };
    // 获取路径
    let pwd = process.workspace.get_pwd();
    let pwd_buf = pwd.as_bytes();
    // 将路径复制到缓冲区
    buf[..pwd_buf.len()].copy_from_slice(pwd_buf);
    Ok(buf.as_ptr() as usize)
}

pub fn sys_dup(fd: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();
    // 申请文件描述符空间
    let new_fd = process.fd_table.alloc();
    // 判断文件描述符是否存在
    if let Some(tree_node) = process.fd_table.get(fd).clone() {
        process.fd_table.set(new_fd, Some(tree_node));
        Ok(new_fd)
    } else {
        Ok(SYS_CALL_ERR)
    }
}

pub fn sys_dup3(fd: usize, new_fd: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();
    // 判断是否存在文件描述符
    if let Some(tree_node) = process.fd_table.get(fd).clone() {
        // 申请空间 判断是否申请成功
        if process.fd_table.alloc_fixed_index(new_fd) == SYS_CALL_ERR {
            Ok(SYS_CALL_ERR)
        } else {
            process.fd_table.set(new_fd, Some(tree_node));
            Ok(new_fd)
        }
    } else {
        Ok(SYS_CALL_ERR)
    }
}

pub fn sys_mkdirat(dirfd: usize, filename: usize, flags: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();

    let filename = process.pmm.get_phys_addr(VirtAddr::from(filename)).unwrap();
    let filename = get_string_from_raw(filename);

    // 判断文件描述符是否存在
    if dirfd == 0xffffffffffffff9c {
        // 在用户根据目录创建
        process.workspace.mkdir(&filename, flags as u16);
        Ok(0)
    } else {
        // 判度是否存在节点
        if let Some(tree_node) = process.fd_table.get(dirfd).clone() {
            // 匹配文件节点
            match &mut tree_node.lock().target {
                FileDescEnum::File(tree_node) => {
                    tree_node.mkdir(&filename, flags as u16);
                    Ok(0)
                }, 
                _ => {
                    Ok(SYS_CALL_ERR)
                }
            }
        } else {
            Ok(SYS_CALL_ERR)
        }
    }
}

pub fn sys_unlinkat(fd: usize, filename: usize, flags: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();

    // 获取参数
    let filename = process.pmm.get_phys_addr(VirtAddr::from(filename)).unwrap();
    let filename = get_string_from_raw(filename);

    // 判断文件描述符是否存在
    if fd == 0xffffffffffffff9c {
        if let Ok(node) = FILETREE.force_get().open(&filename) {
            let node_name = node.get_filename();

            let parent = node.get_parent().clone().unwrap();
            parent.delete(&node_name);
            Ok(0)
        } else {
            Ok(SYS_CALL_ERR)
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
                        Ok(0)
                    } else {
                        Ok(SYS_CALL_ERR)
                    }
                }, 
                _ => {
                    Ok(SYS_CALL_ERR)
                }
            }
        } else {
            Ok(SYS_CALL_ERR)
        }
    }
}

pub fn sys_chdir(filename: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();
    let filename = process.pmm.get_phys_addr(VirtAddr::from(filename)).unwrap();
    let filename = get_string_from_raw(filename);

    if let Ok(file) = FILETREE.lock().open(&filename) {
        process.workspace = file.clone();
        Ok(0)
    } else {
        Ok(SYS_CALL_ERR)
    }
}

pub fn sys_openat(fd: usize, filename: usize, flags: usize, open_mod: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();

    // 获取文件信息
    let filename = process.pmm.get_phys_addr(VirtAddr::from(filename)).unwrap();
    let filename = get_string_from_raw(filename);

    let flags = OpenFlags::from_bits(flags as u32).unwrap();

    // 判断文件描述符是否存在
    if fd == 0xffffffffffffff9c {
        // 根据文件类型匹配
        if flags.contains(OpenFlags::CREATE) {
            process.workspace.create(&filename);
        }
        if let Ok(file) = process.workspace.open(&filename) {
            let fd = process.fd_table.alloc();
            process.fd_table.set(fd, Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::File(file.clone()))))));
            Ok(fd)
        } else {
            Ok(SYS_CALL_ERR)
        }
    } else {
        if let Some(tree_node) = process.fd_table.get(fd).clone() {
            // 匹配文件类型
            match &mut tree_node.lock().target {
                FileDescEnum::File(tree_node) => {
                    if flags.contains(OpenFlags::CREATE) {
                        tree_node.create(&filename);
                    }
                    if let Ok(file) = tree_node.open(&filename) {
                        let fd = process.fd_table.alloc();
                        process.fd_table.set(fd, Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::File(file.clone()))))));
                        Ok(fd)
                    } else {
                        Ok(SYS_CALL_ERR)
                    }
                }, 
                _ => {
                    Ok(SYS_CALL_ERR)
                }
            }
        } else {
            Ok(SYS_CALL_ERR)
        }
    }
}

pub fn sys_close(fd: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();

    if process.fd_table.get(fd).is_some() {
        process.fd_table.set(fd, None);
        Ok(0)
    } else {
        Ok(SYS_CALL_ERR)
    }
}

pub fn sys_pipe2(req_ptr: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();
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

    // 创建成功
    Ok(0)
}

pub fn sys_getdents(fd: usize, ptr: usize, len: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();

    // 获取参数
    let start_ptr = usize::from(process.pmm.get_phys_addr(VirtAddr::from(ptr)).unwrap());
    let mut buf_ptr = start_ptr;
    if let Some(file_tree_node) = process.fd_table.get(fd) {
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
                Ok(buf_ptr - start_ptr)
            },
            _ => {
                Ok(SYS_CALL_ERR)
            }
        }
    } else {
        Ok(SYS_CALL_ERR)
    }
}

pub fn sys_read(fd: usize, buf_ptr: usize, count: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();

    // 获取参数
    let mut buf = process.pmm.get_phys_addr(buf_ptr.into()).unwrap();
    let buf = unsafe { slice::from_raw_parts_mut(buf.as_mut_ptr(), count) };

    // 判断文件描述符是否存在
    if let Some(file_tree_node) = process.fd_table.get(fd) {
        // 匹配文件目标类型
        match &mut file_tree_node.lock().target {
            FileDescEnum::File(file_tree_node) => {
                let size = file_tree_node.read_to(buf);
                Ok(size)
            },
            FileDescEnum::Pipe(pipe) => {
                Ok(pipe.read(buf))
            },
            _ => {
                Ok(SYS_CALL_ERR)
            }
        }
    } else {
        Ok(SYS_CALL_ERR)
    }
}

pub fn sys_write(fd: usize, buf_ptr: usize, count: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();
    
    // 获取参数
    let buf = process.pmm.get_phys_addr(buf_ptr.into()).unwrap();
    // 寻找物理地址
    let buf = unsafe {slice::from_raw_parts_mut(usize::from(buf) as *mut u8, count)};

    // 判断文件描述符是否存在
    if let Some(file_tree_node) = process.fd_table.get(fd) {
        // 判断文件描述符类型
        match &mut file_tree_node.lock().target {
            FileDescEnum::File(file_tree) => {
                sys_write_wrap(file_tree.clone(),buf_ptr,count);
                Ok(count)
            },
            FileDescEnum::Device(device_name) => {
                Ok(match device_name as &str {
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
                })
            },
            FileDescEnum::Pipe(pipe) => Ok(pipe.write(buf, count)),
            // _ => {
            //     let result_code: isize = -1;
            //     context.x[10] = result_code as usize;
            // }
        }
    } else {
        Ok(SYS_CALL_ERR)
    }
}

pub fn sys_fstat(fd: usize, buf_ptr: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process().borrow_mut();

    // 获取参数
    let kstat_ptr = unsafe {
        (usize::from(process.pmm.get_phys_addr(buf_ptr.into()).unwrap()) as *mut Kstat).as_mut().unwrap()
    };
    // 判断文件描述符是否存在
    if let Some(tree_node) = process.fd_table.get(fd) {
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
                Ok(0)
            }, 
            _ => {
                Ok(SYS_CALL_ERR)
            }
        }
    } else {
        Ok(SYS_CALL_ERR)
    }
}

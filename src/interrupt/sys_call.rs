use core::slice;

use alloc::{string::String, sync::Arc};
use riscv::register::satp;

use crate::{console::puts, task::{kill_current_task, get_current_task, exec, clone_task, TASK_CONTROLLER_MANAGER, suspend_and_run_next, wait_task, FileDescEnum, FileDesc}, memory::{page_table::{PageMapping, PTEFlags}, addr::{VirtAddr, PhysPageNum, PhysAddr}}, fs::{filetree::{FILETREE, FileTreeNode}, file::{Kstat, FileType}},  interrupt::TICKS, sync::mutex::Mutex};

use super::{Context,  timer::{TimeSpec, TMS}};

// 中断调用列表
pub const SYS_GETCWD:usize  = 17;
pub const SYS_DUP: usize    = 23;
pub const SYS_DUP3: usize   = 24;
pub const SYS_MKDIRAT:usize = 34;
pub const SYS_UNLINKAT:usize= 35;
pub const SYS_UMOUNT2: usize= 39;
pub const SYS_MOUNT: usize  = 40;
pub const SYS_CHDIR: usize  = 49;
pub const SYS_OPENAT:usize  = 56;
pub const SYS_CLOSE: usize  = 57;
pub const SYS_PIPE2: usize  = 59;
pub const SYS_GETDENTS:usize= 61;
pub const SYS_READ:  usize  = 63;
pub const SYS_WRITE: usize  = 64;
pub const SYS_FSTAT: usize  = 80;
pub const SYS_EXIT:  usize  = 93;
pub const SYS_NANOSLEEP: usize = 101;
pub const SYS_SCHED_YIELD: usize = 124;
pub const SYS_TIMES: usize  = 153;
pub const SYS_UNAME: usize  = 160;
pub const SYS_GETTIMEOFDAY: usize= 169;
pub const SYS_GETPID:usize  = 172;
pub const SYS_GETPPID:usize = 173;
pub const SYS_BRK:   usize  = 214;
pub const SYS_CLONE: usize  = 220;
pub const SYS_EXECVE:usize  = 221;
pub const SYS_MMAP: usize   = 222;
pub const SYS_MUNMAP:usize  = 215;
pub const SYS_WAIT4: usize  = 260;

// 系统调用错误码
pub const SYS_CALL_ERR: usize = -1 as isize as usize;


// Open标志
bitflags! {
    pub struct OpenFlags: u32 {
        const RDONLY = 0;
        const WRONLY = 1 << 0;
        const RDWR = 1 << 1;
        const CREATE = 1 << 6;
        const TRUNC = 1 << 10;
        const O_DIRECTORY = 1 << 21;
    }
}

// 系统信息结构
pub struct UTSname  {
    sysname: [u8;65],
    nodename: [u8;65],
    release: [u8;65],
    version: [u8;65],
    machine: [u8;65],
    domainname: [u8;65],
}

// 文件Dirent结构
#[repr(C)]
struct Dirent {
    d_ino: u64,	        // 索引结点号
    d_off: u64,	        // 到下一个dirent的偏移
    d_reclen: u16,	    // 当前dirent的长度
    d_type: u8,	        // 文件类型
    d_name_start: u8	//文件名
}

// sys_write调用
pub fn sys_write(fd: FileTreeNode, buf: usize, count: usize) -> usize {
    // 根据satp中的地址构建PageMapping 获取当前的映射方式
    let pmm = PageMapping::from(PhysPageNum(satp::read().bits()).to_addr());
    let buf = pmm.get_phys_addr(VirtAddr::from(buf)).unwrap();

    // 寻找物理地址
    let buf = unsafe {slice::from_raw_parts_mut(usize::from(buf) as *mut u8, count)};
    
    // 匹配文件类型
    match fd.get_file_type() {
        FileType::VirtFile => {
            fd.write(buf);
        }
        _ => {info!("SYS_WRITE暂未找到设备");}
    }
    count
}

// 从内存中获取字符串 目前仅支持ascii码
pub fn get_string_from_raw(addr: PhysAddr) -> String {
    let mut ptr = addr.as_ptr();
    let mut str: String = String::new();
    loop {
        let ch = unsafe { *ptr };
        if ch == 0 {
            break;
        }
        str.push(ch as char);
        unsafe { ptr = ptr.add(1) };
    }
    str
}

// 将字符串写入内存 目前仅支持ascii码
pub fn write_string_to_raw(target: &mut [u8], str: &str) {
    let mut index = 0;
    for c in str.chars() {
        target[index] = c as u8;
        index = index + 1;
    }
    target[index] = 0;
}

// 系统调用
pub fn sys_call() {
    // 读取当前任务和任务的寄存器上下文
    let current_task_wrap = get_current_task().unwrap();
    let mut current_task = current_task_wrap.force_get();
    let context: &mut Context = &mut current_task.context;
    // 重新设置current_task 前一个current_task所有权转移
    let mut current_task = current_task_wrap.force_get();
    let mut pmm = PageMapping::from(PhysPageNum(satp::read().bits()).to_addr());
    // 将 恢复地址 + 4 跳过调用地址
    context.sepc += 4;

    // 匹配系统调用 a7(x17) 作为调用号
    match context.x[17] {
        // 获取文件路径
        SYS_GETCWD => {
            // 获取参数
            let mut buf = pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap();
            let size = context.x[11];
            // 设置缓冲区地址
            let buf = unsafe { slice::from_raw_parts_mut(buf.as_mut_ptr(), size) };
            // 获取路径
            let pwd = current_task.home_dir.get_pwd();
            let pwd_buf = pwd.as_bytes();
            // 将路径复制到缓冲区
            buf[..pwd_buf.len()].copy_from_slice(pwd_buf);
            context.x[10] = buf.as_ptr() as usize;
        }
        // 复制文件描述符
        SYS_DUP => {
            // 获取寄存器信息
            let fd = context.x[10];
            // 申请文件描述符空间
            let new_fd = current_task.alloc_fd();
            // 判断文件描述符是否存在
            if let Some(tree_node) = current_task.fd_table[fd].clone() {
                current_task.fd_table[new_fd] = Some(tree_node);
                context.x[10] = new_fd;
            } else {
                context.x[10] = SYS_CALL_ERR;
            }
        }
        // 复制文件描述符
        SYS_DUP3 => {
            // 获取参数信息
            let fd = context.x[10];
            let new_fd = context.x[11];
            // 判断是否存在文件描述符
            if let Some(tree_node) = current_task.fd_table[fd].clone() {
                // 申请空间 判断是否申请成功
                if current_task.alloc_fd_with_size(new_fd) == SYS_CALL_ERR {
                    context.x[10] = SYS_CALL_ERR;
                } else {
                    current_task.fd_table[new_fd] = Some(tree_node);
                    context.x[10] = new_fd;
                }
            } else {
                context.x[10] = SYS_CALL_ERR;
            }
        }
        // 创建文件夹
        SYS_MKDIRAT => {
            // 获取文件参数
            let dirfd = context.x[10];
            let filename = pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap();
            let filename = get_string_from_raw(filename);
            let flags = context.x[12];

            // 判断文件描述符是否存在
            if dirfd == 0xffffffffffffff9c {
                // 在用户根据目录创建
                current_task.home_dir.mkdir(&filename, flags as u16);
                context.x[10] = 0;
            } else {
                // 判度是否存在节点
                if let Some(tree_node) = current_task.fd_table[dirfd].clone() {
                    // 匹配文件节点
                    match &mut tree_node.lock().target {
                        FileDescEnum::File(tree_node) => {
                            tree_node.mkdir(&filename, flags as u16);
                            context.x[10] = 0;
                        }, 
                        _ => {
                            context.x[10] = SYS_CALL_ERR;
                        }
                    }
                } else {
                    context.x[10] = SYS_CALL_ERR;
                }
            }
        }
        // 取消link
        SYS_UNLINKAT => {
            // 获取参数
            let fd = context.x[10];
            let filename = pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap();
            let filename = get_string_from_raw(filename);
            let _flags = context.x[12];

            // 判断文件描述符是否存在
            if fd == 0xffffffffffffff9c {
                if let Ok(node) = FILETREE.force_get().open(&filename) {
                    let node_name = node.get_filename();

                    let parent = node.get_parent().clone().unwrap();
                    parent.delete(&node_name);
                    context.x[10] = 0;
                } else {
                    context.x[10] = -1 as isize as usize;
                }
            } else {
                if let Some(tree_node) = current_task.fd_table[fd].clone() {
                    // 匹配目标 判断文件类型
                    match &mut tree_node.lock().target {
                        FileDescEnum::File(tree_node) => {
                            if let Ok(node) = tree_node.open(&filename) {
                                let node_name = node.get_filename();
            
                                let parent = node.get_parent().clone().unwrap();
                                parent.delete(&node_name);
                                context.x[10] = 0;
                            } else {
                                context.x[10] = SYS_CALL_ERR;
                            }
                        }, 
                        _ => {
                            context.x[10] = SYS_CALL_ERR;
                        }
                    }
                } else {
                    context.x[10] = SYS_CALL_ERR;
                }
            }
            
        }
        // umount设备
        SYS_UMOUNT2 => {
            let _special_ptr = pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap();
            let _flag = context.x[11];
            context.x[10] = 0;
        }
        // mount设备
        SYS_MOUNT => {
            // 读取文件信息
            let special_ptr = pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap();
            let dir_ptr = pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap();
            let fstype_ptr = pmm.get_phys_addr(VirtAddr::from(context.x[12])).unwrap();
            let _flag = context.x[13];
            let _data_ptr = context.x[14];
            let _special = get_string_from_raw(special_ptr);
            let _dir = get_string_from_raw(dir_ptr);
            let _fstype = get_string_from_raw(fstype_ptr);

            context.x[10] = 0;
        }
        // 改变文件信息
        SYS_CHDIR => {
            // 获取文件信息
            let filename = pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap();
            let filename = get_string_from_raw(filename);

            if let Ok(file) = FILETREE.lock().open(&filename) {
                current_task.home_dir = file.clone();
                context.x[10] = 0;
            } else {
                context.x[10] = SYS_CALL_ERR;
            }
            
        }
        // 打开文件地址
        SYS_OPENAT => {
            // 获取文件信息
            let fd = context.x[10];
            let filename = pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap();
            let filename = get_string_from_raw(filename);
            let flags = context.x[12];
            let _open_mod = context.x[13];

            let flags = OpenFlags::from_bits(flags as u32).unwrap();

            // 判断文件描述符是否存在
            if fd == 0xffffffffffffff9c {
                // 根据文件类型匹配
                if flags.contains(OpenFlags::CREATE) {
                    current_task.home_dir.create(&filename);
                }
                if let Ok(file) = current_task.home_dir.open(&filename) {
                    let fd = current_task.alloc_fd();
                    current_task.fd_table[fd] = Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::File(file.clone())))));
                    context.x[10] = fd;
                } else {
                    context.x[10] = SYS_CALL_ERR;
                }
            } else {
                if let Some(tree_node) = current_task.fd_table[fd].clone() {
                    // 匹配文件类型
                    match &mut tree_node.lock().target {
                        FileDescEnum::File(tree_node) => {
                            if flags.contains(OpenFlags::CREATE) {
                                tree_node.create(&filename);
                            }
                            if let Ok(file) = tree_node.open(&filename) {
                                let fd = current_task.alloc_fd();
                                current_task.fd_table[fd] = Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::File(file.clone())))));
                                context.x[10] = fd;
                            } else {
                                context.x[10] = SYS_CALL_ERR;
                            }
                        }, 
                        _ => {
                            context.x[10] = SYS_CALL_ERR;
                        }
                    }
                } else {
                    context.x[10] = SYS_CALL_ERR;
                }
            };
        }
        // 关闭文件描述符
        SYS_CLOSE => {
            // 获取文件参数
            let fd = context.x[10];
            if let Some(_) = current_task.fd_table[fd].clone() {
                current_task.fd_table[fd] = None;
                context.x[10] = 0;
            } else {
                context.x[10] = SYS_CALL_ERR;
            }
        }
        // 进行PIPE
        SYS_PIPE2 => {
            // 匹配文件参数
            let req_ptr = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap()) as *mut u32;
            // 创建pipe
            let (read_pipe, write_pipe) = FileDesc::new_pipe();
            // 写入数据
            let read_fd = current_task.alloc_fd();
            current_task.fd_table[read_fd] = Some(Arc::new(Mutex::new(read_pipe)));
            let write_fd = current_task.alloc_fd();
            current_task.fd_table[write_fd] = Some(Arc::new(Mutex::new(write_pipe)));
            // 写入文件数据
            unsafe {
                req_ptr.write(read_fd as u32);
                req_ptr.add(1).write(write_fd as u32);
            };

            // 创建成功
            context.x[10] = 0;
        }
        // 获取文件节点
        SYS_GETDENTS => {
            // 获取参数
            let fd = context.x[10];
            let start_ptr = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap());
            let mut buf_ptr = start_ptr;
            if let Some(file_tree_node) = current_task.fd_table[fd].clone() {
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
                            if buf_ptr - start_ptr >= 512 {
                                break;
                            }
                        }
                        context.x[10] = buf_ptr - start_ptr;
                    },
                    _ => {
                        context.x[10] = SYS_CALL_ERR;
                    }
                }
            } else {
                context.x[10] = SYS_CALL_ERR;
            }
        }
        // 读取文件描述符
        SYS_READ => {
            // 获取参数
            let fd = context.x[10];
            let mut buf = pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap();
            let count = context.x[12];
            let buf = unsafe { slice::from_raw_parts_mut(buf.as_mut_ptr(), count) };

            // 判断文件描述符是否存在
            if let Some(file_tree_node) = current_task.fd_table[fd].clone() {
                // 匹配文件目标类型
                match &mut file_tree_node.lock().target {
                    FileDescEnum::File(file_tree_node) => {
                        let size = file_tree_node.read_to(buf);
                        context.x[10] = size as usize;
                    },
                    FileDescEnum::Pipe(pipe) => {
                        context.x[10] = pipe.read(buf);
                    },
                    _ => {
                        context.x[10] = SYS_CALL_ERR;
                    }
                }
            } else {
                context.x[10] = SYS_CALL_ERR;
            }
            
        }
        // 写入文件数据
        SYS_WRITE => {
            // 获取参数
            let fd = context.x[10];
            let buf = pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap();
            let count = context.x[12];
            // 寻找物理地址
            let buf = unsafe {slice::from_raw_parts_mut(usize::from(buf) as *mut u8, count)};

            // 判断文件描述符是否存在
            if let Some(file_tree_node) = current_task.fd_table[fd].clone() {
                // 判断文件描述符类型
                match &mut file_tree_node.lock().target {
                    FileDescEnum::File(file_tree) => {
                        sys_write(file_tree.clone(),context.x[11],context.x[12]);
                        context.x[10] = context.x[12];
                    },
                    FileDescEnum::Device(device_name) => {
                        match device_name as &str {
                            "STDIN" => {},
                            "STDOUT" => {
                                puts(buf);
                                context.x[10] = buf.len();
                            },
                            "STDERR" => {},
                            _ => {info!("未找到设备!");}
                        }
                    },
                    FileDescEnum::Pipe(pipe) => {
                        context.x[10] = pipe.write(buf, count);
                    },
                    // _ => {
                    //     let result_code: isize = -1;
                    //     context.x[10] = result_code as usize;
                    // }
                }
            } else {
                context.x[10] = SYS_CALL_ERR;
            }
        }
        // 获取文件数据信息
        SYS_FSTAT => {
            // 获取参数
            let fd = context.x[10];
            let kstat_ptr = unsafe {
                (usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap()) as *mut Kstat).as_mut().unwrap()
            };
            // 判断文件描述符是否存在
            if let Some(tree_node) = current_task.fd_table[fd].clone() {
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
                        context.x[10] = 0;
                    }, 
                    _ => {
                        context.x[10] = SYS_CALL_ERR;
                    }
                }
            } else {
                context.x[10] = SYS_CALL_ERR;
            }
        }
        // 退出文件信息
        SYS_EXIT => {
            kill_current_task();
        }
        // 文件休眠
        SYS_NANOSLEEP => {
            // 获取文件参数
            let req_ptr = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap()) as *mut TimeSpec;
            let req = unsafe { req_ptr.as_mut().unwrap() };
            let rem_ptr = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap()) as *mut TimeSpec;
            let rem = unsafe { rem_ptr.as_mut().unwrap() };
            // 如果 nsec < 0则此任务已被处理 nsec = - remain_ticks
            if rem.tv_nsec < 0 {
                let remain_ticks = (-rem.tv_nsec) as usize;
                if remain_ticks <= unsafe {TICKS} {
                    context.x[10] = 0;
                } else {
                    // 减少spec进行重复请求 然后切换任务
                    context.sepc = context.sepc - 4;
                    suspend_and_run_next();
                }
            } else {
                // 1秒100个TICKS  1ns = 1/1000ms = 1/10000TICKS
                let wake_ticks = req.tv_sec * 100 + req.tv_nsec as u64 / 10000;
                let remain_ticks = wake_ticks + unsafe {TICKS as u64};

                rem.tv_nsec = - (remain_ticks as i64);
                // 减少spec进行重复请求 然后切换任务
                context.sepc = context.sepc - 4;
                suspend_and_run_next();
            }
        }
        // 转移文件权限
        SYS_SCHED_YIELD => {
            suspend_and_run_next();
        }
        // 获取文件时间
        SYS_TIMES => {
            // 等待添加
            let tms = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap()) as *mut TMS;
            let tms = unsafe { tms.as_mut().unwrap() };

            // 写入文件时间
            tms.tms_cstime = current_task.tms.tms_cstime;
            tms.tms_cutime = current_task.tms.tms_cutime;
            context.x[10] = unsafe {TICKS};
        }
        // 获取系统信息
        SYS_UNAME => {
            // 获取参数
            let sys_info = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap()) as *mut UTSname;
            let sys_info = unsafe { sys_info.as_mut().unwrap() };
            // 写入系统信息
            write_string_to_raw(&mut sys_info.sysname, "ByteOS");
            write_string_to_raw(&mut sys_info.nodename, "ByteOS");
            write_string_to_raw(&mut sys_info.release, "release");
            write_string_to_raw(&mut sys_info.version, "alpha 1.1");
            write_string_to_raw(&mut sys_info.machine, "riscv k210");
            write_string_to_raw(&mut sys_info.domainname, "alexbd.cn");
            context.x[10] = 0;
        }
        // 获取时间信息
        SYS_GETTIMEOFDAY => {
            let timespec = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap()) as *mut TimeSpec;
            unsafe { timespec.as_mut().unwrap().get_now() };
            context.x[10] = 0;
        }
        // 获取进程信息
        SYS_GETPID => {
            // 当前任务
            let current_task_wrap = get_current_task().unwrap();
            let current_task = current_task_wrap.force_get();
            context.x[10] = current_task.pid;
        }
        // 获取进程父进程
        SYS_GETPPID => {
            let current_task_wrap = get_current_task().unwrap();
            let current_task = current_task_wrap.force_get();
            context.x[10] = current_task.ppid;
        }
        // 申请堆空间
        SYS_BRK => {
            let top_pos = context.x[10];
            // 如果是0 返回堆顶 否则设置为新的堆顶
            if top_pos == 0 {
                context.x[10] = get_current_task().unwrap().lock().get_heap_size();
            } else {
                let top = get_current_task().unwrap().lock().set_heap_top(top_pos);
                context.x[10] = top;
            }
        }
        // 复制进程信息
        SYS_CLONE => {
            let _flag = context.x[10];
            let stack_addr = context.x[11];
            let _ptid = context.x[12];
            let _tls = context.x[13];
            let _ctid = context.x[14];

            let mut task = clone_task(&mut current_task_wrap.force_get());
            
            // 如果指定了栈 则设置栈
            if stack_addr > 0 {
                task.context.x[2] = stack_addr;
            }

            task.context.x[10] = 0;
            context.x[10] = task.pid;
            // 加入调度信息
            TASK_CONTROLLER_MANAGER.force_get().add(task);
            suspend_and_run_next();
        }
        // 执行文件
        SYS_EXECVE => {
            let filename = pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap();
            let filename = get_string_from_raw(filename);
            exec(&filename);
            kill_current_task();
        }
        // 进行文件映射
        SYS_MMAP => {
            let start = context.x[10];
            let _len = context.x[11];
            let _prot = context.x[12];
            let _flags = context.x[13];
            let fd = context.x[14];
            let _offset = context.x[15];

            if let Some(file_tree_node) = current_task.fd_table[fd].clone() {
                match &mut file_tree_node.lock().target {
                    FileDescEnum::File(file_tree_node) => {
                        // 如果start为0 则分配空间 暂分配0xd0000000
                        if start == 0 {
                            // 添加映射
                            pmm.add_mapping(PhysAddr::from(file_tree_node.get_cluster()), VirtAddr::from(0xd0000000), 
                                PTEFlags::VRWX | PTEFlags::U);
                            context.x[10] = 0xd0000000;
                        } else {
                            context.x[10] = 0;
                        }
                    },
                    _ => {
                        context.x[10] = SYS_CALL_ERR;
                    }
                }
            } else {
                context.x[10] = SYS_CALL_ERR;
            }
        }
        // 取消文件映射
        SYS_MUNMAP => {
            let start = context.x[10];
            let _len = context.x[11];
            pmm.remove_mapping(VirtAddr::from(start));
            context.x[10] = 0;
        }
        // 等待进程
        SYS_WAIT4 => {
            let pid = context.x[10];
            let ptr = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap()) as *mut u16;
            let options = context.x[12];
            // wait_task中进行上下文大小
            wait_task(pid, ptr, options);
        }
        _ => {
            warn!("未识别调用号 {}", context.x[17]);
        }
    }
}
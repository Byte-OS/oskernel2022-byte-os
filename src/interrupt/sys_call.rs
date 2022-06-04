use core::slice;

use alloc::{string::String, sync::Arc, vec::Vec};
use riscv::register::satp;

use crate::{console::puts, task::{kill_current_task, get_current_task, exec, clone_task, TASK_CONTROLLER_MANAGER, suspend_and_run_next, wait_task, FileDescEnum, FileDesc}, memory::{page_table::PageMapping, addr::{VirtAddr, PhysPageNum, PhysAddr}}, fs::{filetree::{FILETREE, FileTreeNode}, file::Kstat},  interrupt::TICKS, sync::mutex::Mutex};

use super::{Context,  timer::{TimeSpec, TMS}};

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
pub const SYS_WAIT4: usize  = 260;

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

pub struct UTSname  {
    sysname: [u8;65],
    nodename: [u8;65],
    release: [u8;65],
    version: [u8;65],
    machine: [u8;65],
    domainname: [u8;65],
}

#[repr(C)]
struct Dirent {
    d_ino: u64,	// 索引结点号
    d_off: u64,	// 到下一个dirent的偏移
    d_reclen: u16,	// 当前dirent的长度
    d_type: u8,	// 文件类型
    d_name_start: u8	//文件名
}

pub fn sys_write(fd: FileTreeNode, buf: usize, count: usize) -> usize {
    // 根据satp中的地址构建PageMapping 获取当前的映射方式
    let pmm = PageMapping::from(PhysPageNum(satp::read().bits()).to_addr());
    let buf = pmm.get_phys_addr(VirtAddr::from(buf)).unwrap();

    // 寻找物理地址
    let buf = unsafe {slice::from_raw_parts_mut(usize::from(buf) as *mut u8, count)};
    
    if fd.is_device() {
        let device_name = fd.get_filename();
        if device_name == "STDIN" {

        } else if device_name == "STDOUT" {
            puts(buf);
        } else if device_name == "STDERR" {

        } else {
            info!("未找到设备!");
        }
    } else {
        info!("暂未找到中断地址");
    }
    count
}

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

pub fn write_string_to_raw(target: &mut [u8], str: &str) {
    let mut index = 0;
    for c in str.chars() {
        target[index] = c as u8;
        index = index + 1;
    }
    target[index] = 0;
}

pub fn sys_call() {
    let current_task_wrap = get_current_task().unwrap();
    let mut current_task = current_task_wrap.force_get();
    let context: &mut Context = &mut current_task.context;
    // 重新设置current_task 前一个current_task所有权转移
    let mut current_task = current_task_wrap.force_get();
    let pmm = PageMapping::from(PhysPageNum(satp::read().bits()).to_addr());
    context.sepc = context.sepc + 4;
    // a7(x17) 作为调用号
    match context.x[17] {
        SYS_GETCWD => {
            let current_task_wrap = get_current_task().unwrap();
            let current_task = current_task_wrap.force_get();
            // 内存映射管理器
            let pmm = PageMapping::from(PhysPageNum(satp::read().bits()).to_addr());
            // 获取参数
            let mut buf = pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap();
            let size = context.x[11];
            let buf = unsafe { slice::from_raw_parts_mut(buf.as_mut_ptr(), size) };
            let pwd = current_task.home_dir.get_pwd();

            let pwd_buf = pwd.as_bytes();
            buf[..pwd_buf.len()].copy_from_slice(pwd_buf);
            context.x[10] = buf.as_ptr() as usize;
        }
        SYS_DUP => {
            let fd = context.x[10];
            let mut current_task = current_task_wrap.force_get();
            let new_fd = current_task.alloc_fd();
            if let Some(tree_node) = current_task.fd_table[fd].clone() {
                current_task.fd_table[new_fd] = Some(tree_node);
                context.x[10] = new_fd;
            } else {
                context.x[10] = -1 as isize as usize;
            }
        }
        SYS_DUP3 => {
            let fd = context.x[10];
            let new_fd = context.x[11];
            let mut current_task = current_task_wrap.force_get();
            if let Some(tree_node) = current_task.fd_table[fd].clone() {
                // 申请空间
                if current_task.alloc_fd_with_size(new_fd) == -1 as isize as usize {
                    context.x[10] = -1 as isize as usize;
                } else {
                    current_task.fd_table[new_fd] = Some(tree_node);
                    context.x[10] = new_fd;
                }
            } else {
                context.x[10] = -1 as isize as usize;
            }
        }
        SYS_MKDIRAT => {
            let dirfd = context.x[10];
            let filename = pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap();
            let filename = get_string_from_raw(filename);
            let flags = context.x[12];

            // 判断文件描述符是否存在
            if dirfd == 0xffffffffffffff9c {
                current_task.home_dir.mkdir(&filename, flags as u16);
                context.x[10] = 0;
            } else {
                if let Some(tree_node) = current_task.fd_table[dirfd].clone() {
                    match &mut tree_node.lock().target {
                        FileDescEnum::File(tree_node) => {
                            tree_node.mkdir(&filename, flags as u16);
                            context.x[10] = 0;
                        }, 
                        _ => {
                            let result_code: isize = -1;
                            context.x[10] = result_code as usize;
                        }
                    }
                } else {
                    let result_code: isize = -1;
                    context.x[10] = result_code as usize;
                }
            };
        },
        SYS_UNLINKAT => {
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
                    match &mut tree_node.lock().target {
                        FileDescEnum::File(tree_node) => {
                            if let Ok(node) = tree_node.open(&filename) {
                                let node_name = node.get_filename();
            
                                let parent = node.get_parent().clone().unwrap();
                                parent.delete(&node_name);
                                context.x[10] = 0;
                            } else {
                                context.x[10] = -1 as isize as usize;
                            }
                        }, 
                        _ => {
                            let result_code: isize = -1;
                            context.x[10] = result_code as usize;
                        }
                    }
                } else {
                    context.x[10] = -1 as isize as usize;
                }
            };

            
        },
        SYS_UMOUNT2 => {
            let _special_ptr = pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap();
            let _flag = context.x[11];
            context.x[10] = 0;
        },
        SYS_MOUNT => {
            let special_ptr = pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap();
            let dir_ptr = pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap();
            let fstype_ptr = pmm.get_phys_addr(VirtAddr::from(context.x[12])).unwrap();
            let _flag = context.x[13];
            let _data_ptr = context.x[14];
            let _special = get_string_from_raw(special_ptr);
            let _dir = get_string_from_raw(dir_ptr);
            let _fstype = get_string_from_raw(fstype_ptr);
            // info!("special: {}, dir: {}, fstype: {}", special, dir, fstype);
            // let special = get_string_from_raw(fstype_ptr);
            context.x[10] = 0;
        },
        SYS_CHDIR => {
            let current_task_wrap = get_current_task().unwrap();
            let mut current_task = current_task_wrap.force_get();
            let pmm = PageMapping::from(PhysPageNum(satp::read().bits()).to_addr());
            let filename = pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap();
            let filename = get_string_from_raw(filename);
            if let Ok(file) = FILETREE.lock().open(&filename) {
                // let file = file.to_file();
                // let 
                current_task.home_dir = file.clone();
                context.x[10] = 0;
            } else {
                let result_code: isize = -1;
                context.x[10] = result_code as usize;
            }
            
        }
        SYS_OPENAT => {
            let current_task_wrap = get_current_task().unwrap();
            let mut current_task = current_task_wrap.force_get();
            let pmm = PageMapping::from(PhysPageNum(satp::read().bits()).to_addr());
            let fd = context.x[10];
            let filename = pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap();
            let filename = get_string_from_raw(filename);
            let flags = context.x[12];
            let _open_mod = context.x[13];

            let flags = OpenFlags::from_bits(flags as u32).unwrap();

            // 判断文件描述符是否存在
            if fd == 0xffffffffffffff9c {
                if flags.contains(OpenFlags::CREATE) {
                    current_task.home_dir.create(&filename);
                }
                if let Ok(file) = current_task.home_dir.open(&filename) {
                    let fd = current_task.alloc_fd();
                    current_task.fd_table[fd] = Some(Arc::new(Mutex::new(FileDesc::new(FileDescEnum::File(file.clone())))));
                    context.x[10] = fd;
                } else {
                    let result_code: isize = -1;
                    context.x[10] = result_code as usize;
                }
            } else {
                if let Some(tree_node) = current_task.fd_table[fd].clone() {
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
                                let result_code: isize = -1;
                                context.x[10] = result_code as usize;
                            }
                        }, 
                        _ => {
                            let result_code: isize = -1;
                            context.x[10] = result_code as usize;
                        }
                    }
                } else {
                    let result_code: isize = -1;
                    context.x[10] = result_code as usize;
                }
            };
        }
        SYS_CLOSE => {
            let current_task_wrap = get_current_task().unwrap();
            let mut current_task = current_task_wrap.force_get();
            let fd = context.x[10];
            if let Some(_) = current_task.fd_table[fd].clone() {
                current_task.fd_table[fd] = None;
                context.x[10] = 0;
            } else {
                let result_code: isize = -1;
                context.x[10] = result_code as usize;
            }
        }
        SYS_PIPE2 => {
            let req_ptr = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap()) as *mut u32;
            let (read_pipe, write_pipe) = FileDesc::new_pipe();
            let read_fd = current_task.alloc_fd();
            current_task.fd_table[read_fd] = Some(Arc::new(Mutex::new(read_pipe)));
            let write_fd = current_task.alloc_fd();
            current_task.fd_table[write_fd] = Some(Arc::new(Mutex::new(write_pipe)));

            unsafe {
                req_ptr.write(read_fd as u32);
                req_ptr.add(1).write(write_fd as u32);
            };

            // 创建成功
            context.x[10] = 0;
        },
        SYS_GETDENTS => {
            // 获取参数
            let fd = context.x[10];
            let mut buf_ptr = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap());
            if let Some(file_tree_node) = current_task.fd_table[fd].clone() {
                match &mut file_tree_node.lock().target {
                    FileDescEnum::File(file_tree_node) => {
                        let sub_nodes = file_tree_node.get_children();
                        for i in 0..sub_nodes.len() {
                            let sub_node_name = sub_nodes[i].get_filename();
                            let dirent = unsafe { (buf_ptr as *mut Dirent).as_mut().unwrap() };
                            // 计算大小保证内存对齐
                            let node_size = ((18 + sub_node_name.len() as u16 + 1 + 15) / 16) * 16;
                            dirent.d_ino = i as u64;
                            dirent.d_off = i as u64;
                            dirent.d_reclen = node_size;
                            dirent.d_type = 0;
                            let buf_str = unsafe {
                                slice::from_raw_parts_mut(&mut dirent.d_name_start as *mut u8, (node_size - 18) as usize)
                            };
                            write_string_to_raw(buf_str, &sub_node_name);
                            buf_ptr = buf_ptr + dirent.d_reclen as usize;
                        }
                        context.x[10] = 0;
                    },
                    _ => {
                        let result_code: isize = -1;
                        context.x[10] = result_code as usize;
                    }
                }
            } else {
                let result_code: isize = -1;
                context.x[10] = result_code as usize;
            }
        },
        SYS_READ => {
            // 获取参数
            let fd = context.x[10];
            let mut buf = pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap();
            let count = context.x[12];
            let buf = unsafe { slice::from_raw_parts_mut(buf.as_mut_ptr(), count) };

            if let Some(file_tree_node) = current_task.fd_table[fd].clone() {
                match &mut file_tree_node.lock().target {
                    FileDescEnum::File(file_tree_node) => {
                        let size = file_tree_node.to_file().read_to(buf);
                        context.x[10] = size as usize;
                    },
                    FileDescEnum::Pipe(pipe) => {
                        context.x[10] = pipe.read(buf);
                    },
                    _ => {
                        let result_code: isize = -1;
                        context.x[10] = result_code as usize;
                    }
                }
            } else {
                let result_code: isize = -1;
                context.x[10] = result_code as usize;
            }
            
        }
        SYS_WRITE => {
            let fd = context.x[10];
            let buf = pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap();
            let count = context.x[12];
            // 寻找物理地址
            let buf = unsafe {slice::from_raw_parts_mut(usize::from(buf) as *mut u8, count)};

            if let Some(file_tree_node) = current_task.fd_table[fd].clone() {
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
                            _ => info!("未找到设备!")
                        }
                    },
                    FileDescEnum::Pipe(pipe) => {
                        context.x[10] = pipe.write(buf, count);
                    },
                    _ => {
                        let result_code: isize = -1;
                        context.x[10] = result_code as usize;
                    }
                }
            } else {
                context.x[10] = -1 as isize as usize;
            }
        },
        SYS_FSTAT => {
            let fd = context.x[10];
            let kstat_ptr = unsafe {
                (usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap()) as *mut Kstat).as_mut().unwrap()
            };
            if let Some(tree_node) = current_task.fd_table[fd].clone() {
                match &mut tree_node.lock().target {
                    FileDescEnum::File(tree_node) => {
                        let tree_node = tree_node.0.borrow_mut();
                        kstat_ptr.st_dev = 1;
                        kstat_ptr.st_ino = tree_node.cluster as u64;
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
                        let result_code: isize = -1;
                        context.x[10] = result_code as usize;
                    }
                }
            } else {
                let result_code: isize = -1;
                context.x[10] = result_code as usize;
            }
        },
        SYS_EXIT => {
            kill_current_task();
        },
        SYS_NANOSLEEP => {
            let req_ptr = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap()) as *mut TimeSpec;
            let req = unsafe { req_ptr.as_mut().unwrap() };
            let rem_ptr = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap()) as *mut TimeSpec;
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
        },
        SYS_SCHED_YIELD => {
            suspend_and_run_next();
        },
        SYS_TIMES => {
            // 等待添加
            let tms = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap()) as *mut TMS;
            let _tms = unsafe { tms.as_mut().unwrap() };
        },
        SYS_UNAME => {
            let sys_info = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap()) as *mut UTSname;
            let sys_info = unsafe { sys_info.as_mut().unwrap() };
            write_string_to_raw(&mut sys_info.sysname, "ByteOS");
            write_string_to_raw(&mut sys_info.nodename, "ByteOS");
            write_string_to_raw(&mut sys_info.release, "release");
            write_string_to_raw(&mut sys_info.version, "alpha 1.1");
            write_string_to_raw(&mut sys_info.machine, "riscv k210");
            write_string_to_raw(&mut sys_info.domainname, "alexbd.cn");
            context.x[10] = 0;
        },
        SYS_GETTIMEOFDAY => {
            let timespec = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap()) as *mut TimeSpec;
            unsafe { timespec.as_mut().unwrap().get_now() };
            context.x[10] = 0;
        },
        SYS_GETPID => {
            // 当前任务
            let current_task_wrap = get_current_task().unwrap();
            let current_task = current_task_wrap.force_get();
            context.x[10] = current_task.pid;
        },
        SYS_GETPPID => {
            let current_task_wrap = get_current_task().unwrap();
            let current_task = current_task_wrap.force_get();
            context.x[10] = current_task.ppid;
        },
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
            TASK_CONTROLLER_MANAGER.force_get().add(task);
            suspend_and_run_next();
        }
        SYS_EXECVE => {
            let filename = pmm.get_phys_addr(VirtAddr::from(context.x[10])).unwrap();
            let filename = get_string_from_raw(filename);
            exec(&filename);
            kill_current_task();
        }
        SYS_WAIT4 => {
            let pid = context.x[10];
            let ptr = usize::from(pmm.get_phys_addr(VirtAddr::from(context.x[11])).unwrap()) as *mut u16;
            let options = context.x[12];
            wait_task(pid, ptr, options);
        }
        _ => {
            info!("未识别调用号 {}", context.x[17]);
        }
    }
}
use core::slice;

use alloc::{string::String, vec::Vec, rc::Rc};
use riscv::register::{sepc, scause::{self, Trap, Exception, Interrupt}, stval, sstatus};

use crate::{memory::{page_table::PageMappingManager, addr::{VirtAddr, PhysAddr}}, interrupt::timer, fs::filetree::INode, task::task_scheduler::kill_task, sys_call::consts::EBADF};

use crate::fs::file::FileType;
use crate::interrupt::timer::set_last_ticks;
use crate::runtime_err::RuntimeError;
use crate::task::task::Task;

pub mod fd;
pub mod task;
pub mod time;
pub mod mm;
pub mod consts;

// 中断调用列表
pub const SYS_GETCWD:usize  = 17;
pub const SYS_DUP: usize    = 23;
pub const SYS_DUP3: usize   = 24;
pub const SYS_MKDIRAT:usize = 34;
pub const SYS_UNLINKAT:usize= 35;
pub const SYS_UMOUNT2: usize= 39;
pub const SYS_MOUNT: usize  = 40;
pub const SYS_STATFS: usize = 43;
pub const SYS_CHDIR: usize  = 49;
pub const SYS_OPENAT:usize  = 56;
pub const SYS_CLOSE: usize  = 57;
pub const SYS_PIPE2: usize  = 59;
pub const SYS_GETDENTS:usize= 61;
pub const SYS_LSEEK: usize  = 62;
pub const SYS_READ:  usize  = 63;
pub const SYS_WRITE: usize  = 64;
pub const SYS_READV:  usize  = 65;
pub const SYS_WRITEV: usize = 66;
pub const SYS_FSTATAT: usize= 79;
pub const SYS_FSTAT: usize  = 80;
pub const SYS_UTIMEAT:usize = 88;
pub const SYS_EXIT:  usize  = 93;
pub const SYS_EXIT_GROUP: usize = 94;
pub const SYS_SET_TID_ADDRESS: usize = 96;
pub const SYS_FUTEX: usize  = 98;
pub const SYS_NANOSLEEP: usize = 101;
pub const SYS_GETTIME: usize = 113;
pub const SYS_SCHED_YIELD: usize = 124;
pub const SYS_KILL: usize = 129;
pub const SYS_TIMES: usize  = 153;
pub const SYS_UNAME: usize  = 160;
pub const SYS_GETTIMEOFDAY: usize= 169;
pub const SYS_GETPID:usize  = 172;
pub const SYS_GETPPID:usize = 173;
pub const SYS_GETTID: usize = 178;
pub const SYS_BRK:   usize  = 214;
pub const SYS_CLONE: usize  = 220;
pub const SYS_EXECVE:usize  = 221;
pub const SYS_MMAP: usize   = 222;
pub const SYS_MPROTECT:usize= 226;
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
pub fn sys_write_wrap(pmm: Rc<PageMappingManager>, fd: Rc<INode>, buf: usize, count: usize) -> usize {
    // 根据satp中的地址构建PageMapping 获取当前的映射方式
    let buf = pmm.get_phys_addr(VirtAddr::from(buf)).unwrap();

    // 寻找物理地址
    let buf = unsafe {slice::from_raw_parts_mut(usize::from(buf) as *mut u8, count)};
    
    // 匹配文件类型
    match fd.get_file_type() {
        FileType::VirtFile => {
            fd.write(buf);
        }
        _ => {warn!("SYS_WRITE暂未找到设备");}
    }
    count
}

// 从内存中获取字符串 目前仅支持ascii码
pub fn get_string_from_raw(addr: PhysAddr) -> String {

    let mut ptr = addr.as_ptr();
    let mut str: String = String::new();
    loop {
        let ch = unsafe { ptr.read() };
        if ch == 0 {
            break;
        }
        str.push(ch as char);
        unsafe { ptr = ptr.add(1) };
    }
    str
}

// 从内存中获取数字直到0
pub fn get_usize_vec_from_raw(addr: PhysAddr) -> Vec<usize> {
    let mut usize_vec = vec![];
    let mut usize_vec_ptr = addr.0 as *const usize;
    loop {
        let value = unsafe { usize_vec_ptr.read() };
        if value == 0 {break;}
        usize_vec.push(value);
        usize_vec_ptr = unsafe { usize_vec_ptr.add(1) };
    }
    usize_vec
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

impl Task {
    // 系统调用
    pub fn sys_call(&self, call_type: usize, args: [usize; 7]) -> Result<(), RuntimeError> {
        // 匹配系统调用 a7(x17) 作为调用号
        match call_type {
            // 获取文件路径
            SYS_GETCWD => self.get_cwd(args[0], args[1]),
            // 复制文件描述符
            SYS_DUP => self.sys_dup(args[0]),
            // 复制文件描述符
            SYS_DUP3 => self.sys_dup3(args[0], args[1]),
            // 创建文件夹
            SYS_MKDIRAT => self.sys_mkdirat(args[0], args[1], args[2]),
            // 取消link
            SYS_UNLINKAT => self.sys_unlinkat(args[0], args[1], args[2]),
            // umount设备
            SYS_UMOUNT2 => Ok(()),
            // mount设备
            SYS_MOUNT => Ok(()),
            // 获取文件系统信息
            SYS_STATFS => self.sys_statfs(args[0], args[1].into()),
            // 改变文件信息
            SYS_CHDIR => self.sys_chdir(args[0]),
            // 打开文件地址
            SYS_OPENAT => self.sys_openat(args[0], args[1], args[2], args[3]),
            // 关闭文件描述符
            SYS_CLOSE => self.sys_close(args[0]),
            // 进行PIPE
            SYS_PIPE2 => self.sys_pipe2(args[0]),
            // 获取文件节点
            SYS_GETDENTS => self.sys_getdents(args[0], args[1], args[2]),
            // 移动读取位置
            SYS_LSEEK => self.sys_lseek(args[0], args[1], args[2]),
            // 读取文件描述符
            SYS_READ => self.sys_read(args[0], args[1], args[2]),
            // 写入文件数据
            SYS_WRITE => self.sys_write(args[0], args[1], args[2]),
            // 读取数据
            SYS_READV => self.sys_readv(args[0], args[1].into(), args[2]),
            // 写入数据
            SYS_WRITEV => self.sys_writev(args[0], args[1].into(), args[2]),
            // 获取文件数据信息
            SYS_FSTATAT => self.sys_fstatat(args[0], args[1].into(), args[2], args[3]),
            // 获取文件数据信息
            SYS_FSTAT => self.sys_fstat(args[0], args[1]),
            // 改变文件时间
            SYS_UTIMEAT => self.sys_utimeat(args[0], args[1].into(), args[2].into(), args[3]),
            // 退出文件信息
            SYS_EXIT => self.sys_exit(args[0]),
            // 退出组
            SYS_EXIT_GROUP => self.sys_exit_group(args[0]),
            // 设置tid
            SYS_SET_TID_ADDRESS => self.sys_set_tid_address(args[0]),
            // 互斥锁
            SYS_FUTEX => self.sys_futex(args[0].into(), args[1] as u32, args[2] as u32, args[3], args[4]),
            // 文件休眠
            SYS_NANOSLEEP => self.sys_nanosleep(args[0], args[1]),
            // 获取系统时间
            SYS_GETTIME => self.sys_gettime(args[0], args[1].into()),
            // 转移文件权限
            SYS_SCHED_YIELD => self.sys_sched_yield(),
            // 结束进程
            SYS_KILL => self.sys_kill(args[0], args[1]),
            // 获取文件时间
            SYS_TIMES => self.sys_times(args[0]),
            // 获取系统信息
            SYS_UNAME => self.sys_uname(args[0]),
            // 获取时间信息
            SYS_GETTIMEOFDAY => self.sys_gettimeofday(args[0]),
            // 获取进程信息
            SYS_GETPID => self.sys_getpid(),
            // 获取进程父进程
            SYS_GETPPID => self.sys_getppid(),
            // 获取tid
            SYS_GETTID => self.sys_gettid(),
            // 申请堆空间
            SYS_BRK => self.sys_brk(args[0]),
            // 复制进程信息
            SYS_CLONE => self.sys_clone(args[0], args[1], args[2].into(), args[3], args[4].into()),
            // 执行文件
            SYS_EXECVE => self.sys_execve(args[0].into(), args[1].into(), args[2].into()),
            // 进行文件映射
            SYS_MMAP => self.sys_mmap(args[0], args[1], args[2], args[3], args[4], args[5]),
            // 页面保护
            SYS_MPROTECT => self.sys_mprotect(args[0], args[1], args[2]),
            // 取消文件映射
            SYS_MUNMAP => self.sys_munmap(args[0], args[1]),
            // 等待进程
            SYS_WAIT4 => self.sys_wait4(args[0], args[1].into(), args[2]),
            _ => {
                warn!("未识别调用号 {}", call_type);
                Ok(())
            }
        }
    }

    pub fn catch(&self) {
        let result = self.interrupt();
        debug!("catch");
        if let Err(err) = result {
            match err {
                RuntimeError::KillSelfTask => {
                    kill_task(self.pid, self.tid);
                }
                RuntimeError::NoEnoughPage => {
                    panic!("No Enough Page");
                }
                RuntimeError::NoMatchedFileDesc => {
                    let mut inner = self.inner.borrow_mut();
                    warn!("文件未找到");
                    inner.context.x[10] = SYS_CALL_ERR;
                }
                RuntimeError::FileNotFound => {
                    let mut inner = self.inner.borrow_mut();
                    warn!("文件未找到");
                    inner.context.x[10] = SYS_CALL_ERR;
                }
                RuntimeError::EBADF => {
                    let mut inner = self.inner.borrow_mut();
                    warn!("文件未找到  EBADF");
                    inner.context.x[10] = EBADF;
                }
                _ => {
                    warn!("异常: {:?}", err);
                }
            }
        }
    }

    pub fn interrupt(&self) -> Result<(), RuntimeError> {
        unsafe {
            sstatus::set_fs(sstatus::FS::Dirty);
        }
        let scause = scause::read();
        let stval = stval::read();
        let mut task_inner = self.inner.borrow_mut();
        let context = &mut task_inner.context;
        // warn!("中断发生: {:#x}, 地址: {:#x}", scause.bits(), context.sepc);
        // 更新TICKS
        set_last_ticks();

        // 匹配中断原因
        match scause.cause(){
            // 断点中断
            Trap::Exception(Exception::Breakpoint) => {
                warn!("break中断产生 中断地址 {:#x}", sepc::read());
                context.sepc = context.sepc + 2;
            },
            // 时钟中断
            Trap::Interrupt(Interrupt::SupervisorTimer) => timer::timer_handler(),
            // 页处理错误
            Trap::Exception(Exception::StorePageFault) | Trap::Exception(Exception::StoreFault) => {
                error!("缺页中断触发 缺页地址: {:#x} 触发地址:{:#x} 已同步映射", stval, context.sepc);
                drop(context);
                if stval > 0xf0000000 && stval < 0xf00010000 {
                    error!("处理缺页中断;");
                    let mut process = task_inner.process.borrow_mut();
                    process.stack.alloc_until(stval)?;
                } else {
                    panic!("无法 恢复的缺页中断");
                }
                // panic!("系统终止");
            },
            // 用户请求
            Trap::Exception(Exception::UserEnvCall) => {
                // 将 恢复地址 + 4 跳过调用地址
                debug!("中断号: {} 调用地址: {:#x}", context.x[17], sepc::read());

                // 对sepc + 4
                context.sepc += 4;
                // 复制参数
                let mut args = [0;7];
                args.clone_from_slice(&context.x[10..17]);
                let call_type = context.x[17];
                drop(context);
                drop(task_inner);
                

                self.sys_call(call_type, args)?;
            },
            // 加载页面错误
            Trap::Exception(Exception::LoadPageFault) => {
                panic!("加载权限异常 地址:{:#x} 调用地址: {:#x}", stval, context.sepc)
            },
            // 页面未对齐错误
            Trap::Exception(Exception::StoreMisaligned) => {
                warn!("页面未对齐");
            }
            Trap::Exception(Exception::IllegalInstruction) => {
                warn!("中断 {:#x} 地址 {:#x} stval: {:#x}", scause.bits(), sepc::read(), stval);
                // panic!("指令页错误");

            }
            Trap::Exception(Exception::InstructionPageFault) => {
                warn!("中断 {:#x} 地址 {:#x} stval: {:#x}", scause.bits(), sepc::read(), stval);
                panic!("指令页错误");
            }
            // 其他情况，终止当前线程
            _ => {
                warn!("未知 中断 {:#x} 地址 {:#x} stval: {:#x}", scause.bits(), sepc::read(), stval);
                return Err(RuntimeError::KillSelfTask);
            },
        }
    
        // 更新TICKS
        set_last_ticks();

        Ok(())
    }
}
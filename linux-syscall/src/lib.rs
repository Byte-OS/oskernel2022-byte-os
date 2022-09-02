#![no_std]
#![feature(drain_filter)]

#[macro_use]
extern crate alloc;
extern crate riscv;
#[macro_use]
extern crate bitflags;
#[macro_use]
extern crate output;
#[macro_use]
extern crate lazy_static; 

use alloc::rc::Rc;
use alloc::vec::Vec;
use fd::dir::get_cwd;
use fd::dir::sys_chdir;
use fd::dir::sys_mkdirat;
use fd::dir::sys_unlinkat;
use fd::open::sys_close;
use fd::open::sys_dup;
use fd::open::sys_dup3;
use fd::open::sys_openat;
use fd::open::sys_pipe2;
use fd::open::sys_ppoll;
use fd::open::sys_readlinkat;
use fd::rw::sys_lseek;
use fd::rw::sys_pread;
use fd::rw::sys_read;
use fd::rw::sys_readv;
use fd::rw::sys_sendfile;
use fd::rw::sys_write;
use fd::rw::sys_writev;
use fd::stat::sys_fstat;
use fd::stat::sys_fstatat;
use fd::stat::sys_getdents;
use fd::stat::sys_statfs;
use kernel::task::interface::kill_task;
use kernel::task::interface::switch_next;
use mm::sys_brk;
use mm::sys_mmap;
use mm::sys_mprotect;
use mm::sys_munmap;
use net::sys_fcntl;
use riscv::register::scause;
use riscv::register::scause::Trap;
use riscv::register::scause::Exception;
use riscv::register::scause::Interrupt;
use riscv::register::stval;
use riscv::register::sstatus;
use kernel::interrupt::timer;
use kernel::sync::mutex::Mutex;
use kernel::interrupt::timer::set_last_ticks;
use kernel::runtime_err::RuntimeError;
use kernel::task::signal::SignalUserContext;
use kernel::task::task::Task;
use signal::sys_sigaction;
use signal::sys_sigprocmask;
use signal::sys_sigreturn;
use task::exit::sys_exit;
use task::exit::sys_exit_group;
use task::exit::sys_kill;
use task::exit::sys_tgkill;
use task::exit::sys_tkill;
use task::fork::sys_clone;
use task::fork::sys_execve;
use task::fork::sys_sched_yield;
use task::fork::sys_wait4;
use task::futex::sys_futex;
use task::info::sys_getpid;
use task::info::sys_getppid;
use task::info::sys_getrusage;
use task::info::sys_gettid;
use task::info::sys_set_tid_address;
use task::info::sys_uname;
use time::sys_gettime;
use time::sys_gettimeofday;
use time::sys_nanosleep;
use time::sys_times;
use time::sys_utimeat;

use crate::consts::errors;
use crate::consts::syscalls::*;


pub mod fd;
pub mod task;
pub mod time;
pub mod mm;
pub mod consts;
pub mod signal;
pub mod net;

type SyscallTask = Rc<Task>;

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

    pub struct SignalFlag: usize {
        const SA_NOCLDSTOP = 0x1;
        const SA_NOCLDWAIT = 0x2;
        const SA_SIGINFO   = 0x4;
        const SA_RESTART   = 0x10000000;
        const SA_NODEFER   = 0x40000000;
        const SA_RESETHAND = 0x80000000;
        const SA_RESTORER  = 0x04000000;
    }

    pub struct CloneFlags: usize {
        const CSIGNAL		= 0x000000ff;
        const CLONE_VM	= 0x00000100;
        const CLONE_FS	= 0x00000200;
        const CLONE_FILES	= 0x00000400;
        const CLONE_SIGHAND	= 0x00000800;
        const CLONE_PIDFD	= 0x00001000;
        const CLONE_PTRACE	= 0x00002000;
        const CLONE_VFORK	= 0x00004000;
        const CLONE_PARENT	= 0x00008000;
        const CLONE_THREAD	= 0x00010000;
        const CLONE_NEWNS	= 0x00020000;
        const CLONE_SYSVSEM	= 0x00040000;
        const CLONE_SETTLS	= 0x00080000;
        const CLONE_PARENT_SETTID	= 0x00100000;
        const CLONE_CHILD_CLEARTID	= 0x00200000;
        const CLONE_DETACHED	= 0x00400000;
        const CLONE_UNTRACED	= 0x00800000;
        const CLONE_CHILD_SETTID	= 0x01000000;
        const CLONE_NEWCGROUP	= 0x02000000;
        const CLONE_NEWUTS	= 0x04000000;
        const CLONE_NEWIPC	= 0x08000000;
        const CLONE_NEWUSER	= 0x10000000;
        const CLONE_NEWPID	= 0x20000000;
        const CLONE_NEWNET	= 0x40000000;
        const CLONE_IO	= 0x80000000;
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
#[allow(unused)]
struct Dirent {
    d_ino: u64,	        // 索引结点号
    d_off: u64,	        // 到下一个dirent的偏移
    d_reclen: u16,	    // 当前dirent的长度
    d_type: u8,	        // 文件类型
    // d_name_start: u8	//文件名 文件名 自行处理？
}

// 系统调用
pub fn sys_call(task: SyscallTask, call_type: usize, args: [usize; 7]) -> Result<(), RuntimeError> {
    // 匹配系统调用 a7(x17) 作为调用号
    match call_type {
        // 获取文件路径
        SYS_GETCWD => get_cwd(task, args[0].into(), args[1]),
        // 复制文件描述符
        SYS_DUP => sys_dup(task, args[0]),
        // 复制文件描述符
        SYS_DUP3 => sys_dup3(task, args[0], args[1]),
        // 控制资源
        SYS_FCNTL => sys_fcntl(task, args[0], args[1], args[2]),
        // 创建文件夹
        SYS_MKDIRAT => sys_mkdirat(task, args[0], args[1].into(), args[2]),
        // 取消link
        SYS_UNLINKAT => sys_unlinkat(task, args[0], args[1].into(), args[2]),
        // umount设备
        SYS_UMOUNT2 => Ok(()),
        // mount设备
        SYS_MOUNT => Ok(()),
        // 获取文件系统信息
        SYS_STATFS => sys_statfs(task, args[0], args[1].into()),
        // 改变文件信息
        SYS_CHDIR => sys_chdir(task, args[0].into()),
        // 打开文件地址
        SYS_OPENAT => sys_openat(task, args[0], args[1].into(), args[2], args[3]),
        // 关闭文件描述符
        SYS_CLOSE => sys_close(task, args[0]),
        // 进行PIPE
        SYS_PIPE2 => sys_pipe2(task, args[0].into()),
        // 获取文件节点
        SYS_GETDENTS => sys_getdents(task, args[0], args[1].into(), args[2]),
        // 移动读取位置
        SYS_LSEEK => sys_lseek(task, args[0], args[1], args[2]),
        // 读取文件描述符
        SYS_READ => sys_read(task, args[0], args[1].into(), args[2]),
        // 写入文件数据
        SYS_WRITE => sys_write(task, args[0], args[1].into(), args[2]),
        // 读取数据
        SYS_READV => sys_readv(task, args[0], args[1].into(), args[2]),
        // 写入数据
        SYS_WRITEV => sys_writev(task, args[0], args[1].into(), args[2]),
        // 读取数据
        SYS_PREAD => sys_pread(task, args[0], args[1].into(), args[2], args[3]),
        // 发送文件
        SYS_SENDFILE => sys_sendfile(task, args[0], args[1], args[2], args[3]),
        // 等待ppoll
        SYS_PPOLL => sys_ppoll(task, args[0].into(), args[1], args[2].into()),
        // 读取文件数据
        SYS_READLINKAT => sys_readlinkat(task, args[0], args[1].into(), args[2].into(), args[3]),
        // 获取文件数据信息
        SYS_FSTATAT => sys_fstatat(task, args[0], args[1].into(), args[2].into(), args[3]),
        // 获取文件数据信息
        SYS_FSTAT => sys_fstat(task, args[0], args[1].into()),
        // 改变文件时间
        SYS_UTIMEAT => sys_utimeat(task, args[0], args[1].into(), args[2].into(), args[3]),
        // 退出文件信息
        SYS_EXIT => sys_exit(task, args[0]),
        // 退出组
        SYS_EXIT_GROUP => sys_exit_group(task, args[0]),
        // 设置tid
        SYS_SET_TID_ADDRESS => sys_set_tid_address(task, args[0].into()),
        // 互斥锁
        SYS_FUTEX => sys_futex(task, args[0].into(), args[1] as u32, args[2] as _, args[3], args[4]),
        // 文件休眠
        SYS_NANOSLEEP => sys_nanosleep(task, args[0].into(), args[1].into()),
        // 获取系统时间
        SYS_GETTIME => sys_gettime(task, args[0], args[1].into()),
        // 转移文件权限
        SYS_SCHED_YIELD => sys_sched_yield(task),
        // 结束进程
        SYS_KILL => sys_kill(task, args[0], args[1]),
        // 结束任务进程
        SYS_TKILL => sys_tkill(task, args[0], args[1]),
        // 结束进程
        SYS_TGKILL => sys_tgkill(task, args[0], args[1], args[2]),
        // 释放sigacrtion
        SYS_SIGACTION => sys_sigaction(task, args[0], args[1].into(),args[2].into(), args[3]),
        // 遮盖信号
        SYS_SIGPROCMASK => sys_sigprocmask(task, args[0] as _, args[1].into(),args[2].into(), args[3] as _),
        //
        // SYS_SIGTIMEDWAIT => {
        //     let mut inner = self.inner.borrow_mut();
        //     inner.context.x[10] = 0;
        //     Ok(())
        // }
        // 信号返回程序
        SYS_SIGRETURN => sys_sigreturn(task),
        // 获取文件时间
        SYS_TIMES => sys_times(task, args[0]),
        // 获取系统信息
        SYS_UNAME => sys_uname(task, args[0].into()),
        // 获取任务获取信息
        SYS_GETRUSAGE => sys_getrusage(task, args[0], args[1].into()),
        // 获取时间信息
        SYS_GETTIMEOFDAY => sys_gettimeofday(task, args[0]),
        // 获取进程信息
        SYS_GETPID => sys_getpid(task),
        // 获取进程父进程
        SYS_GETPPID => sys_getppid(task),
        // 获取uid
        SYS_GETUID => {
            task.update_context(|x| x.x[10] = 1);
            Ok(())
        },
        // 获取gid
        SYS_GETGID => {
            task.update_context(|x| x.x[10] = 1);
            Ok(())
        },
        // 获取tid
        SYS_GETTID => sys_gettid(task),
        // 申请堆空间
        SYS_BRK => sys_brk(task, args[0]),
        // 复制进程信息
        SYS_CLONE => sys_clone(task, args[0], args[1], args[2].into(), args[3], args[4].into()),
        // 执行文件
        SYS_EXECVE => sys_execve(task, args[0].into(), args[1].into(), args[2].into()),
        // 进行文件映射
        SYS_MMAP => sys_mmap(task, args[0], args[1], args[2], args[3], args[4], args[5]),
        // 页面保护
        SYS_MPROTECT => sys_mprotect(task, args[0], args[1], args[2]),
        // 取消文件映射
        SYS_MUNMAP => sys_munmap(task, args[0], args[1]),
        // 等待进程
        SYS_WAIT4 => sys_wait4(task, args[0], args[1].into(), args[2]),
        _ => {
            warn!("未识别调用号 {}", call_type);
            Ok(())
        }
    }
}

pub fn catch(task: SyscallTask) {
    let result = interrupt(task.clone());
    if let Err(err) = result {
        match err {
            RuntimeError::KillCurrentTask => {
                unsafe { kill_task(task.pid, task.tid); }
            }
            RuntimeError::NoEnoughPage => {
                panic!("No Enough Page");
            }
            RuntimeError::NoMatchedFileDesc => {
                let mut inner = task.inner.borrow_mut();
                warn!("未找到匹配的文件描述符");
                inner.context.x[10] = errors::EPERM;
            }
            RuntimeError::FileNotFound => {
                let mut inner = task.inner.borrow_mut();
                warn!("文件未找到");
                inner.context.x[10] = errors::ENOENT;
            }
            RuntimeError::EBADF => {
                let mut inner = task.inner.borrow_mut();
                warn!("文件未找到  EBADF");
                inner.context.x[10] = errors::EBADF;
            }
            // 统一处理任务切换
            RuntimeError::ChangeTask => unsafe { 
                switch_next() 
            },
            _ => {
                warn!("异常: {:?}", err);
            }
        }
    }
}

pub fn signal(task: SyscallTask, signal: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    let mut process = inner.process.borrow_mut();

    process.pmm.change_satp();
    
    let sig_action = process.sig_actions[signal];

    let handler = sig_action.handler;
    // 如果没有处理器
    if handler == 0 {
        return Ok(());
    }
    // 保存上下文
    let mut temp_context = inner.context.clone();
    let pmm = process.pmm.clone();
    // 获取临时页表 对数据进行处理
    let ucontext = process.heap.get_temp(pmm)?.tranfer::<SignalUserContext>();
    // 中断正在处理中
    if ucontext.context.x[0] != 0 {
        return Ok(());
    }
    let restorer = sig_action.restorer;
    let _flags = SignalFlag::from_bits_truncate(sig_action.flags);
    
    drop(process);
    inner.context.sepc = handler;
    inner.context.x[1] = restorer;
    inner.context.x[10] = signal;
    inner.context.x[11] = 0;
    inner.context.x[12] = 0xe0000000;
    ucontext.context.clone_from(&temp_context);
    ucontext.context.x[0] = ucontext.context.sepc;
    drop(inner);

    debug!("handle signal: {}  handler: {:#x}", signal, handler);
    loop {
        task.run();
        if let Err(RuntimeError::SigReturn) = interrupt(task.clone()) {
            break;
        }
    }
    // 修改回调地址
    temp_context.sepc = ucontext.context.x[0];

    // 恢复上下文 并 移除临时页
    let mut inner = task.inner.borrow_mut();
    let process = inner.process.borrow_mut();
    process.heap.release_temp();
    drop(process);
    inner.context.clone_from(&temp_context);
    Ok(())
}

pub fn interrupt(task: SyscallTask) -> Result<(), RuntimeError> {
    unsafe {
        sstatus::set_fs(sstatus::FS::Dirty);
    }
    let scause = scause::read();
    let stval = stval::read();
    let mut task_inner = task.inner.borrow_mut();
    let context = &mut task_inner.context;
    // warn!("中断发生: {:#x}, 地址: {:#x}", scause.bits(), context.sepc);
    // 更新TICKS
    set_last_ticks();

    // 匹配中断原因
    match scause.cause(){
        // 断点中断
        Trap::Exception(Exception::Breakpoint) => {
            warn!("break中断产生 中断地址 {:#x}", context.sepc);
            context.sepc = context.sepc + 2;
        },
        // 时钟中断
        Trap::Interrupt(Interrupt::SupervisorTimer) => {
            timer::timer_handler();
        },
        // 页处理错误
        Trap::Exception(Exception::StorePageFault) | Trap::Exception(Exception::StoreFault) => {
            error!("缺页中断触发 缺页地址: {:#x} 触发地址:{:#x} 已同步映射", stval, context.sepc);
            drop(context);
            if stval > 0xef00_0000 && stval < 0xf00010000 {
                error!("处理缺页中断;");
                let mut process = task_inner.process.borrow_mut();
                process.stack.alloc_until(stval)?;
            } else {
                panic!("无法 恢复的缺页中断");
            }
        },
        // 用户请求
        Trap::Exception(Exception::UserEnvCall) => {
            // debug!("中断号: {} 调用地址: {:#x}", context.x[17], context.sepc);

            // 将 恢复地址 + 4 跳过调用地址
            context.sepc += 4;
            // 复制参数
            let mut args = [0;7];
            args.copy_from_slice(&context.x[10..17]);
            let call_type = context.x[17];
            drop(context);
            drop(task_inner);
            

            sys_call(task, call_type, args)?;
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
            warn!("中断 {:#x} 地址 {:#x} stval: {:#x}", scause.bits(), context.sepc, stval);
            // panic!("指令页错误");

        }
        Trap::Exception(Exception::InstructionPageFault) => {
            warn!("中断 {:#x} 地址 {:#x} stval: {:#x}", scause.bits(), context.sepc, stval);
            panic!("指令页错误");
        }
        // 其他情况，终止当前线程
        _ => {
            warn!("未知 中断 {:#x} 地址 {:#x} stval: {:#x}", scause.bits(), context.sepc, stval);
            return Err(RuntimeError::KillCurrentTask);
        },
    }

    // 更新TICKS
    set_last_ticks();

    Ok(())
}

lazy_static! {
    pub static ref VFORK_WAIT_LIST: Mutex<Vec<usize>> = Mutex::new(Vec::new());
}

pub fn is_vfork_wait(pid: usize) -> bool {
    let vfork_wait_list = VFORK_WAIT_LIST.lock();
    vfork_wait_list.iter().find(|&&x| x == pid).is_some()
}

pub fn add_vfork_wait(pid: usize) {
    let mut vfork_wait_list = VFORK_WAIT_LIST.lock();
    vfork_wait_list.push(pid);
}

pub fn remove_vfork_wait(pid: usize) {
    let mut vfork_wait_list = VFORK_WAIT_LIST.lock();
    vfork_wait_list.drain_filter(|&mut x| x==pid);
}
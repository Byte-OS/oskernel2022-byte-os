use core::slice;

use alloc::{string::String, vec::Vec};
use riscv::register::{satp, sepc};

use crate::{memory::{page_table::PageMapping, addr::{VirtAddr, PhysPageNum, PhysAddr}}, fs::{filetree::{FileTreeNode}, file::{FileType}},  interrupt::{sys_call::{fd::{get_cwd, sys_dup, sys_dup3, sys_mkdirat, sys_unlinkat, sys_chdir, sys_openat, sys_close, sys_pipe2, sys_getdents, sys_read, sys_write, sys_fstat}, task::{sys_exit, sys_set_tid_address, sys_sched_yield, sys_uname, sys_getpid, sys_getppid, sys_clone, sys_execve, sys_wait4, sys_kill}, time::{sys_nanosleep, sys_times, sys_gettimeofday}, mm::{sys_brk, sys_mmap, sys_munmap}}}, runtime_err::RuntimeError};



pub mod fd;
pub mod task;
pub mod time;
pub mod mm;

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
pub const SYS_SET_TID_ADDRESS: usize = 96;
pub const SYS_NANOSLEEP: usize = 101;
pub const SYS_SCHED_YIELD: usize = 124;
pub const SYS_KILL: usize = 129;
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
pub fn sys_write_wrap(fd: FileTreeNode, buf: usize, count: usize) -> usize {
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

// 系统调用
pub fn sys_call(call_type: usize, args: [usize; 7]) -> Result<usize, RuntimeError> {
    info!("中断号: {} 调用地址: {:#x}", call_type, sepc::read());


    // 匹配系统调用 a7(x17) 作为调用号
    match call_type {
        // 获取文件路径
        SYS_GETCWD => get_cwd(args[0], args[1]),
        // 复制文件描述符
        SYS_DUP => sys_dup(args[0]),
        // 复制文件描述符
        SYS_DUP3 => sys_dup3(args[0], args[1]),
        // 创建文件夹
        SYS_MKDIRAT => sys_mkdirat(args[0], args[1], args[2]),
        // 取消link
        SYS_UNLINKAT => sys_unlinkat(args[0], args[1], args[2]),
        // umount设备
        SYS_UMOUNT2 => Ok(0),
        // mount设备
        SYS_MOUNT => Ok(0),
        // 改变文件信息
        SYS_CHDIR => sys_chdir(args[0]),
        // 打开文件地址
        SYS_OPENAT => sys_openat(args[0], args[1], args[2], args[3]),
        // 关闭文件描述符
        SYS_CLOSE => sys_close(args[0]),
        // 进行PIPE
        SYS_PIPE2 => sys_pipe2(args[0]),
        // 获取文件节点
        SYS_GETDENTS => sys_getdents(args[0], args[1], args[2]),
        // 读取文件描述符
        SYS_READ => sys_read(args[0], args[1], args[2]),
        // 写入文件数据
        SYS_WRITE => sys_write(args[0], args[1], args[2]),
        // 获取文件数据信息
        SYS_FSTAT => sys_fstat(args[0], args[1]),
        // 退出文件信息
        SYS_EXIT => sys_exit(),
        // 设置tid
        SYS_SET_TID_ADDRESS => sys_set_tid_address(args[0]),
        // 文件休眠
        SYS_NANOSLEEP => sys_nanosleep(args[0], args[1]),
        // 转移文件权限
        SYS_SCHED_YIELD => sys_sched_yield(),
        SYS_KILL => sys_kill(args[0], args[1]),
        // 获取文件时间
        SYS_TIMES => sys_times(args[0]),
        // 获取系统信息
        SYS_UNAME => sys_uname(args[0]),
        // 获取时间信息
        SYS_GETTIMEOFDAY => sys_gettimeofday(args[0]),
        // 获取进程信息
        SYS_GETPID => sys_getpid(),
        // 获取进程父进程
        SYS_GETPPID => sys_getppid(),
        // 申请堆空间
        SYS_BRK => sys_brk(args[0]),
        // 复制进程信息
        SYS_CLONE => sys_clone(args[0], args[1], args[2], args[3], args[4]),
        // 执行文件
        SYS_EXECVE => sys_execve(args[0], args[1]),
        // 进行文件映射
        SYS_MMAP => sys_mmap(args[0], args[1], args[2], args[3], args[4], args[5]),
        // 取消文件映射
        SYS_MUNMAP => sys_munmap(args[0], args[1]),
        // 等待进程
        SYS_WAIT4 => sys_wait4(args[0], args[1], args[2]),
        _ => {
            warn!("未识别调用号 {}", call_type);
            Ok(SYS_CALL_ERR)
        }
    }
}
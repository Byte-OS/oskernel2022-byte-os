// remove std lib
#![no_std]
#![no_main]
#![feature(panic_info_message)]
#![feature(default_alloc_error_handler)]
#![feature(naked_functions)]
#![feature(asm_const)]
#![allow(unaligned_references)]


#[macro_use]
extern crate output;
extern crate alloc;
mod virtio_impl;

use core::arch::asm;

use alloc::rc::Rc;
use kernel::{memory, interrupt, device, fs};
use kernel::fs::cache::cache_file;
use kernel::fs::filetree::INode;
use riscv::register::sstatus;
use task_scheduler::start_tasks;
use arch::sbi;

/// 汇编入口函数
/// 
/// 分配栈 并调到rust入口函数
#[naked]
#[no_mangle]
#[link_section = ".text.entry"]
unsafe extern "C" fn _start() -> ! {
    const STACK_SIZE: usize = 4096;

    #[link_section = ".bss.stack"]
    static mut STACK: [u8; STACK_SIZE] = [0u8; STACK_SIZE];

    core::arch::asm!(
        "   la  sp, {stack} + {stack_size}
            j   rust_main
        ",
        stack_size = const STACK_SIZE,
        stack      =   sym STACK,
        options(noreturn),
    )
}

/// rust 入口函数
/// 
/// 进行操作系统的初始化，
#[no_mangle]
pub extern "C" fn rust_main(hart_id: usize, device_tree_p_addr: usize) -> ! {
    // 保证仅有一个核心工作
    if hart_id != 0 {
        sbi::hart_suspend(0x00000000, support_hart_resume as usize, 0);
    }

    unsafe {
        sstatus::set_fs(sstatus::FS::Dirty);

        // 开启SUM位 让内核可以访问用户空间  踩坑：  
        // only in qemu. eg: qemu is riscv 1.10    k210 is riscv 1.9.1  
        // in 1.10 is SUM but in 1.9.1 is PUM which is the opposite meaning with SUM
        #[cfg(not(feature = "board_k210"))]
        sstatus::set_sum();
    }

    // 输出设备信息
    info!("当前核心 {}", hart_id);
    info!("设备树地址 {:#x}", device_tree_p_addr);

    // 提示信息
    info!("Welcome to Byte os!");

    // 初始化内存
    memory::init();

    // 初始化中断
    interrupt::init();

    // 初始化设备
    device::init();

    // 初始化文件系统
    fs::init();

    // 输出文件树
    print_file_tree(INode::root());

    // 创建busybox 指令副本
    let busybox_node = INode::get(None, "busybox").expect("can't find busybox");
    busybox_node.linkat("sh");
    busybox_node.linkat("echo");
    busybox_node.linkat("cat");
    busybox_node.linkat("cp");
    busybox_node.linkat("ls");
    busybox_node.linkat("pwd");

    // 缓冲文件 加快系统处理
    cache_file("busybox");
    cache_file("lua");

    // 初始化多任务
    start_tasks();

    // 调用rust api关机
    panic!("正常关机")
}


/// 辅助核心进入的函数
/// 
/// 目前让除 0 核之外的其他内核进入该函数进行等待
#[allow(unused)]
extern "C" fn support_hart_resume(hart_id: usize, _param: usize) {
    loop {
        // 使用wfi 省电
        unsafe { asm!("wfi") }
    }
}


/// 打印目录树
/// 
/// 将文件目录以树的形式打印出来 相当于tree指令
pub fn print_file_tree(node: Rc<INode>) {

    /// 打印目录树 - 递归部分
    fn print_file_tree_back(node: Rc<INode>, space: usize) {
        let iter = node.clone_children();
        let mut iter = iter.iter().peekable();
        while let Some(sub_node) = iter.next() {
            if iter.peek().is_none() {
                info!("{:>2$}└──{}", "", sub_node.get_filename(), space);
            } else {
                info!("{:>2$}├──{}", "", sub_node.get_filename(), space);
            }
            if sub_node.is_dir() {
                print_file_tree_back(sub_node.clone(), space + 3);
            }
        }
    }

    info!("{}", node.get_pwd());
    print_file_tree_back(node, 0);
}


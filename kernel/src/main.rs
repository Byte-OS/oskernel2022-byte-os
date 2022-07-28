// remove std lib
#![no_std]
#![no_main]
#![feature(panic_info_message)]
#![feature(default_alloc_error_handler)]
#![allow(unaligned_references)]
#![feature(derive_default_enum)]


// 使用定义的命令行宏   
#[macro_use]
mod console;
mod device;
pub mod interrupt;
mod memory;
mod fs;
mod sbi;
mod panic;
mod sync;
pub mod task;
pub mod runtime_err;
pub mod elf;
pub mod sys_call;

#[macro_use]
extern crate bitflags;
#[macro_use]
extern crate lazy_static; 
#[macro_use]
extern crate alloc;
use core::arch::global_asm;


use alloc::rc::Rc;
use riscv::register::sstatus;

use crate::{fs::filetree::INode, memory::page::get_free_page_num};


mod virtio_impl;


global_asm!(include_str!("entry.asm"));

/// 清空bss段
fn clear_bss() {
    extern "C" {
        fn sbss();
        fn ebss();
    }
    let bss_start_addr = sbss as usize as *mut u8;
    let bss_size = ebss as usize - sbss as usize;
    unsafe {
        core::slice::from_raw_parts_mut(bss_start_addr, bss_size).fill(0);
    }
    
    // 显示BSS段信息
    info!("the bss section range: {:X}-{:X}, {} KB", sbss as usize, ebss as usize, bss_size / 0x1000);
}

#[no_mangle]
pub extern "C" fn rust_main(hart_id: usize, device_tree_p_addr: usize) -> ! {
    // // 保证仅有一个核心工作
    #[cfg(not(debug_assertions))]
    if hart_id != 0 {
        sbi::hart_suspend(0x00000000, support_hart_resume as usize, 0);
    }

    #[cfg(feature = "board_k210")]
    if hart_id != 0 {
        sbi::hart_suspend(0x00000000, support_hart_resume as usize, 0);
    }

    unsafe {
        sstatus::set_fs(sstatus::FS::Dirty);
    }
    
    // 清空bss段
    clear_bss();

    // 输出设备信息
    info!("当前核心 {}", hart_id);
    info!("设备树地址 {:#x}", device_tree_p_addr);

    // 提示信息
    info!("Welcome to test os!");

    // 初始化内存
    memory::init();

    // 初始化中断
    interrupt::init();

    // 初始化设备
    device::init();

    // 初始化文件系统
    fs::init();

    // 输出文件树
    print_file_tree(INode::get(None, "/", false).unwrap());

    // cache_file("runtest.exe");
    // cache_file("entry-static.exe");
    // cache_file("entry-dynamic.exe");
    // cache_file("libc.so");
    // cache_file("dlopen_dso.so");
    // cache_file("tls_align_dso.so");
    // cache_file("tls_get_new-dtv_dso.so");
    // cache_file("tls_init_dso.so");

    // 初始化多任务
    task::init();

    // 输出剩余页表
    debug!("剩余页表: {}", get_free_page_num());
    // 调用rust api关机
    // shutdown()
    panic!("关机")
}


extern "C" fn support_hart_resume(hart_id: usize, _param: usize) {
    info!("核心 {} 作为辅助核心进行等待", hart_id);
    loop {} // 进入循环
}


// 打印目录树
pub fn print_file_tree(node: Rc<INode>) {
    // info!("is root {:?}", node.is_root());
    info!("{}", node.get_pwd());
    print_file_tree_back(node, 0);
}

// 打印目录树 - 递归
pub fn print_file_tree_back(node: Rc<INode>, space: usize) {
    let iter = node.get_children();
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
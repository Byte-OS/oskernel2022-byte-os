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
mod interrupt;
mod memory;
mod fs;
mod sbi;
mod panic;
mod sync;

#[macro_use]
extern crate lazy_static; 
#[macro_use]
extern crate alloc;
use core::arch::{global_asm, asm};

use fs::filetree::FileTreeNode;
use interrupt::TICKS;

use crate::{sbi::shutdown, fs::filetree::FILETREE};


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
pub extern "C" fn rust_main(_hartid: usize, device_tree_paddr: usize) -> ! {
    // 清空bss段
    clear_bss();

    // 输出设备信息
    info!("当前核心 {}", _hartid);
    info!("设备树地址 {:#x}", device_tree_paddr);

    // 初始化中断
    interrupt::init();

    // 初始化内存
    memory::init();

    // 初始化设备
    device::init();

    // 初始化文件系统
    fs::init();
    
    // 提示信息
    info!("Welcome to test os!");

    //
    unsafe {
        loop {
            if TICKS % 100 == 0 {
                info!("{} TICKS", TICKS);
                if TICKS >= 1000 {
                    info!("继续执行");
                    break;
                }
                // 等待中断产生
                asm!("WFI");
            }
        }
    }

    // 输出文件树
    print_file_tree(FILETREE.lock().open("/").unwrap());

    

    // 

    // let mut words = String::new();
    // read_line_display(&mut words);
    // info!("I say {}", words);

    // 调用rust api关机
    shutdown()
}

// 打印目录树
pub fn print_file_tree(node: FileTreeNode) {
    // info!("is root {:?}", node.is_root());
    info!("{}", node.get_pwd());
    print_file_tree_back(&node, 0);
}

// 打印目录树 - 递归
pub fn print_file_tree_back(node: &FileTreeNode, space: usize) {
    let iter = node.get_children();
    let mut iter = iter.iter().peekable();
    while let Some(sub_node) = iter.next() {
        if iter.peek().is_none() {
            info!("{:>2$}└──{}", "", sub_node.get_filename(), space);
        } else {
            info!("{:>2$}├──{}", "", sub_node.get_filename(), space);
        }
        if sub_node.is_dir() {
            print_file_tree_back(sub_node, space + 3);
        }
    }
}
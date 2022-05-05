// remove std lib
#![no_std]
#![no_main]
#![feature(panic_info_message)]
#![feature(default_alloc_error_handler)]


// 使用定义的命令行宏   
#[macro_use]
mod console;
mod interrupt;
mod memory;
mod sbi;
mod panic;

extern crate alloc;
use core::arch::{global_asm, asm};
use alloc::{vec::Vec, string::String};

use crate::sbi::{shutdown};
use crate::console::{read_line_display, read};

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
pub extern "C" fn rust_main() -> ! {
    // 清空bss段
    clear_bss();

    // 初始化中断
    interrupt::init();

    // 初始化内存
    memory::init();
    
    // 提示信息
    info!("Welcome to test os!");

    unsafe {
        asm!("ebreak");
    }

    // 测试获取信息
    // let ch = read();
    // info!("read char {:#x}", ch as u8);

    let mut words = String::new();
    read_line_display(&mut words);
    info!("I say {}", words);

    // 测试数据分配
    let mut a1: Vec<u8> = Vec::new();
    a1.push(1);
    a1.push(2);
    for a in a1 {
        info!("{}", a);
    }

    

    // 调用rust api关机
    shutdown()
}

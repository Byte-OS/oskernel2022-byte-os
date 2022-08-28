#![no_std]
#![no_main]
#![feature(panic_info_message)]
#![feature(default_alloc_error_handler)]
#![allow(unaligned_references)]
#![feature(const_btree_new)]
#![feature(drain_filter)]

// 使用定义的命令行宏   
#[macro_use]
pub mod console;
pub mod device;
pub mod interrupt;
pub mod memory;
pub mod fs;
pub mod sbi;
pub mod panic;
pub mod sync;
pub mod task;
pub mod runtime_err;
pub mod elf;
// pub mod sys_call;

#[macro_use]
extern crate bitflags;
#[macro_use]
extern crate lazy_static; 
#[macro_use]
extern crate alloc;

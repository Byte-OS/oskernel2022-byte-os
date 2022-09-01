#![no_std]
#![no_main]
#![feature(panic_info_message)]
#![feature(default_alloc_error_handler)]
#![allow(unaligned_references)]
#![feature(const_btree_new)]
#![feature(drain_filter)]

pub mod device;
pub mod interrupt;
pub mod memory;
pub mod fs;
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
#[macro_use]
extern crate output;

// remove std lib
#![no_std]
#![no_main]
#![feature(panic_info_message)]
#![feature(alloc_error_handler)]
#![allow(unused)]


extern crate alloc;


#[macro_use]
mod console;
mod sbi;
mod memory;
mod panic;
mod interrupt;
mod sync;
mod syscall;

#[macro_use]
extern crate lazy_static;

use alloc::boxed::Box;
use alloc::vec;
use core::arch::global_asm;
use core::arch::asm;
use crate::interrupt::timer::TICKS;
use crate::sbi::{console_getchar, shutdown};

global_asm!(include_str!("entry.asm"));

/// fill the bss section with zero
fn clear_bss() {
    extern "C" {
        fn sbss();
        fn ebss();
    }
    unsafe {
        core::slice::from_raw_parts_mut(sbss as usize as *mut u8, ebss as usize - sbss as usize)
            .fill(0);
    }
    
    // display bss info
    info!("the bss section range: {:X}-{:X}, {} KB", sbss as usize, ebss as usize, (ebss as usize - sbss as usize) / 0x1000);
}

#[no_mangle]
pub extern "C" fn rust_main() -> ! {

    clear_bss();
    
    info!("Welcome to test os!");

    // initialize interrupt
    interrupt::init();

    // initialize memory
    memory::init();

    // // test ebreak
    unsafe { asm!("ebreak"); }
    info!("ebreak success");

    // wait for 105 ticks
    unsafe {
        while TICKS < 105 { asm!("wfi")}
        info!("this is {} TICKS", TICKS);
    }

    shutdown()
}

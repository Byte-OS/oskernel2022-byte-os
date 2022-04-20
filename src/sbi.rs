//! 调用 Machine 层的操作
// 目前还不会用到全部的 SBI 调用，暂时允许未使用的变量或函数
#![allow(unused)]

use core::arch::asm;

const SBI_SET_TIMER: usize = 0;
const SBI_CONSOLE_PUT_CHAR: usize = 1;
const SBI_CONSOLE_GET_CHAR: usize = 2;
const SBI_CLEAR_IPI: usize = 3;
const SBI_SEND_IPI: usize = 4;
const SBI_REMOTE_FENCE_I: usize = 5;
const SBI_REMOTE_SFENCE_VMA: usize = 6;
const SBI_REMOTE_SFENCE_VMA_ASID: usize = 7;
const SBI_SHUTDOWN: usize = 8;

// sbi calls
fn sbi_call(which: usize, arg0: usize, arg1: usize, arg2: usize) -> i32 {
    let mut ret;
    unsafe {
        asm!("ecall",
        in("a7") which,
        inlateout("a0") arg0 as i32 => ret,
        in("a1") arg1,
        in("a2") arg2);
    }
    ret
}

pub fn set_timer(time: usize) {
    sbi_call(SBI_SET_TIMER, time, 0, 0);
}

/// display a character on screen
pub fn console_putchar(ch: u8) {
    sbi_call(SBI_CONSOLE_PUT_CHAR, ch as usize, 0, 0);
}

/// get a cahracter from screen
pub fn console_getchar() -> i32 {
    sbi_call(SBI_CONSOLE_GET_CHAR, 0, 0, 0)
}


/// 调用 SBI_SHUTDOWN 来关闭操作系统（直接退出 QEMU）
pub fn shutdown() -> ! {
    sbi_call(SBI_SHUTDOWN, 0, 0, 0);
    unreachable!()
}
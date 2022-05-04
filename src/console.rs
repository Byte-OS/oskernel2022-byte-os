use core::{fmt::{Write, Result, Arguments}, ops::Add};
use alloc::string::String;

use crate::sbi::*;

// 读入一个字符
pub fn read() -> char {
    console_getchar()
}

// 无回显输入
pub fn read_line(str: &mut String) {
    loop {
        let c = read();
        if c == '\n' {
            break;
        }
        str.push(c);
    }
}

// 有回显输入
pub fn read_line_display(str: &mut String) {
    loop {
        let c = read();
        console_putchar(c as u8);

        if c as u8 == 0x0D {
            console_putchar(0xa);
            break;
        }
        str.push(c);
    }
}

struct Stdout;

// 实现输出Trait
impl Write for Stdout {
    fn write_str(&mut self, s: &str) -> Result {
        let mut buffer = [0u8; 4];
        for c in s.chars() {
            for code_point in c.encode_utf8(&mut buffer).as_bytes().iter() {
                console_putchar(*code_point);
            }
        }
        Ok(())
    }
}

// 输出函数
pub fn print(args: Arguments) {
    Stdout.write_fmt(args).unwrap();
}

// 定义宏
#[macro_export]
macro_rules! print {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!($fmt $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! info {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!("\x1b[1;34m", "[INFO] ", $fmt, "\n", "\x1b[0m") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! warn {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!("\x1b[1;33m", "[WARN] ", $fmt, "\n", "\x1b[0m") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! error {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!("\x1b[1;31m", "[ERROR] ", $fmt, "\n", "\x1b[0m") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! println {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?));
    }
}
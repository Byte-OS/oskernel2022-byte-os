
use core::fmt::{Write, Arguments, Result};

use arch::sbi::console_putchar;

#[macro_export]
macro_rules! print {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!($fmt $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! info {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        // $crate::console::print(format_args!(concat!("\x1b[1;34m", "[INFO] ", $fmt, "\x1b[0m", "\n") $(, $($arg)+)?));
        $crate::console::print(format_args!(concat!("[INFO] ", $fmt, "\n") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! warn {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        // #[cfg(not(feature = "not_debug"))]
        // $crate::console::print(format_args!(concat!("\x1b[1;33m", "[WARN] ", $fmt, "\x1b[0m", "\n") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! debug {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        #[cfg(not(feature = "not_debug"))]
        $crate::console::print(format_args!(concat!("\x1b[1;31m", "[DEBUG] ", $fmt, "\x1b[0m", "\n") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! error {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        // #[cfg(not(feature = "not_debug"))]
        // $crate::console::print(format_args!(concat!("\x1b[1;31m", "[ERROR] ", $fmt, "\x1b[0m", "\n") $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! println {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?));
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
pub fn puts(args: &[u8]) {
    for i in args {
        console_putchar(*i);
    }
}

// 输出函数
pub fn print(args: Arguments) {
    Stdout.write_fmt(args).unwrap();
}
use core::slice;

use crate::{console::puts, task::{STDOUT, STDIN, STDERR}, memory::{page_table::KERNEL_PAGE_MAPPING, addr::VirtAddr}, sbi::shutdown};

use super::Context;

pub const SYS_WRITE: usize = 64;

pub fn sys_write(fd: usize, buf: usize, count: usize) -> usize {
    let buf = KERNEL_PAGE_MAPPING.lock().get_phys_addr(VirtAddr::from(buf)).unwrap();
    let buf = unsafe {slice::from_raw_parts_mut(usize::from(buf) as *mut u8, count)};
    match fd {
        STDIN => {

        },
        STDOUT => {
            puts(buf);
        },
        STDERR => {

        },
        _=>{
            info!("暂未找到中断地址");
        }
    };
    count
}

pub fn sys_call(context: &mut Context) {
    // a7(x17) 作为调用号
    match context.x[17] {
        SYS_WRITE => {
            sys_write(context.x[10],context.x[11],context.x[12]);
            context.x[10] = context.x[12];
        },
        SYS_EXIT => {
            info!("退出程序");
            shutdown();
        },
        _ => {
            info!("未识别调用号 {}", context.x[17]);
        }
    }
    context.sepc = context.sepc + 4;
    // info!("用户请求 请求号:{}", context.x[17]);
}
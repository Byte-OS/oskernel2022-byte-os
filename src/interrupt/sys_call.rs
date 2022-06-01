use core::slice;

use riscv::register::satp;

use crate::{console::puts, task::{STDOUT, STDIN, STDERR, kill_current_task}, memory::{page_table::PageMapping, addr::{VirtAddr, PhysPageNum}}, sbi::shutdown};

use super::Context;

pub const SYS_WRITE: usize  = 64;
pub const SYS_EXIT:  usize  = 93;
pub const SYS_BRK:   usize  = 214;


pub fn sys_write(fd: usize, buf: usize, count: usize) -> usize {
    // 根据satp中的地址构建PageMapping 获取当前的映射方式
    let pmm = PageMapping::from(PhysPageNum(satp::read().bits()).to_addr());
    let buf = pmm.get_phys_addr(VirtAddr::from(buf)).unwrap();

    // 寻找物理地址
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
            kill_current_task();
        },
        SYS_BRK => {

        }
        _ => {
            info!("未识别调用号 {}", context.x[17]);
        }
    }
    context.sepc = context.sepc + 4;
}
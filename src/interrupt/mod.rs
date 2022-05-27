mod timer;

use core::arch::{global_asm, asm};
use riscv::register::{sstatus::Sstatus, scause::{Trap, Exception, Interrupt,Scause}, sepc};

pub use timer::TICKS;

use crate::memory::{addr::{VirtAddr, PhysAddr},  page_table::{PTEFlags, KERNEL_PAGE_MAPPING}};

#[repr(C)]
pub struct Context {
    pub x: [usize; 32],     // 32 个通用寄存器
    pub sstatus: Sstatus,
    pub sepc: usize
}

// break中断
fn breakpoint(context: &mut Context) {
    warn!("break中断产生 中断地址 {:#x}", sepc::read());
    context.sepc = context.sepc + 2;
    // panic!("中断退出")
}

// 中断错误
fn fault(_context: &mut Context, scause: Scause, stval: usize) {
    info!("中断 {:#x} 地址 {:#x} stval: {:#x}", scause.bits(), sepc::read(), stval);
    panic!("未知中断")
}

fn handle_page_fault(stval: usize) {
    warn!("缺页中断触发 缺页地址: {:#x} 已同步映射", stval);
    KERNEL_PAGE_MAPPING.lock().add_mapping(PhysAddr::from(stval), VirtAddr::from(stval), PTEFlags::VRWX);
    unsafe{
        asm!("sfence.vma {x}", x = in(reg) stval)
    };
    // panic!("缺页异常");
}

// 中断回调
#[no_mangle]
fn interrupt_callback(context: &mut Context, scause: Scause, stval: usize) {
    match scause.cause(){
        Trap::Exception(Exception::Breakpoint) => breakpoint(context),
        // 时钟中断
        Trap::Interrupt(Interrupt::SupervisorTimer) => timer::timer_handler(context),
        Trap::Exception(Exception::StorePageFault) => handle_page_fault(stval),
        // 其他情况，终止当前线程
        _ => fault(context, scause, stval),
    }
}

// 包含中断代码
global_asm!(include_str!("interrupt.asm"));


// 设置中断
pub fn init() {
    extern "C" {
        fn int_callback_entry();
    }

    unsafe {
        asm!("csrw stvec, a0", in("a0") int_callback_entry as usize);
    }

    // 初始化定时器
    timer::init();

}
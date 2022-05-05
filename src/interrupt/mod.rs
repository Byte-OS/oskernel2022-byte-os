use core::arch::{global_asm, asm};
use riscv::register::{sstatus::Sstatus, scause::{self, Trap, Exception, Scause}, stval, sepc};


#[repr(C)]
#[derive(Debug)]
pub struct Context {
    pub x: [usize; 32],     // 32 个通用寄存器
    pub sstatus: Sstatus,
    pub sepc: usize
}

// break中断
fn breakpoint(context: &mut Context) {
    warn!("寄存器地址 x1 {}", context.x[1]);
    warn!("break中断产生 中断地址 {:#x}", sepc::read());
}

// 中断错误
fn fault(context: &mut Context, scause: Scause, stval: usize) {
    info!("中断 {:#x} 地址 {:#x}", scause.bits(), sepc::read());
    panic!("未知中断")
}

// 中断回调
#[no_mangle]
fn interrupt_callback(context: &mut Context, scause: Scause, stval: usize) {
    match scause.cause(){
        Trap::Exception(Exception::Breakpoint) => breakpoint(context),
        // 时钟中断
        // Trap::Interrupt(Interrupt::SupervisorTimer) => supervisor_timer(context),
        // 其他情况，终止当前线程
        _ => fault(context, scause, stval),
    }
    fault(context, scause, stval);
    panic!("中断产生");
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

}
pub mod timer;

use core::arch::{global_asm, asm};
use riscv::register::{scause::{Trap, Exception, Interrupt,Scause}, sepc};
mod sys_call;

pub use timer::TICKS;

use crate::{memory::{addr::{VirtAddr, PhysAddr},  page_table::{PTEFlags, KERNEL_PAGE_MAPPING, switch_to_kernel_page, switch_to_user_page}}, task::get_current_task, runtime_err::RuntimeError};

use self::timer::LAST_TICKS;

#[repr(C)]
#[derive(Debug)]
// 上下文
pub struct Context {
    pub x: [usize; 32],     // 32 个通用寄存器
    pub sstatus: usize,
    pub sepc: usize
}

impl Context {
    // 创建上下文信息
    pub fn new() -> Self {
        Context {
            x: [0usize; 32],
            sstatus: 0,
            sepc: 0
        }
    }
    // 从另一个上下文复制
    pub fn clone_from(&mut self, target: &Self) {
        for i in 0..32 {
            self.x[i] = target.x[i];
        }

        self.sstatus = target.sstatus;
        self.sepc = target.sepc;
    }
}

// break中断
fn breakpoint(context: &mut Context) {
    warn!("break中断产生 中断地址 {:#x}", sepc::read());
    context.sepc = context.sepc + 2;
}

// 中断错误
fn fault(_context: &mut Context, scause: Scause, stval: usize) {
    info!("中断 {:#x} 地址 {:#x} stval: {:#x}", scause.bits(), sepc::read(), stval);
    panic!("未知中断")
}

// 处理缺页异常
fn handle_page_fault(stval: usize) {
    warn!("缺页中断触发 缺页地址: {:#x} 触发地址:{:#x} 已同步映射", stval, sepc::read());
    panic!("end");
    KERNEL_PAGE_MAPPING.lock().add_mapping(PhysAddr::from(stval).into(), 
        VirtAddr::from(stval).into(), PTEFlags::VRWX).expect("缺页处理异常");
    unsafe{
        asm!("sfence.vma {x}", x = in(reg) stval)
    };
}

// 内核中断回调
#[no_mangle]
fn kernel_callback(context: &mut Context, scause: Scause, stval: usize) -> usize {
    match scause.cause(){
        // 中断异常
        Trap::Exception(Exception::Breakpoint) => breakpoint(context),
        // 时钟中断
        Trap::Interrupt(Interrupt::SupervisorTimer) => timer::timer_handler(),
        // 缺页异常
        Trap::Exception(Exception::StorePageFault) => handle_page_fault(stval),
        // 加载页面错误
        Trap::Exception(Exception::LoadPageFault) => {
            panic!("加载权限异常 地址:{:#x}", stval)
        },
        Trap::Exception(Exception::InstructionPageFault) => handle_page_fault(stval),
        // 页面未对齐异常
        Trap::Exception(Exception::StoreMisaligned) => {
            info!("页面未对齐");
        }
        // 其他情况，终止当前线程
        _ => fault(context, scause, stval),
    }
    context as *const Context as usize
}


// 用户中断回调
#[no_mangle]
pub fn interrupt_callback(context: &mut Context, scause: Scause, stval: usize) {
    warn!("中断发生: {:#x}, 地址: {:#x}", scause.bits(), context.sepc);
    // 如果当前有任务则选择任务复制到context
    if let Some(current_task) = get_current_task() {
        current_task.inner.borrow_mut().context.clone_from(context);
        // 处理进程时间
        // current_task.force_get().tms.tms_cutime += unsafe { TICKS - LAST_TICKS } as u64;
        unsafe {
            LAST_TICKS = TICKS;
        }
    }


    // 匹配中断原因
    match scause.cause(){
        // 断点中断
        Trap::Exception(Exception::Breakpoint) => breakpoint(context),
        // 时钟中断
        Trap::Interrupt(Interrupt::SupervisorTimer) => timer::timer_handler(),
        // 页处理错误
        Trap::Exception(Exception::StorePageFault) => handle_page_fault(stval),
        // 用户请求
        Trap::Exception(Exception::UserEnvCall) => {
            // 将 恢复地址 + 4 跳过调用地址
            let mut args = [0;7];
            args.clone_from_slice(&context.x[10..17]);
            let res = sys_call::sys_call(context.x[17], args);
            // 错误处理
            if let Err(e) = res {
                match e {
                    RuntimeError::FileNotFound => panic!("文件未找到"),
                    RuntimeError::NoEnoughPage => panic!("页表不足"),
                    RuntimeError::ChangeTask => {},
                    _ => panic!("未知错误")
                }
            } else {
                if let Some(current_task) = get_current_task() {
                    current_task.inner.borrow_mut().context.x[10] = res.unwrap();
                }
            }
        },
        // 加载页面错误
        Trap::Exception(Exception::LoadPageFault) => {
            panic!("加载权限异常 地址:{:#x} 调用地址: {:#x}", stval, context.sepc)
        },
        // 页面未对齐错误
        Trap::Exception(Exception::StoreMisaligned) => {
            info!("页面未对齐");
        }
        // 其他情况，终止当前线程
        _ => fault(context, scause, stval),
    }

    // 如果当前有任务则选择任务复制到context
    if let Some(current_task) = get_current_task() {
        context.clone_from(&current_task.inner.borrow_mut().context);
        // current_task.force_get().tms.tms_cstime += unsafe { TICKS - LAST_TICKS } as u64;
        unsafe {
            LAST_TICKS = TICKS;
        }
    }
}

// 包含中断代码
global_asm!(include_str!("interrupt-kernel.asm"));
global_asm!(include_str!("interrupt-user.asm"));

// 设置中断
pub fn init() {
    extern "C" {
        fn kernel_callback_entry();
        fn int_callback_entry();
    }

    // 输出内核信息
    info!("kernel_callback_entry addr: {:#x}", kernel_callback_entry as usize);
    info!("int_callback_entry addr: {:#x}", int_callback_entry as usize);

    unsafe {
        asm!("csrw stvec, a0", in("a0") kernel_callback_entry as usize);
    }

    // 初始化定时器
    timer::init();
    test();
}

// 调试代码
pub fn test() {
    unsafe {asm!("ebreak")};
}
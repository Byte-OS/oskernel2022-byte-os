use crate::task::get_current_task;
use crate::{sbi::set_timer, task::suspend_and_run_next};
use crate::interrupt::Context;
use riscv::register::{sie, sstatus, time};

const INTERVAL: usize = 10000;     // 定时器周期

pub static mut TICKS: usize = 0;
/// 时钟中断处理器
pub fn timer_handler(context: &mut Context) {
    set_next_timeout();
    unsafe {
        TICKS=TICKS+1;
    }
    // 储存当前指针内容
    // suspend_and_run_next(context);
}

// 设置下一次时钟中断触发时间
fn set_next_timeout() {
    // 调用sbi设置定时器
    set_timer(time::read() + INTERVAL);
}

// 初始化定时器
pub fn init() {
    info!("初始化定时器");
    unsafe {
        // 开启时钟中断
        sie::set_stimer();
        // 允许中断产生
        sstatus::set_sie();
    }
    // 设置下一次中断产生时间
    set_next_timeout();
}
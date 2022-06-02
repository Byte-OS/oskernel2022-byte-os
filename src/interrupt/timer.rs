use crate::sync::mutex::Mutex;
use crate::task::get_current_task;
use crate::{sbi::set_timer, task::suspend_and_run_next};
use crate::interrupt::Context;
use riscv::register::{sie, sstatus, time};

const INTERVAL: usize = 12500000 / 100;     // 定时器周期
const CHANGE_TASK_TICKS: usize = 10;

pub struct NextTaskTicks(usize);

impl NextTaskTicks {
    pub fn new() -> Self {
        NextTaskTicks(CHANGE_TASK_TICKS)
    }

    pub fn refresh(&mut self) {
        self.0 = self.0 + CHANGE_TASK_TICKS;
    }

    pub fn need_change(&self, ticks: usize) -> bool {
        ticks > self.0
    }
}

lazy_static! {
    pub static ref NEXT_TICKS: Mutex<NextTaskTicks> = Mutex::new(NextTaskTicks::new());
}

pub static mut TICKS: usize = 0;
/// 时钟中断处理器
pub fn timer_handler(context: &mut Context) {
    set_next_timeout();
    unsafe {
        TICKS=TICKS+1;
    }
    if NEXT_TICKS.force_get().need_change(unsafe { TICKS }) {
        suspend_and_run_next();
    }
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
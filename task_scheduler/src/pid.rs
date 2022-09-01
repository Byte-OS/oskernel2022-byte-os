use crate::NEXT_PID;

// PID生成器
pub struct PidGenerater(usize);

impl PidGenerater {
    // 创建进程id生成器
    pub fn new() -> Self {
        PidGenerater(1000)
    }
}

/// 获取一个pid
/// 
/// 获取一个新的pid并将pid的指针后移，防止发生重复
#[no_mangle]
pub fn get_new_pid() -> usize {
    let mut next_pid = NEXT_PID.lock();
    let n = next_pid.0;
    next_pid.0 = n + 1;
    n
}
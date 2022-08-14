use alloc::{vec::Vec, collections::VecDeque};
use k210_soc::sleep::usleep;

use crate::{sync::mutex::Mutex, memory::page::get_free_page_num, task::task_scheduler::add_task_to_scheduler};


use super::exec;

lazy_static! {
    pub static ref TASK_QUEUE: Mutex<VecDeque<&'static str>> = Mutex::new(VecDeque::from(vec![
        // "busybox sh busybox_testcode.sh",
        // "busybox sh test.sh date.lua",
        // "busybox sh test.sh file_io.lua",
        // "busybox sh test.sh max_min.lua",
        // "busybox sh test.sh random.lua",
        // "busybox sh test.sh remove.lua",
        // "busybox sh test.sh round_num.lua",
        // "busybox sh test.sh sin30.lua",
        // "busybox sh test.sh sort.lua",
        // "busybox sh test.sh strings.lua",
        
        // sleep

        // lmbench_all
        "busybox echo latency measurements",
        "sleep",
        "lmbench_all lat_syscall -P 1 null",
        "lmbench_all lat_syscall -P 1 read",
        "lmbench_all lat_syscall -P 1 write",
        "sleep",
        "busybox mkdir -p /var/tmp",
        "busybox touch /var/tmp/lmbench",
        "sleep",
        "lmbench_all lat_syscall -P 1 stat /var/tmp/lmbench",
        "lmbench_all lat_syscall -P 1 fstat /var/tmp/lmbench",
        "lmbench_all lat_syscall -P 1 open /var/tmp/lmbench",
        "lmbench_all lat_select -n 100 -P 1 file",
        // "lmbench_all lat_sig -P 1 install",
        // "lmbench_all lat_sig -P 1 catch",
        // "lmbench_all lat_sig -P 1 prot lat_sig",
        // "lmbench_all lat_pipe -P 1",
        // "lmbench_all lat_proc -P 1 fork",
        // "lmbench_all lat_proc -P 1 exec",
        "sleep",
        "busybox cp hello /tmp",
        "sleep",
        // "lmbench_all lat_proc -P 1 shell",
        "lmbench_all lmdd label=\"File /var/tmp/XXX write bandwidth:\" of=/var/tmp/XXX move=645m fsync=1 print=3",
        "lmbench_all lat_pagefault -P 1 /var/tmp/XXX",
        "lmbench_all lat_mmap -P 1 512k /var/tmp/XXX",
        "sleep",
        "busybox echo file system latency",
        "sleep",
        // "lmbench_all lat_fs /var/tmp",
        "sleep",
        "busybox echo Bandwidth measurements",
        "sleep",
        // "lmbench_all bw_pipe -P 1",
        "lmbench_all bw_file_rd -P 1 512k io_only /var/tmp/XXX",
        "lmbench_all bw_file_rd -P 1 512k open2close /var/tmp/XXX",
        "lmbench_all bw_mmap_rd -P 1 512k mmap_only /var/tmp/XXX",
        "lmbench_all bw_mmap_rd -P 1 512k open2close /var/tmp/XXX",
        "sleep",
        "busybox echo context switch overhead",
        "sleep",
        "lmbench_all lat_ctx -P 1 -s 32 2 4 8 16 24 32 64 96",

    ]));
}


pub fn exec_by_str(str: &str) {
    debug!("执行任务: {}", str);
    let args: Vec<&str> = str.split(" ").collect();
    if let Ok(task) = exec(args[0], args[0..].to_vec()) {
        task.before_run();
        add_task_to_scheduler(task);
    }
}

// 加载下一个任务
pub fn load_next_task() -> bool {
    loop {
        if let Some(pro_name) = TASK_QUEUE.lock().pop_front() {
            if pro_name == "sleep" {
                #[cfg(feature = "board_k210")]
                usleep(100000);
                continue;
            }
            info!("剩余页表: {}", get_free_page_num());
            exec_by_str(pro_name);
            break true
        } else {
            info!("剩余页表: {}", get_free_page_num());
            break false
        }
    }
}


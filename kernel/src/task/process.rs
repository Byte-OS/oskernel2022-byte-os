use alloc::{vec::Vec, sync::Arc};

use crate::memory::{page_table::PageMappingManager, mem_set::MemSet};

use super::task::Task;

pub struct Process {
    pid: usize,                     // 进程id
    ppid: usize,                    // 父进程id
    pmm: PageMappingManager,        // 内存页映射管理 
    memset: MemSet,                 // 内存使用集
    tasks: Vec<Option<Arc<Task>>>,  // 任务管理器
}


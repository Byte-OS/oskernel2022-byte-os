use alloc::{vec::Vec, sync::Arc};

use crate::{memory::{page_table::PageMappingManager, mem_set::MemSet, addr::VirtAddr}, fs::filetree::{FileTreeNode, open}, sync::mutex::Mutex, runtime_err::RuntimeError, interrupt::timer::TMS};

use super::{task::Task, stack::UserStack, UserHeap, FileDesc, fd_table::FDTable};

pub struct Process {
    pub pid: usize,                     // 进程id
    pub ppid: usize,                    // 父进程id
    pub pmm: PageMappingManager,        // 内存页映射管理 
    pub memset: MemSet,                 // 内存使用集
    pub tasks: Vec<Option<Arc<Task>>>,  // 任务管理器
    pub entry: VirtAddr,                // 入口地址
    pub stack: UserStack,               // 用户栈
    pub heap: UserHeap,                 // 用户堆
    pub workspace: FileTreeNode,        // 工作目录
    pub fd_table: FDTable,              // 文件描述表
    pub tms: TMS,                       // 时间记录结构
}

impl Process {
    pub fn new(pid: usize) -> Result<Self, RuntimeError> {
        let pmm = PageMappingManager::new()?;
        let heap = UserHeap::new()?;
        let pte = pmm.pte.clone();
        let mut process = Self { 
            pid, 
            ppid: 1, 
            pmm, 
            memset: MemSet::new(), 
            tasks: vec![], 
            entry: 0usize.into(), 
            stack: UserStack::new(pte)?, 
            heap, 
            workspace: open("/")?.clone(), 
            fd_table: FDTable::new(),
            tms: TMS::new()
        };
        Ok(process)
    }
}
use core::cell::RefCell;

use alloc::{vec::Vec, rc::{Rc, Weak}};

use crate::{memory::{page_table::PageMappingManager, mem_set::MemSet, addr::VirtAddr}, fs::filetree::{FileTreeNode, open}, runtime_err::RuntimeError, interrupt::timer::TMS};

use super::{task::{Task, TaskStatus}, stack::UserStack, UserHeap, fd_table::FDTable};

pub struct Process {
    pub pid: usize,                             // 进程id
    pub parent: Option<Rc<RefCell<Process>>>,   // 父进程
    pub pmm: PageMappingManager,                // 内存页映射管理 
    pub mem_set: MemSet,                        // 内存使用集
    pub tasks: Vec<Weak<RefCell<Task>>>,        // 任务管理器
    pub entry: VirtAddr,                        // 入口地址
    pub stack: UserStack,                       // 用户栈
    pub heap: UserHeap,                         // 用户堆
    pub workspace: FileTreeNode,                // 工作目录
    pub fd_table: FDTable,                      // 文件描述表
    pub tms: TMS,                               // 时间记录结构
}

impl Process {
    pub fn new(pid: usize, parent: Option<Rc<RefCell<Process>>>) -> Result<(Rc<RefCell<Process>>, Task), RuntimeError> {
        let pmm = PageMappingManager::new()?;
        let heap = UserHeap::new()?;
        let pte = pmm.pte.clone();
        let process = Self { 
            pid, 
            parent, 
            pmm, 
            mem_set: MemSet::new(), 
            tasks: vec![], 
            entry: 0usize.into(), 
            stack: UserStack::new(pte)?, 
            heap, 
            workspace: open("/")?.clone(), 
            fd_table: FDTable::new(),
            tms: TMS::new()
        };
        // 创建默认任务
        let process = Rc::new(RefCell::new(process));
        let task = Task::new(0, process.clone());
        process.borrow_mut().tasks.push(Rc::downgrade(&Rc::new(RefCell::new(task.clone()))));
        Ok((process, task))
    }

    // 进程进行等待
    pub fn wait(&self) {
        let task = self.get_task(0);
        task.borrow().inner.borrow_mut().status = TaskStatus::WAITING;
    }

    // 释放进程资源
    pub fn release(&self) {
        self.mem_set.release();
        self.pmm.mem_set.release();
        self.stack.mem_set.release();
    }

    // 判断是否在等待状态
    pub fn is_waiting(&self) -> bool {
        // tasks的len 一定大于 0
        let task = self.get_task(0);
        // 如果父进程在等待 则直接释放资源 并改变父进程的状态
        if task.borrow().inner.borrow().status == TaskStatus::WAITING {
            true
        } else {
            false
        }
    }

    // 获取task 任务
    pub fn get_task(&self, index: usize) -> Rc<RefCell<Task>> {
        if index >= self.tasks.len() {
            panic!("in process.rs index >= task.len()");
        }
        self.tasks[0].upgrade().unwrap()
    }



    // 结束进程
    pub fn exit(&mut self, exit_code: usize) {
        // 如果没有父进程则直接回收资源， 如果有父进程等待也进行回收， 否则等待waitpid进行资源回收
        match &self.parent {
            Some(parent_process) => {
                let parent_process_ref = parent_process.borrow_mut();
                if parent_process_ref.is_waiting() {
                    let task = self.get_task(0);
                    task.borrow().inner.borrow_mut().status = TaskStatus::READY;
                    self.release();
                }
            },
            None => {
                self.release();
            }
        }
    }
}
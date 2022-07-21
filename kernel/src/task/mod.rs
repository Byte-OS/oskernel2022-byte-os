use core::arch::global_asm;
use core::cell::RefCell;

use alloc::collections::BTreeMap;
use alloc::rc::Rc;
use alloc::string::String;
use alloc::vec::Vec;
use xmas_elf::program::{Type, SegmentData};
use crate::elf::{self, ElfExtra};
use crate::fs::filetree::INode;
use crate::memory::addr::{get_pages_num, get_buf_from_phys_page};
use crate::memory::mem_map::MemMap;
use crate::memory::page::{alloc_more, dealloc_more, alloc};
use crate::runtime_err::RuntimeError;
use crate::task::process::Process;
use crate::task::task_scheduler::start_tasks;
use crate::{memory::{page_table::PTEFlags, addr::{PAGE_SIZE, VirtAddr, PhysAddr, PhysPageNum}, page::PAGE_ALLOCATOR}};
use self::pipe::PipeBuf;
use self::task::Task;
use self::task_scheduler::NEXT_PID;

pub mod pipe;
pub mod task_queue;
pub mod stack;
pub mod controller;
pub mod pid;
pub mod process;
pub mod task;
pub mod fd_table;
pub mod task_scheduler;

pub const STDIN: usize = 0;
pub const STDOUT: usize = 1;
pub const STDERR: usize = 2;

#[allow(dead_code)]
// 用户heap
pub struct UserHeap {
    start: PhysPageNum, 
    pointer: usize,
    size: usize
}

// 文件描述符类型
pub enum FileDescEnum {
    File(Rc<INode>),
    Pipe(PipeBuf),
    Device(String)
}

// 文件描述符
pub struct FileDesc {
    pub target: FileDescEnum,
    pub pointer: usize,
    pub readable: bool,
    pub writable: bool
}

impl FileDesc {
    // 创建文件描述符
    pub fn new(target: FileDescEnum) -> Self {
        FileDesc {
            target,
            pointer: 0,
            readable: true,
            writable: true
        }
    }

    // 创建pipe
    pub fn new_pipe() -> (Self, Self) {
        let buf = PipeBuf::new();
        let read_pipe = FileDesc {
            target: FileDescEnum::Pipe(buf.clone()),
            pointer: 0,
            readable: true,
            writable: false
        };
        let write_pipe = FileDesc {
            target: FileDescEnum::Pipe(buf.clone()),
            pointer: 0,
            readable: false,
            writable: true
        };
        (read_pipe, write_pipe)
    }
}

impl UserHeap {
    // 创建heap
    pub fn new() -> Result<Self, RuntimeError> {
        let phy_start = PAGE_ALLOCATOR.lock().alloc()?;
        // 申请页表作为heap
        Ok(UserHeap {
            start: phy_start,
            pointer: 0,
            size: PAGE_SIZE
        })
    }

    // 获取堆开始的地址
    pub fn get_addr(&self) -> PhysAddr {
        self.start.into()
    }

    pub fn get_heap_size(&self) -> usize {
        self.pointer
    }

    pub fn set_heap_top(&mut self, top: usize) -> usize {
        let origin_top = self.pointer;
        self.pointer = top;
        origin_top
    }
}


// 获取pid
pub fn get_new_pid() -> usize {
    NEXT_PID.lock().next()
}

pub fn exec_with_process<'a>(process: Rc<RefCell<Process>>, task: Rc<Task>, path: &'a str, args: Vec<&'a str>) 
        -> Result<Rc<Task>, RuntimeError> {
    info!("读取path: {}", path);

    // 如果存在write
    let program = INode::get(None, path, false)?;
    
    // 申请页表存储程序
    let elf_pages = get_pages_num(program.get_file_size());
    // 申请页表
    let elf_phy_start = alloc_more(elf_pages)?;
    // 获取缓冲区地址并读取
    let buf = get_buf_from_phys_page(elf_phy_start, elf_pages);
    program.read_to(buf);

    // 读取elf信息
    let elf = xmas_elf::ElfFile::new(buf).unwrap();
    let elf_header = elf.header;    
    let magic = elf_header.pt1.magic;

    let entry_point = elf.header.pt2.entry_point() as usize;
    assert_eq!(magic, [0x7f, 0x45, 0x4c, 0x46], "invalid elf!");

    // 测试代码
    let header = elf
        .program_iter()
        .find(|ph| ph.get_type() == Ok(Type::Interp));
    if let Some(header) = header {
        info!("has interp");
        if let Ok(SegmentData::Undefined(_data)) = header.get_data(&elf) {
            // 对 动态链接文件进行转发
            // let len = (0..).find(|&i| data[i] == 0).unwrap();
            // let mut path = core::str::from_utf8(&data[..len]).unwrap();
            let path = "libc.so";
            let mut new_args = vec![path];
            new_args.extend_from_slice(&args[..]);
            return exec_with_process(process, task, path, new_args);
        }
    }

    // let base = 0x20000000;

    // let entry_point = base + entry_point;

    match elf.relocate(process.borrow().pmm.clone(), 0x20000000) {
        Ok(_) => {info!("relocate success");},
        Err(value) => {info!("test: {}", value);}
    };

    // 创建新的任务控制器 并映射栈
    let mut process = process.borrow_mut();

    // 重新映射内存 并设置头
    let ph_count = elf_header.pt2.ph_count();
    for i in 0..ph_count {
        let ph = elf.program_header(i).unwrap();
        if ph.get_type().unwrap() == xmas_elf::program::Type::Load {
            let start_va: VirtAddr = ph.virtual_addr().into();
            let alloc_pages = get_pages_num(ph.mem_size() as usize + start_va.0 % 0x1000);
            let phy_start = alloc_more(alloc_pages)?;

            let ph_offset = ph.offset() as usize;
            let offset = ph.offset() as usize % PAGE_SIZE;
            let read_size = ph.file_size() as usize;
            let temp_buf = get_buf_from_phys_page(phy_start, alloc_pages);

            let vr_start = ph.virtual_addr() as usize % 0x1000;
            let vr_end = vr_start + read_size;

            // 添加memset
            process.mem_set.inner().push(MemMap::exists_page(phy_start, VirtAddr::from(ph.virtual_addr()).into(), 
                alloc_pages, PTEFlags::VRWX | PTEFlags::U));

            // 初始化
            temp_buf[..vr_start].fill(0);
            temp_buf[vr_end..].fill(0);
            temp_buf[vr_start..vr_end].copy_from_slice(&buf[ph_offset..ph_offset+read_size]);

            process.pmm.add_mapping_range(PhysAddr::from(phy_start) + PhysAddr::from(offset), 
                start_va, ph.mem_size() as usize, PTEFlags::VRWX | PTEFlags::U)?;
        }
    }

    // 添加参数
    let stack = &mut process.stack;
    
    let mut auxv = BTreeMap::new();
    auxv.insert(elf::AT_PLATFORM, stack.push_str("riscv"));
    auxv.insert(elf::AT_EXECFN, stack.push_str(path));
    auxv.insert(elf::AT_PHNUM, elf_header.pt2.ph_count() as usize);
    auxv.insert(elf::AT_PAGESZ, PAGE_SIZE);
    auxv.insert(elf::AT_ENTRY, entry_point);
    auxv.insert(elf::AT_PHENT, elf_header.pt2.ph_entry_size() as usize);
    auxv.insert(elf::AT_PHDR, elf.get_ph_addr()? as usize);

    stack.init_args(args, vec![], auxv);
    
    // 更新context
    let mut task_inner = task.inner.borrow_mut();
    task_inner.context.x.fill(0);
    task_inner.context.sepc = entry_point;
    task_inner.context.x[2] =process.stack.get_stack_top();
    drop(task_inner);

    // 映射堆
    let heap_ppn = process.heap.get_addr().into();

    process.pmm.add_mapping(heap_ppn, 
        0xf0110usize.into(), PTEFlags::VRWX | PTEFlags::U)?;

    drop(process);
    // 释放读取的文件
    dealloc_more(elf_phy_start, elf_pages);
    
    // 任务管理器添加任务
    Ok(task)
}

// 执行一个程序 path: 文件名 思路：加入程序准备池  等待执行  每过一个时钟周期就执行一次
pub fn exec<'a>(path: &'a str, args: Vec<&'a str>) -> Result<Rc<Task>, RuntimeError> { 
    // 创建新的任务控制器 并映射栈
    let (process, task) = Process::new(get_new_pid(), None)?;
    exec_with_process(process, task, path, args)
}

// 包含更换任务代码
global_asm!(include_str!("change_task.asm"));

// 初始化多任务系统
pub fn init() {
    info!("多任务初始化");
    // run_first();
    start_tasks();
}
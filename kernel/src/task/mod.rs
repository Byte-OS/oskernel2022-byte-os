use core::arch::global_asm;
use core::cell::RefCell;


use alloc::collections::BTreeMap;
use alloc::rc::Rc;
use alloc::string::String;
use alloc::vec::Vec;
use xmas_elf::program::{Type, SegmentData};
use crate::elf::{self, ElfExtra};
use crate::fs::filetree::INode;
use crate::memory::addr::{get_pages_num, get_buf_from_phys_page, get_buf_from_phys_addr};
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
        // let phy_start = alloc()?;
        // 申请页表作为heap
        Ok(UserHeap {
            start: 0usize.into(),
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
        warn!("set top: {}", top);
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
    // let file = INode::open(None, path, false)?;
    let program = INode::get(None, path, false)?;
    
    // 申请页表存储程序
    let elf_pages = get_pages_num(program.get_file_size());
    
    // 申请暂时内存
    let temp_buf = MemMap::new_kernel_buf(elf_pages)?;
    // 获取缓冲区地址并读取
    let buf = get_buf_from_phys_page(temp_buf.ppn, temp_buf.page_num);
    program.read_to(buf);
    // let file_inner = file.0.borrow_mut();
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
            let path = "libc.so";
            let mut new_args = vec![path];
            new_args.extend_from_slice(&args[..]);
            return exec_with_process(process, task, path, new_args);
        }
    }

    // 创建新的任务控制器 并映射栈
    let mut process = process.borrow_mut();

    let mut base = 0x20000000;
    let mut relocated_arr = vec![];

    base = match elf.relocate(process.pmm.clone(), base) {
        Ok(arr) => {
            relocated_arr = arr;
            info!("relocate success");
            base
        },
        Err(value) => {
            info!("test: {}", value);
            0
        }
    };

    // 重新映射内存 并设置头
    let ph_count = elf_header.pt2.ph_count();
    for i in 0..ph_count {
        let ph = elf.program_header(i).unwrap();
        if ph.get_type().unwrap() == xmas_elf::program::Type::Load {
            let start_va: VirtAddr = (ph.virtual_addr() as usize + base).into();
            let alloc_pages = get_pages_num(ph.mem_size() as usize + start_va.0 % 0x1000);
            let phy_start = alloc_more(alloc_pages)?;

            let ph_offset = ph.offset() as usize;
            let offset = ph.offset() as usize % PAGE_SIZE;
            let read_size = ph.file_size() as usize;
            let temp_buf = get_buf_from_phys_page(phy_start, alloc_pages);

            let vr_offset = ph.virtual_addr() as usize % 0x1000;
            let vr_offset_end = vr_offset + read_size;

            // 添加memset
            process.mem_set.inner().push(MemMap::exists_page(phy_start, VirtAddr::from(ph.virtual_addr()).into(), 
                alloc_pages, PTEFlags::VRWX | PTEFlags::U));

            // 初始化
            temp_buf[vr_offset..vr_offset_end].copy_from_slice(&buf[ph_offset..ph_offset+read_size]);
            process.pmm.add_mapping_range(PhysAddr::from(phy_start) + PhysAddr::from(offset), 
                start_va, ph.mem_size() as usize, PTEFlags::VRWX | PTEFlags::U)?;
        }
    }
    if base > 0 {
        let pmm = process.pmm.clone();
        for (addr, value) in relocated_arr.clone() {
            let phys_addr = pmm.get_phys_addr(addr.into())?;
            let ptr = phys_addr.tranfer::<usize>();
            *ptr = value;
        }
    }

    // 添加参数
    let stack = &mut process.stack;
    
    let mut auxv = BTreeMap::new();
    auxv.insert(elf::AT_PLATFORM, stack.push_str("riscv"));
    auxv.insert(elf::AT_EXECFN, stack.push_str(path));
    auxv.insert(elf::AT_PHNUM, elf_header.pt2.ph_count() as usize);
    auxv.insert(elf::AT_PAGESZ, PAGE_SIZE);
    auxv.insert(elf::AT_ENTRY, base + entry_point);
    auxv.insert(elf::AT_PHENT, elf_header.pt2.ph_entry_size() as usize);
    auxv.insert(elf::AT_PHDR, base + elf.get_ph_addr()? as usize);

    auxv.insert(elf::AT_GID, 1);
    auxv.insert(elf::AT_EGID, 1);
    auxv.insert(elf::AT_UID, 1);
    auxv.insert(elf::AT_EUID, 1);
    auxv.insert(elf::AT_SECURE, 0);

    stack.init_args(args, vec![], auxv);
    
    // 更新context
    let mut task_inner = task.inner.borrow_mut();
    task_inner.context.x.fill(0);
    task_inner.context.sepc = base + entry_point;
    task_inner.context.x[2] = process.stack.get_stack_top();
    drop(task_inner);

    // 映射堆
    let heap_ppn = process.heap.get_addr().into();

    process.pmm.add_mapping(heap_ppn, 
        0xf0110usize.into(), PTEFlags::VRWX | PTEFlags::U)?;

    drop(process);
    // 释放读取的文件
    
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
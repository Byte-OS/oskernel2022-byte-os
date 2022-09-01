use kernel::fs::file::FileOP;
use kernel::memory::mem_map::MemMap;
use kernel::memory::mem_map::MapFlags;
use kernel::memory::page::get_free_page_num;
use kernel::memory::page_table::PTEFlags;
use kernel::memory::addr::PAGE_SIZE;
use kernel::memory::addr::VirtAddr;
use kernel::memory::addr::get_buf_from_phys_addr;
use kernel::runtime_err::RuntimeError;
use kernel::task::fd_table::FD_NULL;
use kernel::task::fd_table::FD_RANDOM;

use crate::SyscallTask;

pub fn sys_brk(task: SyscallTask, top_pos: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    let mut process = inner.process.borrow_mut();
    if top_pos == 0 {
        let top = process.heap.get_heap_top();
        drop(process);
        inner.context.x[10] = top;
    } else {
        let ret = if top_pos > process.heap.get_heap_top() + PAGE_SIZE {
            process.heap.get_heap_top()
        } else {
            process.heap.set_heap_top(top_pos)?
        };
        drop(process);
        inner.context.x[10] = ret;
    }
    Ok(())
}

pub fn sys_mmap(task: SyscallTask, start: usize, len: usize, _prot: usize, 
        flags: usize, fd: usize, offset: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    let mut process = inner.process.borrow_mut();
    let start = if start == 0 {
        let latest_addr = process.mem_set.get_last_addr();
        if latest_addr < 0xd000_0000 {
            0xd000_0000
        } else {
            latest_addr
        }
    } else {
        start
    };
    if len == 0x80000 || len == 524288 {
        let start_page = start / PAGE_SIZE;
        let end_page = start_page + (len / PAGE_SIZE);
        let mem_map = MemMap::new(start_page.into(), 1, PTEFlags::UVRWX)?;
        for i in start_page..end_page {
            process.pmm.add_mapping(mem_map.ppn, i.into(), PTEFlags::UVRWX)?;
        }
        process.mem_set.0.push(mem_map);
        drop(process);
        inner.context.x[10] = start;
        return Ok(());
    }
    let flags = MapFlags::from_bits_truncate(flags as u32);
    let mut p_start = process.pmm.get_phys_addr(start.into())?;
    if p_start.0 < 0x8000_0000 {
        let page_num = len / PAGE_SIZE;
        let mem_map = MemMap::new(VirtAddr::from(start).into(), page_num, PTEFlags::UVRWX)?;
        p_start = mem_map.ppn.into();
        process.pmm.add_mapping_by_map(&mem_map)?;
        process.mem_set.0.push(mem_map);
    }
    let buf = get_buf_from_phys_addr(p_start, len);

    if flags.contains(MapFlags::MAP_FIXED) {
        warn!("contains: fixed");
    }
    if fd == FD_NULL {
        todo!()
    } else if fd == FD_RANDOM {
        drop(process);
        inner.context.x[10] = start;
        Ok(())
    } else {
        let file = process.fd_table.get_file(fd)?;
        debug!("file size: {:#x}", file.get_size());
        file.copy_to(offset, buf);
        drop(process);
        inner.context.x[10] = start;
        Ok(())
    }
}

pub fn sys_mprotect(task: SyscallTask, _addr: usize, _len: usize, _prot: usize) -> Result<(), RuntimeError> {
    // debug!("保护页面: {:#x}  len: {:#x}", _addr, _len);
    let mut inner = task.inner.borrow_mut();
    inner.context.x[10] = 0;
    Ok(())
}

pub fn sys_munmap(task: SyscallTask, start: usize, _len: usize) -> Result<(), RuntimeError> {
    let mut inner = task.inner.borrow_mut();
    let process = inner.process.borrow_mut();
    process.pmm.remove_mapping(start.into());
    drop(process);
    inner.context.x[10] = 0;
    Ok(())
}
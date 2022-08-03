use crate::fs::file::FileOP;
use crate::memory::mem_map::MemMap;
use crate::memory::mem_map::MapFlags;
use crate::memory::page_table::PTEFlags;
use crate::runtime_err::RuntimeError;
use crate::sys_call::SYS_CALL_ERR;
use crate::task::task::Task;
use crate::memory::addr::PAGE_SIZE;
use crate::memory::addr::VirtAddr;
use crate::memory::addr::get_buf_from_phys_addr;
use crate::task::fd_table::FD_NULL;
use crate::task::fd_table::FD_RANDOM;

impl Task {
    pub fn sys_brk(&self, _top_pos: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();

        inner.context.x[10] = SYS_CALL_ERR;
        warn!("brk");
        Ok(())
    }

    pub fn sys_mmap(&self, start: usize, len: usize, _prot: usize, 
        flags: usize, fd: usize, offset: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let mut process = inner.process.borrow_mut();
        let start = if start == 0 {
            process.mem_set.get_last_addr()
        } else {
            start
        };
        debug!("mmap start: {:#x}, len: {:#x}, prot: {}, flags: {}, fd: {:#x}, offset: {:#x}", start, len, _prot, flags, fd, offset);
        debug!("mmap pages: {}", len / PAGE_SIZE);
        let flags = MapFlags::from_bits_truncate(flags as u32);
        let mut p_start = process.pmm.get_phys_addr(start.into())?;
        debug!("申请: {}", p_start.0);
        if p_start.0 < 0x8000_0000 {
            let page_num = len / PAGE_SIZE;
            let mem_map = MemMap::new(VirtAddr::from(start).into(), page_num, PTEFlags::UVRWX)?;
            p_start = mem_map.ppn.into();
            process.pmm.add_mapping_by_map(&mem_map)?;
            process.mem_set.0.push(mem_map);
        }
        let buf = get_buf_from_phys_addr(p_start, len);
        if start == 0x205000 {
            debug!("addr :{:#x}", p_start.0);
            buf[0] = 1;
        }
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

    pub fn sys_mprotect(&self, _addr: usize, _len: usize, _prot: usize) -> Result<(), RuntimeError> {
        debug!("保护页面: {:#x}  len: {:#x}", _addr, _len);
        let mut inner = self.inner.borrow_mut();
        inner.context.x[10] = 0;
        Ok(())
    }

    pub fn sys_munmap(&self, start: usize, _len: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        process.pmm.remove_mapping(start.into());
        drop(process);
        inner.context.x[10] = 0;
        Ok(())
    }
}
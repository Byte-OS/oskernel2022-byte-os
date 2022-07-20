use crate::runtime_err::RuntimeError;
use crate::task::task::Task;
use crate::memory::addr::PAGE_SIZE;
use crate::task::fd_table::FD_NULL;
use crate::fs::file::FileOP;

impl Task {
    pub fn sys_brk(&self, top_pos: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.clone();
        let mut process = process.borrow_mut();

        // 如果是0 返回堆顶 否则设置为新的堆顶
        inner.context.x[10] = if top_pos == 0 {
            process.heap.get_heap_size()
        } else {
            process.heap.set_heap_top(top_pos)
        };
        warn!("brk");
        Ok(())
    }

    pub fn sys_mmap(&self, start: usize, _len: usize, _prot: usize, 
        _flags: usize, fd: usize, _offset: usize) -> Result<(), RuntimeError> {
        let mut inner = self.inner.borrow_mut();
        let process = inner.process.borrow_mut();
        info!("mmap start: {:#x}, len: {:#x}, prot: {}, flags: {}, fd: {}, offset: {}", start, _len, _prot, _flags, fd, _offset);
        info!("mmap pages: {}", _len / PAGE_SIZE);
        if fd == FD_NULL {
            todo!()
        } else {
            let file = process.fd_table.get_file(fd)?;
            info!("file size: {:#x}", file.get_size() / PAGE_SIZE);
            file.mmap(process.pmm.clone(), start.into());
            drop(process);
            inner.context.x[10] = start;
            Ok(())
        }
        // let mut inner = self.inner.borrow_mut();
        // let process = inner.process.clone();
        // let process = process.borrow_mut();

        // inner.context.x[10] = if fd == SYS_CALL_ERR { // 如果是匿名映射
        //     // let page_num = (len + 4095) / 4096;
        //     let page_num = 2;
        //     if let Ok(start_page) = PAGE_ALLOCATOR.force_get().alloc_more(page_num) {
        //         let virt_start = 0xe0000000;
        //         process.pmm.add_mapping(start_page, VirtAddr::from(virt_start).into(), 
        //             PTEFlags::VRWX |PTEFlags::U)?;
        //         // 添加映射成功
        //         virt_start
        //     } else {
        //         SYS_CALL_ERR
        //     }
        //     // context.x[10] = 0;
        // } else {
        //     if let Some(file_tree_node) = process.fd_table.get(fd) {
        //         match &mut file_tree_node.lock().target {
        //             FileDescEnum::File(file_tree_node) => {
        //                 // 如果start为0 则分配空间 暂分配0xd0000000
        //                 if start == 0 {
        //                     // 添加映射
        //                     process.pmm.add_mapping(PhysAddr::from(file_tree_node.get_cluster()).into(), 
        //                         0xd0000usize.into(), PTEFlags::VRWX | PTEFlags::U)?;
        //                     0xd0000000
        //                 } else {
        //                     0
        //                 }
        //             },
        //             _ => {
        //                 SYS_CALL_ERR
        //             }
        //         }
        //     } else {
        //         SYS_CALL_ERR
        //     }
        // };
        // Ok(())
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
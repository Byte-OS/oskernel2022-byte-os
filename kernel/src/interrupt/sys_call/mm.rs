use crate::{runtime_err::RuntimeError, task::{task_scheduler::get_current_process, FileDescEnum}, memory::{page::PAGE_ALLOCATOR, page_table::PTEFlags, addr::{VirtAddr, PhysAddr}}};

use super::SYS_CALL_ERR;

pub fn sys_brk(top_pos: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process();
    let mut process = process.borrow_mut();
    // 如果是0 返回堆顶 否则设置为新的堆顶
    if top_pos == 0 {
        Ok(process.heap.get_heap_size())
    } else {
        let top = process.heap.set_heap_top(top_pos);
        Ok(top)
    }
}

pub fn sys_mmap(start: usize, _len: usize, _prot: usize, 
    _flags: usize, fd: usize, _offset: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process();
    let process = process.borrow_mut();

    if fd == SYS_CALL_ERR { // 如果是匿名映射
        // let page_num = (len + 4095) / 4096;
        let page_num = 2;
        if let Ok(start_page) = PAGE_ALLOCATOR.force_get().alloc_more(page_num) {
            let virt_start = 0xe0000000;
            process.pmm.add_mapping(start_page, VirtAddr::from(virt_start).into(), 
                PTEFlags::VRWX |PTEFlags::U)?;
            // 添加映射成功
            Ok(virt_start)
        } else {
            Ok(SYS_CALL_ERR)
        }
        // context.x[10] = 0;
    } else {
        if let Some(file_tree_node) = process.fd_table.get(fd) {
            match &mut file_tree_node.lock().target {
                FileDescEnum::File(file_tree_node) => {
                    // 如果start为0 则分配空间 暂分配0xd0000000
                    if start == 0 {
                        // 添加映射
                        process.pmm.add_mapping(PhysAddr::from(file_tree_node.get_cluster()).into(), 
                            0xd0000usize.into(), PTEFlags::VRWX | PTEFlags::U)?;
                        Ok(0xd0000000)
                    } else {
                        Ok(0)
                    }
                },
                _ => {
                    Ok(SYS_CALL_ERR)
                }
            }
        } else {
            Ok(SYS_CALL_ERR)
        }
    }
}

pub fn sys_munmap(start: usize, _len: usize) -> Result<usize, RuntimeError> {
    let process = get_current_process();
    let mut process = process.borrow_mut();
    process.pmm.remove_mapping(start.into());
    Ok(0)
}
use crate::runtime_err::RuntimeError;

use super::{addr::{PhysPageNum, VirtPageNum, VirtAddr, PAGE_SIZE}, page::alloc_more};

pub struct MemMap {
    pub ppn: PhysPageNum,
    pub vpn: VirtPageNum,
    pub page_num: usize
}

impl MemMap {
    // 申请开始页表和页表数量 申请内存
    pub fn new(vpn: VirtPageNum, page_num: usize) -> Result<Self, RuntimeError> {
        let phys_num_start = alloc_more(page_num)?;
        Ok(Self {
            ppn: phys_num_start,
            vpn,
            page_num
        })
    }

    // 通过虚拟地址申请内存map
    pub fn alloc_range(start_va: VirtAddr, end_va: VirtAddr) -> Result<Self, RuntimeError> {
        let start_page: usize = start_va.0 / PAGE_SIZE * PAGE_SIZE;   // floor get start_page
        let end_page: usize = (end_va.0 + PAGE_SIZE - 1) / PAGE_SIZE;  
        let page_num = end_page - start_page;
        let phys_num_start = alloc_more(page_num)?;
        Ok(Self {
            ppn: phys_num_start,
            vpn: VirtPageNum::from(start_va),
            page_num
        })
    }
}
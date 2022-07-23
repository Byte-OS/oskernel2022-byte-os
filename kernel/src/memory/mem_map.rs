use crate::runtime_err::RuntimeError;

use super::{addr::{PhysPageNum, VirtPageNum, VirtAddr, PAGE_SIZE, get_buf_from_phys_page}, page::{alloc_more, dealloc_more}, page_table::PTEFlags};

bitflags! {
    // MAP Flags
    pub struct MapFlags: u32 {
        const MAP_SHARED          =    0x01;
        const MAP_PRIVATE         =    0x02;
        const MAP_SHARED_VALIDATE =    0x03;
        const MAP_TYPE            =    0x0f;
        const MAP_FIXED           =    0x10;
        const MAP_ANONYMOUS       =    0x20;
        const MAP_NORESERVE       =    0x4000;
        const MAP_GROWSDOWN       =    0x0100;
        const MAP_DENYWRITE       =    0x0800;
        const MAP_EXECUTABLE      =    0x1000;
        const MAP_LOCKED          =    0x2000;
        const MAP_POPULATE        =    0x8000;
        const MAP_NONBLOCK        =    0x10000;
        const MAP_STACK           =    0x20000;
        const MAP_HUGETLB         =    0x40000;
        const MAP_SYNC            =    0x80000;
        const MAP_FIXED_NOREPLACE =    0x100000;
        const MAP_FILE            =    0;
    }
}

#[derive(Clone)]
pub struct MemMap {
    pub ppn: PhysPageNum,
    pub vpn: VirtPageNum,
    pub page_num: usize,
    pub flags: PTEFlags
}

impl MemMap {
    // 申请开始页表和页表数量 申请内存
    pub fn new(vpn: VirtPageNum, page_num: usize, flags: PTEFlags) -> Result<Self, RuntimeError> {
        let phys_num_start = alloc_more(page_num)?;
        Ok(Self {
            ppn: phys_num_start,
            vpn,
            page_num,
            flags
        })
    }

    // 申请开始页表和页表数量 申请内存
    pub fn new_kernel_buf(page_num: usize) -> Result<Self, RuntimeError> {
        let phys_num_start = alloc_more(page_num)?;
        Ok(Self {
            ppn: phys_num_start,
            vpn: 0usize.into(),
            page_num,
            flags: PTEFlags::VRWX
        })
    }

    // 获取pte容器地址
    pub fn pte_container(ppn: PhysPageNum) -> Self {
        Self {
            ppn,
            vpn: VirtPageNum::default(),
            page_num: 1,
            flags: PTEFlags::V
        }
    }

    // 通过虚拟地址申请内存map
    pub fn alloc_range(start_va: VirtAddr, end_va: VirtAddr, flags: PTEFlags) -> Result<Self, RuntimeError> {
        let start_page: usize = start_va.0 / PAGE_SIZE * PAGE_SIZE;   // floor get start_page
        let end_page: usize = (end_va.0 + PAGE_SIZE - 1) / PAGE_SIZE;  
        let page_num = end_page - start_page;
        let phys_num_start = alloc_more(page_num)?;
        Ok(Self {
            ppn: phys_num_start,
            vpn: VirtPageNum::from(start_va),
            page_num,
            flags
        })
    }

    // 添加已经映射的页
    pub fn exists_page(ppn: PhysPageNum, vpn: VirtPageNum, page_num: usize, flags: PTEFlags) -> Self {
        Self { 
            ppn, 
            vpn, 
            page_num, 
            flags
        }
    }

    pub fn pte_page(ppn: PhysPageNum) -> Self {
        Self {
            ppn,
            vpn: 0usize.into(),
            page_num: 1,
            flags: PTEFlags::V
        }
    }

    pub fn clone_with_data(&self) -> Result<Self, RuntimeError> {
        let page_num = self.page_num;
        let phys_num_start = alloc_more(page_num)?;

        // 复制数据
        let new_data = get_buf_from_phys_page(phys_num_start, self.page_num);
        let old_data = get_buf_from_phys_page(self.ppn, self.page_num);
        new_data.clone_from_slice(old_data);


        Ok(Self {
            ppn: phys_num_start,
            vpn: self.vpn,
            page_num,
            flags: self.flags.clone()
        })
    }

    // 释放map页表资源
    pub fn release(&self) {
        // get_buf_from_phys_page(self.ppn, self.page_num).fill(0);
        dealloc_more(self.ppn, self.page_num);
    }
}

impl Drop for MemMap {
    fn drop(&mut self) {
        dealloc_more(self.ppn, self.page_num);
    }
}
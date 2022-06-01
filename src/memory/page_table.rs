use _core::{arch::asm, slice::from_raw_parts_mut};
use bitflags::*;

use crate::{memory::addr::PhysAddr, sync::mutex::Mutex};

use super::{addr::{PhysPageNum,  VirtAddr, PAGE_PTE_NUM}, page::PAGE_ALLOCATOR};

bitflags! {
    pub struct PTEFlags: u8 {
        const V = 1 << 0;       // 是否合法 为1合法
        const R = 1 << 1;       // 可读
        const W = 1 << 2;       // 可写
        const X = 1 << 3;       // 可执行
        const U = 1 << 4;       // 处于U特权级下是否允许被访问
        const G = 1 << 5;       // 
        const A = 1 << 6;       // 是否被访问过
        const D = 1 << 7;       // 是否被修改过
        const NONE = 0;
        const VRWX = 0xf;
    }
}

#[derive(Copy, Clone)]
#[repr(C)]
pub struct PageTableEntry {
    pub bits: usize,
}

impl PageTableEntry {
    pub fn new(ppn: PhysPageNum, flags: PTEFlags) -> Self {
        PageTableEntry {
            bits: ppn.0 << 10 | flags.bits as usize,
        }
    }
    pub fn empty() -> Self {
        PageTableEntry {
            bits: 0,
        }
    }
    pub fn ppn(&self) -> PhysPageNum {
        (self.bits >> 10 & ((1usize << 44) - 1)).into()
    }
    pub fn flags(&self) -> PTEFlags {
        PTEFlags::from_bits(self.bits as u8).unwrap()
    }

    // 判断是否为页表
    pub fn is_valid_pte(&self) -> bool {
        self.flags().contains(PTEFlags::V) && self.flags() & PTEFlags::VRWX != PTEFlags::V
    }

    // 判断是否为页目录
    pub fn is_valid_pd(&self) -> bool {
        self.flags().contains(PTEFlags::V) && self.flags() & PTEFlags::VRWX == PTEFlags::V
    }

    pub unsafe fn get_mut_ptr_from_phys(addr:PhysAddr) -> *mut Self {
        usize::from(addr) as *mut Self
    }
}

#[derive(Clone)]
pub enum PagingMode {
    Bare = 0,
    Sv39 = 8,
    Sv48 = 9
}

#[derive(Clone)]
pub struct PageMappingManager {
    paging_mode: PagingMode,
    pte: PageMapping
}

#[repr(C)]
#[derive(Clone, Copy)]
pub struct PageMapping(usize);

impl From<usize> for PageMapping {
    fn from(addr: usize) -> Self {
        PageMapping(addr)
    }
}

impl From<PhysAddr> for PageMapping {
    fn from(addr: PhysAddr) -> Self {
        PageMapping(addr.0)
    }
}

impl From<PageMapping> for PhysPageNum {
    fn from(addr: PageMapping) -> Self {
        PhysPageNum::from(PhysAddr::from(addr.0))
    }
}

impl From<PageMapping> for usize {
    fn from(addr: PageMapping) -> Self {
        addr.0
    }
}

impl PageMapping {
    pub fn new(addr: PhysAddr) -> PageMapping {
        PageMapping(addr.0)
    }

    // 初始化页表
    pub fn alloc_pte(&self, level: usize) -> Option<PhysPageNum> {
        match PAGE_ALLOCATOR.lock().alloc() {
            Some(page) => {
                let pte = unsafe {
                    from_raw_parts_mut(usize::from(page.to_addr()) as *mut PageTableEntry, PAGE_PTE_NUM)
                };
                for i in 0..PAGE_PTE_NUM {
                    pte[i] = PageTableEntry::new(PhysPageNum::from(i << (level*9)), PTEFlags::VRWX);
                }
                Some(page)
            }
            None=>None
        }
        
    }

    // 添加mapping
    pub fn add_mapping(&mut self, phy_addr: PhysAddr, virt_addr: VirtAddr, flags:PTEFlags) {
        // 如果没有pte则申请pte
        if usize::from(self.0) == 0 {
            self.0 = PhysAddr::from(self.alloc_pte(2).unwrap()).into();
        }

        // 得到 列表中的项
        let l2_pte_ptr = unsafe {
            PageTableEntry::get_mut_ptr_from_phys(PhysAddr::from(self.0)).add(virt_addr.l2())
        };
        let mut l2_pte = unsafe { l2_pte_ptr.read() };

        // 判断 是否是页表项 如果是则申请一个页防止其内容
        if !l2_pte.is_valid_pd() {
            // 创建一个页表放置二级页目录 并写入一级页目录的项中
            l2_pte = PageTableEntry::new(PhysPageNum::from(PhysAddr::from(self.alloc_pte(1).unwrap())), PTEFlags::V);
            // 写入列表
            unsafe {l2_pte_ptr.write(l2_pte)};
        }

        let l1_pte_ptr = unsafe {
            PageTableEntry::get_mut_ptr_from_phys(PhysAddr::from(l2_pte.ppn())).add(virt_addr.l1())
        };
        let mut l1_pte = unsafe {l1_pte_ptr.read()};

        // 判断 是否有指向下一级的页表
        if !l1_pte.is_valid_pd(){
            l1_pte = PageTableEntry::new(PhysPageNum::from(PhysAddr::from(self.alloc_pte(0).unwrap())), PTEFlags::V);
            unsafe{l1_pte_ptr.write(l1_pte)};
        }
        
        // 写入映射项
        unsafe {
            PageTableEntry::get_mut_ptr_from_phys(PhysAddr::from(l1_pte.ppn()))
                .add(virt_addr.l0()).write(PageTableEntry::new(PhysPageNum::from(phy_addr), flags));
        }
    }

    // 获取物理地址
    pub fn get_phys_addr(&self, virt_addr: VirtAddr) -> Option<PhysAddr> {
        // 如果没有pte则申请pte
        if usize::from(self.0) == 0 {
            return None;
        }

        // 得到 列表中的项
        let l2_pte_ptr = unsafe {
            PageTableEntry::get_mut_ptr_from_phys(PhysAddr::from(self.0)).add(virt_addr.l2())
        };
        let l2_pte = unsafe { l2_pte_ptr.read() };

        // 判断 是否有指向下一级的页表
        if !l2_pte.flags().contains(PTEFlags::V) {
            return None;
        }
        if l2_pte.flags() & PTEFlags::VRWX != PTEFlags::V {
            return Some(PhysAddr::from(virt_addr.page_offset() | (virt_addr.l0() << 12) | (virt_addr
                .l1() << 21) | (usize::from(l2_pte.ppn()) << 12)));
        }

        let l1_pte_ptr = unsafe {
            PageTableEntry::get_mut_ptr_from_phys(PhysAddr::from(l2_pte.ppn())).add(virt_addr.l1())
        };
        let l1_pte = unsafe { l1_pte_ptr.read() };

        // 判断 是否有指向下一级的页表
        if !l1_pte.flags().contains(PTEFlags::V) {
            return None;
        }
        if l1_pte.flags() & PTEFlags::VRWX != PTEFlags::V {
            return Some(PhysAddr::from(virt_addr.page_offset() | (virt_addr.l0() << 12) | (usize::from(l1_pte.ppn()) << 12)));
        }

        // 获取pte项
        let l0_pte_ptr = unsafe {
            PageTableEntry::get_mut_ptr_from_phys(PhysAddr::from(l1_pte.ppn())).add(virt_addr.l0())
        };
        let l0_pte = unsafe { l0_pte_ptr.read() };
        if !l0_pte.flags().contains(PTEFlags::V) {
            return None;
        }
        Some(PhysAddr::from(usize::from(PhysAddr::from(l0_pte.ppn())) + virt_addr.page_offset()))
    }
}


impl PageMappingManager {

    pub fn new() -> Self {
        PageMappingManager { 
            paging_mode: PagingMode::Sv39, 
            pte: PageMapping::from(0)
        }
    }

    // 获取pte
    pub fn get_pte(&self) -> usize {
        self.pte.into()
    }

    // 初始化pte
    pub fn init_pte(&mut self) {
        // 如果没有pte则申请pte
        if usize::from(self.pte) != 0 {
            PAGE_ALLOCATOR.lock().dealloc(PhysPageNum::from(self.pte));
        }
        self.pte = PhysAddr::from(self.pte.alloc_pte(2).unwrap()).into();
    }

    // 添加mapping
    pub fn add_mapping(&mut self, phy_addr: PhysAddr, virt_addr: VirtAddr, flags:PTEFlags) {
        self.pte.add_mapping(phy_addr, virt_addr, flags);
    }

    // 获取物理地址
    pub fn get_phys_addr(&self, virt_addr: VirtAddr) -> Option<PhysAddr> {
        self.pte.get_phys_addr(virt_addr)
    }

    // 更改pte
    pub fn change_satp(&self) {
        let satp_addr = (self.paging_mode.clone() as usize) << 60 | usize::from(PhysPageNum::from(self.pte));
        unsafe {
            asm!("csrw satp, a0",
            "sfence.vma", in("a0") satp_addr)
        }
    }
}

lazy_static! {
    pub static ref KERNEL_PAGE_MAPPING: Mutex<PageMappingManager> = Mutex::new(PageMappingManager::new());
}

// 初始化页面映射
pub fn init() {
    let mut mapping_manager = KERNEL_PAGE_MAPPING.lock();
    mapping_manager.init_pte();
    mapping_manager.change_satp();
}

pub fn refresh_addr(addr: usize) {
    unsafe {
        asm!("sfence.vma {x}", x = in(reg) addr)
    }
}
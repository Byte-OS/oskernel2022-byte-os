use _core::{arch::asm, mem::size_of};
use bitflags::*;
use riscv::register::satp;

use crate::memory::addr::PhysAddr;

use super::{addr::{PhysPageNum, PAGE_SIZE}, page::PAGE_ALLOCATOR};

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
}

pub enum PagingMode {
    Bare = 0,
    Sv39 = 8,
    Sv48 = 9
}

pub fn change_satp(paging_mode: PagingMode, pte: usize) {
    let satp_addr = (paging_mode as usize) << 60 | pte;
    let satp_value = satp::read();
    info!("satp value before set is 0x{:X}", satp_value.bits());
    unsafe {
        // asm!("csrw satp, a0", in("a0") satp_addr);
        asm!("csrw satp, a0",
        "sfence.vma",
        "addi a0, x0, 1", in("a0") satp_addr)
    }
    let satp_value = satp::read();
    info!("satp value after set is 0x{:X}", satp_value.bits());
}

pub fn init() {
    if let Some(page) = PAGE_ALLOCATOR.lock().alloc() {
        let pte = unsafe {
            &mut *((usize::from(PhysAddr::from(page)))as *mut [PageTableEntry; PAGE_SIZE/size_of::<PageTableEntry>()])
        };
        
        info!("item size: {}", size_of::<PageTableEntry>());
        info!("pte page: {:?}, addr: {:#x}", PhysAddr::from(page), pte.as_ptr() as usize);
        for i in 0..16 {
            // pte[i] = PhysicalPageTableEntry(((pti.as_ptr() as usize >> 12) << 10)  | 0x1f);
            pte[i] = PageTableEntry {
                bits: ((i << 18) << 10)  | 0x0f
            };
        }
        let addr = pte.as_ptr() as usize;
        info!("page entry address {:x}", addr);

        info!("page number is {:x}", usize::from(pte[2].ppn()) << 12);

        for i in 0..16 {
            info!("Physical Page Table Entry {:#x}", pte[i].bits);

        }

        change_satp(PagingMode::Sv39, addr >> 12)
    }
}
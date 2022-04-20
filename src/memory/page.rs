
use core::arch::asm;
use core::fmt::{Display, Formatter, write};
use bitflags::bitflags;
use riscv::register::satp;

/// save page whether in use
struct PageMonitor {
    ppn: usize,
    in_use: bool
}

/// create new page
impl PageMonitor {
    fn new(ppn: usize, in_use: bool) -> PageMonitor {
        PageMonitor {
            ppn,
            in_use
        }
    }
}

pub enum PagingMode {
    Bare = 0,
    Sv39 = 8,
    Sv48 = 9
}

bitflags! {
    pub struct PTEFlags: u8 {
        const V = 1 << 0;
        const R = 1 << 1;
        const W = 1 << 2;
        const X = 1 << 3;
        const U = 1 << 4;
        const G = 1 << 5;
        const A = 1 << 6;
        const D = 1 << 7;
    }
}

struct PageTableEntry(usize);
struct PageTableItem(usize);
struct VirtualPageTableEntry(usize);

struct VirtualAddress(usize);

impl VirtualAddress {
    fn vpn(&self, n: u8) -> usize {
        self.0 >> 12 >> 9 * n
    }
}

impl From<usize> for VirtualAddress {
    fn from(value: usize) -> Self {
        VirtualAddress(value)
    }
}

#[derive(Copy, Clone, Debug)]
#[repr(C)]
struct PhysicalPageTableEntry(usize);

impl Display for PhysicalPageTableEntry {
    fn fmt(&self, f: &mut Formatter<'_>) -> core::fmt::Result {
        write!(f, "0x{:x}", self.0)
    }
}

impl PhysicalPageTableEntry {
    fn ppn(&self) -> usize {
        self.0 >> 10
    }
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

/// init memory
pub fn init() {
    // prepare page table entry before enable paging
    extern "C" {
        static mut pte: [PhysicalPageTableEntry; 4];
        static mut pti: [PhysicalPageTableEntry; 16];
    }
    unsafe {
        for i in 0..pte.len() {
            // pte[i] = PhysicalPageTableEntry(((pti.as_ptr() as usize >> 12) << 10)  | 0x1f);
            pte[i] = PhysicalPageTableEntry(((i << 18) << 10)  | 0x0f);
        }

        info!("page entry address {:x}", pte.as_ptr() as usize);

        info!("page number is {:x}", pte[2].ppn() << 12);

        for i in pte  {
            info!("Physical Page Table Entry {}", i);
        }

        change_satp(PagingMode::Sv39, pte.as_ptr() as usize >> 12);

        // test for pageing
    }
}

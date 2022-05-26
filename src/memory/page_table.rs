use bitflags::*;

use super::addr::PhysPageNum;

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
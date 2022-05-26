use core::fmt::{self, Debug, Formatter};

pub const PAGE_SIZE: usize = 4096;

#[repr(C)]
#[derive(Copy, Clone, Ord, PartialOrd, Eq, PartialEq)]
pub struct PhysAddr(pub usize);
#[repr(C)]
#[derive(Copy, Clone, Ord, PartialOrd, Eq, PartialEq)]
pub struct VirtAddr(pub usize);
#[repr(C)]
#[derive(Copy, Clone, Ord, PartialOrd, Eq, PartialEq)]
pub struct PhysPageNum(pub usize);
#[repr(C)]
#[derive(Copy, Clone, Ord, PartialOrd, Eq, PartialEq)]
pub struct VirtPageNum(pub usize);

// 实现从usize转换
impl From<usize> for PhysAddr  {
    fn from(addr: usize) -> Self {
        PhysAddr(addr)
    }
}

impl From<usize> for PhysPageNum  {
    fn from(addr: usize) -> Self {
        PhysPageNum(addr)
    }
}

impl From<usize> for VirtPageNum  {
    fn from(addr: usize) -> Self {
        VirtPageNum(addr)
    }
}

impl From<usize> for VirtAddr  {
    fn from(addr: usize) -> Self {
        VirtAddr(addr)
    }
}
// 实现转换到usize
impl From<PhysAddr> for usize  {
    fn from(addr: PhysAddr) -> Self {
        addr.0
    }
}

impl From<PhysPageNum> for usize  {
    fn from(addr: PhysPageNum) -> Self {
        addr.0
    }
}

impl From<VirtPageNum> for usize  {
    fn from(addr: VirtPageNum) -> Self {
        addr.0
    }
}

impl From<VirtAddr> for usize  {
    fn from(addr: VirtAddr) -> Self {
        addr.0
    }
}

//
impl Debug for PhysPageNum {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        f.write_fmt(format_args!("PhysPageNum: {:#x}", self.0))
    }
}

impl Debug for PhysAddr {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        f.write_fmt(format_args!("PhysAddr: {:#x}", self.0))
    }
}

impl Debug for VirtPageNum {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        f.write_fmt(format_args!("VirtPageNum: {:#x}", self.0))
    }
}

impl Debug for VirtAddr {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        f.write_fmt(format_args!("VirtAddr: {:#x}", self.0))
    }
}

impl From<PhysPageNum> for PhysAddr  {
    fn from(page: PhysPageNum) -> Self {
        PhysAddr(page.0 << 12)
    }
}

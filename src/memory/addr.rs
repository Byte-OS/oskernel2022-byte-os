use core::fmt::{self, Debug, Formatter};

pub const PAGE_SIZE: usize = 4096;
pub const PAGE_PTE_NUM: usize = 512;

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

// 添加debug
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

// From
impl From<PhysPageNum> for PhysAddr  {
    fn from(page: PhysPageNum) -> Self {
        PhysAddr(page.0 << 12)
    }
}

impl From<PhysAddr> for PhysPageNum  {
    fn from(page: PhysAddr) -> Self {
        PhysPageNum(page.0 >> 12)
    }
}

impl From<VirtPageNum> for VirtAddr  {
    fn from(page: VirtPageNum) -> Self {
        VirtAddr(page.0 << 12)
    }
}

impl From<VirtAddr> for VirtPageNum  {
    fn from(page: VirtAddr) -> Self {
        VirtPageNum(page.0 >> 12)
    }
}
// 获取原始指针
impl VirtAddr {
    pub fn as_ptr(&self) -> *const u8 {
        self.0 as *const u8
    }

    pub fn as_mut_ptr(&mut self) -> *mut u8 {
        self.0 as *mut u8
    }
}

impl PhysAddr {
    pub fn as_ptr(&self) -> *const u8 {
        self.0 as *const u8
    }

    pub fn as_mut_ptr(&mut self) -> *mut u8 {
        self.0 as *mut u8
    }
}

impl PhysPageNum {
    pub fn to_addr(&self) -> PhysAddr {
        PhysAddr(self.0 << 12)
    }
}

// 获取页表偏移
impl VirtAddr{
    // 页内偏移
    pub fn page_offset(&self) -> usize {
        self.0 & 0xfff
    }

    // 第一级页表偏移
    pub fn l2(&self) -> usize {
        (self.0 >> 30) & 0x1ff
    }

    // 第二级页表偏移
    pub fn l1(&self) -> usize {
        (self.0 >> 21) & 0x1ff
    }

    // 第三级页表偏移
    pub fn l0(&self) -> usize {
        (self.0 >> 12) & 0x1ff
    }
}
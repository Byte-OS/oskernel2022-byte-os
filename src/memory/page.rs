use alloc::vec::{Vec, self};

use crate::{sync::mutex::Mutex, memory::addr::{PAGE_SIZE, PhysAddr}};

use super::addr::PhysPageNum;

const ADDR_END: usize = 0x80800000;
const ADDR_START: usize = 0x80000000;

// 内存页分配器
pub struct MemoryPageAllocator {
    pub start: usize,
    pub end: usize,
    pub pages: Vec<bool>
}


// 添加内存页分配器方法
impl MemoryPageAllocator {
    fn new() -> Self {
        MemoryPageAllocator {
            start: 0,
            end: 0,
            pages: vec![]
        }
    }

    fn init(&mut self, start: usize, end: usize) {
        self.start = start;
        self.end = end;
        self.pages = vec![false;(end - start) / PAGE_SIZE];
        info!("初始化页式内存管理, 页表数: {}", self.pages.capacity());
    }

    pub fn alloc(&mut self) -> Option<PhysPageNum> {
        for i in 0..self.pages.len() {
            if !self.pages[i] {
                self.pages[i] = true;
                return Some(PhysPageNum::from((self.start >> 9) + i));
            }
        }
        None
    }

    pub fn dealloc(&mut self, page: PhysPageNum) {
        let index = usize::from(page) - (self.start >> 9); 
        if let Some(in_use) = self.pages.get(index) {
            info!("释放页: {:?}", page);
            self.pages[index] = false;
        }
    }
}

lazy_static! {
    pub static ref PAGE_ALLOCATOR: Mutex<MemoryPageAllocator> = Mutex::new(MemoryPageAllocator::new());
}

pub fn init() {
    extern "C"{
        fn end();
    }

    // 初始化页表 Vector中每一个元素代表一个页表 通过这种方法来分配页表
    PAGE_ALLOCATOR.lock().init(end as usize, ADDR_END);
    
    //测试页表分配
    test_alloc();
}

fn test_alloc() {
    let mut allocator = PAGE_ALLOCATOR.lock();
    if let Some(page) =  allocator.alloc() {
        info!("申请到的页表为: {:?}, 地址为：{:?}", page, PhysAddr::from(page));
        allocator.dealloc(page)
    }
    if let Some(page) =  allocator.alloc() {
        info!("申请到的页表为: {:?}, 地址为：{:?}", page, PhysAddr::from(page));
    }
    if let Some(page) =  allocator.alloc() {
        info!("申请到的页表为: {:?}, 地址为：{:?}", page, PhysAddr::from(page));
    }
    if let Some(page) =  allocator.alloc() {
        info!("申请到的页表为: {:?}, 地址为：{:?}", page, PhysAddr::from(page));
    }
}
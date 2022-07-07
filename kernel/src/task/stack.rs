use crate::memory::{page_table::PageMapping, addr::VirtAddr};


const PTR_SIZE: usize = 8;

pub struct UserStack {
    pub bottom: usize,
    pub top: usize,
    pub pmm: PageMapping
}

impl UserStack {
    // 创建新的栈
    pub fn new(pmm: PageMapping) -> Self {
        UserStack { 
            bottom: 0xf0001000, 
            top: 0xf0001000,
            pmm
        }
    }

    // 获取虚拟地址对应的物理地址
    pub fn get_phys_addr(&mut self, virt_addr: usize) -> usize {
        // 此处确保代码不会出现问题 因此可以直接unwrap
        self.pmm.get_phys_addr(VirtAddr::from(virt_addr)).unwrap().0
    }

    // 在栈中加入数字
    pub fn push(&mut self, num: usize) -> usize {
        self.top -= PTR_SIZE;
        unsafe {
            (self.top as *mut usize).write(num)
        };
        self.top
    }

    // 在栈中加入字符串 并且内存对齐
    pub fn push_str(&mut self, str: &[u8]) -> usize {
        let str_len = (str.len() + (PTR_SIZE - 1)) / PTR_SIZE;
        self.top -= PTR_SIZE * str_len;

        self.top
    }

    // 在栈中加入指针 内部调用push 后期可额外处理
    pub fn push_ptr(&mut self, ptr: usize) -> usize {
        self.push(ptr)
    }
}
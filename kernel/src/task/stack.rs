use alloc::{vec::Vec, collections::BTreeMap, rc::Rc};

use crate::{memory::{page_table::{PageMapping, PTEFlags, PageMappingManager}, addr::VirtAddr, mem_set::{MemSet, self}, mem_map::MemMap}, runtime_err::RuntimeError};


const PTR_SIZE: usize = 8;

pub struct UserStack {
    pub bottom: usize,
    pub top: usize,
    pub pmm: Rc<PageMappingManager>,
    pub mem_set: MemSet
}

impl UserStack {
    // 创建新的栈
    pub fn new(pmm: Rc<PageMappingManager>) -> Result<Self, RuntimeError> {
        let mut mem_set = MemSet::new();
        let mem_map = MemMap::new(0xeffffusize.into(), 2, PTEFlags::UVRWX)?;
        pmm.add_mapping_by_map(&mem_map)?;
        mem_set.inner().push(mem_map);
        Ok(UserStack { 
            bottom: 0xf0001000, 
            top: 0xf0001000,
            pmm,
            mem_set
        })
    }

    pub fn get_stack_top(&self) -> usize {
        self.top
    }

    // 在栈中加入数字
    pub fn push(&mut self, num: usize) -> usize {
        self.top -= PTR_SIZE;
        let phys_ptr = self.pmm.get_phys_addr(self.top.into()).unwrap().0;
        unsafe {
            (phys_ptr as *mut usize).write(num)
        };
        self.top
    }

    // 在栈中加入字符串 并且内存对齐
    pub fn push_arr(&mut self, str: &[u8]) -> usize {
        // 设置 总长度
        let str_len = (str.len() + 1 + (PTR_SIZE - 1)) / PTR_SIZE;
        self.top -= PTR_SIZE * str_len;

        let mut phys_ptr = self.pmm.get_phys_addr(self.top.into()).unwrap().0;
        let mut virt_ptr = self.top;
        for i in 0..str.len() {
            // 写入字节
            unsafe {(phys_ptr as *mut u8).write(str[i])};
            virt_ptr += 1;
            // 如果虚拟地址越界 则重新映射
            if virt_ptr % 4096 == 0 {
                phys_ptr = self.pmm.get_phys_addr(VirtAddr::from(self.top)).unwrap().0;
            } else {
                phys_ptr += 1;
            }
        }
        // 写入 \0 作为结束符
        unsafe {(phys_ptr as *mut u8).write(0)};
        self.top
    }

    pub fn push_str(&mut self, str: &str) -> usize {
        self.push_arr(str.as_bytes())
    }

    // 在栈中加入指针 内部调用push 后期可额外处理
    pub fn push_ptr(&mut self, ptr: usize) -> usize {
        self.push(ptr)
    }

    pub fn init_args(&mut self, args: Vec<&str>, _envp: Vec<&str>, auxv: BTreeMap<usize, usize>) {
        let args: Vec<usize> = args.iter().map(|x| self.push_str(x)).collect();
        // auxv top
        self.push(0);

        for (key, value) in auxv {
            self.push(value);
            self.push(key);
        }
        // envp top
        self.push(0);

        // argv top
        self.push(0);

        // args
        let args_len = args.len();
        for i in args.iter().rev() {
            self.push(i.clone());
        }
        self.push(args_len);
    }

    // 复制数据
    pub fn clone_with_data(&self, pmm: Rc<PageMappingManager>) -> Result<Self, RuntimeError> {
        let mut mem_set = self.mem_set.clone_with_data()?;
        let mem_map = MemMap::new(0xeffffusize.into(), 2, PTEFlags::UVRWX)?;
        pmm.add_mapping_by_map(&mem_map)?;

        mem_set.inner().push(mem_map);
        Ok(UserStack { 
            bottom: self.bottom, 
            top: self.top,
            pmm,
            mem_set
        })
    }
}
mod heap;
mod page;
pub mod addr;
mod page_table;

// 内存初始化
pub fn init() {
    // 初始化堆 便于变量指针分配
    heap::init();

    // 初始化页
    page::init();
}
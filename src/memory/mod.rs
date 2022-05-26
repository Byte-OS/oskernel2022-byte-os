mod heap;
pub mod page;
pub mod addr;
pub mod page_table;

// 内存初始化
pub fn init() {
    // 初始化堆 便于变量指针分配
    heap::init();

    // 初始化页管理器
    page::init();

    // 开始页映射
    page_table::init();
}
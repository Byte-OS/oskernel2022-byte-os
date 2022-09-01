
use crate::memory::addr::{PhysPageNum, PhysAddr, VirtAddr};
use crate::memory::page::PAGE_ALLOCATOR;

/// dma内存申请
/// 
/// 申请内存作为virtio的dma内存
#[no_mangle]
extern "C" fn virtio_dma_alloc(pages: usize) -> PhysAddr {
    PAGE_ALLOCATOR.lock().alloc_more(pages).expect("virtio dma内存申请失败").into()
}

/// dma内存释放
/// 
/// 释放virtio 使用的dma内存
#[no_mangle]
extern "C" fn virtio_dma_dealloc(paddr: PhysAddr, pages: usize) -> i32 {
    PAGE_ALLOCATOR.lock().dealloc_more(PhysPageNum::from(paddr), pages);
    0
}

/// 物理内存转为虚拟内存
/// 
/// 因为在内核中恒等映射，所以直接转换直接返回即可
#[no_mangle]
extern "C" fn virtio_phys_to_virt(paddr: PhysAddr) -> VirtAddr {
    paddr.0.into()
}

/// 虚拟内存转为物理内存
/// 
/// 因为在内核中恒等映射，所以直接返回即可
#[no_mangle]
extern "C" fn virtio_virt_to_phys(vaddr: VirtAddr) -> PhysAddr {
    vaddr.0.into()
}

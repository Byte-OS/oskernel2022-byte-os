
use crate::memory::{page::PAGE_ALLOCATOR, addr::{PhysPageNum, PhysAddr, VirtAddr}};


#[no_mangle]
extern "C" fn virtio_dma_alloc(pages: usize) -> PhysAddr {
    info!("申请设备地址!");
    if let Ok(page_num) = PAGE_ALLOCATOR.lock().alloc_more(pages) {
        let addr = PhysAddr::from(page_num);
        info!("alloc DMA: {:?}, pages={}", addr, pages);
        return addr
    } else {
        panic!("申请失败");
    }
    // let paddr = DMA_PADDR.fetch_add(0x1000 * pages, Ordering::SeqCst);
}

#[no_mangle]
extern "C" fn virtio_dma_dealloc(paddr: PhysAddr, pages: usize) -> i32 {
    PAGE_ALLOCATOR.lock().dealloc_more(PhysPageNum::from(paddr), pages);
    0
}

#[no_mangle]
extern "C" fn virtio_phys_to_virt(paddr: PhysAddr) -> VirtAddr {
    VirtAddr::from(usize::from(paddr))
}

#[no_mangle]
extern "C" fn virtio_virt_to_phys(vaddr: VirtAddr) -> PhysAddr {
    PhysAddr::from(usize::from(vaddr))
}

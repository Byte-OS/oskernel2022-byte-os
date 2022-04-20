use core::alloc::{GlobalAlloc, Layout};
use buddy_system_allocator::LockedHeap;

/// kernel size
const KERNEL_HEAP_SIZE: usize = 0x000a_0000;

/// the space of allocator to manage
static mut HEAP: [u8; KERNEL_HEAP_SIZE] = [0; KERNEL_HEAP_SIZE];

#[global_allocator]
static HEAP_ALLOCATOR: LockedHeap<32> = LockedHeap::empty();

#[alloc_error_handler]
fn handler_alloc_error(layout: Layout) -> ! {
    panic!("an allocation of memory error occured, abort")
}

/// initialize the global_allocator
pub fn init() {
    unsafe {
        // init ALLOCATOR with start and size;
        HEAP_ALLOCATOR.lock().init(HEAP.as_ptr() as usize, KERNEL_HEAP_SIZE);
    }
    info!("the allocator initialized success!");
}
pub mod interrupt;

pub const VIRTIO0: usize = 0x10001000;
pub const PROGRAM_START:usize = 0x80200000;
pub const HEAP_SIZE: usize = 0x0008_0000;
pub const KERNEL_STACK_SIZE: usize = 4096;
pub const ADDR_END: usize = 0x82000000;
pub const CLOCK_FREQ: usize = 1250000;

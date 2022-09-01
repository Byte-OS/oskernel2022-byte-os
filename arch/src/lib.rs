#![no_std]
#![feature(naked_functions)]

pub mod sbi;
mod rv_qemu;

pub use rv_qemu::VIRTIO0 as VIRTIO0;
pub use rv_qemu::PROGRAM_START as PROGRAM_START;
pub use rv_qemu::HEAP_SIZE as HEAP_SIZE;
pub use rv_qemu::KERNEL_STACK_SIZE as KERNEL_STACK_SIZE;
pub use rv_qemu::ADDR_END as ADDR_END;
pub use rv_qemu::interrupt::kernelvec as kernelvec;
pub use rv_qemu::interrupt::change_task as change_task;
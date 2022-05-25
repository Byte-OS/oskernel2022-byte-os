pub mod block;

pub use block::BLK_CONTROL;
pub use block::SECTOR_SIZE;

pub trait BlockDevice {
    fn read_block(&mut self, sector_offset: usize, buf: &mut [u8]);

    fn write_block(&mut self, sector_offset: usize, buf: &mut [u8]);
}

pub fn init() {
    block::init();
}
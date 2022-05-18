pub mod block;

pub use block::BLK_CONTROL;
pub use block::SECTOR_SIZE;

pub fn init() {
    block::init();
}
use virtio_drivers::VirtIOBlk;
use super::BlockDevice;

pub const VIRTIO0: usize = 0x10001000;
pub const SECTOR_SIZE: usize = 512;

pub struct VirtIOBlock(pub VirtIOBlk<'static>);

impl BlockDevice for VirtIOBlock {
    fn read_block(&mut self, sector_offset: usize, buf: &mut [u8]) {
        self.0.read_block(sector_offset, buf).expect("读取失败")
    }

    fn write_block(&mut self, sector_offset: usize, buf: &mut [u8]) {
        self.0.read_block(sector_offset, buf).expect("写入失败")
    }

    fn handle_irq(&mut self) {
        todo!()
    }
}

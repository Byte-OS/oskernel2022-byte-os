use alloc::vec;
use alloc::vec::Vec;
use virtio_drivers::VirtIOBlk;
use virtio_drivers::VirtIOHeader;
use crate::fs::Partition;

const VIRTIO0: usize = 0x10001000;
const SECTOR_SIZE: usize = 512;

pub static mut BLK_CONTROL: BlockDeviceContainer = BlockDeviceContainer(vec![]);

pub struct DiskDevice<'a> {
    device: VirtIOBlk<'a>,
    parition: Vec<Partition>
}

impl DiskDevice<'_> {
    // 读取一个扇区
    pub fn read_sector(&mut self, block_id: usize, buf:& mut [u8]) {
        let mut output = vec![0; SECTOR_SIZE];
        self.device.read_block(block_id, &mut output).expect("读取失败");
        buf.copy_from_slice(&output[..buf.len()]);
    }

    // 写入一个扇区
    pub fn write_sector(&mut self, block_id: usize, buf:& mut [u8]) {
        let mut input = vec![0; SECTOR_SIZE];
        input.copy_from_slice(&buf);
        self.device.write_block(block_id, &mut input);
    }
}

pub struct BlockDeviceContainer<'a> (Vec<DiskDevice<'a>>);

impl BlockDeviceContainer<'_> {
    pub fn add(&mut self, virtio: usize) {
        self.0.push(DiskDevice { 
            device: VirtIOBlk::new(unsafe {&mut *(virtio as *mut VirtIOHeader)}).expect("failed to create blk driver"), 
            parition: vec![]
        });
    }

    // 读取一个扇区
    pub fn read_one_sector(&mut self, device_id: usize, block_id: usize, buf:& mut [u8]) {
        self.0[device_id].read_sector(block_id, buf)
    }

    // 写入一个扇区
    pub fn write_one_sector(&mut self, device_id: usize, block_id: usize, buf:& mut [u8]) {
        self.0[device_id].write_sector(block_id, buf)
    }
}

pub fn init() {
    unsafe {
        BLK_CONTROL.add(VIRTIO0);
    }
}
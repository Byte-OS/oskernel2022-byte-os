use core::borrow::Borrow;

use alloc::boxed::Box;
use alloc::sync::Arc;
use alloc::vec;
use alloc::vec::Vec;
use virtio_drivers::VirtIOBlk;
use virtio_drivers::VirtIOHeader;
use crate::fs::fat32::FAT32;
use crate::sync::mutex::Mutex;

use super::BlockDevice;

const VIRTIO0: usize = 0x10001000;
pub const SECTOR_SIZE: usize = 512;

pub static mut BLK_CONTROL: BlockDeviceContainer = BlockDeviceContainer(vec![]);

pub struct BlockDeviceContainer (Vec<Arc<Mutex<FAT32>>>);

pub struct VirtIOBlock(VirtIOBlk<'static>);

impl BlockDevice for VirtIOBlock {
    fn read_block(&mut self, sector_offset: usize, buf: &mut [u8]) {
        self.0.read_block(sector_offset, buf).expect("读取失败")
    }

    fn write_block(&mut self, sector_offset: usize, buf: &mut [u8]) {
        self.0.read_block(sector_offset, buf).expect("写入失败")
    }
}

impl BlockDeviceContainer {
    pub fn add(&mut self, virtio: usize) {
        // 创建存储设备
        let device = VirtIOBlk::new(unsafe {&mut *(virtio as *mut VirtIOHeader)}).expect("failed to create blk driver");
        let block_device:Arc<Mutex<Box<dyn BlockDevice>>> = Arc::new(Mutex::new(Box::new(VirtIOBlock(device))));
        let disk_device = Arc::new(Mutex::new(FAT32::new(block_device)));
        // device.lock().write_block_nb(block_id, buf, resp)
        // 识别分区
        self.0.push(disk_device);
    }

    // 获取所有文件系统
    pub fn get_partitions(&self) -> Vec<Arc<Mutex<FAT32>>> {
        self.0.clone()
    }

    // 获取分区
    pub fn get_partition(&self, device_id: usize) -> Arc<Mutex<FAT32>> {
        self.0[device_id].clone()
    }
}

pub fn init() {
    unsafe {
        BLK_CONTROL.add(VIRTIO0);
    }
}
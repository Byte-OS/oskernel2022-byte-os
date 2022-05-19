use alloc::sync::Arc;
use alloc::vec;
use alloc::vec::Vec;
use virtio_drivers::VirtIOBlk;
use virtio_drivers::VirtIOHeader;
use crate::fs::fat32::FAT32;
use crate::sync::mutex::Mutex;

const VIRTIO0: usize = 0x10001000;
pub const SECTOR_SIZE: usize = 512;

pub static mut BLK_CONTROL: BlockDeviceContainer = BlockDeviceContainer(vec![]);

pub struct BlockDeviceContainer<'a> (Vec<Arc<Mutex<FAT32<'a>>>>);

impl<'a> BlockDeviceContainer<'a> {
    pub fn add(&mut self, virtio: usize) {
        // 创建存储设备
        let device = Arc::new(Mutex::new(VirtIOBlk::new(unsafe {&mut *(virtio as *mut VirtIOHeader)}).expect("failed to create blk driver")));
        let disk_device = Arc::new(Mutex::new(FAT32::new(device)));
        // device.lock().write_block_nb(block_id, buf, resp)
        // 识别分区
        self.0.push(disk_device);
    }

    // 获取所有文件系统
    pub fn get_partitions(&self) -> Vec<Arc<Mutex<FAT32<'a>>>> {
        self.0.clone()
    }
}

pub fn init() {
    unsafe {
        BLK_CONTROL.add(VIRTIO0);
    }
}
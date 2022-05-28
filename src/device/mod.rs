pub mod block;
pub mod sdcard;

use alloc::boxed::Box;
use alloc::sync::Arc;
use alloc::vec::Vec;
pub use block::SECTOR_SIZE;
use virtio_drivers::VirtIOBlk;
use virtio_drivers::VirtIOHeader;

use crate::fs::fat32::FAT32;
use crate::sync::mutex::Mutex;

use self::block::VIRTIO0;
use self::block::VirtIOBlock;
use self::sdcard::SDCardWrapper;

pub static mut BLK_CONTROL: BlockDeviceContainer = BlockDeviceContainer(vec![]);

pub trait BlockDevice {
    fn read_block(&mut self, sector_offset: usize, buf: &mut [u8]);

    fn write_block(&mut self, sector_offset: usize, buf: &mut [u8]);

    fn handle_irq(&mut self);
}

pub struct BlockDeviceContainer (Vec<Arc<Mutex<FAT32>>>);


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

    pub fn add_sdcard(&mut self) {
        // 创建存储设备
        let block_device:Arc<Mutex<Box<dyn BlockDevice>>> = Arc::new(Mutex::new(Box::new(SDCardWrapper::new())));
        
        let mut buf = [0u8; 512];
        block_device.lock().read_block(0, &mut buf);

        let disk_device = Arc::new(Mutex::new(FAT32::new(block_device)));

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
    info!("初始化设备");
    #[cfg(not(feature = "board_k210"))]
    unsafe {
        BLK_CONTROL.add(VIRTIO0);
    }
    #[cfg(feature = "board_k210")]
    unsafe {
        BLK_CONTROL.add_sdcard();
    }
    info!("初始化设备");
}
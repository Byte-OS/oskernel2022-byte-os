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

use self::block::VirtIOBlock;
use self::sdcard::SDCardWrapper;

#[cfg(not(feature = "board_k210"))]
pub const VIRTIO0: usize = 0x10001000;

// 存储设备控制器 用来存储读取设备
pub static mut BLK_CONTROL: BlockDeviceContainer = BlockDeviceContainer(vec![]);

pub trait BlockDevice {
    // 读取扇区
    fn read_block(&mut self, sector_offset: usize, buf: &mut [u8]);
    // 写入扇区
    fn write_block(&mut self, sector_offset: usize, buf: &mut [u8]);
    // 处理中断
    fn handle_irq(&mut self);
}

// 块储存设备容器
pub struct BlockDeviceContainer (Vec<Arc<Mutex<FAT32>>>);

impl BlockDeviceContainer {
    // 添加VIRTIO设备
    pub fn add(&mut self, virtio: usize) {
        // 创建存储设备
        let device = VirtIOBlk::new(unsafe {&mut *(virtio as *mut VirtIOHeader)}).expect("failed to create blk driver");
        let block_device:Arc<Mutex<Box<dyn BlockDevice>>> = Arc::new(Mutex::new(Box::new(VirtIOBlock(device))));
        let disk_device = Arc::new(Mutex::new(FAT32::new(block_device)));
        // 加入设备表
        self.0.push(disk_device);
    }

    #[allow(unused)]
    // 添加sd卡存储设备
    pub fn add_sdcard(&mut self) {
        // 创建SD存储设备
        let block_device:Arc<Mutex<Box<dyn BlockDevice>>> = Arc::new(Mutex::new(Box::new(SDCardWrapper::new())));
        let disk_device = Arc::new(Mutex::new(FAT32::new(block_device)));

        // 加入存储设备表
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

// 初始化函数
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
use alloc::sync::Arc;
use alloc::vec;
use alloc::vec::Vec;
use virtio_drivers::VirtIOBlk;
use virtio_drivers::VirtIOHeader;
use crate::fs::Partition;
use crate::fs::fat32::FAT32;
use crate::sync::mutex::Mutex;
// use crate::fs::get_partitions;

const VIRTIO0: usize = 0x10001000;
const SECTOR_SIZE: usize = 512;

pub static mut BLK_CONTROL: BlockDeviceContainer = BlockDeviceContainer(vec![]);

pub struct DiskDevice<'a> {
    pub device: VirtIOBlk<'a>,
    pub parition: Vec<Arc<Mutex<dyn Partition + 'a>>>
}

impl<'a> DiskDevice<'a> {
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
        self.device.write_block(block_id, &mut input).expect("写入失败")
    }

    // 识别分区
    pub fn spefic_partitions(&mut self, device: Arc<Mutex<DiskDevice<'a>>>) {
        let partition = Arc::new(Mutex::new(FAT32::new(device, 0)));
        // 添加分区
        self.parition.push(partition);
    }
}

pub struct BlockDeviceContainer<'a> (Vec<Arc<Mutex<DiskDevice<'a>>>>);

impl BlockDeviceContainer<'_> {
    pub fn add(&mut self, virtio: usize) {
        // 创建存储设备
        let disk_device = Arc::new(Mutex::new(DiskDevice { 
            device: VirtIOBlk::new(unsafe {&mut *(virtio as *mut VirtIOHeader)}).expect("failed to create blk driver"), 
            parition: vec![]
        }));
        info!("识别扇区");
        // 识别分区
        disk_device.lock().spefic_partitions(disk_device.clone());
        info!("识别扇区完毕");
        self.0.push(disk_device);
    }

    // 读取一个扇区
    pub fn read_one_sector(&mut self, device_id: usize, block_id: usize, buf:& mut [u8]) {
        self.0[device_id].lock().read_sector(block_id, buf)
    }

    // 写入一个扇区
    pub fn write_one_sector(&mut self, device_id: usize, block_id: usize, buf:& mut [u8]) {
        self.0[device_id].lock().write_sector(block_id, buf)
    }
}

pub fn init() {
    unsafe {
        BLK_CONTROL.add(VIRTIO0);
    }
}
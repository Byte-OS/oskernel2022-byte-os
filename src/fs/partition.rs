use crate::device::BLK_CONTROL;

#[derive(Default)]
pub struct Partition {
    device_id: usize,           // 设备编号
    start_sector: usize,        // 开始扇区
}

impl Partition {
    // 读取一个sector
    pub fn read_sector(&self, sector_offset: usize, buf: &mut [u8]) {
        unsafe {
            BLK_CONTROL.read_one_sector(self.device_id, sector_offset, buf);
        }
    }

    // 写入一个sector
    pub fn write_sector(&self, sector_offset: usize, buf: &mut [u8]) {
        unsafe {
            BLK_CONTROL.read_one_sector(self.device_id, sector_offset, buf);
        }
    }
}
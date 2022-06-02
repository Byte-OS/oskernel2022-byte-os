use alloc::{string::String, vec::Vec};

use crate::device::BLK_CONTROL;

// 文件类型
#[allow(dead_code)]
#[derive(Default, Clone, Copy, PartialEq)]
pub enum FileType {
    File,           // 文件
    Directory,      // 文件夹
    Device,         // 设备
    Pipline,        // 管道
    #[default]
    None            // 空
}

pub struct FileItem {
    pub device_id: usize,       // 设备id
    pub filename : String,      // 文件名
    pub start_cluster : usize,  // 开始簇
    pub size : usize,           // 文件大小
    pub flag : FileType,        // 文件标志
}

impl FileItem {
    #[allow(unused)]
    fn read_string(&self) -> String {
        todo!()
    }

    // 读取文件内容
    pub fn read(&self) -> Vec<u8> {
        let mut file_vec = vec![0u8; self.size];
        unsafe {
            BLK_CONTROL.get_partition(self.device_id).lock().read(self.start_cluster, self.size, &mut file_vec);
        }
        file_vec
    }

    // 读取文件内容
    pub fn read_to(&self, buf: &mut [u8]) -> usize  {
        unsafe {
            BLK_CONTROL.get_partition(self.device_id).lock().read(self.start_cluster, self.size, buf)
        }
    }
}
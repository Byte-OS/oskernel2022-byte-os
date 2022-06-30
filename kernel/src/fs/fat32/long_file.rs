use alloc::string::String;

use super::{file_trait::FilesystemItemOperator, FAT32FileItemAttr};

// FAT32长文件目录项
#[allow(dead_code)]
#[repr(packed)]
pub struct FAT32longFileItem {
    attr: FAT32FileItemAttr,        // 属性
    filename: [u16; 5],             // 长目录文件名unicode码
    sign: u8,                       // 长文件名目录项标志, 取值0FH
    system_reserved: u8,            // 系统保留
    verification: u8,               // 校验值
    filename1: [u16; 6],            // 长文件名unicode码
    start: u16,                     // 文件起始簇号
    filename2: [u16; 2]             // 长文件名unicode码
}

// 实现文件读取trait
impl FilesystemItemOperator for FAT32longFileItem {
    // 获取文件名
    fn filename(&self) -> String {
        let mut filename = String::new();
        // 从filename中遍历
        for i in self.filename {
            if i == 0x00 {return filename;}
            filename.push(char::from_u32(i as u32).unwrap());
        }
        // 从filename1中遍历
        for i in self.filename1 {
            if i == 0x00 {return filename;}
            filename.push(char::from_u32(i as u32).unwrap());
        }
        // 从filename2中遍历
        for i in self.filename2 {
            if i == 0x00 {return filename;}
            filename.push(char::from_u32(i as u32).unwrap());
        }
        filename
    }
    // 获取文件大小
    fn file_size(&self) -> usize {
        todo!()
    }
    // 获取文件开始簇
    fn start_cluster(&self) -> usize {
        self.start as usize
    }
    // 获取文件信息
    fn get_attr(&self) -> FAT32FileItemAttr {
        self.attr.clone()
    }
}
use alloc::string::String;

use super::{file_trait::FilesystemItemOperator, FAT32FileItemAttr};

// FAT32长文件目录项
#[allow(dead_code)]
#[repr(packed)]
pub struct FAT32longFileItem {
    attr: FAT32FileItemAttr,        // 属性
    filename: [u8; 10],             // 长目录文件名unicode码
    sign: u8,                       // 长文件名目录项标志, 取值0FH
    system_reserved: u8,            // 系统保留
    verification: u8,               // 校验值
    filename1: [u8; 12],            // 长文件名unicode码
    start: u16,                     // 文件起始簇号
    filename2: [u8; 4]              // 长文件名unicode码
}

impl FilesystemItemOperator for FAT32longFileItem {
    fn filename(&self) -> String {
        let mut filename = String::new();
        let mut end_pos = 10;

        while self.filename[end_pos - 2] == 0x00 || self.filename[end_pos - 2] == 0xff {
            end_pos = end_pos - 2;
        }

        filename = filename + &String::from_utf8_lossy(&self.filename[..end_pos]);
        if end_pos < 10 {
            return filename;
        }

        end_pos = 12;
        while end_pos >= 2 && (self.filename1[end_pos - 2] == 0x00 || self.filename1[end_pos - 2] == 0xff) {
            end_pos = end_pos - 2;
        }
        filename = filename + &String::from_utf8_lossy(&self.filename1[..end_pos]);
        if end_pos < 12 {
            return filename;
        }

        end_pos = 4;
        while end_pos >= 2 && (self.filename2[end_pos - 2] == 0x00 || self.filename2[end_pos - 2] == 0xff) {
            end_pos = end_pos - 2;
        }
        filename = filename + &String::from_utf8_lossy(&self.filename2[..end_pos]);
        filename
    }

    fn file_size(&self) -> usize {
        todo!()
    }

    fn start_cluster(&self) -> usize {
        self.start as usize
    }

    fn get_attr(&self) -> FAT32FileItemAttr {
        self.attr.clone()
    }
}
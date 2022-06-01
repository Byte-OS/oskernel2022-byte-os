use core::fmt::Error;

use super::file::FileItem;

pub trait Partition {
    fn read_sector(&self, sector_offset: usize, buf: &mut [u8]);                // 读取扇区
    fn write_sector(&self, sector_offset: usize, buf: &mut [u8]);               // 写入扇区
    fn open_file(&self, filename: &str) -> Result<FileItem, Error>;                 // 打开文件
    fn read_file(&self, file: FileItem, buf: &mut [u8]) -> Result<(), Error>;       // 读取文件
    fn write_file(&self, filename: &str, file: &FileItem) -> Result<(), Error>;     // 写入文件
    fn mount(&self, prefix: &str);                                              // 获取文件树
}
use core::fmt::Error;

use alloc::vec::Vec;

use crate::device::block::DiskDevice;

use super::file::File;

pub trait Partition<'a> {
    fn new(device: &'a DiskDevice, start_sector: usize) -> dyn Partition<'a>;   // 创建
    fn read_sector(&self, sector_offset: usize, buf: &mut [u8]);                // 读取扇区
    fn write_sector(&self, sector_offset: usize, buf: &mut [u8]);               // 写入扇区
    fn open_file(&self, filename: &str) -> Result<File, Error>;                 // 打开文件
    fn read_file(&self, file: File, buf: &mut [u8]) -> Result<(), Error>;       // 读取文件
    fn write_file(&self, filename: &str, file: &File) -> Result<(), Error>;     // 写入文件
}

lazy_static! {
    static ref PARTITIONS: Vec<dyn Partition> = vec![];     // 所有扇区
}

pub fn get_partitions() {
    PARTITIONS
}
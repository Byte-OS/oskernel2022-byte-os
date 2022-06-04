use alloc::string::String;


use super::FAT32FileItemAttr;

// 文件项操作接口
pub trait FilesystemItemOperator {
    fn filename(&self) -> String;            // 获取文件名
    fn file_size(&self) -> usize;            // 获取文件大小
    fn start_cluster(&self) -> usize;        // 开始簇
    fn get_attr(&self) -> FAT32FileItemAttr;     // 文件属性
}
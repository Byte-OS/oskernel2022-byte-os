pub mod fat32;
pub mod file;
mod partition;
pub mod filetree;
pub mod stdio;

pub use partition::Partition;

// 初始化文件系统
pub fn init() {
    fat32::init();
    info!("初始化文件系统");
}
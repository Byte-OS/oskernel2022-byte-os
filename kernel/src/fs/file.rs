// 文件类型
#[allow(dead_code)]
#[derive(Default, Clone, Copy, PartialEq)]
pub enum FileType {
    File,           // 文件
    VirtFile,       // 虚拟文件
    Directory,      // 文件夹
    Device,         // 设备
    Pipline,        // 管道
    #[default]
    None            // 空
}

#[repr(C)]
pub struct Kstat {
	pub st_dev: u64,			// 设备号
	pub st_ino: u64,			// inode
	pub st_mode: u32,			// 设备mode
	pub st_nlink: u32,			// 文件links
	pub st_uid: u32,			// 文件uid
	pub st_gid: u32,			// 文件gid
	pub st_rdev: u64,			// 文件rdev
	pub __pad: u64,				// 保留
	pub st_size: u64,			// 文件大小
	pub st_blksize: u32,		// 占用块大小
	pub __pad2: u32,			// 保留
	pub st_blocks: u64,			// 占用块数量
	pub st_atime_sec: u64,		// 最后访问秒
	pub st_atime_nsec: u64,		// 最后访问微秒
	pub st_mtime_sec: u64,		// 最后修改秒
	pub st_mtime_nsec: u64,		// 最后修改微秒
	pub st_ctime_sec: u64,		// 最后创建秒
	pub st_ctime_nsec: u64,		// 最后创建微秒
}

pub trait FileOP {
	fn readable(&self) -> bool;
	fn writeable(&self) -> bool;
	fn read(&self, data: &mut [u8]) -> usize;
	fn write(&self, data: &[u8]) -> usize;
	fn read_at(&self, pos: usize, data: &mut [u8]) -> usize;
	fn write_at(&self, pos: usize, data: &[u8]) -> usize;
	fn get_size(&self) -> usize;
}
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
	pub st_dev: u64,
	pub st_ino: u64,
	pub st_mode: u32,
	pub st_nlink: u32,
	pub st_uid: u32,
	pub st_gid: u32,
	pub st_rdev: u64,
	pub __pad: u64,
	pub st_size: u64,
	pub st_blksize: u32,
	pub __pad2: u32,
	pub st_blocks: u64,
	pub st_atime_sec: u64,
	pub st_atime_nsec: u64,
	pub st_mtime_sec: u64,
	pub st_mtime_nsec: u64,
	pub st_ctime_sec: u64,
	pub st_ctime_nsec: u64,
}
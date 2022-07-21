use core::any::{Any, TypeId};

use alloc::rc::Rc;
use core::cell::RefCell;

use crate::{memory::mem_map::MemMap, runtime_err::RuntimeError};
use crate::memory::addr::{get_buf_from_phys_page, get_pages_num, PAGE_SIZE, VirtAddr, PhysAddr};
use crate::memory::page::alloc_more;
use crate::memory::page_table::{PageMappingManager, PTEFlags};

use super::filetree::INode;

pub const DEFAULT_VIRT_FILE_PAGE: usize = 2;

// 文件类型
#[allow(dead_code)]
#[derive(Default, Clone, Copy, PartialEq)]
pub enum FileType {
    File,           // 文件
    VirtFile,       // 虚拟文件
    Directory,      // 文件夹
    Device,         // 设备
    Pipeline,       // 管道
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

pub trait FileOP: Any {
	fn readable(&self) -> bool;
	fn writeable(&self) -> bool;
	fn read(&self, data: &mut [u8]) -> usize;
	fn write(&self, data: &[u8], count: usize) -> usize;
	fn read_at(&self, pos: usize, data: &mut [u8]) -> usize;
	fn write_at(&self, pos: usize, data: &[u8], count: usize) -> usize;
	fn get_size(&self) -> usize;
}

pub struct File(RefCell<FileInner>);

pub struct FileInner {
    pub file: Rc<INode>,
    pub offset: usize,
    pub file_size: usize,
    pub mem_size: usize,
    pub buf: &'static mut [u8],
    pub mem_map: Option<Rc<MemMap>>
}

impl File {
    pub fn new(inode: Rc<INode>) -> Result<Rc<Self>, RuntimeError>{
        if inode.get_file_type() == FileType::VirtFile {
            let inner = inode.0.borrow_mut();
            let file_size = inner.size;
            let mem_size = DEFAULT_VIRT_FILE_PAGE * PAGE_SIZE;
            let buf = get_buf_from_phys_page(PhysAddr::from(inner.cluster).into(), mem_size);
            drop(inner);
            Ok(Rc::new(Self(RefCell::new(FileInner {
                file: inode,
                offset: 0,
                file_size,
                buf,
                mem_size,
                mem_map: None
            }))))
        } else {
            // 申请页表存储程序
            let elf_pages = get_pages_num(inode.get_file_size());
            // 申请页表
            let elf_phy_start = alloc_more(elf_pages)?;
            let mem_map = MemMap::exists_page(elf_phy_start, elf_phy_start.0.into(),
                elf_pages, PTEFlags::VRWX);
            // 获取缓冲区地址并读取
            let buf = get_buf_from_phys_page(elf_phy_start, elf_pages);
            inode.read_to(buf);
            let file_size = inode.get_file_size();
            warn!("读取文件: {}", inode.get_filename());
            Ok(Rc::new(Self(RefCell::new(FileInner {
                file: inode,
                offset: 0,
                file_size,
                buf,
                mem_size: elf_pages * PAGE_SIZE,
                mem_map: Some(Rc::new(mem_map))
            }))))
        }
        
    }

    pub fn get_inode(&self) -> Rc<INode> {
        let inner = self.0.borrow_mut();
        inner.file.clone()
    }

    pub fn copy_to(&self, offset: usize, buf: &mut [u8]) {
        let inner = self.0.borrow_mut();
        let len = inner.buf.len() - offset;
        buf[..len].clone_from_slice(&inner.buf[offset..]);
    }

    pub fn mmap(&self, pmm: Rc<PageMappingManager>, virt_addr: VirtAddr) {
        let inner = self.0.borrow_mut();
        let mem_map = inner.mem_map.clone().expect("没有申请页面");
        // for i in 0..mem_map.page_num {
        //     let addr = pmm.get_phys_addr(virt_addr + VirtAddr::from(i * 0x1000)).unwrap();
        //     // info!("获取addr: {:#x}", addr.0);
        // }
        pmm.add_mapping_range(mem_map.ppn.into(), virt_addr, mem_map.page_num * PAGE_SIZE, PTEFlags::UVRWX);
    }

    pub fn lseek(&self, offset: usize, whence: usize) -> usize {
        let mut inner = self.0.borrow_mut();
        info!("seek: {}, {}   file_size: {}", offset, whence, inner.file_size);
        inner.offset = match whence {
            // SEEK_SET
            0 => { 
                if offset < inner.file_size {
                    offset
                } else {
                    inner.file_size - 1
                }
            }
            // SEEK_CUR
            1 => { 
                if inner.offset + offset < inner.file_size {
                    inner.offset + offset
                } else {
                    inner.file_size - 1
                }
            }
            // SEEK_END
            2 => {
                if inner.file_size < offset + 1 {
                    inner.file_size - offset - 1
                } else {
                    0
                }
            }
            _ => { 0 }
        };
        inner.offset
    }
}

impl FileOP for File {
    fn readable(&self) -> bool {
        true
    }

    fn writeable(&self) -> bool {
        true
    }

    fn read(&self, data: &mut [u8]) -> usize {
        let mut inner = self.0.borrow_mut();
        let remain = inner.file_size - inner.offset;
        let len = if remain < data.len() { remain } else { data.len() };
        info!("读取len: {} offset: {}", len, inner.offset);
        data[..len].clone_from_slice(&inner.buf[inner.offset..inner.offset + len]);
        inner.offset += len;
        len
    }

    fn write(&self, data: &[u8], count: usize) -> usize {
        let mut inner = self.0.borrow_mut();
        let end = inner.offset + count;
        if end >= inner.mem_size {
            panic!("无法写入超出部分");
        }
        let start = inner.offset;
        inner.buf[start..end].clone_from_slice(&data);
        inner.offset += count;
        if inner.offset >= inner.file_size {
            inner.file_size = inner.offset + 1;
        }
        count
    }

    fn read_at(&self, pos: usize, data: &mut [u8]) -> usize {
        todo!()
    }

    fn write_at(&self, pos: usize, data: &[u8], count: usize) -> usize {
        todo!()
    }

    fn get_size(&self) -> usize {
        self.0.borrow_mut().file_size
    }
}

impl dyn FileOP {
    pub fn is<T: 'static>(&self) -> bool {
        TypeId::of::<T>() == self.type_id()
    }
    pub fn downcast<T: 'static>(self: Rc<Self>) -> Result<Rc<T>,Rc<Self>> {
        if self.is::<T>() {
            unsafe {
                Ok(Rc::from_raw(Rc::into_raw(self) as _))
            }
        } else {
            Err(self)
        }
    }
}
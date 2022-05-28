use core::{cell::RefCell, mem::size_of};

use alloc::{sync::Arc, rc::Rc, string::String, boxed::Box};

use crate::{sync::mutex::Mutex, device::{SECTOR_SIZE, BLK_CONTROL, BlockDevice}, fs::{fat32::{long_file::FAT32longFileItem, short_file::FAT32shortFileItem}, filetree::FileTreeNodeRaw}};

use self::{fat32bpb::FAT32BPB, file_trait::FilesystemItemOperator};

use super::{Partition, file::{File, FileType}, filetree::{FILETREE, FileTreeNode}};

pub mod fat32bpb;
pub mod short_file;
pub mod file_trait;
pub mod long_file;

#[allow(dead_code)]
#[derive(Clone)]
pub enum FAT32FileItemAttr {
    RW  = 0,            // 读写
    R   = 1,            // 只读
    HIDDEN = 1 << 1,    // 隐藏
    SYSTEM = 1 << 2,    // 系统文件
    VOLUME = 1 << 3,    // 卷标
    SUBDIR = 1 << 4,    // 子目录
    FILE   = 1 << 5,    // 归档
}


pub struct FAT32 {
    // pub device: Arc<Mutex<VirtIOBlk<'a>>>,
    pub device: Arc<Mutex<Box<dyn BlockDevice>>>,
    pub bpb: FAT32BPB,
}

impl Partition for FAT32 {
    fn read_sector(&self, sector_offset: usize, buf: &mut [u8]) {
        let mut output = vec![0; SECTOR_SIZE];
        // let t = self.device.lock();
        self.device.lock().read_block(sector_offset, &mut output);
        
        buf.copy_from_slice(&output[..buf.len()]);
    }

    fn write_sector(&self, sector_offset: usize, buf: &mut [u8]) {
        let mut input = vec![0; SECTOR_SIZE];
        input.copy_from_slice(&buf);
        self.device.lock().write_block(sector_offset, &mut input);
    }

    fn open_file(&self, _filename: &str) -> Result<File, core::fmt::Error> {
        todo!()
    }

    fn read_file(&self, _file: File, _buf: &mut [u8]) -> Result<(), core::fmt::Error> {
        todo!()
    }

    fn write_file(&self, _filename: &str, _file: &File) -> Result<(), core::fmt::Error> {
        todo!()
    }

    fn mount(&self, prefix: &str) {
        // 获取文件树前缀节点
        let filetree = FILETREE.lock();
        if let Ok(filetree_node) = filetree.open(prefix) {
            let filetree_node = filetree_node;
            info!("当前文件树节点：{}", filetree_node.get_pwd());
            if filetree_node.is_dir() && filetree_node.is_empty() {
                self.read_directory(2, &filetree_node);
            }
            
        } else {
            panic!("不存在文件数节点： {}", prefix);
        }
    }
}

/// 目前仅支持挂载文件系统
impl FAT32 {
    // 创建新的FAT32表项 device_id: 为设备id 目前支持文件系统 需要手动读取bpb
    pub fn new(device: Arc<Mutex<Box<dyn BlockDevice>>>) -> Self {
        let fat32 = FAT32 {
            device,
            bpb: Default::default()
        };
        unsafe {
            fat32.read_sector(0, &mut *(&fat32.bpb as *const FAT32BPB as *mut [u8; size_of::<FAT32BPB>()]));
        }
        fat32
    }

    // 读取一个簇
    pub fn read_cluster(&self, cluster_offset: usize, buf: &mut [u8]) {
        let mut start;
        let mut end = 0;
        for i in 0..self.bpb.sectors_per_cluster as usize {
            if end >= buf.len() {
                break;
            }
            start = end;
            end = end + self.bpb.bytes_per_sector as usize;
            if end > buf.len() {
                end = buf.len();
            }
            
            self.read_sector(self.bpb.data_sector() + (cluster_offset - 2) * self.bpb.sectors_per_cluster as usize + i, &mut buf[start..end])
        }
    }

    pub fn read_file_from(&self, buf: &[u8]) -> Option<FileTreeNode> {
        if buf[11] == 0 {
            return None;
        }
        let mut filename = String::new();
        unsafe {
            for i in 0..buf.len()/0x20 {
                match buf[i*0x20 + 11] {
                    0x0f=>{
                        let long_name = &*(buf.as_ptr() as *const u8 as *const FAT32longFileItem);
                        filename = filename + long_name.filename().as_ref();
                    }
                    _=> {
                        let file_item;
                        let file_tree_type;
                        file_item = &*(buf.as_ptr().add(i*0x20) as *const u8 as *const FAT32shortFileItem);
                        if buf.len() == 0x20 {
                            filename = filename + &file_item.filename();
                        }
                        file_tree_type = match file_item.get_attr(){
                            FAT32FileItemAttr::FILE =>FileType::File,
                            FAT32FileItemAttr::RW => todo!(),
                            FAT32FileItemAttr::R => todo!(),
                            FAT32FileItemAttr::HIDDEN => todo!(),
                            FAT32FileItemAttr::SYSTEM => todo!(),
                            FAT32FileItemAttr::VOLUME => todo!(),
                            FAT32FileItemAttr::SUBDIR => FileType::Directory,
                        };
                        return Some(FileTreeNode(Rc::new(RefCell::new(FileTreeNodeRaw{
                            filename: filename,
                            file_type: file_tree_type,
                            parent: Default::default(),
                            children: vec![],
                            size: file_item.file_size(),
                            cluster: file_item.start_cluster()
                        }))))
                    },
                }
            }
        }
        None
    }

    pub fn get_next_cluster(&self, curr_cluster: usize) -> usize {
        let mut buf = vec![0u8; SECTOR_SIZE];
        let sector_offset = curr_cluster / (SECTOR_SIZE / 4);
        let byte_offset = (curr_cluster % (SECTOR_SIZE / 4)) * 4;
        self.read_sector(self.bpb.reserved_sector as usize + sector_offset, &mut buf);
        u32::from_ne_bytes(buf[byte_offset..byte_offset + 4].try_into().unwrap()) as usize
    }

    // 读取文件
    pub fn read(&self, start_cluster: usize, file_size: usize, buf: &mut [u8]) {
        let mut cluster = start_cluster;
        // 文件需要读取的大小
        let size = if file_size < buf.len() {file_size} else {buf.len()};
        
        for i in (0..size).step_by(SECTOR_SIZE) {
            let end = if size < i + SECTOR_SIZE {size} else { i + SECTOR_SIZE};
            info!("{}", i);
            self.read_cluster(cluster, &mut buf[i..end]);
            // 如果不是有效簇 则跳出循环
            if cluster >= 0x0fff_ffef { return; }
            // 如果是有效簇 获取下一个簇地址
            cluster = self.get_next_cluster(cluster);
        }
    }

    pub fn read_directory(&self, start_cluster: usize, filetree_node: &FileTreeNode) {
        let mut buf = vec![0u8; self.bpb.sectors_per_cluster as usize * SECTOR_SIZE];
            let mut cluster = start_cluster;
            
            // 0x0 - 0x0fffffef 为有效簇
            while cluster < 0x0fff_ffef {
                self.read_cluster(cluster, &mut buf);
                
                let mut start;
                let mut end = 0;
                loop {
                    start = end;

                    while buf[end + 11] == 0x0f {
                        end = end + 0x20;
                    }
                    end = end + 0x20;

                    let new_node = self.read_file_from(&buf[start..end]);
                    if let Some(new_node) = new_node {
                        if !(new_node.get_filename() == "." || new_node.get_filename() == "..") {
                            if new_node.is_dir() {                            
                                self.read_directory(new_node.get_cluster(), &new_node);
                            }
                            // 添加到节点
                            filetree_node.add(new_node.clone());
                        }
                        
                    }

                    if end >= self.bpb.sectors_per_cluster as usize * SECTOR_SIZE {
                        break;
                    }
                }
                cluster = self.get_next_cluster(cluster);
            }
    }
}


pub fn init() {
    // let mut buf = vec![0u8; 64];
    unsafe {
        for partition in BLK_CONTROL.get_partitions() {
            let fat32 = partition.lock();
            // info!("数据扇区地址: {:#x}", fat32.bpb.data_sector() << 9);
            // fat32.bpb.info();
            fat32.mount("/");
        }        
    }
}

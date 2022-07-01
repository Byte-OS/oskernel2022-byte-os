use core::{cell::RefCell, mem::size_of, slice, ptr};

use alloc::{sync::Arc, rc::Rc, string::String, boxed::Box};

use crate::{sync::mutex::Mutex, device::{SECTOR_SIZE, BLK_CONTROL, BlockDevice}, fs::{fat32::{long_file::FAT32longFileItem, short_file::FAT32shortFileItem}, filetree::FileTreeNodeRaw}};

use self::{fat32bpb::FAT32BPB, file_trait::FilesystemItemOperator};

use super::{Partition, file::FileType, filetree::{FILETREE, FileTreeNode}};

pub mod fat32bpb;
pub mod short_file;
pub mod file_trait;
pub mod long_file;

#[allow(dead_code)]
#[derive(Clone)]
/// FAT32文件属性
pub enum FAT32FileItemAttr {
    RW  = 0,            // 读写
    R   = 1,            // 只读
    HIDDEN = 1 << 1,    // 隐藏
    SYSTEM = 1 << 2,    // 系统文件
    VOLUME = 1 << 3,    // 卷标
    SUBDIR = 1 << 4,    // 子目录
    FILE   = 1 << 5,    // 归档
}

/// FAT32表
pub struct FAT32 {
    pub device: Arc<Mutex<Box<dyn BlockDevice>>>,   // 设备
    pub bpb: FAT32BPB,                              // bpb
}

impl Partition for FAT32 {
    // 读扇区
    fn read_sector(&self, sector_offset: usize, buf: &mut [u8]) {
        // 创建缓冲区
        let mut output = vec![0; SECTOR_SIZE];
        // 读取扇区信息
        self.device.lock().read_block(sector_offset, &mut output);        
        // 复制到buf
        buf.copy_from_slice(&output[..buf.len()]);
    }

    // 写扇区
    fn write_sector(&self, sector_offset: usize, buf: &mut [u8]) {
        // 创建缓冲区
        let mut input = vec![0; SECTOR_SIZE];
        input.copy_from_slice(&buf);
        // 写入扇区
        self.device.lock().write_block(sector_offset, &mut input);
    }

    // 挂载分区到路径
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

    // 从内存中读取文件
    pub fn read_file_from(&self, buf: &[u8]) -> Option<FileTreeNode> {
        if buf[11] == 0 || buf[0] == 0xe5{
            return None;
        }
        let mut filename = String::new();
        unsafe {
            for i in 0..buf.len()/0x20 {
                match buf[i*0x20 + 11] {
                    0x0f=>{
                        // let long_name = &*(buf.as_ptr() as *const u8 as *const FAT32longFileItem);
                        let long_name = &*((buf.as_ptr() as usize + i*0x20) as *const FAT32longFileItem);
                        filename = long_name.filename() + &filename;
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
                            cluster: file_item.start_cluster(),
                            nlinkes: 1,
                            st_atime_sec: 0,
                            st_atime_nsec: 0,
                            st_mtime_sec: 0,
                            st_mtime_nsec: 0,
                            st_ctime_sec: 0,
                            st_ctime_nsec: 0,
                        }))))
                    },
                }
            }
        }
        None
    }

    // 获取下一个cluster
    pub fn get_next_cluster(&self, curr_cluster: usize) -> usize {
        let mut buf = vec![0u8; SECTOR_SIZE];
        let sector_offset = curr_cluster / (SECTOR_SIZE / 4);
        let byte_offset = (curr_cluster % (SECTOR_SIZE / 4)) * 4;

        self.read_sector(self.bpb.reserved_sector as usize + sector_offset, &mut buf);
        
        u32::from_ne_bytes(buf[byte_offset..byte_offset + 4].try_into().unwrap()) as usize
    }

    // 读取文件
    pub fn read(&self, start_cluster: usize, file_size: usize, buf: &mut [u8]) -> usize {
        let mut cluster = start_cluster;
        // 文件需要读取的大小
        let size = if file_size < buf.len() {file_size} else {buf.len()};
        let cluster_size = SECTOR_SIZE * self.bpb.sectors_per_cluster as usize;
        
        for i in (0..size).step_by(cluster_size) {
            let end = if size < i + cluster_size {size} else { i + cluster_size};
            self.read_cluster(cluster, &mut buf[i..end]);
            // 如果不是有效簇 则跳出循环
            if cluster >= 0x0fff_ffef { return size; }
            // 如果是有效簇 获取下一个簇地址
            cluster = self.get_next_cluster(cluster);
        }
        size
    }

    // 输出文件系统信息
    pub fn info(&self) {
        info!("每簇扇区数: {}", self.bpb.sectors_per_cluster);
        info!("FAT表地址: {:#x}", self.bpb.reserved_sector as usize * 512);
        info!("FAT表大小: {:#x}", self.bpb.sectors_per_fat as usize * 512);
    }

    // 读取文件夹
    pub fn read_directory(&self, start_cluster: usize, filetree_node: &FileTreeNode) {
        // 创建缓冲区 缓冲区大小为一个簇(cluster)
        let mut buf = vec![0u8; self.bpb.sectors_per_cluster as usize * SECTOR_SIZE];
        let mut cluster = start_cluster;

        // 文件项读取Buf
        let mut file_item_buf = FileItemBuf::new();

        while cluster < 0x0fff_ffef {
            self.read_cluster(cluster, &mut buf);
            
            let mut start = 0;
            // TODO: add new buf, resolving the possible problem that index out of bound
            loop {
                if start >= self.bpb.sectors_per_cluster as usize * SECTOR_SIZE {
                    break;
                }
                file_item_buf.push(&buf[start..start+0x20]);
                if file_item_buf.is_end() {
                    // 如果是结束项 则进行读取
                    let new_node = self.read_file_from(file_item_buf.get());
                    if let Some(new_node) = new_node {
                        if !(new_node.get_filename() == "." || new_node.get_filename() == "..") {
                            if new_node.is_dir() {                            
                                self.read_directory(new_node.get_cluster(), &new_node);
                            }
                            // 添加到节点
                            filetree_node.add(new_node.clone());
                        }
                    }
                    file_item_buf.init();
                }
                start += 0x20;
            }

            cluster = self.get_next_cluster(cluster);
        }
        
        // 0x0 - 0x0fffffef 为有效簇
        // while cluster < 0x0fff_ffef {
        //     self.read_cluster(cluster, &mut buf);
            
        //     let mut start;
        //     let mut end = 0;
        //     // TODO: add new buf, resolving the possible problem that index out of bound
        //     loop {
        //         start = end;

        //         while buf[end + 11] == 0x0f {
        //             end = end + 0x20;
        //         }
        //         end = end + 0x20;

        //         let new_node = self.read_file_from(&buf[start..end]);
        //         if let Some(new_node) = new_node {
        //             if !(new_node.get_filename() == "." || new_node.get_filename() == "..") {
        //                 if new_node.is_dir() {                            
        //                     self.read_directory(new_node.get_cluster(), &new_node);
        //                 }
        //                 // 添加到节点
        //                 filetree_node.add(new_node.clone());
        //             }
                    
        //         }

        //         if end >= self.bpb.sectors_per_cluster as usize * SECTOR_SIZE {
        //             break;
        //         }
        //     }

        //     cluster = self.get_next_cluster(cluster);
        // }
    }

    // 获取最后一个fat
    #[allow(unused)]
    pub fn get_last_cluster(&self, start_cluster: usize) -> usize {
        let mut cluster = start_cluster;
        loop {
            let next_cluster = self.get_next_cluster(cluster);
            if cluster >= 0x0fff_ffef {
                break;
            }
            cluster = next_cluster;
        }
        cluster
    }

    // 改变fat表中的cluster指向
    #[allow(unused)]
    pub fn change_fat_cluster(&self, cluster: usize, value: usize) {
        let mut buf = vec![0u8; SECTOR_SIZE];
        let sector_offset = cluster / (SECTOR_SIZE / 4);
        let byte_offset = (cluster % (SECTOR_SIZE / 4)) * 4;

        self.read_sector(self.bpb.reserved_sector as usize + sector_offset, &mut buf);
        buf[byte_offset..byte_offset + 4].clone_from_slice(&u32::to_ne_bytes(value as u32));
    }

    // 申请cluster
    #[allow(unused)]
    pub fn alloc_cluster(&self) -> Option<usize> {
        let mut buf = vec![0u32; SECTOR_SIZE / 4];

        for i in 0..self.bpb.sectors_per_fat as usize {
            // 读取fat表到buf中
            self.read_sector(self.bpb.reserved_sector as usize + i, unsafe {
                slice::from_raw_parts_mut(buf.as_mut_ptr() as *mut u8, SECTOR_SIZE)
            });
            // 遍历扇区中的cluster
            for offset in 0..buf.len() {
                if buf[offset] == 0 {
                    return Some(i * (SECTOR_SIZE / 4) + offset + 2);
                }
            }
        }
        None
    }
}

// 初始化分区
pub fn init() {
    unsafe {
        for partition in BLK_CONTROL.get_partitions() {
            let fat32 = partition.lock();
            // 输出分区信息
            fat32.info();
            // 挂载分区
            fat32.mount("/");
        }        
    }
}

const FILE_ITEM_BUF_SIZE: usize = 0x100;

pub struct FileItemBuf {
    pointer: usize,
    buf: [u8; FILE_ITEM_BUF_SIZE]
}

impl FileItemBuf {
    pub fn new() -> Self {
        FileItemBuf {
            pointer: 0,
            buf: [0;FILE_ITEM_BUF_SIZE]
        }
    }

    pub fn init(&mut self) {
        self.pointer = 0
    }

    // add items, return new size that buf used
    pub fn push(&mut self, buf: &[u8]) -> usize {
        let new_pointer = self.pointer + buf.len();
        // 判断数组是否越界
        if new_pointer > FILE_ITEM_BUF_SIZE {
            panic!("FileItemBuf数组越界");
        }
        self.buf[self.pointer..new_pointer].copy_from_slice(buf);
        self.pointer = new_pointer;
        new_pointer
    }

    // get items buf
    pub fn get(&self) -> &[u8] {
        &self.buf[..self.pointer]
    }

    pub fn is_end(&self) -> bool { 
        self.buf[self.pointer - 0x20 + 11] != 0xf
    }
}
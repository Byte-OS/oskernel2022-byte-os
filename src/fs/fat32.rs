use core::mem::size_of;

use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use crate::device::BLK_CONTROL;

struct FAT32 {
    device_id: usize,
    fat32bpb: FAT32BPB
}

#[repr(packed)]
pub struct FAT32BPB {
    jmpcode: [u8; 3],       // 跳转代码
    oem: [u8; 8],           // oem 信息
    bytes_per_sector: u16,  // 每扇区字节数
    sectors_per_cluster: u8,// 每簇扇区数
    reserved_sector: u16,   // 保留扇区数 第一个FAT之前的扇区数 包含引导扇区
    fat_number: u8,         // fat表数量
    root_entries: u16,      // 根目录项数 FAT32必须为0
    small_sector: u16,      // 小扇区区数 FAT32必须为0
    media_descriptor: u8,   // 媒体描述符 0xF8标识硬盘 0xF0表示3.5寸软盘
    sectors_per_fat: u16,   // 每FAT扇区数
    sectors_per_track: u16, // 每道扇区数
    number_of_head: u16,    // 磁头数
    hidden_sector: u32,     // 隐藏扇区数
    large_sector: u32,      // 总扇区数
}


impl FAT32 {
    
}

pub fn init() {
    let mut buf = vec![0u8; size_of::<FAT32BPB>()];
    unsafe {
        BLK_CONTROL.read_one_sector(0, 0, &mut buf);
        // for i in buf {
        //     info!("{:#x}", i);
        // }   
        info!("缓冲区地址:{:#x}", buf.as_mut_ptr() as usize);
        let ref fat_header = *(buf.as_mut_ptr() as *mut u8 as *mut FAT32BPB);
        info!("fat_header address: {:#x}", fat_header as *const _ as usize);
        info!("size of :{}", size_of::<FAT32BPB>());
        info!("变量地址:{:#x}", &(fat_header.jmpcode) as *const _ as usize);
        info!("磁盘大小:{}", fat_header.large_sector * fat_header.bytes_per_sector as u32);
        info!("FAT表数量:{}, 占扇区:{}, 占空间:{:#x}", fat_header.fat_number, fat_header.fat_number as u16 * fat_header.sectors_per_fat, fat_header.fat_number as u32 * fat_header.sectors_per_fat as u32 * fat_header.bytes_per_sector as u32);
        info!("保留扇区数: {}, 地址: {:#x}", fat_header.reserved_sector, fat_header.reserved_sector * 512);
        info!("数据扇区地址: {:#x}", (fat_header.reserved_sector + fat_header.fat_number as u16 * fat_header.sectors_per_fat) as u32 * fat_header.bytes_per_sector as u32);
        info!("OEM信息:{}", String::from_utf8_lossy(&fat_header.oem));
        info!("根目录数量: {:?}", fat_header.jmpcode);

        // let fat_header: FAT32BPB = unsafe {
            
        // };
    }
}
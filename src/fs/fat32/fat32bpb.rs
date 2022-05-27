use alloc::string::String;

#[allow(dead_code)]
#[derive(Default)]
#[repr(packed)]
pub struct FAT32BPB {
    pub jmpcode: [u8; 3],       // 跳转代码
    pub oem: [u8; 8],           // oem 信息
    pub bytes_per_sector: u16,  // 每扇区字节数
    pub sectors_per_cluster: u8,// 每簇扇区数
    pub reserved_sector: u16,   // 保留扇区数 第一个FAT之前的扇区数 包含引导扇区
    pub fat_number: u8,         // fat表数量
    pub root_entries: u16,      // 根目录项数 FAT32必须为0
    pub small_sector: u16,      // 小扇区区数 FAT32必须为0
    pub media_descriptor: u8,   // 媒体描述符 0xF8标识硬盘 0xF0表示3.5寸软盘
    pub _sectors_per_fat: u16,  // 每FAT扇区数, 只被FAT12/和FAT16使用 对于FAT32必须设置位0
    pub sectors_per_track: u16, // 每道扇区数
    pub number_of_head: u16,    // 磁头数
    pub hidden_sector: u32,     // 隐藏扇区数
    pub large_sector: u32,      // 总扇区数
    pub sectors_per_fat: u32,   // 每FAT扇区数 只被FAT32使用
    pub extended_flag: u16,     // 扩展标志 只被fat32使用
    pub filesystem_version: u16,// 文件系统版本
    pub root_cluster_numb: u32, // 根目录簇号 只被FAT32使用 根目录第一簇的簇号 一般为2
    pub info_sector_numb: u16,  // 文件系统信息扇区号 只被fat32使用
    pub backup_boot_sector: u16,// 备份引导扇区
    pub reserved_sector1: [u8;12]   // 系统保留
}

impl FAT32BPB {
    // 获取数据扇区号
    pub fn data_sector(&self) -> usize {
        (self.reserved_sector as u32 + self.fat_number as u32 * self.sectors_per_fat) as usize
    }

    // 输出fat32信息
    #[allow(unused)]
    pub fn info(&self) {
        info!("扇区大小: {}", self.bytes_per_sector);
        info!("磁盘大小:{} bytes", self.large_sector * self.bytes_per_sector as u32);
        info!("FAT表数量:{}, 占扇区:{}, {:#x}", self.fat_number, self.fat_number as u32 * self.sectors_per_fat, &self.sectors_per_fat as *const u32 as usize - self as *const FAT32BPB as usize);
        info!("FAT表位置: {:#x}", (self.hidden_sector as usize) << 9);
        info!("保留扇区数: {}, 地址: {:#x}", self.reserved_sector, self.reserved_sector * 512);
        info!("数据扇区: {:#x}", self.data_sector());
        info!("OEM信息:{}", String::from_utf8_lossy(&self.oem));
        info!("根目录数量: {:?}", self.jmpcode);
        info!("每簇扇区数: {:#x}", self.sectors_per_cluster);
        info!("隐藏扇区数: {:#x}", self.hidden_sector);
    }
}

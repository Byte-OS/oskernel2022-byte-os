mod fat32;
mod file;
mod partition;
mod filetree;

pub fn init() {
    fat32::init();
}
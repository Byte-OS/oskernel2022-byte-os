mod fat32;
mod file;
mod partition;
mod filetree;

pub use filetree::get_file_tree;

pub use partition::Partition;

pub fn init() {
    // fat32::init();
}
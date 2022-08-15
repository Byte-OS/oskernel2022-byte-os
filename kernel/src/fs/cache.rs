use alloc::rc::Rc;
use hashbrown::HashMap;

use crate::{sync::mutex::Mutex, fs::file::File};

use super::{filetree::INode, file::FileOP};

lazy_static! {
    pub static ref CACHE_FILES: Mutex<HashMap<&'static str, Rc<File>>> = Mutex::new(HashMap::new());
}

#[allow(unused)]
pub fn cache_file(filename: &'static str) {
    let inode = INode::get(None, &filename).unwrap();
    info!("缓冲文件: {}", filename);
    CACHE_FILES.force_get().insert(filename, File::cache(inode).unwrap());
}

pub fn get_cache_file(filename: &str) -> Option<Rc<File>> {
    match CACHE_FILES.force_get().get(filename) {
        Some(file) => {
            file.lseek(0, 0);
            Some(file.clone())
        },
        None => None
    }
}

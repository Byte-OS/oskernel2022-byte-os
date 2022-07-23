use alloc::rc::Rc;
use hashbrown::HashMap;

use crate::{sync::mutex::Mutex, fs::file::File};

use super::filetree::INode;

lazy_static! {
    pub static ref CACHE_FILES: Mutex<HashMap<&'static str, Rc<File>>> = Mutex::new(HashMap::new());
}

pub fn cache_file(filename: &'static str) {
    let inode = INode::get(None, &filename, false).unwrap();
    debug!("缓冲: {}", filename);
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
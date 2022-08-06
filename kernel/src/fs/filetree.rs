
use core::cell::RefCell;

use alloc::{string::{String, ToString}, vec::Vec, rc::{Rc, Weak}};
use fatfs::{Read, Write};

use crate::{device::{DiskFile, FileSystem, Dir}, runtime_err::RuntimeError};

use super::{file::{FileType, File}, cache::get_cache_file};


pub static mut FILE_TREE: Option<Rc<INode>> = None;

pub enum DiskFileEnum {
    DiskFile(DiskFile),
    DiskDir(Dir),
    None
}

// 文件树原始树
pub struct INodeInner {
    pub filename: String,               // 文件名
    pub file_type: FileType,            // 文件数类型
    pub parent: Option<Weak<INode>>,    // 父节点
    pub children: Vec<Rc<INode>>,       // 子节点
    pub file: DiskFileEnum              // 硬盘文件
}

pub struct INode(pub RefCell<INodeInner>);

impl INode {
    // 创建文件 创建文件时需要使用文件名
    pub fn new(filename: String, file: DiskFileEnum, 
            file_type: FileType, parent: Option<Weak<INode>>) -> Rc<Self> {
        Rc::new(Self(RefCell::new(INodeInner {
            filename, 
            file_type, 
            parent, 
            children: vec![],
            file
        })))
    }

    // 根目录节点
    pub fn root() -> Rc<INode> {
        unsafe {
            if let Some(data) = &FILE_TREE {
                return data.clone();
            };
            todo!("无法在为初始化之前调用root")
        }
    }

    // 添加节点到父节点
    pub fn add(self: Rc<Self>, child: Rc<INode>) {
        let mut inner = self.0.borrow_mut();
        let mut cinner = child.0.borrow_mut();
        cinner.parent = Some(Rc::downgrade(&self));
        drop(cinner);
        inner.children.push(child);
    }

    pub fn get_children(self: Rc<Self>, filename: &str) -> Result<Rc<INode>, RuntimeError> {
        match filename {
            "."     => Ok(self.clone()),
            ".."    => {
                let inner = self.0.borrow_mut();
                match inner.parent.clone() {
                    Some(parent) => {
                        match parent.upgrade() {
                            Some(p) => Ok(p.clone()),
                            None => Ok(self.clone())
                        }
                    },
                    None => {
                        Ok(self.clone())
                    }
                }
            },
            name => {
                for child in self.clone_children() {
                    if child.get_filename() == filename {
                        return Ok(child.clone());
                    }
                }
                Err(RuntimeError::FileNotFound)
            }
        }
    }

    pub fn find(self: Rc<Self>, path: &str) -> Result<Rc<INode>, RuntimeError> {
        // traverse path
        let (name, rest_opt) = split_path(path);
        if let Some(rest) = rest_opt {
            // 如果是文件夹
            self.get_children(name)?.find(rest)
        } else {
            self.get_children(name)
        }
    }

    // 根据路径 获取文件节点
    pub fn get(current: Option<Rc<INode>>, path: &str) -> Result<Rc<INode>, RuntimeError> {
        // 如果有节点
        if let Some(node) = current {
            node.get_children(path)
        } else {
            Self::root().get_children(path)
        }
    }

    // 根据路径 获取文件节点
    pub fn open(current: Option<Rc<INode>>, path: &str) -> Result<Rc<File>, RuntimeError> {
        let inode = Self::get(current, path)?;
        if let Some(file) = get_cache_file(&inode.get_filename()) {
            return Ok(file.clone());
        }
        File::new(inode)
    }

    // 获取当前路径
    pub fn get_pwd(&self) -> String {
        let tree_node = self.clone();
        let mut path = String::new();
        loop {
            path = path + "/" + &tree_node.get_filename();
            if self.is_root() { break; }
        }
        path
    }

    // 判断当前是否为根目录
    pub fn is_root(&self) -> bool {
        // 根目录文件名为空
        self.0.borrow().parent.is_none()
    }

    // 判断是否为目录
    pub fn is_dir(&self) -> bool {
        match self.0.borrow().file_type {
            FileType::Directory => true,
            _ => false
        }
    }

    // 获取文件名
    pub fn get_filename(&self) -> String{
        self.0.borrow_mut().filename.clone()
    }

    // 获取子元素
    pub fn clone_children(&self) -> Vec<Rc<INode>> {
        self.0.borrow().children.clone()
    }

    // 判断是否为空
    pub fn is_empty(&self) -> bool {
        self.0.borrow_mut().children.is_empty()
    }

    // 删除子节点
    pub fn delete(&self, filename: &str) {
        self.0.borrow_mut().children.retain(|c| c.get_filename() != filename);
    }

    // 获取文件大小
    pub fn get_file_size(&self) -> usize {
        match self.0.borrow_mut().file {
            DiskFileEnum::DiskFile(f) => f.size().unwrap() as usize,
            _ => 0
        }
    }

    // 获取文件类型
    pub fn get_file_type(&self) -> FileType {
        self.0.borrow_mut().file_type
    }

    // 读取文件内容
    pub fn read(&self) -> Vec<u8> {
        let mut file_vec = vec![0u8; self.get_file_size()];
        self.0.borrow_mut().file.read_exact(&mut file_vec);
        file_vec
    }
    
    // 读取文件内容
    pub fn read_to(&self, buf: &mut [u8]) -> usize  {
        // 不再处理虚拟文件
        self.0.borrow_mut().file.read_exact(buf);
        buf.len()
    }

    // 写入设备
    pub fn write(&self, buf: &mut [u8]) -> usize {
        self.0.borrow_mut().file.write(buf).unwrap()
    }

    // 创建文件夹
    pub fn mkdir(current: Option<Rc<INode>>, path: &str, _flags: u16) -> Result<Rc<INode>, RuntimeError>{
        Self::get(current, path)
    }

    // 删除自身
    pub fn del_self(&self) {
        let inner = self.0.borrow_mut();
        let parent = inner.parent.clone();
        if let Some(parent) = parent {
            let parent = parent.upgrade().unwrap();
            let filename = inner.filename.clone();
            drop(inner);
            parent.delete(&filename);
        }
    }

    // 删除自身
    pub fn is_valid(&self) -> bool {
        let inner = self.0.borrow_mut();
        let parent = inner.parent.clone();
        if let Some(parent) = parent {
            parent.upgrade().is_some()
        } else {
            false
        }
    }
}

fn split_path(path: &str) -> (&str, Option<&str>) {
    let trimmed_path = path.trim_matches('/');
    trimmed_path.find('/').map_or((trimmed_path, None), |n| {
        (&trimmed_path[..n], Some(&trimmed_path[n + 1..]))
    })
}

// pub fn mount(path: &str, root_dir: Dir) {
//     for i in root_dir.iter() {
//         let file = i.unwrap();
//         if file.is_dir() {
//             // 如果是文件夹的话进行 深度遍历
//             mount(&(path.to_string() + &file.file_name() + "/"), file.to_dir());
//         } else {
//             // 如果是文件的话则进行挂载
//             INode::new(filename, file, file_type, parent)
//         }
//     }
// }

pub fn init(path: &str, root_dir: Dir) {

}
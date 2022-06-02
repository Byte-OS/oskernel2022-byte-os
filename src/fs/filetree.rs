
use core::cell::RefCell;

use alloc::{string::{String, ToString}, vec::Vec, sync::Arc, rc::Rc};

use crate::sync::mutex::Mutex;

use super::file::{FileItem, FileType};

pub struct FileTree(FileTreeNode);

lazy_static! {
    // 文件树初始化
    pub static ref FILETREE: Arc<Mutex<FileTree>> = Arc::new(Mutex::new(FileTree(FileTreeNode(
        Rc::new(RefCell::new(FileTreeNodeRaw { 
            filename: "".to_string(), 
            file_type: FileType::Directory, 
            parent: None, 
            children: vec![],
            size: 0,
            cluster: 2
        }))
    ))));
}

impl FileTree {
    // 根据路径 获取文件节点 从根目录读取即为绝对路径读取
    pub fn open(&self, path: &str) -> Result<FileTreeNode, &str> {
        self.0.open(path)
    }

    pub fn create(&mut self, filename: &str) {
        self.0.create(filename)
    }

    // 卸载设备
    pub fn umount(&self, device: &str, _flags: usize) {

    }

    // 挂载设备
    pub fn mount(&self, device: &str, dir: &str, fs_type: usize, flags: usize, data: usize) {

    }
}

// 文件树原始树
pub struct FileTreeNodeRaw {
    pub filename: String,               // 文件名
    pub file_type: FileType,            // 文件数类型
    pub parent: Option<FileTreeNode>,   // 父节点
    pub children: Vec<FileTreeNode>,    // 子节点
    pub cluster: usize,                 // 开始簇
    pub size: usize                     // 文件大小
}


#[derive(Clone)]
pub struct FileTreeNode(pub Rc<RefCell<FileTreeNodeRaw>>);

impl FileTreeNode {
    pub fn new_device(filename: &str) -> Self {
        FileTreeNode(Rc::new(RefCell::new(FileTreeNodeRaw {
            filename:String::from(filename),        // 文件名
            file_type: FileType::Device,            // 文件数类型
            parent: None,                           // 父节点
            children: vec![],                       // 子节点
            cluster: 0,                             // 开始簇
            size: 0                                 // 文件大小
        })))
    }
    
    // 根据路径 获取文件节点
    pub fn open(&self, path: &str) -> Result<FileTreeNode, &str> {
        let mut tree_node = self.clone();
        let location: Vec<&str> = path.split("/").collect();
        for locate in location {
            match locate {
                ".."=> {        // 如果是.. 则返回上一级
                    if !tree_node.is_root() {
                        tree_node = tree_node;
                    }
                },
                "."=> {}        // 如果是. 则不做处理
                ""=> {}         // 空，不做处理 出现多个// 复用的情况
                _ => {          // 默认情况则搜索
                    let mut sign = false;
                    // 遍历名称
                    for node in tree_node.get_children() {
                        // info!("文件夹内容:{} 长度:{} 需要匹配:{} 长度:{}", node.get_filename(), node.get_filename().len(), locate, locate.len());
                        if node.get_filename() == locate {
                            tree_node = node.clone();
                            sign = true;
                            break;
                        }
                    }
                    if !sign {
                        return Err("文件不存在");
                    }
                }
            }
        }
        Ok(tree_node)
    }

    // 获取当前路径
    pub fn get_pwd(&self) -> String {
        // 如果是根目录 则直接返回 / 作为路径
        if self.is_root() {
            return "/".to_string();
        }
        // 如果不是根目录 则遍历得到路径
        let mut tree_node = self.clone();
        let mut path = String::new();
        // 如果不为根目录 则一直添加路径
        while !self.is_root() {
            path = path + "/" + &tree_node.get_filename();
            if let Some(parent) = tree_node.get_parent() {
                tree_node = parent;
            } else {
                break;
            }
            // tree_node = tree_node.get_parent().unwrap();
        }
        path
    }

    // 判断当前是否为根目录
    pub fn is_root(&self) -> bool {
        self.0.borrow_mut().filename == ""
        // self.0.borrow_mut().parent.is_none()
    }

    // 判断是否为目录
    pub fn is_dir(&self) -> bool {
        match self.0.borrow_mut().file_type {
            FileType::Directory => {
                true
            },
            _ => {
                false
            }
        }
    }

    // 获取文件名
    pub fn get_filename(&self) -> String{
        self.0.borrow_mut().filename.clone()
    }

    // 获取子元素
    pub fn get_children(&self) -> Vec<FileTreeNode> {
        self.0.borrow_mut().children.clone()
    }

    // 获取父元素
    pub fn get_parent(&self) -> Option<FileTreeNode> {
        self.0.borrow_mut().parent.clone()
    }

    // 判断是否为空
    pub fn is_empty(&self) -> bool {
        self.0.borrow_mut().children.is_empty()
    }

    // 添加节点
    pub fn add(&self, node: FileTreeNode) {
        let mut curr_node = self.0.borrow_mut();
        curr_node.children.push(node);
        curr_node.parent = Some(self.clone());
    }

    // 获取簇位置
    pub fn get_cluster(&self) -> usize {
        self.0.borrow_mut().cluster
    }

    // 获取文件大小
    pub fn get_file_size(&self) -> usize {
        self.0.borrow_mut().size
    }

    pub fn get_file_type(&self) -> FileType {
        self.0.borrow_mut().file_type
    }

    // 判断是否为设备文件
    pub fn is_device(&self) -> bool {
        self.0.borrow().file_type == FileType::Device
    }

    // 创建文件
    pub fn create(&mut self, filename: &str) {
        let new_node = FileTreeNode(Rc::new(RefCell::new(FileTreeNodeRaw {
            filename:String::from(filename),        // 文件名
            file_type: FileType::File,            // 文件数类型
            parent: None,                           // 父节点
            children: vec![],                       // 子节点
            cluster: 0,                             // 开始簇
            size: 0                                 // 文件大小
        })));
        self.add(new_node);
    }

    // 到文件
    pub fn to_file(&self) -> FileItem {
        FileItem { 
            device_id: 0,
            filename: self.get_filename(), 
            start_cluster: self.get_cluster(), 
            size: self.get_file_size(), 
            flag: self.get_file_type()
        }
    }

    pub fn mkdir(&mut self, filename: &str, flags: u16) {
        let node = FileTreeNode(Rc::new(RefCell::new(FileTreeNodeRaw {
            filename:String::from(filename),        // 文件名
            file_type: FileType::Directory,         // 文件数类型
            parent: None,                           // 父节点
            children: vec![],                       // 子节点
            cluster: 0,                             // 开始簇
            size: 0                                 // 文件大小
        })));
        let mut curr_node = self.0.borrow_mut();
        curr_node.children.push(node);
        curr_node.parent = Some(self.clone());
    }
}
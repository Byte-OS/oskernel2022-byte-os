
use core::{cell::RefCell};

use alloc::{string::{String, ToString}, vec::Vec, sync::Arc, rc::Rc};

use crate::sync::mutex::Mutex;

use super::file::File;

pub struct FileTree(FileTreeNode);

lazy_static! {
    // 文件树初始化
    pub static ref FILETREE: Arc<Mutex<FileTree>> = Arc::new(Mutex::new(FileTree(FileTreeNode(
        Rc::new(RefCell::new(FileTreeNodeRaw { 
            filename: "".to_string(), 
            file_type: FileTreeType::Directory, 
            parent: None, 
            children: vec![],
            cluster: 2
        }))
    ))));
}

impl FileTree {
    // 根据路径 获取文件节点 从根目录读取即为绝对路径读取
    pub fn open(&self, path: &str) -> Result<FileTreeNode, &str> {
        self.0.open(path)
    }
}

// 文件类型
#[allow(dead_code)]
#[derive(Default)]
pub enum FileTreeType {
    File,           // 文件
    Directory,      // 文件夹
    Device,         // 设备
    Pipline,        // 管道
    #[default]
    None            // 空
}

// 文件树原始树
pub struct FileTreeNodeRaw {
    pub filename: String,               // 文件名
    pub file_type: FileTreeType,        // 文件数类型
    pub parent: Option<FileTreeNode>,   // 父节点
    pub children: Vec<FileTreeNode>,     // 子节点
    pub cluster: usize
}


#[derive(Clone)]
pub struct FileTreeNode(pub Rc<RefCell<FileTreeNodeRaw>>);

impl FileTreeNode {
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
            tree_node = tree_node.get_parent().unwrap();
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
            FileTreeType::Directory => {
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

    // 到文件
    pub fn to_file(&self) -> File {
        // File { 
        //     fat32: (), 
        //     filename: (), 
        //     start_cluster: (), 
        //     block_idx: (), 
        //     open_cnt: (), 
        //     size: (), 
        //     flag: () 
        // }
        todo!()
    }
}
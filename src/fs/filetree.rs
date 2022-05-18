
use alloc::{string::{String, ToString}, vec::Vec};

pub struct FileTree(FileTreeNode);

lazy_static! {
    // 文件树初始化
    pub static ref FILETREE: FileTree = FileTree(FileTreeNode { 
        filename: "".to_string(), 
        file_type: FileTreeType::Directory, 
        parent: None, 
        children: vec![] 
    });
}

impl FileTree {
    // 根据路径 获取文件节点 从根目录读取即为绝对路径读取
    pub fn open(&self, path: &str) -> Result<&FileTreeNode, &str> {
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

pub struct FileTreeNode {
    pub filename: String,           // 文件名
    pub file_type: FileTreeType,    // 文件数类型
    pub parent: Option<&'static FileTreeNode>,       // 父节点
    pub children: Vec<&'static FileTreeNode> // 子节点
}

impl FileTreeNode {
    // 根据路径 获取文件节点
    pub fn open(&self, path: &str) -> Result<&FileTreeNode, &str> {
        let mut tree_node = self;
        let location: Vec<&str> = path.split("/").collect();
        for locate in location {
            match locate {
                ".."=> {        // 如果是.. 则返回上一级
                    if !tree_node.is_root() {
                        tree_node = tree_node.parent.unwrap();
                    }
                },
                "."=> {}        // 如果是. 则不做处理
                ""=> {}         // 空，不做处理 出现多个// 复用的情况
                _ => {          // 默认情况则搜索
                    let mut sign = false;
                    // 遍历名称
                    for node in &tree_node.children {
                        if node.filename == locate {
                            tree_node = node;
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
        let mut tree_node = self;
        let mut path = String::new();
        // 如果不为根目录 则一直添加路径
        while !self.is_root() {
            path = path + "/" + &tree_node.filename;
            tree_node = tree_node.parent.unwrap();
        }
        path
    }

    // 判断当前是否为根目录
    pub fn is_root(&self) -> bool {
        self.parent.is_none()
        // self.filename == ""
    }
}

pub fn get_file_tree() -> &'static FileTree {
    &FILETREE
}

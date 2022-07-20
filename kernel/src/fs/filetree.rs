
use core::{cell::RefCell, slice};

use alloc::{string::{String, ToString}, vec::Vec, rc::{Rc, Weak}};

use crate::{sync::mutex::Mutex, device::BLK_CONTROL, memory::addr::PAGE_SIZE, runtime_err::RuntimeError};

use super::file::{FileType, File};


lazy_static! {
    // 文件树初始化
    pub static ref FILE_TREE: Mutex<Rc<INode>> = Mutex::new(INode::new("", FileType::Directory, None, 2));
}

// 文件树原始树
pub struct INodeInner {
    pub filename: String,               // 文件名
    pub file_type: FileType,            // 文件数类型
    pub parent: Option<Weak<INode>>, // 父节点
    pub cluster: usize,                 // 开始簇
    pub size: usize,                    // 文件大小
    pub nlinkes: u64,                   // 链接数量
    pub st_atime_sec: u64,              // 最后访问秒
	pub st_atime_nsec: u64,             // 最后访问微秒
	pub st_mtime_sec: u64,              // 最后修改秒
	pub st_mtime_nsec: u64,             // 最后修改微秒
	pub st_ctime_sec: u64,              // 最后创建秒
	pub st_ctime_nsec: u64,             // 最后创建微秒
    pub children: Vec<Rc<INode>>,       // 子节点
}

pub struct INode(pub RefCell<INodeInner>);

impl INode {
    // 创建文件
    pub fn new(name: &str, file_type: FileType, parent: Option<Weak<INode>>, cluster: usize) -> Rc<Self> {
        Rc::new(Self(RefCell::new(INodeInner {
            filename: name.to_string(), 
            file_type, 
            parent, 
            children: vec![],
            size: 0,
            cluster,
            nlinkes: 1,
            st_atime_sec: 0,
            st_atime_nsec: 0,
            st_mtime_sec: 0,
            st_mtime_nsec: 0,
            st_ctime_sec: 0,
            st_ctime_nsec: 0,
        })))
    }

    // 根目录节点
    pub fn root() -> Rc<INode> {
        FILE_TREE.force_get().clone()
    }

    // 添加节点到父节点
    pub fn add(self: Rc<Self>, child: Rc<INode>) {
        let mut inner = self.0.borrow_mut();
        let mut cinner = child.0.borrow_mut();
        cinner.parent = Some(Rc::downgrade(&self));
        drop(cinner);
        inner.children.push(child);
    }

    // 根据路径 获取文件节点
    pub fn get(current: Option<Rc<INode>>, path: &str, create_sign: bool) -> Result<Rc<INode>, RuntimeError> {
        let mut current = match current {
            Some(tree) => tree.clone(),
            None => Self::root()
        };
        if path.len() == 0 { return Ok(current); }

        if path.chars().nth(0).unwrap() == '/' {
            current = Self::root();
        }
        // 分割文件路径
        let location: Vec<&str> = path.split("/").collect();
        
        // 根据路径匹配文件
        for locate in location {
            current = match locate {
                ".."=> {        // 如果是.. 则返回上一级
                    let inner = current.0.borrow_mut();
                    match &inner.parent {
                        Some(parent) => {
                            Ok(parent.upgrade().unwrap())
                        }, 
                        None => Ok(current.clone())
                    }
                },
                "."=> Ok(current),        // 如果是. 则不做处理
                ""=> Ok(current),         // 空，不做处理 出现多个// 复用的情况
                _ => {          // 默认情况则搜索
                    // 遍历名称
                    for node in current.get_children() {
                        if node.get_filename() == locate {
                            return Ok(node);
                        }
                    }
                    if create_sign {
                        let node = Self::new(locate, FileType::Directory, 
                            Some(Rc::downgrade(&current)), 0);
                        Self::add(current, node.clone());
                        Ok(node.clone())
                    } else {
                        Err(RuntimeError::FileNotFound)
                    }
                }
            }?;
        }
        Ok(current)
    }

    // 根据路径 获取文件节点
    pub fn open(current: Option<Rc<INode>>, path: &str, create_sign: bool) -> Result<Rc<File>, RuntimeError> {
        let inode = Self::get(current, path, create_sign)?;
        Ok(File::new(inode))
    }

    // 获取当前路径
    pub fn get_pwd(&self) -> String {
        let mut tree_node = self.clone();
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
    pub fn get_children(&self) -> Vec<Rc<INode>> {
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

    // 获取簇位置
    pub fn get_cluster(&self) -> usize {
        self.0.borrow_mut().cluster
    }

    // 获取文件大小
    pub fn get_file_size(&self) -> usize {
        self.0.borrow_mut().size
    }

    // 获取文件类型
    pub fn get_file_type(&self) -> FileType {
        self.0.borrow_mut().file_type
    }

    // 读取文件内容
    pub fn read(&self) -> Vec<u8> {
        let mut file_vec = vec![0u8; self.get_file_size()];
        unsafe {
            BLK_CONTROL.get_partition(0).lock().read(self.get_cluster(), self.get_file_size(), &mut file_vec);
        }
        file_vec
    }
    
    // 读取文件内容
    pub fn read_to(&self, buf: &mut [u8]) -> usize  {
        match self.get_file_type() {
            // 虚拟文件处理
            FileType::VirtFile => {
                let len = if self.get_file_size() > buf.len() { buf.len() } else { self.get_file_size() };
                let target = unsafe {
                    slice::from_raw_parts_mut(self.get_cluster() as *mut u8, PAGE_SIZE)
                };
                buf[..len].copy_from_slice(&target[0..len]);
                len
            }
            _=> {
                unsafe {
                    BLK_CONTROL.get_partition(0).lock().read(self.get_cluster(), self.get_file_size(), buf)
                }
            }
        }
    }

    // 写入设备
    pub fn write(&self, buf: &mut [u8]) -> usize {
        match self.get_file_type() {
            // 虚拟文件处理
            FileType::VirtFile => {
                let target = unsafe {
                    slice::from_raw_parts_mut(self.get_cluster() as *mut u8, PAGE_SIZE)
                };
                target[0..buf.len()].copy_from_slice(buf);
                self.0.borrow_mut().size = buf.len();
                buf.len()
            }
            _=> {
                error!("暂未支持写入的文件格式");
                0
            }
        }
    }

    // 创建文件夹
    pub fn mkdir(current: Option<Rc<INode>>, path: &str, _flags: u16) -> Result<Rc<INode>, RuntimeError>{
        Self::get(current, path, true)
    }

    // 删除自身
    pub fn del_self(&self) {
        let inner = self.0.borrow_mut();
        let parent = inner.parent.clone();
        if let Some(parent) = parent {
            let parent = parent.upgrade().unwrap();
            parent.delete(&inner.filename);
        }
    }
}
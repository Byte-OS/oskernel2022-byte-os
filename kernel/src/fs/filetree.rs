
use core::{cell::RefCell, slice};

use alloc::{string::{String, ToString}, vec::Vec, sync::Arc, rc::Rc};

use crate::{sync::mutex::Mutex, device::BLK_CONTROL, memory::{page::PAGE_ALLOCATOR, addr::{PhysAddr, PAGE_SIZE}}, runtime_err::RuntimeError};

use super::file::FileType;


lazy_static! {
    // 文件树初始化
    pub static ref FILETREE: Arc<Mutex<FileTree>> = Arc::new(Mutex::new(FileTree(FileTreeNode(
        Rc::new(RefCell::new(FileTreeNodeRaw { 
            filename: "".to_string(), 
            file_type: FileType::Directory, 
            parent: None, 
            children: vec![],
            size: 0,
            cluster: 2,
            nlinkes: 0,
            st_atime_sec: 0,
            st_atime_nsec: 0,
            st_mtime_sec: 0,
            st_mtime_nsec: 0,
            st_ctime_sec: 0,
            st_ctime_nsec: 0,
        }))
    ))));
}

// 文件树
pub struct FileTree(FileTreeNode);

impl FileTree {
    // 根据路径 获取文件节点 从根目录读取即为绝对路径读取
    pub fn open(&self, path: &str) -> Result<FileTreeNode, RuntimeError> {
        self.0.open(path)
    }

    // 卸载设备
    #[allow(unused)]
    pub fn umount(&self, _device: &str, _flags: usize) {
        todo!()
    }

    // 挂载设备
    #[allow(unused)]
    pub fn mount(&self, _device: &str, _dir: &str, _fs_type: usize, _flags: usize, _data: usize) {
        todo!()
    }
}

// 文件树原始树
pub struct FileTreeNodeRaw {
    pub filename: String,               // 文件名
    pub file_type: FileType,            // 文件数类型
    pub parent: Option<FileTreeNode>,   // 父节点
    pub children: Vec<FileTreeNode>,    // 子节点
    pub cluster: usize,                 // 开始簇
    pub size: usize,                    // 文件大小
    pub nlinkes: u64,                   // 链接数量
    pub st_atime_sec: u64,              // 最后访问秒
	pub st_atime_nsec: u64,             // 最后访问微秒
	pub st_mtime_sec: u64,              // 最后修改秒
	pub st_mtime_nsec: u64,             // 最后修改微秒
	pub st_ctime_sec: u64,              // 最后创建秒
	pub st_ctime_nsec: u64,             // 最后创建微秒
}


#[derive(Clone)]
// 文件树节点
pub struct FileTreeNode(pub Rc<RefCell<FileTreeNodeRaw>>);

impl FileTreeNode {
    // 创建新设备
    pub fn new_device(filename: &str) -> Self {
        FileTreeNode(Rc::new(RefCell::new(FileTreeNodeRaw {
            filename:String::from(filename),        // 文件名
            file_type: FileType::Device,            // 文件数类型
            parent: None,                           // 父节点
            children: vec![],                       // 子节点
            cluster: 0,                             // 开始簇
            size: 0,                                // 文件大小
            nlinkes: 0,
            st_atime_sec: 0,
            st_atime_nsec: 0,
            st_mtime_sec: 0,
            st_mtime_nsec: 0,
            st_ctime_sec: 0,
            st_ctime_nsec: 0,
        })))
    }
    
    // 创建新的管道
    pub fn new_pipe() -> Self {
        FileTreeNode(Rc::new(RefCell::new(FileTreeNodeRaw {
            filename:String::from("pipe"),        // 文件名
            file_type: FileType::Pipline,            // 文件数类型
            parent: None,                           // 父节点
            children: vec![],                       // 子节点
            cluster: 0,                             // 作为pip buf index
            size: 0,                                // 文件大小
            nlinkes: 0,
            st_atime_sec: 0,
            st_atime_nsec: 0,
            st_mtime_sec: 0,
            st_mtime_nsec: 0,
            st_ctime_sec: 0,
            st_ctime_nsec: 0,
        })))
    }

    // 根据路径 获取文件节点
    pub fn open(&self, path: &str) -> Result<FileTreeNode, RuntimeError> {
        let mut tree_node = self.clone();
        // 分割文件路径
        let location: Vec<&str> = path.split("/").collect();
        // 根据路径匹配文件
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
                        return Err(RuntimeError::FileNotFound);
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
        }
        path
    }

    // 判断当前是否为根目录
    pub fn is_root(&self) -> bool {
        // 根目录文件名为空
        self.0.borrow_mut().filename == ""
    }

    // 判断是否为目录
    pub fn is_dir(&self) -> bool {
        match self.0.borrow_mut().file_type {
            FileType::Directory => true,
            _ => false
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
        node.0.borrow_mut().parent = Some(self.clone());
        curr_node.children.push(node);
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

    // 创建文件
    pub fn create(&mut self, filename: &str) -> Result<(), RuntimeError> {
        let str_split: Vec<&str> = filename.split("/").collect();
        let filename = str_split[str_split.len() - 1];

        // 申请页表
        let page_num = PAGE_ALLOCATOR.lock().alloc()?;
        // 将申请的页表转为地址
        let addr = usize::from(PhysAddr::from(page_num));
        // 清空页表
        unsafe {
            let temp_ref = slice::from_raw_parts_mut(addr as *mut u64, PAGE_SIZE / 8);
            for i in 0..temp_ref.len() {
                temp_ref[i] = 0;
            }
        }
        // 创建节点
        let new_node = FileTreeNode(Rc::new(RefCell::new(FileTreeNodeRaw {
            filename:String::from(filename),  // 文件名
            file_type: FileType::VirtFile,    // 文件数类型
            parent: None,                     // 父节点
            children: vec![],                 // 无需
            cluster: addr,                    // 虚拟文件cluster指向申请到的页表内存地址 默认情况下支持一个页表
            size: 0,                          // 文件大小
            nlinkes: 1,                       // link数量
            st_atime_sec: 0,                  // 最后访问时间
            st_atime_nsec: 0,                 
            st_mtime_sec: 0,                  // 最后修改时间
            st_mtime_nsec: 0,                 
            st_ctime_sec: 0,                  // 最后修改文件状态时间
            st_ctime_nsec: 0,
        })));
        self.add(new_node);

        Ok(())

        // 写入硬盘空间
        // TODO: 进行持久化储存
        // match self.get_file_type() {
        //     FileType::Directory => {
        //         // 申请cluster
        //         unsafe {
        //             let cluster = BLK_CONTROL.get_partition(0).lock().alloc_cluster();
        //             match cluster {
        //                 Some(cluster) => {info!("cluster: {}", cluster);}
        //                 None => {panic!("已无空间");}
        //             }
        //         }
        //     }
        //     _ => {}
        // }
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
        unsafe {
            BLK_CONTROL.get_partition(0).lock().read(self.get_cluster(), self.get_file_size(), buf)
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
    pub fn mkdir(&mut self, filename: &str, _flags: u16) {
        let node = FileTreeNode(Rc::new(RefCell::new(FileTreeNodeRaw {
            filename:String::from(filename),        // 文件名
            file_type: FileType::Directory,         // 文件数类型
            parent: None,                           // 父节点
            children: vec![],                       // 子节点
            cluster: 0,                             // 开始簇
            size: 0,                                // 文件大小
            nlinkes: 0,
            st_atime_sec: 0,
            st_atime_nsec: 0,
            st_mtime_sec: 0,
            st_mtime_nsec: 0,
            st_ctime_sec: 0,
            st_ctime_nsec: 0,
        })));
        let mut curr_node = self.0.borrow_mut();
        // 将新创建的文件夹加入子节点
        curr_node.children.push(node);
        curr_node.parent = Some(self.clone());
    }
}
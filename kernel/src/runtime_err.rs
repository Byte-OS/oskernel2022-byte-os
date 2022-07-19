#[derive(Debug)]
pub enum RuntimeError {
    NoEnoughPage,
    FileNotFound,
    // 没有对应的物理地址
    NoMatchedAddr,
    ChangeTask,
    // 没有对应的文件
    NoMatchedFile,
    // 没有对应的fd
    NoMatchedFileDesc
}
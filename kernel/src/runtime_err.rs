#[derive(Debug)]
pub enum RuntimeError {
    NoEnoughPage,
    FileNotFound,
    // 没有对应的物理地址
    NoMatchedAddr,
    ChangeTask
}
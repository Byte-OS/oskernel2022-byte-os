// Open标志
bitflags! {
    pub struct OpenFlags: u32 {
        const RDONLY = 0;
        const WRONLY = 1 << 0;
        const RDWR = 1 << 1;
        const CREATE = 1 << 6;
        const TRUNC = 1 << 10;
        const O_DIRECTORY = 1 << 21;
    }

    pub struct SignalFlag: usize {
        const SA_NOCLDSTOP = 0x1;
        const SA_NOCLDWAIT = 0x2;
        const SA_SIGINFO   = 0x4;
        const SA_RESTART   = 0x10000000;
        const SA_NODEFER   = 0x40000000;
        const SA_RESETHAND = 0x80000000;
        const SA_RESTORER  = 0x04000000;
    }

    pub struct CloneFlags: usize {
        const CSIGNAL		= 0x000000ff;
        const CLONE_VM	= 0x00000100;
        const CLONE_FS	= 0x00000200;
        const CLONE_FILES	= 0x00000400;
        const CLONE_SIGHAND	= 0x00000800;
        const CLONE_PIDFD	= 0x00001000;
        const CLONE_PTRACE	= 0x00002000;
        const CLONE_VFORK	= 0x00004000;
        const CLONE_PARENT	= 0x00008000;
        const CLONE_THREAD	= 0x00010000;
        const CLONE_NEWNS	= 0x00020000;
        const CLONE_SYSVSEM	= 0x00040000;
        const CLONE_SETTLS	= 0x00080000;
        const CLONE_PARENT_SETTID	= 0x00100000;
        const CLONE_CHILD_CLEARTID	= 0x00200000;
        const CLONE_DETACHED	= 0x00400000;
        const CLONE_UNTRACED	= 0x00800000;
        const CLONE_CHILD_SETTID	= 0x01000000;
        const CLONE_NEWCGROUP	= 0x02000000;
        const CLONE_NEWUTS	= 0x04000000;
        const CLONE_NEWIPC	= 0x08000000;
        const CLONE_NEWUSER	= 0x10000000;
        const CLONE_NEWPID	= 0x20000000;
        const CLONE_NEWNET	= 0x40000000;
        const CLONE_IO	= 0x80000000;
    }
}

// 文件Dirent结构
#[repr(C)]
#[allow(unused)]
struct Dirent {
    d_ino: u64,	         // 索引结点号
    d_off: u64,	         // 到下一个dirent的偏移
    d_reclen: u16,	     // 当前dirent的长度
    d_type: u8,	         // 文件类型
    d_name_start: [u8;0 ]//文件名 文件名 自行处理？
}
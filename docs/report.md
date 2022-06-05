# 操作系统设计报告

## 参考信息

[os-competition-info/ref-info.md at main · oscomp/os-competition-info · GitHub](https://github.com/oscomp/os-competition-info/blob/main/ref-info.md)

[Exceptions (alexbd.cn)](http://note.alexbd.cn/#/riscv/exceptions)

## 比赛准备

### 设备信息

RISC-V芯片引导位置为`0x80000000`，由于可以使用`rustsbi`，因此在`0x80200000`处加入操作系统内核即可，无需再次编写`bootloader`.

### 添加nightly工具链

在编写操作系统过程中需要用到某些`nightly`功能，因此添加`nightly`工具链。

```sh
rustup install nightly
rustup default nightly
```

### 添加Rust build工具

build工具中包含`rust-objdump`和`rust-objcopy`

```sh
cargo install cargo-binutils
rustup component add llvm-tools-preview
```

### 添加target elf

```sh
rustup target add riscv64imac-unknown-none-elf
```

## 需求分析

### 系统调用

```rust
// 系统调用列表
pub const SYS_GETCWD:usize  = 17;
pub const SYS_DUP: usize    = 23;
pub const SYS_DUP3: usize   = 24;
pub const SYS_MKDIRAT:usize = 34;
pub const SYS_UNLINKAT:usize= 35;
pub const SYS_UMOUNT2: usize= 39;
pub const SYS_MOUNT: usize  = 40;
pub const SYS_CHDIR: usize  = 49;
pub const SYS_OPENAT:usize  = 56;
pub const SYS_CLOSE: usize  = 57;
pub const SYS_PIPE2: usize  = 59;
pub const SYS_GETDENTS:usize= 61;
pub const SYS_READ:  usize  = 63;
pub const SYS_WRITE: usize  = 64;
pub const SYS_FSTAT: usize  = 80;
pub const SYS_EXIT:  usize  = 93;
pub const SYS_NANOSLEEP: usize = 101;
pub const SYS_SCHED_YIELD: usize = 124;
pub const SYS_TIMES: usize  = 153;
pub const SYS_UNAME: usize  = 160;
pub const SYS_GETTIMEOFDAY: usize= 169;
pub const SYS_GETPID:usize  = 172;
pub const SYS_GETPPID:usize = 173;
pub const SYS_BRK:   usize  = 214;
pub const SYS_CLONE: usize  = 220;
pub const SYS_EXECVE:usize  = 221;
pub const SYS_MMAP: usize   = 222;
pub const SYS_MUNMAP:usize  = 215;
pub const SYS_WAIT4: usize  = 260;
```



## 系统框架和模块设计

### 1.文件系统

#### 内核文件树

`ByteOS`采用系统文件树，将文件读取后存储到文件树，以文件树节点作为文件进行操作。

`ByteOS`采用`FAT32`作为文件系统。将文件

## 遇到的主要问题和解决方法

### 1. SYS_GETDENTS 缓冲区溢出异常

在系统调用`SYS_GETDENTS`中对于目录文件进行修改的时候，因为文件内容过多导致缓冲区溢出，在测试案例输出的时候会导致本来输出数字的结果变为输出字母。**在系统调用文件中进行读取字节数限制，修复成功。**

```rust
for i in 0..sub_nodes.len() {
    ...
    // 保证缓冲区不会溢出
    if buf_ptr - start_ptr >= len {
        break;
    }
}
```

### 2. RustSBI多核启动导致数据异常

`rustsbi`在`qemu`中以`Debug`模式启动时只会启动一个核心，但是已`Release`启动时会启动多个核心，在操作系统管理和调试时存在一定问题。**因此目前仅使用一个核心，在操作系统主函数中使用cfg设置其他核心终止，保证仅有一个核心工作。**

```rust
#[no_mangle]
pub extern "C" fn rust_main(hartid: usize, device_tree_paddr: usize) -> ! {
    // // 保证仅有一个核心工作
    #[cfg(not(debug_assertions))]
    if hartid != 0 {
        sbi::hart_suspend(0x00000000, support_hart_resume as usize, 0);
    }
}
```

### 3. 操作系统内核在评测机运行时无法编译

`ByteOS`在早期开发时使用的时`riscv64gc-unknown-none-elf`，但是评测及使用的是`riscv64imac-unknown-none-elf`，因此在编译过程中添加target

```sh
# 编译的目标平台
[build]
# target = "riscv64gc-unknown-none-elf"
target = "riscv64imac-unknown-none-elf"
```

同时在编译时`rustflags`无法使用，因此直接将`rustflags`写入`makefile`中

```makefile
k210: 
	@cp src/linker-k210.ld src/linker.ld
	@RUSTFLAGS="-Clink-arg=-Tsrc/linker.ld" cargo build $(MODE_FLAG) --features "board_k210" --offline
	@rm src/linker.ld
	$(OBJCOPY) $(KERNEL_FILE) --strip-all -O binary $(BIN_FILE)
	@cp $(BOOTLOADER_K210) $(BOOTLOADER_K210).copy
	@dd if=$(BIN_FILE) of=$(BOOTLOADER_K210).copy bs=131072 seek=1
	@mv $(BOOTLOADER_K210).copy $(BIN_FILE)
```



## 比赛仓库目录和文件描述

### 比赛目录

```rust
.
├── Cargo.toml				// Cargo文件
├── README.md				// README文件
├── bootloader				// rustsbi引导目录
│   ├── rustsbi-k210.bin	// rustsbi k210文件
│   └── rustsbi-qemu.bin	// rust qemu文件
├── docs					// 文档目录 部署在pages
│   ├── README.md			// 笔记文档
│   ├── index.html			// 笔记网页
│   └── report.md			// 报告文件
├── fs.img					// 测试文件系统
├── makefile				// makefile文件
├── os.bin					// 生成的操作系统镜像
└── src						// 源代码目录
    ├── console.rs			// 字符输出
    ├── device				// 设备控制模块
    │   ├── block.rs		// VIRTIO Block驱动
    │   ├── mod.rs			// device mod文件
    │   └── sdcard.rs		// SDCARD驱动文件	(来自rCore 进行略微修改)
    ├── entry.asm			// 操作系统入口
    ├── fs					// 文件系统驱动
    │   ├── fat32			// fat32驱动
    │   │   ├── fat32bpb.rs		// fat32bpb
    │   │   ├── file_trait.rs	// file_trait
    │   │   ├── long_file.rs	// fat32长文件名
    │   │   ├── mod.rs			// fat32驱动 mod文件
    │   │   └── short_file.rs	// fat32短文件名
    │   ├── file.rs				// 文件系统文件
    │   ├── filetree.rs			// 文件树
    │   ├── mod.rs				// 文件系统 mod文件
    │   └── partition.rs		// 分区
    ├── interrupt					// 中断
    │   ├── interrupt-kernel.asm	// 内核中断入口
    │   ├── interrupt-user.asm		// 应用程序中断入口
    │   ├── mod.rs					// 中断Mod文件 含有中断处理函数
    │   ├── sys_call.rs				// 系统调用函数
    │   └── timer.rs				// 定时器
    ├── linker-k210.ld				// k210 linker文件
    ├── linker-qemu.ld				// qemu linker文件
    ├── main.rs						// 操作系统主函数
    ├── memory						// 内存描述函数
    │   ├── addr.rs					// 虚拟地址和物理地址描述文件
    │   ├── heap.rs					// 操作系统堆结构 和 Global_Allocator
    │   ├── mod.rs					// 内存mod文件
    │   ├── page.rs					// 内存页 管理器 分配器
    │   └── page_table.rs			// 内存页映射管理器
    ├── panic.rs					// panic 文件
    ├── sbi.rs						// sbi调用函数
    ├── sync						// sync相关函数
    │   ├── mod.rs					// sync mod文件
    │   └── mutex.rs				// Mutex 定义
    ├── task						// 任务管理函数
    │   ├── change_task.asm			// 更换任务 汇编代码
    │   ├── mod.rs					// task mod文件
    │   ├── pipe.rs					// 任务 pipe文件 包含PipeBuf
    │   └── task_queue.rs			// 任务队列文件
    └── virtio_impl.rs				// virtio_impl申请文件
```


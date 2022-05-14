# 操作系统笔记

## 帮助信息

[os-competition-info/ref-info.md at main · oscomp/os-competition-info · GitHub](https://github.com/oscomp/os-competition-info/blob/main/ref-info.md)

## 1.操作系统引导

RISC-V芯片引导位置为`0x80000000`，由于可以使用`rustsbi`，因此在`0x80200000`处加入操作系统内核即可，无需再次编写`bootloader`.

## 2.sbi规范

## 3.操作系统入口函数

## 4.Rust build工具

```shell
cargo install cargo-binutils
rustup component add llvm-tools-preview
```

## 添加target elf

```shell
rustup target add riscv64gc-unknown-none-elf
```

> 可选 使用nightly工具链

```shell
rustup install nightly
rustup default nightly
```

## 使用Rust定义全局变量

```rust
// CACHE_SIZE 是要定义的数组的大小
// 此时需要添加大小才能使用
// 在rust中 变量如果没有使用 可能并不会被有效编译
static mut CACHE: [u8;CACHE_SIZE] = [0;CACHE_SIZE];    

// rust初始化块内存
unsafe {
    core::slice::from_raw_parts_mut(bss_start_addr, bss_size).fill(0);
}
```

## Rust使用自定义的内存管理分配器(heap)

rust在如果使用no_std即使用core库且需要使用Ref Vec等功能需要自己实现#[global_allocator], 然后才能进行内存的分配

### Demo

```rust
use std::alloc::{GlobalAlloc, System, Layout};

struct MyAllocator;

unsafe impl GlobalAlloc for MyAllocator {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        System.alloc(layout)
    }

    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
        System.dealloc(ptr, layout)
    }
}

#[global_allocator]
static GLOBAL: MyAllocator = MyAllocator;

fn main() {
    // This `Vec` will allocate memory through `GLOBAL` above
    let mut v = Vec::new();
    v.push(1);
}
```

### 使用buddy_system_allocator

```rust
use buddy_system_allocator::LockedHeap;

// 堆大小
const HEAP_SIZE: usize = 0x0001_0000;

// 堆空间
static mut HEAP: [u8;HEAP_SIZE] = [0;HEAP_SIZE];

// 堆内存分配器
#[global_allocator]
static HEAP_ALLOCATOR: LockedHeap<64> = LockedHeap::empty();


// 初始化堆内存分配器
pub fn init() {
    unsafe {
        HEAP_ALLOCATOR.lock().init(HEAP.as_ptr() as usize, HEAP_SIZE);
    }
}
```

## 设置输入

CR：Carriage Return，对应ASCII中转义字符\r，表示回车

LF：Linefeed，对应ASCII中转义字符\n，表示换行

CRLF：Carriage Return & Linefeed，\r\n，表示回车并换行

```rust
// 读入一个字符
pub fn read() -> char {
    console_getchar()
}

// 无回显输入
pub fn read_line(str: &mut String) {
    loop {
        let c = read();
        if c == '\n' {
            break;
        }
        str.push(c);
    }
}

// 有回显输入
pub fn read_line_display(str: &mut String) {
    loop {
        let c = read();
        console_putchar(c as u8);

        if c as u8 == 0x0D {
            console_putchar(0xa);
            break;
        }
        str.push(c);
    }
}
```

### utf8转换规则

> Unicode 与 UTF-8 编码有一个归纳的转换规则 ：
> Unicode Code    UTF-8 Code
>  0000～007F     0xxxxxxx
>  0080～07FF     110xxxxx 10xxxxxx
>  0800～FFFF     1110xxxx 10xxxxxx 10xxxxxx
> 10000～10FFFF   11110xxx 10xxxxxx 10xxxxxx 10xxxxxx

获取uf8字符后转unicode

```rust
if c as u8 >= 0b11000000 {
    // 获取到utf8字符 转unicode
    console_putchar(c as u8);
    let mut char_u32:u32 = c as u32;
    let times = if c as u8 <= 0b11100000 {
        char_u32 = char_u32 & 0x1f;
        1
    } else if c as u8 <= 0b11110000 {
        char_u32 = char_u32 & 0x0f;
        2
    } else {
        char_u32 = char_u32 & 0x07;
        3
    };


    for _ in 0..times {
        let c = read();
        console_putchar(c as u8);
        char_u32 = char_u32 << 6;
        char_u32 = char_u32 | ((c as u32) & 0x3f
    }

    str.push(char::from_u32(char_u32).unwrap());
    continue;
}
```

## 中断设置

rust中断设置，首先需要设置`stvec`，`stvec`设置中断入口的地址。

```rust
use core::arch::{global_asm, asm};
use riscv::register::{sstatus::Sstatus, scause::{self, Trap, Exception, Scause}, stval, sepc};


#[repr(C)]
#[derive(Debug)]
pub struct Context {
    pub x: [usize; 32],     // 32 个通用寄存器
    pub sstatus: Sstatus,
    pub sepc: usize
}

// break中断
fn breakpoint(context: &mut Context) {
    warn!("寄存器地址 x1 {}", context.x[1]);
    warn!("break中断产生 中断地址 {:#x}", sepc::read());
}

// 中断错误
fn fault(context: &mut Context, scause: Scause, stval: usize) {
    info!("中断 {:#x} 地址 {:#x}", scause.bits(), sepc::read());
    panic!("未知中断")
}

// 中断回调
#[no_mangle]
fn interrupt_callback(context: &mut Context, scause: Scause, stval: usize) {
    match scause.cause(){
        Trap::Exception(Exception::Breakpoint) => breakpoint(context),
        // 时钟中断
        // Trap::Interrupt(Interrupt::SupervisorTimer) => supervisor_timer(context),
        // 其他情况，终止当前线程
        _ => fault(context, scause, stval),
    }
    fault(context, scause, stval);
    panic!("中断产生");
}

// 包含中断代码
global_asm!(include_str!("interrupt.asm"));


// 设置中断
pub fn init() {
    extern "C" {
        fn int_callback_entry();
    }

    unsafe {
        asm!("csrw stvec, a0", in("a0") int_callback_entry as usize);
    }

}
```

### 中断入口汇编代码

```armasm
# 我们将会用一个宏来用循环保存寄存器。这是必要的设置
.altmacro
# 寄存器宽度对应的字节数
.set    REG_SIZE, 8
# Context 的大小
.set    CONTEXT_SIZE, 34

# 宏：将寄存器存到栈上
.macro SAVE reg, offset
    sd  \reg, \offset*8(sp)
.endm

.macro SAVE_N n
    SAVE  x\n, \n
.endm

# 宏：将寄存器从栈中取出
.macro LOAD reg, offset
    ld  \reg, \offset*8(sp)
.endm

.macro LOAD_N n
    LOAD  x\n, \n
.endm

    .section .text
    .global int_callback_entry
int_callback_entry:
    addi    sp, sp, CONTEXT_SIZE*-8

     # 保存通用寄存器，除了 x0（固定为 0）
    SAVE    x1, 1
    # 将原来的 sp（sp 又名 x2）写入 2 位置
    addi    x1, sp, 34*8
    SAVE    x1, 2
     # 保存 x3 至 x31
    .set    n, 3
    .rept   29
        SAVE_N  %n
        .set    n, n + 1
    .endr
    # 取出 CSR 并保存
    csrr    s1, sstatus
    csrr    s2, sepc
    SAVE    s1, 32
    SAVE    s2, 33

    # 将第一个参数设置为栈顶 便于Context引用访问
    add a0, x0, sp
    # 第二个参数设置为scause
    csrr a1, scause
    # 第三个参数设置为stval
    csrr a2, stval

    # 调用中断回调函数
    call interrupt_callback

    # 恢复 CSR
    LOAD    s1, 32
    LOAD    s2, 33
    csrw    sstatus, s1
    csrw    sepc, s2

    # 恢复通用寄存器
    LOAD    x1, 1

    # 恢复 x3 至 x31
    .set    n, 3
    .rept   29
        LOAD_N  %n
        .set    n, n + 1
    .endr

    # 恢复 sp（又名 x2）这里最后恢复是为了上面可以正常使用 LOAD 宏
    LOAD    x2, 2

    sret
```

### 设置时钟中断

设置时钟中断需要置`sie`寄存器的`stie`位开启定时器，并置`sstatus`的`sie`位开启中断。

寄存器详细说明链接: [10. 自制操作系统: risc-v Supervisor寄存器sstatus/stvec/sip/sie_dumpcore的博客-CSDN博客](https://blog.csdn.net/dai_xiangjun/article/details/123967946)

```rust
use crate::sbi::set_timer;
use crate::interrupt::Context;
use riscv::register::{sie, sstatus, time};

const INTERVAL: usize = 10000;     // 定时器周期

pub static mut TICKS: usize = 0;
/// 时钟中断处理器
pub fn timer_handler(context: &mut Context) {
    set_next_timeout();
    unsafe {
        TICKS=TICKS+1;
        if TICKS % 100 == 0 {
            info!("{} TICKS", TICKS);
        }
    }
}

// 设置下一次时钟中断触发时间
fn set_next_timeout() {
    // 调用sbi设置定时器
    set_timer(time::read() + INTERVAL);
}

// 初始化定时器
pub fn init() {
    info!("初始化定时器");
    unsafe {
        // 开启时钟中断
        sie::set_stimer();
        // 允许中断产生
        sstatus::set_sie();
    }
    // 设置下一次中断产生时间
    set_next_timeout();
}
```

## Virtual I/O protocol

[参考链接](https://web.eecs.utk.edu/~smarz1/courses/cosc361/notes/virtio/)

[IO Device文档](https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.html)

### MMIO Offsets

```rust
#[repr(usize)]
pub enum MmioOffsets {
  MagicValue = 0x000,
  Version = 0x004,
  DeviceId = 0x008,
  VendorId = 0x00c,
  HostFeatures = 0x010,
  HostFeaturesSel = 0x014,
  GuestFeatures = 0x020,
  GuestFeaturesSel = 0x024,
  GuestPageSize = 0x028,
  QueueSel = 0x030,
  QueueNumMax = 0x034,
  QueueNum = 0x038,
  QueueAlign = 0x03c,
  QueuePfn = 0x040,
  QueueNotify = 0x050,
  InterruptStatus = 0x060,
  InterruptAck = 0x064,
  Status = 0x070,
  Config = 0x100,
}
```

rust 读取设备树      

操作系统在启动后需要了解计算机系统中所有接入的设备，这就要有一个读取全部已接入设备信息的能力，而设备信息放在哪里，又是谁帮我们来做的呢？在 RISC-V 中，这个一般是由 bootloader，即 OpenSBI or RustSBI 固件完成的。它来完成对于包括物理内存在内的各外设的探测，将探测结果以 **设备树二进制对象（DTB，Device Tree Blob）** 的格式保存在物理内存中的某个地方。然后bootloader会启动操作系统，即把放置DTB的物理地址将放在 `a1` 寄存器中，而将会把 HART ID （**HART，Hardware Thread，硬件线程，可以理解为执行的 CPU 核**）放在 `a0` 寄存器上，然后跳转到操作系统的入口地址处继续执行。例如，我们可以查看 `virtio_drivers` crate中的在裸机环境下使用驱动程序的例子。我们只需要给 rust_main 函数增加两个参数（即 `a0` 和 `a1` 寄存器中的值 ）即可：

## 测试大小端代码

```rust
// 测试大小端代码
let test_str:u32 = 0x11223344;
let first_char = unsafe {*(&test_str as *const u32 as *const u8)};
if first_char == 0x11 {
    info!("大端在前")
} else {
    info!("小端在前")
}
```

## FAT32文件系统

[详解FAT32文件系统 - CharyGao - 博客园](https://www.cnblogs.com/Chary/p/12981056.html)

```rust
struct FAT32 {
    device_id: usize,
    fat32bpb: FAT32BPB
}

#[repr(packed)]
pub struct FAT32BPB {
    jmpcode: [u8; 3],       // 跳转代码
    oem: [u8; 8],           // oem 信息
    bytes_per_sector: u16,  // 每扇区字节数
    sectors_per_cluster: u8,// 每簇扇区数
    reserved_sector: u16,   // 保留扇区数 第一个FAT之前的扇区数 包含引导扇区
    fat_number: u8,         // fat表数量
    root_entries: u16,      // 根目录项数 FAT32必须为0
    small_sector: u16,      // 小扇区区数 FAT32必须为0
    media_descriptor: u8,   // 媒体描述符 0xF8标识硬盘 0xF0表示3.5寸软盘
    sectors_per_fat: u16,   // 每FAT扇区数
    sectors_per_track: u16, // 每道扇区数
    number_of_head: u16,    // 磁头数
    hidden_sector: u32,     // 隐藏扇区数
    large_sector: u32,      // 总扇区数
}

pub fn init() {
    let mut buf = vec![0u8; size_of::<FAT32BPB>()];
    unsafe {
        BLK_CONTROL.read_one_sector(0, 0, &mut buf); 
        info!("缓冲区地址:{:#x}", buf.as_mut_ptr() as usize);
        let ref fat_header = *(buf.as_mut_ptr() as *mut u8 as *mut FAT32BPB);
        info!("fat_header address: {:#x}", fat_header as *const _ as usize);
        info!("size of :{}", size_of::<FAT32BPB>());
        info!("变量地址:{:#x}", &(fat_header.jmpcode) as *const _ as usize);
        info!("磁盘大小:{}", fat_header.large_sector * fat_header.bytes_per_sector as u32);
        info!("FAT表数量:{}", fat_header.fat_number);
        info!("保留扇区数: {}, 地址: {:#x}", fat_header.reserved_sector, fat_header.reserved_sector * 512);
        info!("OEM信息:{}", String::from_utf8_lossy(&fat_header.oem));
        info!("根目录数量: {:?}", fat_header.jmpcode);
    }
}
```
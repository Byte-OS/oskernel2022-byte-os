// remove std lib
#![no_std]
#![no_main]
#![feature(panic_info_message)]
#![feature(default_alloc_error_handler)]


// 使用定义的命令行宏   
#[macro_use]
mod console;
mod device;
mod interrupt;
mod memory;
mod sbi;
mod panic;

extern crate alloc;
use core::arch::{global_asm, asm};
use alloc::vec;
use alloc::{vec::Vec, string::String};

use device_tree::util::SliceRead;
use interrupt::TICKS;

use crate::device::init;
use crate::sbi::{shutdown};
use crate::console::{read_line_display};

use virtio_drivers::*;
use device_tree::{DeviceTree, Node};

mod virtio_impl;


global_asm!(include_str!("entry.asm"));

/// 清空bss段
fn clear_bss() {
    extern "C" {
        fn sbss();
        fn ebss();
    }
    let bss_start_addr = sbss as usize as *mut u8;
    let bss_size = ebss as usize - sbss as usize;
    unsafe {
        core::slice::from_raw_parts_mut(bss_start_addr, bss_size).fill(0);
    }
    
    // 显示BSS段信息
    info!("the bss section range: {:X}-{:X}, {} KB", sbss as usize, ebss as usize, bss_size / 0x1000);
}


fn init_dt(dtb: usize) {
    info!("device tree @ {:#x}", dtb);
    #[repr(C)]
    struct DtbHeader {
        be_magic: u32,
        be_size: u32,
    }
    let header = unsafe { &*(dtb as *const DtbHeader) };
    let magic = u32::from_be(header.be_magic);
    const DEVICE_TREE_MAGIC: u32 = 0xd00dfeed;
    assert_eq!(magic, DEVICE_TREE_MAGIC);
    let size = u32::from_be(header.be_size);
    let dtb_data = unsafe { core::slice::from_raw_parts(dtb as *const u8, size as usize) };
    let dt = DeviceTree::load(dtb_data).expect("failed to parse device tree");
    walk_dt_node(&dt.root);

    loop{}
}

fn walk_dt_node(dt: &Node) {
    if let Ok(compatible) = dt.prop_str("compatible") {
        if compatible == "virtio,mmio" {
            virtio_probe(dt);
        }
    }
    for child in dt.children.iter() {
        walk_dt_node(child);
    }
}

fn virtio_probe(node: &Node) {
    if let Some(reg) = node.prop_raw("reg") {
        let paddr = reg.as_slice().read_be_u64(0).unwrap();
        let size = reg.as_slice().read_be_u64(8).unwrap();
        let vaddr = paddr;
        info!("walk dt addr={:#x}, size={:#x}", paddr, size);
        let header = unsafe { &mut *(vaddr as *mut VirtIOHeader) };
        info!(
            "Detected virtio device with vendor id {:#X}",
            header.vendor_id()
        );
        info!("Device tree node {:?}", node);
        match header.device_type() {
            DeviceType::Block => virtio_blk(header),
            DeviceType::GPU => virtio_gpu(header),
            DeviceType::Input => virtio_input(header),
            DeviceType::Network => virtio_net(header),
            t => warn!("Unrecognized virtio device: {:?}", t),
        }
    }
}

fn virtio_blk(header: &'static mut VirtIOHeader) {
    let mut blk = VirtIOBlk::new(header).expect("failed to create blk driver");
    let mut input = vec![0xffu8; 512];
    let mut output = vec![0; 512];
    for i in 0..32 {
        for x in input.iter_mut() {
            *x = i as u8;
        }
        blk.write_block(i, &input).expect("failed to write");
        blk.read_block(i, &mut output).expect("failed to read");
        assert_eq!(input, output);
    }
    info!("virtio-blk test finished");
}

fn virtio_gpu(header: &'static mut VirtIOHeader) {
    let mut gpu = VirtIOGpu::new(header).expect("failed to create gpu driver");
    let fb = gpu.setup_framebuffer().expect("failed to get fb");
    for y in 0..768 {
        for x in 0..1024 {
            let idx = (y * 1024 + x) * 4;
            fb[idx] = x as u8;
            fb[idx + 1] = y as u8;
            fb[idx + 2] = (x + y) as u8;
        }
    }
    gpu.flush().expect("failed to flush");
    info!("virtio-gpu test finished");
}

fn virtio_input(header: &'static mut VirtIOHeader) {
    let mut event_buf = [0u64; 32];
    // let mut _input =
        // VirtIOInput::new(header, &mut event_buf).expect("failed to create input driver");
    // loop {
    //     input.ack_interrupt().expect("failed to ack");
    //     info!("mouse: {:?}", input.mouse_xy());
    // }
    // TODO: handle external interrupt
}

fn virtio_net(header: &'static mut VirtIOHeader) {
    let mut net = VirtIONet::new(header).expect("failed to create net driver");
    let mut buf = [0u8; 0x100];
    let len = net.recv(&mut buf).expect("failed to recv");
    info!("recv: {:?}", &buf[..len]);
    net.send(&buf[..len]).expect("failed to send");
    info!("virtio-net test finished");
}

#[no_mangle]
pub extern "C" fn rust_main(_hartid: usize, device_tree_paddr: usize) -> ! {
    // 清空bss段
    clear_bss();

    // 输出设备信息
    info!("当前核心 {}", _hartid);
    info!("设备地址 {:#x}", device_tree_paddr);

    // let mut condvars = BTreeMap::new();
    // let channels = virtio_blk.exclusive_access().virt_queue_size();
    // for i in 0..channels {
    //     let condvar = Condvar::new();
    //     condvars.insert(i, condvar);
    // }

    // 初始化中断
    interrupt::init();

    // 初始化内存
    memory::init();

    // 初始化设备
    device::init();

    const VIRTIO0: usize = 0x10001000;

    virtio_blk(unsafe {
        &mut *(VIRTIO0 as *mut VirtIOHeader)
    });

    // init_dt(device_tree_paddr);

    
    // 提示信息
    info!("Welcome to test os!");

    // // 测试ebreak
    // unsafe {
    //     asm!("ebreak");
    // }

    // 测试获取信息
    // let ch = read();
    // info!("read char {:#x}", ch as u8);

    unsafe {
        loop {
            if TICKS > 1000 {
                info!("继续执行");
                break;
            }
        }
    }

    let mut words = String::new();
    read_line_display(&mut words);
    info!("I say {}", words);

    // 测试数据分配
    let mut a1: Vec<u8> = Vec::new();
    a1.push(1);
    a1.push(2);
    for a in a1 {
        info!("{}", a);
    }

    

    // 调用rust api关机
    shutdown()
}

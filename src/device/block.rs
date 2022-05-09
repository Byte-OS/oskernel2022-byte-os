use alloc::vec;
use alloc::vec::Vec;
use virtio_drivers::VirtIOBlk;
use virtio_drivers::VirtIOHeader;

const VIRTIO0: usize = 0x10001000;
const SECTOR_SIZE: usize = 512;

pub static mut BLK_CONTROL: BlockDeviceContainer = BlockDeviceContainer {
    device: vec![]
};

pub struct BlockDeviceContainer<'a> {
    device: Vec<VirtIOBlk<'a>>,
}

impl BlockDeviceContainer<'_> {
    pub fn add(&mut self, virtio: usize) {
        self.device.push(VirtIOBlk::new(unsafe {&mut *(virtio as *mut VirtIOHeader)}).expect("failed to create blk driver"));
    }

    // pub fn read(&mut self, index: usize, addr: usize, buf:& mut [u8]) {
    //     let mut needRead = buf.len();
    //     let mut output = vec![0; 512];
    //     let remainder = addr % 512;
    //     let mut device_id = addr >> 9;
    //     if remainder > 0 {
    //         self.device[index].read_block(device_id, &mut output);
    //         buf.copy_from_slice(&output[remainder..512]);
    //         needRead = needRead - 512 + remainder;
    //     }
    // }

    pub fn read_one_sector(&mut self, device_id: usize, block_id: usize, buf:& mut [u8]) {
        let mut output = vec![0; 512];
        self.device[device_id].read_block(block_id, &mut output).expect("读取失败");
        buf.copy_from_slice(&output[..buf.len()]);
    }
}

pub fn init() {
    unsafe {
        BLK_CONTROL.add(VIRTIO0);
    }
    // let mut input = vec![0xffu8; 512];
    // let mut output = vec![0; 512];
    // for i in 0..32 {
    //     for x in input.iter_mut() {
    //         *x = i as u8;
    //     }
    //     blk.write_block(i, &input).expect("failed to write");
    //     blk.read_block(i, &mut output).expect("failed to read");
    //     assert_eq!(input, output);
    // }
    // blk.write_block_nb(block_id, buf, resp)
    // blk.read_block(0, &mut output);
    // for i in output {
        // info!("{:#x}", i);
    // }
    info!("virtio-blk test finished");
}
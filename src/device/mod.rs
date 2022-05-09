mod block;

pub use block::BLK_CONTROL;
// #[repr(usize)]
// pub enum MmioOffsets {
//   MagicValue = 0x000,
//   Version = 0x004,
//   DeviceId = 0x008,
//   VendorId = 0x00c,
//   HostFeatures = 0x010,
//   HostFeaturesSel = 0x014,
//   GuestFeatures = 0x020,
//   GuestFeaturesSel = 0x024,
//   GuestPageSize = 0x028,
//   QueueSel = 0x030,
//   QueueNumMax = 0x034,
//   QueueNum = 0x038,
//   QueueAlign = 0x03c,
//   QueuePfn = 0x040,
//   QueueNotify = 0x050,
//   InterruptStatus = 0x060,
//   InterruptAck = 0x064,
//   Status = 0x070,
//   Config = 0x100,
// }

// pub fn pending(bd: &mut BlockDevice) {
//     // Here we need to check the used ring and then free the resources
//     // given by the descriptor id.
//     unsafe {
//       let ref queue = *bd.queue;
//       while bd.ack_used_idx != queue.used.idx {
//         let ref elem = queue.used.ring[bd.ack_used_idx as usize % VIRTIO_RING_SIZE];
//         bd.ack_used_idx = bd.ack_used_idx.wrapping_add(1);
//         let rq = queue.desc[elem.id as usize].addr as *const Request;
//         kfree(rq as *mut u8);
//         // TODO: Awaken the process that will need this I/O. This is
//         // the purpose of the waiting state.
//       }
//     }
//   }
  

// pub fn block_op(dev: usize, buffer: *mut u8, size: u32, offset: u64, write: bool) {
//     unsafe {
//       if let Some(bdev) = BLOCK_DEVICES[dev - 1].as_mut() {
//         // Check to see if we are trying to write to a read only device.
//         if true == bdev.read_only && true == write {
//           println!("Trying to write to read/only!");
//           return;
//         }
//         let sector = offset / 512;
//         // TODO: Before we get here, we are NOT allowed to schedule a read or
//         // write OUTSIDE of the disk's size. So, we can read capacity from
//         // the configuration space to ensure we stay within bounds.
//         let blk_request_size = size_of::<Request>();
//         let blk_request = kmalloc(blk_request_size) as *mut Request;
//         let desc = Descriptor { addr:  &(*blk_request).header as *const Header as u64,
//                                 len:   size_of::<Header>() as u32,
//                                 flags: virtio::VIRTIO_DESC_F_NEXT,
//                                 next:  0, };
//         let head_idx = fill_next_descriptor(bdev, desc);
//         (*blk_request).header.sector = sector;
//         // A write is an "out" direction, whereas a read is an "in" direction.
//         (*blk_request).header.blktype = if true == write {
//           VIRTIO_BLK_T_OUT
//         }
//         else {
//           VIRTIO_BLK_T_IN
//         };
//         // We put 111 in the status. Whenever the device finishes, it will write into
//         // status. If we read status and it is 111, we know that it wasn't written to by
//         // the device.
//         (*blk_request).data.data = buffer;
//         (*blk_request).header.reserved = 0;
//         (*blk_request).status.status = 111;
//         let desc = Descriptor { addr:  buffer as u64,
//                                 len:   size,
//                                 flags: virtio::VIRTIO_DESC_F_NEXT
//                                         | if false == write {
//                                           virtio::VIRTIO_DESC_F_WRITE
//                                         }
//                                         else {
//                                           0
//                                         },
//                                 next:  0, };
//         let _data_idx = fill_next_descriptor(bdev, desc);
//         let desc = Descriptor { addr:  &(*blk_request).status as *const Status as u64,
//                                 len:   size_of::<Status>() as u32,
//                                 flags: virtio::VIRTIO_DESC_F_WRITE,
//                                 next:  0, };
//         let _status_idx = fill_next_descriptor(bdev, desc);
//         (*bdev.queue).avail.ring[(*bdev.queue).avail.idx as usize % virtio::VIRTIO_RING_SIZE] = head_idx;
//         (*bdev.queue).avail.idx = (*bdev.queue).avail.idx.wrapping_add(1);
//         // The only queue a block device has is 0, which is the request
//         // queue.
//         bdev.dev.add(MmioOffsets::QueueNotify.scale32()).write_volatile(0);
//       }
//     }
//   }  

// pub fn setup_block_device(ptr: *mut u32) -> bool {
//     unsafe {
//       // We can get the index of the device based on its address.
//       // 0x1000_1000 is index 0
//       // 0x1000_2000 is index 1
//       // ...
//       // 0x1000_8000 is index 7
//       // To get the number that changes over, we shift right 12 places (3 hex digits)
//       let idx = (ptr as usize - virtio::MMIO_VIRTIO_START) >> 12;
//       // [Driver] Device Initialization
//       // 1. Reset the device (write 0 into status)
//       ptr.add(MmioOffsets::Status.scale32()).write_volatile(0);
//       let mut status_bits = StatusField::Acknowledge.val32();
//       // 2. Set ACKNOWLEDGE status bit
//       ptr.add(MmioOffsets::Status.scale32()).write_volatile(status_bits);
//       // 3. Set the DRIVER status bit
//       status_bits |= StatusField::DriverOk.val32();
//       ptr.add(MmioOffsets::Status.scale32()).write_volatile(status_bits);
//       // 4. Read device feature bits, write subset of feature
//       // bits understood by OS and driver    to the device.
//       let host_features = ptr.add(MmioOffsets::HostFeatures.scale32()).read_volatile();
//       let guest_features = host_features & !(1 << VIRTIO_BLK_F_RO);
//       let ro = host_features & (1 << VIRTIO_BLK_F_RO) != 0;
//       ptr.add(MmioOffsets::GuestFeatures.scale32()).write_volatile(guest_features);
//       // 5. Set the FEATURES_OK status bit
//       status_bits |= StatusField::FeaturesOk.val32();
//       ptr.add(MmioOffsets::Status.scale32()).write_volatile(status_bits);
//       // 6. Re-read status to ensure FEATURES_OK is still set.
//       // Otherwise, it doesn't support our features.
//       let status_ok = ptr.add(MmioOffsets::Status.scale32()).read_volatile();
//       // If the status field no longer has features_ok set,
//       // that means that the device couldn't accept
//       // the features that we request. Therefore, this is
//       // considered a "failed" state.
//       if false == StatusField::features_ok(status_ok) {
//         print!("features fail...");
//         ptr.add(MmioOffsets::Status.scale32()).write_volatile(StatusField::Failed.val32());
//         return false;
//       }
//       // 7. Perform device-specific setup.
//       // Set the queue num. We have to make sure that the
//       // queue size is valid because the device can only take
//       // a certain size.
//       let qnmax = ptr.add(MmioOffsets::QueueNumMax.scale32()).read_volatile();
//       ptr.add(MmioOffsets::QueueNum.scale32()).write_volatile(VIRTIO_RING_SIZE as u32);
//       if VIRTIO_RING_SIZE as u32 > qnmax {
//         print!("queue size fail...");
//         return false;
//       }
//       // First, if the block device array is empty, create it!
//       // We add 4095 to round this up and then do an integer
//       // divide to truncate the decimal. We don't add 4096,
//       // because if it is exactly 4096 bytes, we would get two
//       // pages, not one.
//       let num_pages = (size_of::<Queue>() + PAGE_SIZE - 1) / PAGE_SIZE;
//       // println!("np = {}", num_pages);
//       // We allocate a page for each device. This will the the
//       // descriptor where we can communicate with the block
//       // device. We will still use an MMIO register (in
//       // particular, QueueNotify) to actually tell the device
//       // we put something in memory. We also have to be
//       // careful with memory ordering. We don't want to
//       // issue a notify before all memory writes have
//       // finished. We will look at that later, but we need
//       // what is called a memory "fence" or barrier.
//       ptr.add(MmioOffsets::QueueSel.scale32()).write_volatile(0);
//       // Alignment is very important here. This is the memory address
//       // alignment between the available and used rings. If this is wrong,
//       // then we and the device will refer to different memory addresses
//       // and hence get the wrong data in the used ring.
//       // ptr.add(MmioOffsets::QueueAlign.scale32()).write_volatile(2);
//       let queue_ptr = zalloc(num_pages) as *mut Queue;
//       let queue_pfn = queue_ptr as u32;
//       ptr.add(MmioOffsets::GuestPageSize.scale32()).write_volatile(PAGE_SIZE as u32);
//       // QueuePFN is a physical page number, however it
//       // appears for QEMU we have to write the entire memory
//       // address. This is a physical memory address where we
//       // (the OS) and the block device have in common for
//       // making and receiving requests.
//       ptr.add(MmioOffsets::QueuePfn.scale32()).write_volatile(queue_pfn / PAGE_SIZE as u32);
//       // We need to store all of this data as a "BlockDevice"
//       // structure We will be referring to this structure when
//       // making block requests AND when handling responses.
//       let bd = BlockDevice { queue:        queue_ptr,
//                               dev:          ptr,
//                               idx:          0,
//                               ack_used_idx: 0,
//                               read_only:    ro, };
//       BLOCK_DEVICES[idx] = Some(bd);
  
//       // 8. Set the DRIVER_OK status bit. Device is now "live"
//       status_bits |= StatusField::DriverOk.val32();
//       ptr.add(MmioOffsets::Status.scale32()).write_volatile(status_bits);
  
//       true
//     }
//   }
  

// impl MmioOffsets {
//     pub fn val(self) -> usize {
//       self as usize
//     }
  
//     pub fn scaled(self, scale: usize) -> usize {
//       self.val() / scale
//     }
  
//     pub fn scale32(self) -> usize {
//       self.scaled(4)
//     }
  
//   }

//   pub fn probe() {
//     // Rust's for loop uses an Iterator object, which now has a step_by
//     // modifier to change how much it steps. Also recall that ..= means up
//     // to AND including MMIO_VIRTIO_END.
//     for addr in (MMIO_VIRTIO_START..=MMIO_VIRTIO_END).step_by(MMIO_VIRTIO_STRIDE) {
//       print!("Virtio probing 0x{:08x}...", addr);
//       let magicvalue;
//       let deviceid;
//       let ptr = addr as *mut u32;
//       unsafe {
//         magicvalue = ptr.read_volatile();
//         deviceid = ptr.add(2).read_volatile();
//       }
//       // 0x74_72_69_76 is "virt" in little endian, so in reality
//       // it is triv. All VirtIO devices have this attached to the
//       // MagicValue register (offset 0x000)
//       if MMIO_VIRTIO_MAGIC != magicvalue {
//         println!("not virtio.");
//       }
//       // If we are a virtio device, we now need to see if anything
//       // is actually attached to it. The DeviceID register will
//       // contain what type of device this is. If this value is 0,
//       // then it is not connected.
//       else if 0 == deviceid {
//         println!("not connected.");
//       }
//       // If we get here, we have a connected virtio device. Now we have
//       // to figure out what kind it is so we can do device-specific setup.
//       else {
//         match deviceid {
//           // DeviceID 2 is a block device
//           2 => {
//             print!("block device...");
//             if false == setup_block_device(ptr) {
//               println!("setup failed.");
//             }
//             else {
//               let idx = (addr - MMIO_VIRTIO_START) >> 12;
//               unsafe {
//                 VIRTIO_DEVICES[idx] =
//                   Some(VirtioDevice::new_with(DeviceTypes::Block));
//               }
//               println!("setup succeeded!");
//             }
//           },
//           // DeviceID 4 is a random number generator device
//           4 => {
//             print!("entropy device...");
//             if false == setup_entropy_device(ptr) {
//               println!("setup failed.");
//             }
//             else {
//               println!("setup succeeded!");
//             }
//           },
//           _ => println!("unknown device type."),
//         }
//       }
//     }
//   }  

pub fn init() {
    block::init();
}
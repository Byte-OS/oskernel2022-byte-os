TARGET      := riscv64gc-unknown-none-elf
MODE        := debug
KERNEL_FILE := target/$(TARGET)/$(MODE)/os
BIN_FILE    := target/$(TARGET)/$(MODE)/kernel.bin

OBJDUMP     := rust-objdump --arch-name=riscv64
OBJCOPY     := rust-objcopy --binary-architecture=riscv64

FS_IMG := fs.img

# BOARD
BOARD ?= qemu
SBI ?= rustsbi
BOOTLOADER := bootloader/$(SBI)-$(BOARD).bin

.PHONY: doc kernel build clean qemu run

all: build

build: $(BIN_FILE) 

kernel:
	@cargo build

$(BIN_FILE): kernel
	$(OBJCOPY) $(KERNEL_FILE) --strip-all -O binary $@

asm:
	@$(OBJDUMP) -d $(KERNEL_FILE) | less

asmfile:
	@$(OBJDUMP) -d $(KERNEL_FILE) > kernel.S

# 清理编译出的文件
clean:
	@cargo clean

qemu: build
	@qemu-system-riscv64 \
            -machine virt \
            -bios $(BOOTLOADER) \
            -device loader,file=$(BIN_FILE),addr=0x80200000 \
			-drive file=$(FS_IMG),if=none,format=raw,id=x0 \
        	-device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0 \
			-kernel $(BIN_FILE) \
			-nographic \
			-smp 4 

debug: build
	@qemu-system-riscv64 \
            -machine virt \
            -bios $(BOOTLOADER) \
            -device loader,file=$(BIN_FILE),addr=0x80200000 \
			-drive file=$(FS_IMG),if=none,format=raw,id=x0 \
        	-device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0 \
			-nographic \
			-smp 4 \
			-s -S

fs-img: 
	@rm -f $(FS_IMG)
	@dd if=/dev/zero of=$(FS_IMG) count=81920 bs=512	# 40M
	@mkfs.vfat $(FS_IMG) -F 32

gdb:
	riscv64-elf-gdb \
        -ex 'file $(KERNEL_FILE)' \
        -ex 'set arch riscv:rv64' \
        -ex 'target remote localhost:1234'

hexdump:
	hexdump $(FS_IMG) -C

run: build qemu

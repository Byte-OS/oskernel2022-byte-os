TARGET      := riscv64imac-unknown-none-elf
MODE        := debug
MODE_FLAG	:= 
KERNEL_FILE := target/$(TARGET)/$(MODE)/os
BIN_FILE    := target/$(TARGET)/$(MODE)/kernel.bin

OBJDUMP     := rust-objdump --arch-name=riscv64
OBJCOPY     := rust-objcopy --binary-architecture=riscv64

FS_IMG := fs.img

# BOARD
BOOTLOADER := bootloader/rustsbi-qemu.bin
BOOTLOADER_K210 := bootloader/rustsbi-k210.bin

K210-SERIALPORT	= /dev/ttyUSB0
K210-BURNER	= ../tools/kflash.py


.PHONY: doc kernel build clean qemu run k210 flash

# all: build
all: k210
	cp $(BIN_FILE) os.bin

build: kernel $(BIN_FILE)

kernel:
	@cp src/linker-qemu.ld src/linker.ld
	@cargo build $(MODE_FLAG) --features "board_qemu"
	@rm src/linker.ld
	$(OBJCOPY) $(KERNEL_FILE) --strip-all -O binary $(BIN_FILE)

asm:
	@$(OBJDUMP) -d $(KERNEL_FILE) | less

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

coredump:
	hexdump $(BIN_FILE) -C

run: qemu

k210: 
	@cp src/linker-k210.ld src/linker.ld
	@cargo build $(MODE_FLAG) --features "board_k210"
	@rm src/linker.ld
	$(OBJCOPY) $(KERNEL_FILE) --strip-all -O binary $(BIN_FILE)
	@cp $(BOOTLOADER_K210) $(BOOTLOADER_K210).copy
	@dd if=$(BIN_FILE) of=$(BOOTLOADER_K210).copy bs=131072 seek=1
	@mv $(BOOTLOADER_K210).copy $(BIN_FILE)

flash: k210
	(which $(K210-BURNER)) || (cd .. && git clone https://hub.fastgit.xyz/sipeed/kflash.py.git && mv kflash.py tools)
	@sudo chmod 777 $(K210-SERIALPORT)
	python3 $(K210-BURNER) -p $(K210-SERIALPORT) -b 1500000 $(BIN_FILE)
	python3 -m serial.tools.miniterm --eol LF --dtr 0 --rts 0 --filter direct $(K210-SERIALPORT) 115200
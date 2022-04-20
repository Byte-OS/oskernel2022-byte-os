TARGET      := riscv64gc-unknown-none-elf
MODE        := debug
KERNEL_FILE := target/$(TARGET)/$(MODE)/os
BIN_FILE    := target/$(TARGET)/$(MODE)/kernel.bin

OBJDUMP     := rust-objdump --arch-name=riscv64
OBJCOPY     := rust-objcopy --binary-architecture=riscv64

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
			-kernel $(BIN_FILE) \
			-nographic \
			-smp 4 
gdb:
	riscv64-elf-gdb \
        -ex 'file $(KERNEL_FILE)' \
        -ex 'set arch riscv:rv64' \
        -ex 'target remote localhost:1234'

run: build qemu

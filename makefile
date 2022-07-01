
.PHONY: doc kernel build clean qemu run k210 flash

run:
	@cd kernel && make -f makefile run || exit 1;

flash:
	@cd kernel && make -f makefile flash || exit 1;


hexdump:
	@cd kernel && make -f makefile hexdump || exit 1;

coredump:
	@cd kernel && make -f makefile FS_IMG=../$(FS_IMG) coredump || exit 1;

fs-img: 
	@rm -f $(FS_IMG)
	@dd if=/dev/zero of=$(FS_IMG) count=81920 bs=512	# 40M
	@mkfs.vfat $(FS_IMG) -F 32

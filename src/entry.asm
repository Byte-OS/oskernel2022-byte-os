# 操作系统启动时所需的指令以及字段
#
# 我们在 linker.ld 中将程序入口设置为了 _start，因此在这里我们将填充这个标签
# 它将会执行一些必要操作，然后跳转至我们用 rust 编写的入口函数
#
# 关于 RISC-V 下的汇编语言，可以参考 https://github.com/riscv/riscv-asm-manual/blob/master/riscv-asm.md

    .section .text.entry
    .globl _start
# 目前 _start 的功能：将预留的栈空间写入 $sp，然后跳转至 rust_main
_start:
    #la a0, page_table
    #addi a1, x0, 8
    #slli a1, a1, 60
    #add a0, a0, a1
    #csrw satp, a0
    #sfence.vma

    la sp, boot_stack_top
    call rust_main

    # 回忆：bss 段是 ELF 文件中只记录长度，而全部初始化为 0 的一段内存空间
    # 这里声明字段 .bss.stack 作为操作系统启动时的栈
    .section .bss.stack
    .global pte
    .global pti
pte:
    .space 4096 * 4
pti:
    .space 4096 * 4
    .global boot_stack
boot_stack:
    # 16K 启动栈大小
    .space 4096 * 16
    .global boot_stack_top
boot_stack_top:
    # 栈结尾
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
    .global change_task
change_task:
    # csrw satp, a0
    sfence.vma

    la a0, int_callback_entry
    csrw stvec, a0

    csrw sscratch, sp
    mv sp, a1

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

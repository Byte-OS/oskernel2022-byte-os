.altmacro
    .section .text
    .global int_callback_entry
    .global __restore
int_callback_entry:
    # 交换栈
    csrrw sp, sscratch, sp
    # 申请栈空间
    addi sp, sp, -34*8
    # 保存x1寄存器
    sd x1, 1*8(sp)
    # 保存x3寄存器
    sd x3, 3*8(sp)
    # 保存x5-想1寄存器
    .set n, 4
    .rept 27
        SAVE_N %n
        .set n, n+1
    .endr
    # 保存寄存器信息
    csrr t0, sstatus
    csrr t1, sepc
    sd t0, 32*8(sp)
    sd t1, 33*8(sp)
    # 读取用户栈信息 写入context
    csrr t2, sscratch
    sd t2, 2*8(sp)
    # 将sp作为参数传入
    mv a0, sp
    # 第二个参数设置为scause
    csrr a1, scause
    # 第三个参数设置为stval
    csrr a2, stval

    call interrupt_callback

    # 返回context
    mv sp, a0
    # 读取寄存器信息
    ld t0, 32*8(sp)
    ld t1, 33*8(sp)
    ld t2, 2*8(sp)
    csrw sstatus, t0
    csrw sepc, t1
    csrw sscratch, t2
    # 恢复寄存器信息
    ld x1, 1*8(sp)
    ld x3, 3*8(sp)
    .set n, 4
    .rept 27
        LOAD_N %n
        .set n, n+1
    .endr
    # 释放内核栈空间
    addi sp, sp, 34*8
    # 内核栈和用户栈交换
    csrrw sp, sscratch, sp
    sret
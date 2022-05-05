
int_callback_entry:
    addi sp, sp, -34*8
    addi a0, x0, 10

    # 将a0中的值存入 sp + 1*8 存入a0的值
    sd  a0, 1*8(sp)

    add a0, x0, sp
    # scause: Scause
    csrr a1, scause
    # stval: usize
    csrr a2, stval
    call interrupt_callback
    sret
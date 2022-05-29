    .section .text
    .global change_task
change_task:
    # csrw satp, a0
    sfence.vma

    lui a0, 0x1
    csrw sepc, a0

    la a0, int_callback_entry
    csrw stvec, a0

    csrw sscratch, sp
    mv sp, a1
    sret

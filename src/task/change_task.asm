    .section .text
    .global change_task
change_task:
    # csrw satp, a0
    # lui ra, 0x1
    lui a0, 0x1
    csrw sepc, a0
    sfence.vma
    csrw sscratch, sp
    mv sp, a1
    sret

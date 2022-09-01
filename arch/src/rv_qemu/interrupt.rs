use core::arch::asm;

#[naked]
#[no_mangle]
pub unsafe extern "C" fn kernelvec() {
    asm!(r"
    .altmacro
    .set    REG_SIZE, 8
    .set    CONTEXT_SIZE, 34

    .macro SAVE_K reg, offset
        sd  \reg, \offset*8(sp)
    .endm
    
    .macro SAVE_K_N n
        SAVE_K  x\n, \n
    .endm
    
    .macro LOAD_K reg, offset
        ld  \reg, \offset*8(sp)
    .endm
    
    .macro LOAD_K_N n
        LOAD_K  x\n, \n
    .endm

    .section .text
    .align 2
    addi    sp, sp, CONTEXT_SIZE*-8

    SAVE_K    x1, 1
    addi    x1, sp, 34*8
    SAVE_K    x1, 2
    .set    n, 3
    .rept   29
        SAVE_K_N  %n
        .set    n, n + 1
    .endr
    csrr    t0, sstatus
    csrr    t1, sepc
    SAVE_K    t0, 32
    SAVE_K    t1, 33

    add a0, x0, sp
    csrr a1, scause
    csrr a2, stval

    call kernel_callback

    LOAD_K    s1, 32
    LOAD_K    s2, 33
    csrw    sstatus, s1
    csrw    sepc, s2

    LOAD_K    x1, 1

    .set    n, 3
    .rept   29
        LOAD_K_N  %n
        .set    n, n + 1
    .endr

    LOAD_K    x2, 2
    sret
    ", 
    
    options(noreturn))
}

#[naked]
#[no_mangle]
pub unsafe extern "C" fn change_task(context_ptr: usize) {
    asm!(r"
    .altmacro

    .set    REG_SIZE, 8
    .set    CONTEXT_SIZE, 34

    .macro SAVE reg, offset
        sd  \reg, \offset*8(sp)
    .endm

    .macro SAVE_N n
        SAVE  x\n, \n
    .endm

    .macro SAVE_TP reg, offset
        sd  \reg, \offset*8(tp)
    .endm

    .macro SAVE_TP_N n
        SAVE_TP  x\n, \n
    .endm

    .macro LOAD reg, offset
        ld  \reg, \offset*8(sp)
    .endm

    .macro LOAD_N n
        LOAD  x\n, \n
    .endm

    addi sp, sp, -32*8
    
    SAVE_N 1
    SAVE_N 3
    .set n, 4
    .rept 28
        SAVE_N %n
        .set n, n+1
    .endr

    la a1, __task_restore
    csrw stvec, a1

    csrw sscratch, sp
    mv sp, a0

    LOAD    t0, 32
    LOAD    t1, 33

    # csrw sstatus, t0
    csrw sepc, t1

    LOAD    x1, 1

    .set    n, 3
    .rept   29
        LOAD_N  %n
        .set    n, n + 1
    .endr

    LOAD    x2, 2
    sfence.vma
    sret
    ", options(noreturn))
}

#[naked]
#[no_mangle]
pub unsafe extern "C" fn __task_restore() {
    asm!(r"
    .altmacro
    .align 2
    csrrw sp, sscratch, sp

    sd tp, 0(sp)
    ld tp, 10*8(sp)

    SAVE_TP_N 1
    SAVE_TP_N 3
    .set n, 5
    .rept 27
        SAVE_TP_N %n
        .set n, n+1
    .endr
    csrr t0, sstatus
    csrr t1, sepc
    csrr t2, sscratch
    sd t0, 32*8(tp)
    sd t1, 33*8(tp)
    sd t2, 2*8(tp)

    ld a0, 0(sp)
    sd a0, 4*8(tp)

    LOAD_N 1
    LOAD_N 3
    .set n, 4
    .rept 28
        LOAD_N %n
        .set n, n+1
    .endr

    la a0, kernelvec
    csrw stvec, a0
    
    addi sp, sp, 32*8
    ret
    ", options(noreturn))
}


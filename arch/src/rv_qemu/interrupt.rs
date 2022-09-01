use core::arch::asm;

#[naked]
#[no_mangle]
pub unsafe extern "C" fn kernelvec() {
    asm!("",
    // .altmacro
    // ",
    // r"
    // .set    REG_SIZE, 8
    // .set    CONTEXT_SIZE, 34

    // .macro SAVE_K reg, offset
    //     sd  \reg, \offset*8(sp)
    // .endm
    
    // .macro SAVE_K_N n
    //     SAVE_K  x\n, \n
    // .endm
    
    // .macro LOAD_K reg, offset
    //     ld  \reg, \offset*8(sp)
    // .endm
    
    // .macro LOAD_K_N n
    //     LOAD_K  x\n, \n
    // .endm

    // .section .text
    // .align 2
    // addi    sp, sp, CONTEXT_SIZE*-8

    // SAVE_K    x1, 1
    // addi    x1, sp, 34*8
    // SAVE_K    x1, 2
    // .set    n, 3
    // .rept   29
    //     SAVE_K_N  %n
    //     .set    n, n + 1
    // .endr
    // csrr    t0, sstatus
    // csrr    t1, sepc
    // SAVE_K    t0, 32
    // SAVE_K    t1, 33

    // add a0, x0, sp
    // csrr a1, scause
    // csrr a2, stval

    // call kernel_callback

    // LOAD_K    s1, 32
    // LOAD_K    s2, 33
    // csrw    sstatus, s1
    // csrw    sepc, s2

    // LOAD_K    x1, 1

    // .set    n, 3
    // .rept   29
    //     LOAD_K_N  %n
    //     .set    n, n + 1
    // .endr

    // LOAD_K    x2, 2
    // sret
    "", 
    
    options(noreturn))
}
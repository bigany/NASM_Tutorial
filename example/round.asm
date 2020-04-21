bits 64
default rel

segment .data
    msg db "Hello world! %d", 0xd, 0xa, 0
    default_cw  dw 0000h
    nearest     dw 0000h
    down        dw 0400h
    up          dw 0800h
    zero        dw 0C00h

segment .bss
    result  resd 1

segment .text
global main

extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32
    finit
    fstcw   WORD [default_cw]
    
    mov     ax, [default_cw]
    and     ah, 11110011b
    or      [nearest], ax
    or      [down], ax
    or      [up], ax
    or      [zero], ax

    xor     ax, ax
    fldcw   [down]
    fldpi
    fld     dword [default_cw]
    fsub    st0, st1
    frndint
    fist    DWORD [result]
    xor     rdx, rdx
    mov     edx, [result]
    lea     rcx, [msg]
    call    printf

    xor     rax, rax
    call    ExitProcess
bits 64
default rel

segment .data
    align 16
    msg db "Hello world! %f", 0xd, 0xa, 0
    align 16
    valueA dq 1.2
    pi  dq 3.14159265358979
segment .bss
    result resq 1

segment .text
global main

extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    movsd   xmm0, [valueA]
    addsd   xmm0, [pi]
    movsd   [result], xmm0

    lea     rcx, [msg]
    
    ;fld     dword [result]
    ;fst     qword [result]
    mov     rdx, [result]
    
    call    printf

    xor     rax, rax
    call    ExitProcess
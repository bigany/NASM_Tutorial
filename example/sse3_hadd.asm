bits 64
default rel

segment .data
    align 16
    msg db "Hello world! %f", 0xd, 0xa, 0
    align 16
    vectorA dd 1.2, 3.4, 5.6, 7.8
    vectorB dd 7.8, 5.6, 3.4, 1.2
segment .bss
    result resd 4
    tmp resd 2
segment .text
global main

extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    movaps  xmm0, [vectorA]
    movaps  xmm1, [vectorB]
    haddps  xmm0, xmm1
    movaps  [result], xmm0

    lea     rcx, [msg]
    
    mov     edx, DWORD [result]
    mov     DWORD [tmp], edx
    fld     DWORD [tmp]
    fst     QWORD [tmp]
    
    mov     rdx, [tmp]
    call    printf

    xor     rax, rax
    call    ExitProcess
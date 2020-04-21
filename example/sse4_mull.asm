bits 64
default rel

segment .data
    align 16
    msg db "Hello world! %d", 0xd, 0xa, 0
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

    movaps      xmm0, [vectorA]
    roundps     xmm1, xmm0, 1
    cvtps2dq    xmm2, xmm1
    movaps      xmm3, [vectorB]
    roundps     xmm4, xmm3, 2
    cvtps2dq    xmm5, xmm4
    pmulld      xmm5, xmm2
    movaps      [result], xmm5

    lea     rcx, [msg]
    xor     rdx, rdx
    mov     edx, DWORD [result]
    call    printf

    xor     rax, rax
    call    ExitProcess
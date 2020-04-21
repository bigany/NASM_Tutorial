bits 64
default rel

segment .data
    align 16
    msg db "Hello world! %d", 0xd, 0xa, 0
    align 16
    vectorA dd 1.2, 3.4, 5.6, 7.8, 8.9, 9.0, 0.9, 9.8
    vectorB dd 7.8, 5.6, 3.4, 1.2, 0.1, 0.0, 8.1, -0.8
    vectorC dd 1, 1, 1, 1
    vectorD dd -2, -2, -2, -2

segment .bss
    result resd 4
segment .text
global main

extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    vmovaps     ymm0, [vectorA]
    vmovaps     ymm1, [vectorB]
    vaddps      ymm2, ymm1, ymm0

    vmovdqa     xmm3, [vectorC]
    vmovdqa     xmm4, [vectorC]
    vpsignd     xmm4, xmm3, [vectorD]

    vmovdqa     [result], xmm4
    
    lea     rcx, [msg]
    mov     rdx, [result]
    call    printf

    xor     rax, rax
    call    ExitProcess
bits 64
default rel

segment .data
    msg db "Hello world! %llX", 0xd, 0xa, 0
    w1  dw 1, 2, 3, 4
    w5  dw 5, 6, 7, 8
    result  dq 0

segment .text
global main

extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    movq    mm0, [w1]
    movq    mm1, [w5]

    paddsb  mm0, mm1
    movq    [result], mm0

    lea     rcx, [msg]
    mov     rdx, [result]
    ;and     rdx, 0ffffh
    ;shr     rdx, 48
    call    printf

    xor     rax, rax
    call    ExitProcess
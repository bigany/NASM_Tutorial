bits 64
default rel

%macro intAdd 3
    mov     eax, [%2]
    add     eax, [%3]
    mov     [%1], eax
%endmacro
segment .data
    msg db "Hello world! %d", 0xd, 0xa, 0
    intA dd 2
    intB dd 8
    result dd 0

segment .text
global main

extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    intAdd  result, intA, intB

    lea     rcx, [msg]
    xor     rdx, rdx
    mov     edx, eax
    call    printf

    xor     rax, rax
    call    ExitProcess
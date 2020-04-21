bits 64
default rel

segment .data
    fmt db "Factorical is: %d", 0xd, 0xa, 0

segment .text

global factorical
global main
extern _CRT_INIT
extern ExitProcess
extern printf


factorical:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    test    ecx, ecx   ;n
    jz      .zero
    mov     ebx, 1     ;counter c
    mov     eax, 1     ;result

    inc     ecx

.for_loop:
    cmp     ebx, ecx
    je      .end_loop

    mul     ebx         ;multiply ebx * eax and store in eax 

    inc     ebx
    jmp     .for_loop

.zero:
    mov     eax, 1

.end_loop:
    leave
    ret


main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32


    mov     rcx, 5
    call    factorical 

    lea     rcx, [fmt]
    mov     rdx, rax
    call    printf

    xor     rax, rax
    call    ExitProcess
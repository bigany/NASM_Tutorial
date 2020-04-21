bits 64
default rel

segment .data
    align 4
    msg db "Chapter04! %d", 0xd, 0xa, 0
    addr db "Chapter04! %p", 0xd, 0xa, 0
    res dq 8
    val dd 2
    arrayA db 2, 4, 6, 8
    arrayB dd 0FFFFFh, 0FFFFEh, 0FFFFDh, 0FFFFCh
    len equ ($-arrayB)

segment .text
global main

extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    lea     rcx, [msg]
    mov     rax, 0ah
    mov     rdx, 10h
    xchg    eax, edx
    inc     edx
    sub     rdx, [res]
    neg     dx
    call    printf
    
    mov     eax, 0ah
    lea     rcx, [msg]
    mov     ebx, 08h
    mul     ebx
    div     dword [val]
    mov     edx, eax
    shr     edx, 2
    call    printf

    mov     eax, -534
    cdq
    mov     ebx, 15
    idiv    ebx
    lea     rcx, [msg]
    call    printf

    lea     rcx, [addr]
    mov     rdx, rcx
    call    printf

    lea     rcx, [msg]
    mov     rdx, [arrayB+8]
    call    printf
    xor     rax, rax
    call    ExitProcess
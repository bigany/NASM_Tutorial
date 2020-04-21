bits 64
default rel

segment .data
    align 4
    msg db "BubbleSort:", 0xd, 0xa, 0
    val db "%d ", 0
    newline db 0xd, 0xa, 0
    array dq 5, 8, 2, 9, 4, 6, 3, 1, 10, 7
    len equ ($-array)

segment .text
global main, BubbleSort, print

extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    lea     rdi, [array]
    mov     rsi, 10
    call    BubbleSort

    lea     rcx, [msg]
    call    printf

    lea     rdi, [array]
    xor     rbx, rbx
    ploop:
    cmp     rbx, 10
    jge     pend
    lea     rcx, [val]
    mov     rdx, [rdi + rbx*8]
    call    printf
    inc     rbx
    jmp     ploop
    pend:
    xor     rax, rax
    call    ExitProcess

BubbleSort:
    push    rbp
    mov     rbp, rsp
    push    rbx

    xor     rax, rax
    mov     rdx, rsi

    outer:
        xor     rbx, rbx
        mov     rcx, rdx
        sub     rcx, rax
        dec     rcx
        inner:
            mov     r8, [rdi + rbx * 8]
            cmp     r8, [rdi + rbx * 8 + 8]
            jle     conti
            xchg    r8, [rdi + rbx * 8 + 8]
            mov     qword   [rdi + rbx * 8], r8
            conti:
            inc     rbx
            cmp     rbx, rcx
            jl      inner
        
        inc     rax
        cmp     rax, rdx
        jl      outer

    pop     rbx
    pop     rbp
    ret


bits 64
default rel

segment .data
    msg db "Hello world! %d", 0xd, 0xa, 0
    num1 dq 2
    num2 dq 40

segment .text
global main, sum

extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    mov     rax, 10
    dec     rax
    mov     rbx, 5
    lea     rdi, [rel num1]
    lea     rsi, [rel num2]
    call    sum
    add     rax, rbx
    dec     rax
    
    lea     rcx, [msg]
    mov     rdx, rax
    call    printf

    xor     rax, rax
    call    ExitProcess

sum:
    push    rbp
    mov     rbp, rsp

    push    rbx
    mov     rax, [rdi]
    add     rax, [rsi]

    pop     rbx
    pop     rbp
    ret
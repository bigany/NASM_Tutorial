bits 64
default rel

segment .bss
    align 4
    rbk resb 18

segment .data
    align   4
    msg db "the position is %d", 0xd, 0xa, 0

    src db "a good boy", 0xd, 0xa, 0
    slen EQU ($-src)
    
    dst db  "good boy", 0xd, 0xa, 0
    dlen EQU ($-dst)

segment .text
global main

extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32
    
    lea     rsi, [src]
    lea     rdi, [dst]
    mov     rcx, slen
    mov     rdx, dlen

strstr:
    xor     rax, rax
    mov     rax, -1
    cmp     rcx, rdx
    jl      done
    
    sub     rcx, rdx
    xchg    rcx, rdx

    mov     r8, rcx
    xor     r9, r9
findstr:
    cmp     r9, rdx
    jg      done
    lea     rsi, [src]
    lea     rdi, [dst] 
    add     rsi, r9
    mov     rcx, r8
    cld
    repz    cmpsb
    jz      findit
    inc     r9
    jmp     findstr
findit:
    mov     rax, r9
done:
    lea     rcx, [msg]
    mov     rdx, rax
    call    printf

    xor     rax, rax
    call    ExitProcess



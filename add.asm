bits 64
default rel

segment .bss
    val RESD 1  
segment .data
    ALIGN 4
    fmt db "Result is: %d", 0xd, 0xa, 0
    sum dd 5
    ALIGN 4
    array dd 1,2,3,4
segment .text

global factorical
global main
extern _CRT_INIT
extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32



    lea     rcx, [fmt]

    mov     eax, 10
    xchg    DWORD [sum], eax
    inc     DWORD [sum]
    add     DWORD [sum], 50
    neg     DWORD [sum]
    
    mul     DWORD [sum]
    xchg    DWORD [sum], eax
    sar     DWORD [sum], 2
    shl     DWORD [sum], 2
    xchg    DWORD [sum], eax
    cdq
    mov     ebx, 3
    idiv    ebx

    ;mov     edx, DWORD [sum]
    mov     edx, eax
    call    printf

    lea     rcx, [fmt]
    mov     edx, DWORD [array + 4]
    call    printf
    ;MOVZX   eax, WORD [val] ;0extended
    ;MOVSX   eax, WORD [val] ;sign extended
    
    ;//////////////////////////////////////////////
    xor     rdx, rdx
    mov     rcx, 5
    myloop:
        inc     rdx
        loop    myloop
    
    lea     rcx, [fmt]
    call printf

    xor     rax, rax
    call    ExitProcess
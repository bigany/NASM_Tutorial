bits 64
default rel

segment .bss
    align 4
    STRUC person
        .name resb 255
        .age  resd 1
        .size
    ENDSTRUC
    dst resb 18
    empArr RESB person.size*10
    empSize EQU ($-empArr) / person.size

segment .data
    align   4
    msg db "Hello world! %d", 0xd, 0xa, 0
    len EQU ($-msg)
    mcp db "Hello world! %p", 0xd, 0xa, 0
    search db "!"

    employee: ISTRUC person
    AT person.name, DB "Ren"
    AT person.age, DD 29
    IEND

    nStr db "Hello world! %s", 0xd, 0xa, 0

segment .text
global main

extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    lea     rcx, [nStr]
    lea     rdx, [employee + person.name]
    call    printf

    lea     rsi, [msg]
    lea     rdi, [dst]
    mov     rcx, len
    cld
    rep     movsb

    mov     rcx, len
    lea     rsi, [msg]
    lea     rdi, [mcp]
    std
    repz    cmpsb

    mov     rdx, rcx
    lea     rcx, [dst]
    call    printf

    xor     rax, rax
    mov     al, [search]
    lea     rdi,[msg]
    mov     ecx, len
    cld
    repnz   scasb

    mov     rdx, rcx
    lea     rcx, [dst]
    call    printf

    

    xor     rax, rax
    call    ExitProcess
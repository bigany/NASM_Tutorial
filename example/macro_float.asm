bits 64
default rel

%macro f_add 3
    finit
    fld     QWORD [%2]
    fld     QWORD [%3]
    fadd    st0, st1
    fst     QWORD [%1]
%endmacro

%macro  f_sqrt 2
    finit
    fldpi
    fld     QWORD [%2]
    fsqrt
    fmul    st0, st1
    fst     QWORD [%1]
%endmacro

%macro  sqrtSum 3
    movsd   xmm0, [%2]
    movsd   xmm1, [%3]

    movsd   xmm2, xmm0
    mulsd   xmm0, xmm2
    
    movsd   xmm3, xmm1
    mulsd   xmm1, xmm3
    
    addsd   xmm0, xmm1
    sqrtsd  xmm1, xmm0
    
    movsd   [%1], xmm1
%endmacro

segment .data
    msg db "Hello world! %f", 0xd, 0xa, 0
    floatA dq 1.2
    floatB dq 3.1415926
    floatC dq 9.0
    scalarDA dq 3.0
    scalarDB dq 4.0   
    result dq 0.0

segment .text
global main

extern ExitProcess
extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32
    f_add    result, floatA, floatB
    f_sqrt  result, floatC
    sqrtSum result, scalarDA, scalarDB
    lea     rcx, [msg]
    mov     rdx, [result]
    call    printf

    xor     rax, rax
    call    ExitProcess
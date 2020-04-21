bits 64
default rel

segment .data
    align 16
    amountNeeded    dq 0.0
    interestRate    dq 0.0
    interest        dq 0.0
    monthlyPayment  dq 0.0
    duration        dq 0
    const100        dq 100.0
    const12         dq 12.0
    const1          dq 1.0
    amountMessage   db "    Enter Amount Needed:  $", 0
    interestMessage db "    Enter Interest Rate:  ", 0
    durationMessage db "    Enter Duration (in months):  ", 0
    paymentMessage  db "    Monthly Payment Amount:  $", 0


segment .text
global _asmMain

extern _printString
extern _printDouble
extern _getDouble
extern _getInt

_asmMain:
    push    rbp
    mov     rbp, rsp

    lea     rcx, [amountMessage]
    call    _printString
    call    _getDouble
    movsd   [amountNeeded], xmm0

    lea     rcx, [interestMessage]
    call    _printString
    call    _getDouble

    movsd   xmm1, [const100]
    divsd   xmm0, xmm1
    movsd   [interestRate], xmm0

    lea     rcx, [durationMessage]
    call    _printString
    call    _getInt
    mov     [duration], rax

    movsd   xmm0, [const12]
    movsd   xmm1, [interestRate]
    divsd   xmm1, xmm0
    movsd   [interest], xmm1

    movsd   xmm0, [interest]
    movsd   xmm1, [amountNeeded]
    mulsd   xmm1, xmm0
    movsd   xmm2, xmm1

    addsd   xmm0, [const1]
    mov     rdi, [duration]
    call    _pow

    subsd   xmm0, [const1]
    vdivsd  xmm1, xmm2, xmm0
    movsd   [monthlyPayment], xmm1

    lea     rcx, [paymentMessage]
    call    _printString
    movsd   xmm0, [monthlyPayment]
    call    _printDouble

    pop rbp
    ret

_pow:
    push    rbp
    mov     rbp, rsp

    mov     rcx, rdi
    dec     rcx
    movsd   xmm1, xmm0

    exp:
    mulsd   xmm0, xmm1
    loop exp

    pop rbp
    ret
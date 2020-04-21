bits 64
default rel
extern _printFloat
extern _printDouble

segment .data
value dd 1.2

segment .bss
r_value resd 1
f_value resd 1
d_value resq 1

segment .text
global _asmMain

_asmMain:
push    rbp
mov     rbp, rsp
sub     rsp, 32

finit
fldpi
fld     dword [value]
fadd    st0, st1
fist    dword [r_value]
fstp    dword [f_value]
movss   xmm0, dword [f_value]
call    _printFloat

fstp    qword [d_value]
movsd   xmm0, qword [d_value]
call    _printDouble

sub rsp, 32
pop rbp
ret
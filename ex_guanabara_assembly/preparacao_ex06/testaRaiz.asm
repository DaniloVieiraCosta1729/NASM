section .note.GNU-stack noalloc noexec nowrite

extern printf
extern ln
extern exp
extern ps2d
extern approx

section .data

    msg1 db "Digite um numero: "
    tamMsg1 equ $-msg1

    msg2 db "A raiz de %0.3lf eh: %0.5lf",10,0

section .bss

    num resb 30

section .text
    global main

main:

    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, tamMsg1
    syscall   

    mov rax, 0
    mov rdi, 0
    mov rsi, num
    mov rdx, 30
    syscall

    mov rdi, num
    call ps2d
    movsd xmm4, xmm0
    call approx

    movsd xmm1, xmm0
    movsd xmm0, xmm4

    sub rsp, 8
    mov rdi, msg2
    mov al, 2
    call printf
    add rsp, 8

    ret
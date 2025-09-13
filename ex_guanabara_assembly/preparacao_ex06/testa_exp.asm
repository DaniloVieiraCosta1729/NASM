section .note.GNU-stack noalloc noexec nowrite

extern ps2d
extern printf

section .data

    msg1 db "Digite um numero: "
    tamMsg1 equ $-msg1

    teste db "num = %lf\n",0

    valorTeste dq 10.0

section .bss

    buffer resb 50

section .text
    global main

main:

    ; vamos fazer o input com a syscall read e chamar ps2d em seguida.
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, tamMsg1
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 50
    syscall

    mov rdi, buffer
    call ps2d
    
    sub rsp, 8
    mov rdi, teste
    mov al, 1
    call printf
    add rsp, 8
    ret

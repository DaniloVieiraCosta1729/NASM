section .note.GNU-stack noalloc noexec nowrite
; Pedir um número e mostrar o dobro, triplo e a raiz quadrada desse número.

; Essa versão tem o objetivo de usar os recursos já prontos. 
; A vantagem é que assim eu aprendo sobre o alinhamento pedido pela System V application binary interface e vejo as peculiaridades de linkar com o gcc.
extern printf
extern scanf

section .data
    msg1 db "Digite um numero: "
    tam1 equ $-msg1

    dobro dq 2.0
    triplo dq 3.0

    scan1 db "%lf",0
    print1 db "O dobro eh %0.2f",10,0
    print2 db "O triplo eh %0.2f",10,0
    print3 db "A raiz quadrada eh %0.2f \n",0

section .bss
    n1 resq 1

section .text
    global main
main:
    mov eax, 1
    mov edi, 1
    mov rsi, msg1
    mov edx, tam1
    syscall

    ; pela convenção de chamadas do System V AMD64 e pela man 3 scanf, a função scanf deve ter essa forma
    ; scanf
    sub rsp, 8
    mov rdi, scan1
    mov rsi, n1
    call scanf
    add rsp, 8

    ; printf
    movsd xmm0, [n1]
    mulsd xmm0, [dobro]
    sub rsp, 8
    mov rdi, print1
    mov al, 1
    call printf
    add rsp, 8

    movsd xmm0, [n1]
    mulsd xmm0, [triplo]
    sub rsp, 8
    mov rdi, print2
    mov al, 1
    call printf
    add rsp, 8

    movsd xmm0, [n1]
    sqrtsd xmm0, xmm0
    sub rsp, 8
    mov rdi, print3
    call printf
    add rsp, 8

    ret
section .note.GNU-stack noalloc noexec nowrite 
extern scanf
extern printf
extern ln

section .data
    x dq 65.2
    y dq 32.9
    z dq 10.0

    msg db "ln(%0.3lf) = %0.2lf",10,0

section .text
    global main
main:
    mov rdi, [x]
    call ln
    movsd xmm1, xmm0
    movsd xmm0, [x]

    sub rsp, 8
    mov rdi, msg
    mov al, 2
    call printf
    add rsp, 8

    mov rdi, [y]
    call ln
    movsd xmm1, xmm0
    movsd xmm0, [y]

    sub rsp, 8
    mov rdi, msg
    mov al, 2
    call printf
    add rsp, 8

    mov rdi, [z]
    call ln
    movsd xmm1, xmm0
    movsd xmm0, [z]

    sub rsp, 8
    mov rdi, msg
    mov al, 2
    call printf
    add rsp, 8

    ret
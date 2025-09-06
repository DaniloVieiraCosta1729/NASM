; Esse arquivo apenas testa o uso dos registradores xmm.
; Vamos usar a libc pela primeira vez.

extern printf

section .data
    a dq 2.718281828459 ; se a conta estiver certa, essa é a representação de ponto-flutuante de e.
    b dq 3.141592653589

    msg db "e + pi = %0.2f",10,0

section .text
    global main

main:
    movsd xmm0, [a]
    addsd xmm0, [b]

    sub rsp, 8
    mov rdi, msg
    mov al, 1
    call printf
    add rsp,8
    ret

    section .note.GNU-stack noalloc noexec nowrite ; seção para o linker parar de chorar.

    ; observações interessantes sobre assembly montado pelo gcc: usamos main como entrada; ret da main já encerra o programa.

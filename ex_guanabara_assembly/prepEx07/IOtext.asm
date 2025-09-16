; ======================= TÍTULO =======================
; Testa as syscalls Openat e Close.

section .data

    nomeArquivo db "TextoEX07.txt",0

    texto db "Texto para testar o IO com NASM.", 10, "O objetivo e usar isso no exercicio 7."
    tamTexto equ $-texto
    
section .text
    global _start

_start:
    mov rax, 257 ; syscall nova -> openat
    mov rdi, -100; indica o diretório atual
    mov rsi, nomeArquivo
    mov rdx, 0101o ; 100o (O_WRONLY) + 1o (O_CREAT)
    mov r10, 0644o ; rw-r--r--
    syscall

    mov rbx, rax

    ; agora a gente pode simplesmente chamar a syscall write e passar o file descriptor que a openat retornou em rax.
    mov rdi, rax
    mov rax, 1
    mov rsi, texto
    mov rdx, tamTexto
    syscall

    ; Agora a segunda syscall nova (Close).
    mov rax, 3
    mov rdi, rbx
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
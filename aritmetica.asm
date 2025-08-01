section .data
    
section .bss
    buffer resb 11

section .text
    global _start

_start:
    mov rax, 93
    mov rbx, 10
    lea rdi, [buffer + 10]
    mov byte [rdi], 10

loopDivisao:
    xor rdx, rdx
    div rbx
    dec rdi
    add dl, '0'
    mov [rdi], dl
    test rax, rax
    jnz loopDivisao

    mov rax, 1
    mov rsi, rdi
    mov rdx, buffer + 11
    sub rdx, rdi
    mov rdi, 1
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
    
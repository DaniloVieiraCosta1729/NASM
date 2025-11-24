section .note.GNU-stack noalloc noexec nowrite
; Vamos criar uma funçãozinha simples para gerar número pseudo-aleatórios.

section .data 
; como structs são, no fim das contas, um chunk de memória contígua e os seus campos apenas offsets, podemos criar um espaço suficientemente grande e usar esses espaços como se fossem structs, como sockaddr ou, no nosso caso agora, timeval.
; A timeval é difinida assim: struct timeval {long tv_sec; long tv_usec;}; Ele tem, no total, 16 bytes. 

timeval: times 16 db 0
 
section .text
    global randomD

; input rdi
; output em rax
randomD:
    mov r9, rdi
    
    mov rax, 96
    mov rdi, timeval
    mov rsi, 0
    syscall

    mov rax, [timeval + 8]
    xor rdx, rdx
    mov ebx, r9d
    div ebx
    mov eax, edx
    ret

section .data
	pergunta db "Como voce se chama?",10
	tamPergunta equ $-pergunta

	saudacao db "Iae, "
	tamSaudacao equ $-saudacao
	tamNome equ 50

section .bss
	nome resb tamNome
	tamNomeReal resq 1

section .text
	global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, pergunta
	mov rdx, tamPergunta
	syscall

	mov rax, 0; system call do read
	mov rdi, 0; file descriptor da entrada padrao
	mov rsi, nome
	mov rdx, tamNome
	syscall

	mov [tamNomeReal], rax

	mov rax, 1
	mov rdi, 1
	mov rsi, saudacao
	mov rdx, tamSaudacao
	syscall

	mov rax, 1
	mov rdi, 1
	mov rsi, nome
	mov rdx, [tamNomeReal]
	syscall

	mov rax, 60
	mov rdi, 0
	syscall

section .data
	mensagem db "Oi, "
	tamMensagem equ $-mensagem

	nome db "Ana",10
	tamNome equ $-nome

	tamTotal equ tamMensagem + tamNome

section .text
	global _start

_start:

	mov rax, 1
	mov rdi, 1; file descriptor onde estamos colocando a mensagem
	mov rsi, mensagem
	mov rdx, tamTotal
	syscall

	;mov rax, 1
	;mov rdi, 1
	;mov rsi, nome
	;mov rdx, tamNome
	;syscall

	mov rax, 60
	mov rdi, 0
	syscall

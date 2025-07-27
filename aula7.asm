section .data
	msg db "Tardeh",10
	l equ $-msg

section .text
	global _start

_start:
	mov eax, 1
	mov edi, 1
	mov esi, msg
	mov edi, l; errando de proposito o registrador pra pegar o erro no debugger gdb
	syscall

	mov eax, 60
	mov edi, 0
	syscall

section .data
	x dd 2
	y dd 37
	
	msg1 db "x e maior ou igual a y.",10
	tam1 equ $-msg1

	msg2 db "y e maior que x",10
	tam2 equ $-msg2

section .text
	global _start
_start:
	mov eax, DWORD [x]
	mov ebx, DWORD [y]
	cmp eax, ebx
	jge maior
	jmp menor

maior:
	mov rax, 1
	mov rdi, 1
	mov rsi, msg1
	mov rdx, tam1
	syscall

	jmp encerra

menor:
	mov rax, 1
	mov rdi, 1
	mov rsi, msg2
	mov rdx, tam2
	syscall

encerra:
	mov rax, 60
	mov rdi, 0
	syscall

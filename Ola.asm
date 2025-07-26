section .data
	mensagem db 'Ola, mundo! Finalmente estou entendendo o Assembly =)', 10
	jeitoEstranho db 0x4F,108,97,44,32,0x4d,0x75,0x6e,0x64,111,10

	tamnhoJeitoEstranho equ 11
	tamanhoMensagem equ 54

section .text
	global _start

_start:
	mov rax, 1; identificador da sys_call que escreve
	mov rdi, 1; significa saida padrao
	mov rsi, jeitoEstranho; ponteiro para o lugar da memoria que guarda o conteudo de mensagem
	mov rdx, 11; o registrador rdx guarda aqui o tamanho da variavel
	syscall
	
	mov rax, 1
	mov rdi, 1
	mov rsi, mensagem
	mov rdx, tamanhoMensagem
	syscall

	mov rax, 60; system call que encerra o programa
	mov rdi, 0; primeiro parametro da syscall 60. O 0 indica que nao houve erros
	syscall

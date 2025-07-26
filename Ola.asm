section .data
	mensagem db 'Ola, mundo! Finalmente estou entendendo o Assembly =)', 10

section .text
	global _start

_start:
	mov rax, 1; identificador da sys_call que escreve
	mov rdi, 1; significa saida padrao
	mov rsi, mensagem; ponteiro para o lugar da memoria que guarda o conteudo de mensagem
	mov rdx, 54; o registrador rdx guarda aqui o tamanho da variavel
	syscall
	mov rax, 60; system call que encerra o programa
	mov rdi, 0; primeiro parametro da syscall 60. O 0 indica que nao houve erros
	syscall

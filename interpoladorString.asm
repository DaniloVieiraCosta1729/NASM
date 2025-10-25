;syscall write (endereço, tamanho)
%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

;syscall read
%macro read 2
    mov rax, 0
    mov rdi, 0
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

; macro para interpolação de strings.
; consegue concatenar até 5 strings na ondem em que são passados. Se usar menos, deve preencher os tamanhos dos espaços restantes com 0 ou outra coisa a passar algum endereço valido, como o da mensagem por exemplo;
; deve fornecer o par mensagem tamanho
%macro concat 10
    print %1, %2
    print %3, %4
    print %5, %6
    print %7, %8
    print %9, %10
%endmacro

section .data

    pergunta db "Qual é o seu nome?",10
    tamPergunta equ $-pergunta

    campoResposta db ">>> "
    tamCR equ $-campoResposta

    texto1 db "O nome do usuário é: "
    tamTexto1 equ $-texto1

    texto2 db "Mais texto só para ver se está funcionando mesmo.",10
    tamTexto2 equ $-texto2

section .bss

    nome resb 20
    tamNome resb 1

section .text
    global _start

_start:
    print pergunta, tamPergunta

    print campoResposta, tamCR

    read nome, 20

    mov [tamNome], rax

    ;print texto1, tamTexto1
    ;print nome, [tamNome]

    concat texto1, tamTexto1, nome, [tamNome], texto2, tamTexto2, nome, 0, nome, 0

    mov rax, 60
    mov rdi, 0
    syscall

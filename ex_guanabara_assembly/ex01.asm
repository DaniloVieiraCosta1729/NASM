;Esse é o primeiro arquivo de uma sequência de arquivos que têm como objetivo me ajudar a praticar habilidades muito básicas de escrita de código.
;Vou usar os exercícios propostos pelo Guanabara no curso de Python oferecido por ele.
;A linguagem que utilizarei, porém, será o Assembly para x86-64 com o montador NASM.

;Ex01 - Saudação

section .data
    ola db "Ola, "
    tamOla equ $ - ola

    pergunta db "Qual eh o seu nome?",10
    tamPergunta equ $ - pergunta

    tamMaxNome equ 20

section .bss
    nome resb tamMaxNome
    tamNome resb 1

section .text
    global _start

_start:
    ; vou usar a syscall write com a saida padrao
    mov rax, 1
    mov rdi, 1
    mov rsi, pergunta
    mov rdx, tamPergunta
    syscall

    ; agora vou usar a syscall read pela entrada padrao
    mov rax, 0
    mov rdi, 0
    mov rsi, nome
    mov rdx, tamMaxNome
    syscall

    mov [tamNome], rax; o rax guarda a quantidade de bytes digitados no read, então é só usar a dereferencia [] na variável estática que armazenará o tamanho real do nome.

    ;oi
    mov rax, 1
    mov rdi, 1
    mov rsi, ola
    mov rdx, tamOla
    syscall

    lea rdi, nome; estou declarando um ponteiro para o primeiro byte de nome
    mov rbx, [tamNome]
    add rdi, rbx
    add rdi, 1
    mov byte [rdi], 10

    ;nome
    mov rax, 1
    mov rdi, 1
    mov rsi, nome
    mov rdx, [tamNome]
    syscall

    ;terminar
    mov rax, 60
    mov rdi, 0
    syscall
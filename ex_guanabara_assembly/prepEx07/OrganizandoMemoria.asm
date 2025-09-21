; Aqui eu vou escreve um código bem simples usando apenas inteiros, porque eu quero testar o uso de struc e de macros, mas os bugs estão me impedindo de fazer isso com um código mais elaborado.

struc Aluno
    .nome resb 64
    .tamNome resb 1
    .nota01 resb 1
    .nota02 resb 1
    .nota03 resb 1
    .media resb 1
endstruc

%macro atribuiNota 4 ; struc, nota 1, nota 2, nota 3
    mov rax, %2
    mov byte [%1 + Aluno.nota01], al

    mov rax, %3
    mov byte [%1 + Aluno.nota02], al

    mov rax, %4
    mov byte [%1 + Aluno.nota03], al
%endmacro

%macro media 1
    xor rax, rax
    mov al, byte [%1 + Aluno.nota01]
    add al, byte [%1 + Aluno.nota02]
    add al, byte [%1 + Aluno.nota03]

    xor rdx, rdx
    xor rbx, rbx
    mov bl, 3
    div rbx
    mov byte [%1 + Aluno.media], al
%endmacro

%macro escrever 2 ; endereço, tamanho da mensagem
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro ler 2
    mov rax, 0
    mov rdi, 0
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro pulaLinha 0
    escrever bn, 1
%endmacro

%macro parseN2S 3; número, enderço do buffer, tamanho do buffer
    lea rdi, %2
    mov rsi, %3
    mov rax, %1
    mov rbx, 10
    xor rcx, rcx

    %%loop:
    xor rdx, rdx
    div rbx
    add dl, '0'
    mov byte [rdi + rsi], dl
    dec rsi
    inc rcx
    test rax, rax
    jnz %%loop
    inc rsi
%endmacro

%macro parseS2N 2; recebe o buffer com o texto e o tamanho dele
    
%endmacro

section .data

    bn db 10

    msg0 db "Olá,",10,"Digite o nome do aluno: "
    tamMsg0 equ $-msg0

    msgTeste db "O nome do primeiro aluno é: "
    tamMsgTeste equ $-msgTeste

    msgMedia db "A média do aluno é: "
    tamMsgMedia equ $-msgMedia

section .bss

    aluno1: resb Aluno_size

    mediaTexto resb 8 

section .text
    global _start

_start:
    escrever msg0, tamMsg0

    ler aluno1 + Aluno.nome, Aluno.nota01
    mov byte [aluno1 + Aluno.tamNome], al

    escrever msgTeste, tamMsgTeste
    escrever aluno1 + Aluno.nome, [aluno1 + Aluno.tamNome]
    pulaLinha

    ; Vamos passar a mão os valores das notas
    mov byte [aluno1 + Aluno.nota01], 9
    mov byte [aluno1 + Aluno.nota02], 5
    mov byte [aluno1 + Aluno.nota03], 7

    media aluno1

    escrever msgMedia, tamMsgMedia

    parseN2S [aluno1 + Aluno.media], mediaTexto, 8

    add rsi, mediaTexto

    escrever rsi, 8
    pulaLinha

    mov rax, 60
    mov rdi, 0
    syscall
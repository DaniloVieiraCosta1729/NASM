;Pede para o usuário digitar algo e responde se o que foi digitado é numérico, alfabético ou alfanumérico.
section .data
    msg1 db "Digite algo: "
    tam_msg1 equ $-msg1

    msg2 db "O input eh alfabetico."
    tam_msg2 equ $-msg2

    msg3 db "O input eh numerico."
    tam_msg3 equ $-msg3

    msg4 db "O input é alfanumerico."
    tam_msg4 equ $-msg4

section .bss
    resposta resb 50
    tamResposta resb 1
    alfa resb 1
    num resb 1

section .text
    global _start

_start:
    .pergunta:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, tam_msg1
    syscall

    .registra:
    mov rax, 0
    mov rdi, 0
    mov rsi, resposta
    mov rdx, 50
    syscall

    mov [tamResposta], al

   ; vamos marcar todos os campos com 0 para indicar que a entrada não é de nenhum tipo.
   mov [alfa], 0
   mov [num], 0

   ;agora vamos percorrer o buffer e, se encontrarmos um byte com um valor entre 48 e 57 marcamos a entrada como numerica.
   ; se encontrarmos um, com valor entre 65 e 90 ou 97 e 122, marcamos como alfabetica.

    .fim:
    mov rax, 60
    mov rdi, 0
    syscall
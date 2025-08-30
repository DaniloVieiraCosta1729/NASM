;Pede para o usuário digitar algo e responde se o que foi digitado é numérico, alfabético ou alfanumérico.

; recebe o endereço em rsi, retorna 0 se não for texto/numero, 1 se for texto e 2 se for numero. O retorno é em rax.
; usa bl para não ficar consultando o endereço toda a hora.
extern verifica

section .data
    msg1 db "Digite algo: "
    tam_msg1 equ $-msg1

    msg2 db "O input eh alfabetico."
    tam_msg2 equ $-msg2

    msg3 db "O input eh numerico."
    tam_msg3 equ $-msg3

    msg4 db "O input eh alfanumerico."
    tam_msg4 equ $-msg4

    msg5 db "O input nao eh nada."

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
    ;agora vamos percorrer o buffer.
    mov rsi, resposta
    xor rcx, rcx
    xor rdx, rdx
    mov dl, [tamResposta]
    mov cl, 0

    .loop00:
    cmp dl, cl
    jnz .alimentaDecisao
    
    xor rax, rax
    xor rbx, rbx
    mov al, [num]
    mov bl, [alfa]
    
    test al, bl
    jz .mostraNada

    cmp al, 1
    jl .mostraAlfabetico
    cmp bl, 1
    jl .mostraNumerico
    jmp .mostraAlfanumerico

    .mostraNada:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg5
    mov rdx, tam_msg5
    syscall
    jmp .fim

    .mostraNumerico:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg3
    mov rdx, tam_msg3
    syscall
    jmp .fim

    .mostraAlfabetico:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, tam_msg2
    syscall
    jmp .fim

    .mostraAlfanumerico:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg4
    mov rdx, tam_msg4
    syscall
    jmp .fim

    .alimentaDecisao:
    call verifica
    cmp rax, 2
    je .seNumero
    cmp rax, 1
    je .seLetra
    inc cl
    jmp .loop00

    .seNumero:
    ; se rax = 2
    mov [num], 1
    inc cl
    jmp .loop00

    .seLetra:
    ; se rax = 1
    mov [alfa], 1
    inc cl
    jmp .loop00

    .fim:
    mov rax, 60
    mov rdi, 0
    syscall
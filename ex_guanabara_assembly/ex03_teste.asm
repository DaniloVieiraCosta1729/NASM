; Pede dois números, soma e responde com o resultado.
extern string_num
extern num_string

section .data
    msg1 db "Digite um numero: "
    tam_msg1 equ $-msg1

    msg2 db "Digite o segundo numero: "
    tam_msg2 equ $-msg2

    barraN db 10

section .bss
    n1 resb 20
    valor_n1 resd 1

    n2 resb 20
    valor_n2 resd 1

    n3 resb 21

section .text
    global _start

_start:

; Syscall write para pedir o primeiro número
    mov eax, 1
    mov edi, 1
    mov rsi, msg1
    mov edx, tam_msg1
    syscall

; Syscall read para ler o input dos caracteres que compoem o número
leN1:
    mov rax, 0
    mov rdi, 0
    mov rsi, n1
    mov rdx, 20
    syscall

; Vamos testar a função que converte texto para numero
    mov esi, eax
    dec esi
    mov rdi, n1
    call string_num
    mov [valor_n1], eax

; Através do gdb, confirmei que o valor digitado foi convertido para número e foi armazenado no buffer valor_n1.

; write
    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, tam_msg2
    syscall
    
; read
leN2:
    mov eax, 0
    mov edi, 0
    mov rsi, n2
    mov edx, 20
    syscall

; alimenta o valor_n2 com o número representado em n2
    mov esi, eax; não expliquei isso antes, mas a função string_num usa o tamanho a ser lido em esi, por isso passo o valor de eax para esi e subtraio 1.
    dec esi
    mov rdi, n2
    call string_num
    mov [valor_n2], eax

; Agora começa a parte que não estava funcionando bem... Vamos somar valor_n1 com valor_n2, transformar o resultado em texto e escrecê-lo no terminal.
; Soma valor_n2 com valor_n2
resultado:
    xor eax, eax
    mov eax, [valor_n1]
    add eax, [valor_n2]

    mov rdi, n3
    xor rcx, rcx
    mov rcx, 20
    call num_string

; Write, para mostrar o resultado
    mov rdx, rax
    mov rsi, n3
    add rsi, rcx
    inc rsi
    mov rax, 1
    mov rdi, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, barraN
    mov rdx, 1
    syscall    

termina:
    mov rax, 60
    mov rdi, 0
    syscall
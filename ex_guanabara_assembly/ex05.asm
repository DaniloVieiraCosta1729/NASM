; Pede um número e informa o antecessor e sucessor desse número
; vamos fazer esse exercício para números de 32 bits.

section .data
    pergunta db "Digite um numero: "
    tamPergunta equ $-pergunta

    antecessorTexto db "O antecessor eh: "
    tamAntecessorTexto equ $-antecessorTexto

    sucessorTexto db "O sucessor eh: "
    tamSucessorTexto equ $-sucessorTexto

section .bss
    numero resb 11
    tamNumero resb 1

    sucessor resb 11
    tamSucessor resb 1

    antecessor resb 11
    tamAntecessor resb 1

section .text
    global _start

_start:
    mov eax, 1
    mov edi, 1
    mov rsi, pergunta
    mov edx, tamPergunta
    syscall

    mov eax, 0
    mov edi, 0
    mov rsi, numero
    mov edx, 11
    syscall

    dec eax
    mov [tamNumero], eax

    ; alimenta sucessor
    mov rsi, numero
    xor rdx, rdx
    mov dl, byte [tamNumero]
    call textNum
    
    mov r9d, eax
    dec eax
    inc r9d

    mov rsi, antecessor
    mov dil, byte [tamNumero]
    call numText
    mov byte [tamAntecessor], cl
    
    mov eax, r9d
    mov rsi, sucessor
    mov dil, byte [tamNumero]
    call numText
    mov byte [tamSucessor], cl

    mov rax, 1
    mov rdi, 1
    mov rsi, antecessorTexto
    mov rdx, tamAntecessorTexto
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, antecessor
    inc rsi
    mov rdx, tamAntecessor
    inc rdx
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, sucessorTexto
    mov rdx, tamSucessorTexto
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, sucessor
    inc rsi
    mov rdx, tamSucessor
    inc rdx

    syscall

; reimplementacao de texto -> num
; recebe o endereço do texto em rsi
; recebe a quantidade de bytes em dl
; retorna o valor em eax
; usa cl para iterar
; usa r8d para multiplicar
; usa bl para manipular o caractere
textNum:
    xor rcx, rcx
    xor rax, rax
    mov r8d, 10
    cmp dl, 0
    je .textNumReturn

    .fazNumero:
    imul eax, r8d
    mov bl, byte [rsi + rcx]
    sub bl, '0'
    add eax, ebx
    inc cl
    cmp dl, cl
    jnz .fazNumero

    .textNumReturn:
    ret

; guarda o resultado em rsi
; recebe o tamanho do output em dil (subdivisão de 8 bits menos significativos de rdi)
; recebe o número em eax
; retorna o tamanho real do número em cl
; usa edx para resto da divisão e ebx para receber o divisor
numText:
    xor rdx, rdx
    xor rcx, rcx
    mov ebx, 10
    mov byte [rsi + rdi + 1], 10

    .divisao:
    div ebx
    add dl, '0'
    mov byte [rsi + rdi], dl
    dec dil
    inc cl
    xor rdx, rdx
    test rax, rax
    jnz .divisao

    ret
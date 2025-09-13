section .note.GNU-stack noalloc noexec nowrite
; ======================= TÍTULO =======================
; Paser de cadeia de caracteres para double

; Eu ainda vou implementar que construa um double ou float usando IEEE-754 de forma explicita, mas dessa vez, como quero fazer algo mais prático e que performe melhor, vou usar outra abordagem.
; A ideia é receber um valor como 3.14 e separar isso em dois números, 3 e 14, depois converter ambos para double com cvtsi2sd, dividir 14 por 100 e somar com o 3.0.

section .bss
    parteInteira resd 1
    prtIqtd resb 1

    parteFracionaria resd 1
    prtFqtd resb 1

section .text
    global inteiro
    global fracionario
    global produzDouble

; descrição: salva em parteInteira a parte que representa um inteiro do texto em rdi
; recebe o tamanho total do texto em rsi

inteiro:
    mov rbx, 10
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx

    .loop01:
    imul rax, rbx
    mov dl, byte [rdi + rcx]
    sub dl, '0'
    inc rcx
    add rax, rdx
    cmp rcx, rsi
    je .regInt
    mov r9, [rdi + rcx]
    cmp r9b, '.'
    jne .loop01
    .regInt:
    mov [parteInteira], rax
    mov [prtIqtd], rcx
    ret

    .regZero:
    mov r9d, 0
    mov [parteInteira], r9d
    mov [prtIqtd], rcx
    ret

; descrição: salva em parteFracionaria a parte que representa um número menor do que 1 e maior do que 0 do texto em rdi
; recebe o tamanho total do texto em rsi
fracionario:
    mov rbx, 10
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    mov r8, [prtIqtd]

    .findPoint:
    mov r9, [rdi + rcx]
    cmp r9b, '.'
    inc rcx
    jne .findPoint
    
    .loop02:
    inc rcx
    inc r8
    mov dl, byte [rdi + rcx]
    sub dl, '0'
    add rax, rdx
    cmp rsi, r8
    jg .loop02
    mov [parteFracionaria], rax
    mov [prtFqtd], rcx
    ret

produzDouble:
    call inteiro
    call fracionario
    cvtsi2sd xmm0, [parteInteira]
    cvtsi2sd xmm1, [parteFracionaria]
    mov rcx, [prtFqtd]
    call potencia10
    cvtsi2sd xmm3, rax
    divsd xmm1, xmm3
    addsd xmm0, xmm1
    ret

potencia10:
    .loop03:
    mov rax, 10
    mul rax, 10
    dec rcx
    cmp rcx, 0
    jg .loop03
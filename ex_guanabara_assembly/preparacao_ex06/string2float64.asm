section .note.GNU-stack noalloc noexec nowrite

; ======================= TÍTULO =======================
; Paser de cadeia de caracteres para double

; Descrição: recebe o endereço do buffer e o tamanho; retorna um float correspondente aos caracteres ASCII presentes no buffer

section .data

    dez dq 10.0

section .text
    global temPonto
    global pInt
    global pFrac
    global parseStringDouble

; Lê o buffer e retorna 1 em rax se encontrar o caracter '.' e retorna 0, se não.
; RECEBE endereço do buffer em rdi.
; RECEBE tamanho do buffer em rsi.
; RETORNA posição em rcx.
temPonto:
    xor rcx, rcx
    mov rbx, rsi
    dec rbx
    .loop01:
    cmp rbx, rcx
    je .int
    mov rcx, rsi
    mov rdx, '.'
    cmp dl, byte [rdi + rcx]
    jne .loop01

    mov rax, 1
    ret

    .int:
    xor rax, rax
    ret

; Retorna o valor na forma numérica da parte inteira em rax.
; RECEBE tamanho em rcx
pInt:
    xor rdx, rdx
    xor rax, rax
    xor r8, r8
    mov rbx, 10

    .loop01:
    imul rax, rbx
    mov dl, byte [rdi + r8]
    sub dl, '0'
    add rax, rdx
    inc r8
    cmp rcx, r8
    jg .loop01

    ret

; RECEBE posição do ponto em rcx
; RECEBE tamanho da parte fracionaria em rbx
; RETORNA, em rax, o valor da parte fracionária.
pFrac:
    xor r8, r8
    xor rax, rax
    xor rdx, rdx
    mov r9, 10
    inc rcx

    .loop01:
    imul rax, r9
    mov dl, byte [rdi + rcx]
    sub dl, '0'
    add rax, rdx
    cmp rcx, rsi
    jl .loop01

    xor rcx, rcx
    cvtsi2sd xmm0, rax
    .loop02:
    
    movsd xmm1, [dez]
    div xmm0, xmm1
    inc rcx
    cmp rbx, rcx
    jg .loop02

    ret

; RECEBE endereço do buffer em rdi.
; RECEBE tamanho do buffer em rsi.
; RETORNA um double em xmm0.
parseStringDouble:
    call temPonto
    
    cmp rax, 0
    je .resInteiro

    .resRacional:
    call pInt
    cvtsi2sd xmm0, rax
    mov rbx, rsi
    sub rbx, rcx
    call pFrac
    cvtsi2sd xmm1, rax
    addsd xmm0, xmm1
    ret

    .resInteiro:
    mov rcx, rsi
    call pInt
    cvtsi2sd xmm0, rax
    ret
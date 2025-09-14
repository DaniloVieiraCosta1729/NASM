section .note.GNU-stack noalloc noexec nowrite

; Função exponencial e^x
; Vamos usar um truncamento da série de Maclaurin e aplicar uma técnica que consiste em dividir o expoente por um inteiro k de modo que
; ele fique mais próximo do ponto onde a série está centrada (0 para maclaurin) e depois fazemos o resultado elevado a k.

section .data
    ; eu sou meio medroso, então vou colocar uns 7 termos
    fatoriais dq 1.0, 2.0, 6.0, 24.0, 120.0, 720.0, 5040.0

    reducao dq 65536.0
    um dq 1.0

section .text
    global exp

; Recebe em xmm0 o valor, x, que se deseja ver o exp(x). (Eu iria usar o rdi, mas vou seguir a ABI)
; Retorna em xmm0
exp:
    movsd xmm3, xmm0
    movsd xmm0, [um]
    movsd xmm1, [um]
    mov r9, 0

    ; vamos dividir x por alguma potência de dois, porque assim conseguimos economizar iterações no loop final (ao invés de multiplicar por e^(x/k), k vezes, podemos multiplicar por e^(x/k) por ele mesmo e repetir até que tenhamos e^x)
    ; vou usar 2^16 = 65536
    divsd xmm3, [reducao]

    .loop:
    mulsd xmm1, xmm3
    movsd xmm2, xmm1
    divsd xmm2, [fatoriais + 8 * r9]
    inc r9
    addsd xmm0, xmm2
    cmp r9, 7
    jle .loop

    xor r9, r9
    .reconstroi:
    mulsd xmm0, xmm0
    inc r9
    cmp r9, 16
    jl .reconstroi

    ret

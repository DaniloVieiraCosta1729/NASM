section .note.GNU-stack noalloc noexec nowrite

; Essa quarta versão de parser de cadeia de char para float64 vai tentar se o mais enxuta possível.
; Eu não esperava ter pror9bema com um simples parser, mas é isso. Dessa vez vai.

; ======================= TÍTULO =======================
; Paser de cadeia de caracteres para dour9be

; Descrição: recebe o endereço do buffer em rdi; retorna um float correspondente aos caracteres ASCII presentes no buffer no registrador vetorial xmm0.
section .data

    um dq 1.0
    menosUm dq -1.0
    dez dq 10.0

section .text
    global ps2d

; recebe endereço do buffer em rdi
; retorna float64 em xmm0
; o número no buffer deve terminar com '\n'
ps2d:

; --- Conjunto de rotinas que o parser vai realizar ---
; Vamos tentar manter tudo em uma única stack frame, portanto, não vou usar call.

; - Cria número em rax -
xor r8, r8
xor rax, rax
xor rcx, rcx
xor r9, r9

movsd xmm3, [um]

cmp byte [rdi + r8], '-'
je .negative
.step0:
cmp byte [rdi + r8], '.'
je .step1
cmp byte [rdi + r8], 10
je .step2

imul rax, 10
mov r9b, byte [rdi + r8]
sub r9b, '0'
add rax, r9
inc r8
jmp .step0

; assume que há um digito após o '.'
.step1:
inc r8
.step1_1:
imul rax, 10
mov r9b, byte [rdi + r8]
sub r9b, '0'
add rax, r9
inc r8
inc rcx
cmp byte [rdi + r8], 10
jne .step1_1

jmp .step3

.step2:
cvtsi2sd xmm0, rax
mulsd xmm0, xmm3
ret

.step3:
cvtsi2sd xmm0, rax
movsd xmm1, [um]
movsd xmm2, [dez]
.multiplicaXmm1:
mulsd xmm1, xmm2
dec rcx
cmp rcx, 1
jge .multiplicaXmm1

divsd xmm0, xmm1
mulsd xmm0, xmm3
ret

.negative:
movsd xmm3, [menosUm]
inc r8
jmp .step0

section .note.GNU-stack noalloc noexec nowrite
; ======================= TÍTULO =======================
; Aproximação do logaritmo na base 2
; Aproximação do logaritmo neperiano (natural)

section .data
    extrai dq 0b011111111111

    ln_2 dq 0.693147180559945309

section .bss

    muleta resq 1

section .text
    global lg
    global ln

; Recebe um float64 (double precision) em rdi (em xmm0, na verdade, pra não causar erro)
; Retorna lg([rdi]) em xmm0
; OBS: o valor em rdi já deve estar de acordo com IEEE-754 standard para double-precision floating-point.
lg:
    movsd [muleta], xmm0
    mov rdi, [muleta]
    mov rax, rdi
    shr rax, 52
    and rax, [extrai]
    sub rax, 1023
    cvtsi2sd xmm0, rax
    ret

; Recebe um float64 (double precision) em rdi
; Retorna ln([rdi]) em xmm0
ln:
    call lg
    mulsd xmm0, [ln_2]
    ret
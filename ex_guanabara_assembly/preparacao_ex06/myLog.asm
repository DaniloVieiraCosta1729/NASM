; ======================= TÍTULO =======================
; Aproximação do logaritmo na base 2

section .data
    extrai dq 0b011111111111
    
section .text
    global lg
    global ln

; Recebe um float64 (double precision) em rdi
; Retorna lg([rdi]) em rax
; OBS: o valor em rdi já deve estar de acordo com IEEE-754 standard para double-precision floating-point.
lg:
    shr rdi, 52
    sub rdi, 1023
    and rdi, [extrai]
    mov rax, rdi
    ret
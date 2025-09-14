section .note.GNU-stack noalloc noexec nowrite

; ======================= TÍTULO =======================
; raiz quadrada
; Agora que a gente implementou a função exponencial e o logaritmo neperiano, podemos implementar uma aproximação da raiz quadrada e, com essa aproximação podemos calcular a própria raiz usando newton raphson.
; Como vamos começar fazendo ln(x), não precisamos nos preocupar com valor de exp(x) explodindo para x grande. 

; Seja f: [-a, +inf) -> R+0, f(x) = sqrt(x+a), a > 0
; A inversa de f é, para x >= 0, x(y) = y² - a, que é tem raiz em y = sqrt(a), então vamos aplicar newton-raphson para obter essa raiz. Essa será a nossa função exponencial.

extern ln
extern exp

section .data

    meio dq 0.5

section .bss

    chute resq 1

section .text
    global approx

; recebe x em xmm0
; retorna uma aproximação para sqrt(x) em xmm0
; sqrt(x) = exp(0.5 * ln(x))
approx:
    call ln
    mulsd xmm0, [meio]
    call exp
    ret ; vou retornar aqui para testar a aproximação, mas quando eu for aplicar newton-raphson, vou deixar esse trecho "approx" como apenas uma parte da propria função de radiciação.
    
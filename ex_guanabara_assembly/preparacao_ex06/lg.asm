; ===================== TÍTULO =====================
; Implementação grossei de log_2(x) (logaritmo de x, na base 2), em livros de matemática é comum acha a notação lg(x), então vou seguir isso aqui.

; ===================== EXPLICAÇÃO DO QUE SERÁ FEITO =====================
; Como vai funcionar: sabemos que a representação IEEE-754 de floats normaliza os números, ou seja, escreve de forma bastante semelhante a notação científica
; e guarda o valor (expoente + 127) nos bits de posição 1 até 9 (inclusive).
; A definição de um log_b(x) é, literalmente, o número que eu devo elevar b para que o resultado seja x.
; Então, se um float x é representado como |S|E + 127|M|, então x = [(-1)^(S)] * (1 + M) * (10) ^ (E), os números estão na base 2.
; Perceba que, para x >= 1, lg(x) é aproximadamente E, a diferença entre x e (10)^E é M, ou seja, é um número entre 1 e 0. Esse erro é suficientemente
; pequeno para a aplicação que queremos fazer (chute inicial para raiz quadrada com newton-raphson).
; Logo, faremos lg(x) "=" E

; para double o bias é 1023 e o expoente tem 11 bits.

; ===================== RECURSOS =====================
; Vou me permitir usar a libc aqui, porque o foco principal é a função lg(x) e tbm aplicar o conceito de máscara sobre a representação IEEE-754 de floats
; e não o parse de cadeia de caracteres para a representação de float. Mas vou sim implementar esse parser em outro código mais tarde.

section .note.GNU-stack noalloc noexec nowrite 
extern scanf
extern printf

section .data
    msg1 db "Digite um numero: "
    tamMsg1 equ $-msg1

    scan1 db "%lf",0

    extrai dq 0b011111111111

    msg2 db "O expoente eh: %d",10,0

section .bss
    x resq 1

section .text
    global main
main:
    mov eax, 1
    mov edi, 1
    mov rsi, msg1
    mov edx, tamMsg1
    syscall

    sub rsp, 8
    mov rdi, scan1
    mov rsi, x
    call scanf
    add rsp, 8
    
    ; extrai o expoente de x
    mov rsi, [x]
    shr rsi, 52; esse é o operador >> em assembly, aqui estamos fazendo shift right 52 vezes, ou seja, dividindo o valor em rsi por 2^55 (só sobrará os 9 bits superiores que, agora, estarão na parte menos significativa de rsi)
    and rsi, [extrai]
    sub rsi, 1023; removendo o bias
    
    sub rsp, 8
    mov rdi, msg2
    xor rax, rax
    call printf
    add rsp, 8

    ret
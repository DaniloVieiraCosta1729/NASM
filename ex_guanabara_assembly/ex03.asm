; Esse vai ser legal kk'
; Como o assembly não dá uma função pronta que imprimi um número na tela, nos vamos precisar converter o resultado da soma para uma string.
; Como eu fiz essa conversão há alguns dias atrás, esse exercício vai ser legal porque vou conseguir reforçar bem conhecimento sobre loops.
; Outro fato legal que eu só notei enquanto escrevia o código é que a syscall read, só lê os bytes, ele não interpreta a entrada.
; Isso é excelente, porque vou precisar converter a string para número agora (sequência natural do exercício que fiz antes).

; Ex03 - Solicita dois números; soma esses números; mostra o resultado no terminal.

section .data
    textoX db "Digite o primeiro numero: "
    tamTextoX equ $- textoX

    textoY db "Digite o segundo numero: "
    tamTextoY equ $- textoY

    msgFinal db "A soma dos numeros digitados eh: "
    tamMsgFinal equ $ - msgFinal

    qtdDigitos equ 7

    teste db "testando: "
    tamTeste equ $-teste

section .bss
    x resb qtdDigitos
    y resb qtdDigitos

    resultado resb 10

    tamX resb 1
    tamY resb 1
    tamResultado resb 1

section .text
    global _start

_start:
    ; pede o primeiro numero
    mov rax, 1
    mov rdi, 1
    mov rsi, textoX
    mov rdx, tamTextoX
    syscall

    ; lê o primeiro numero
    mov rax, 0
    mov rdi, 0
    mov rsi, x
    mov rdx, qtdDigitos
    syscall

    mov [tamX], rax

    ; pede o segundo número
    mov rax, 1
    mov rdi, 1
    mov rsi, textoY
    mov rdx, tamTextoY
    syscall

    ;lê o segundo número
    mov rax, 0
    mov rdi, 0
    mov rsi, y
    mov rdx, qtdDigitos
    syscall

    mov [tamY], rax

    ; Vamos usar uma função no sentido mais geral aqui. Eu vou seguir a convenção de chamada system V AMD64.
    ; O que vou tentar é: usar a duas informações cruciais (endereço e tamanho) e então usar dois laços para montar o número no registrador r8 e no final passar o valor para rax e retornar. Mas vai ter um momento em que eu vou precisar somar o valor de rax com o valor de r8, então precisamos zerar o r8 antes de começar.

    mov rsi, x
    mov rdi, [tamX]
    call criaNumero
    xor r9, r9; zerando o registrador que vai fazer o serviço fenomenal, se é q vc me entende.
    add r9, rax

    mov rsi, y
    mov rdi, [tamY]
    call criaNumero
    add r9, rax

    mov rdi, r9
    lea rsi, resultado
    call criaTexto

    ; finalmente, vamos motrar o resultado
    mov rax, 1
    mov rdi, 1
    mov rsi, msgFinal
    mov rdx, tamMsgFinal
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, resultado
    mov rdx, [tamResultado]
    syscall

    ; encerra
    mov rax, 60
    mov rdi, 0
    syscall

    ; Pronto! agora só falta criar uma função que faça o caminho inverso, ou seja, pegue um número e transforme ele em uma string.
    
    ;cri texto (número em rdi e endereço em rsi)
criaTexto:
    mov rbx, 10
    mov rax, rdi
    xor rcx, rcx
    loopDivisao:
        add rcx, 1
        xor rdx, rdx
        div rbx
        add rdx, '0'
        mov [rsi], rdx
        add rsi, 1
        test rax, rax
        jnz loopDivisao
    mov [tamResultado], rcx
    ret

    ; criar numero (endereço em rsi e tamanho em rdi)
criaNumero:
    xor r8, r8
    mov rcx, rdi
    mov rdx, rcx
    mov rax, [rsi]
    sub rax, '0'
    loop01:
        imul rax, 10
        dec rdx
        test rdx, rdx
        jnz loop01
    add r8, rax
    dec rdi
    add rsi, 1
    test rdi, rdi
    jnz criaNumero
    mov rax, r8
    ret
    
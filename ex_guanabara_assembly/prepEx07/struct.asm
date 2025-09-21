section .note.GNU-stack noalloc noexec nowrite
; ======================= DESCRIÇÃO =======================
; Apenas um teste das strucs de forma rápida antes de aplicar no exercício 7.

; Vamos definir uma struc para aluno.
struc Aluno
    .nome resb 32
    .nota01 resq 1
    .nota02 resq 1
    .nota03 resq 1
endstruc ; Aqui temos algo novo. Strucs são como as structs do C, basicamente, o NASM cria os offsets para cada campo toda a vez que instânciamos ela.
; Assim, temos Aluno.nome -> offset = 0; Aluno.nota01 -> offset = 20; Aluno.nota02 -> offset = 28; ...; Aluno_size = 20+3*8 = 44

;; perceba que, diferente do que ocorria em C, aqui os campos das structs não são alinhados automaticamente. Então se estivermos preocupados com performance, precisamos alinhar manualmente. Existe um recurso que ajuda nisso, ele é o alignb 8; Se colocarmos isso após um campo de que está desalinhado, ele vai calcular a quantidade de bytes necessários para alinhar. Não vou alinha dessa vez. (MUDEI DE IDEIA SOBRE ALINHAR DEPOIS, mas não quero atualizar o comentário).

extern printf

section .data

    ; uma forma de inicializar uma struc é com istruc
    aluno4:
    istruc Aluno
        at Aluno.nome, db "Lipschitz",0
        at Aluno.nota01, dq 9.8
        at Aluno.nota02, dq 3.1
        at Aluno.nota03, dq 1.6
    iend

    a1n1 dq 9.0
    a1n2 dq 4.1
    a1n3 dq 9.9

    msg1 db "Digite o nome do Aluno 1: ",0
    tamMsg1 equ $-msg1

    msg2 db "Temos dois alunos registrados: \n%s\n%s ",0

    msg3 db "A nota de %s foi: %0.1lf",0

    msg4 db "A nota da classe foi: %lf\n",0

    maxTamNome db 31

section .bss

    aluno1: resb Aluno_size
    aluno2: resb Aluno_size
    aluno3: resb Aluno_size

section .text
    global main

main:
; enquanto eu não reimplemento a nova versão do parser s2d, vou pedir para o usuário passar o nome apenas, as notas a gente pode incluir a mão.
; Vamos introduzir outro rescurso extremamente poderoso e promissor, as MACROS. 
; Basicamente, o pre-processador do NASM troca as macros por seu código inline, ou seja, evita que fiquemos escrevendo coisas de forma repetitiva.
; Mas uma coisa que achei muito incrível sobre elas é que podemos usar condicionais nelas! E o melhor é que esses condicionais, além de serem um high level razoavelmente inofensivo do ponto de vista didatico (para quem já usou condicionais com jumps e flags antes), ele é RESOLVIDO EM TEMPO DE MONTAGEM, então ele dá mais performance para o código (quando aplicável, obviamente não faz sentido usá-los com valores que vão ser inicializados em tempo de execução).

    %macro nota 4
        mov rax, %2
        mov [%1 + Aluno.nota01], rax
        
        mov rax, %3
        mov [%1 + Aluno.nota02], rax

        mov rax, %4
        mov [%1 + Aluno.nota03], rax
    %endmacro

    %macro escreve 2
        mov rax, 1
        mov rdi, 1
        mov rsi, %1
        mov rdx, %2
        syscall
    %endmacro

    %macro le 2
        mov rax, 0
        mov rdi, 0
        mov rsi, %1
        mov rdx, %2
        syscall
        dec rax
        mov byte [%1 + rax], 0
    %endmacro

    %macro somaNotas 1
        movsd xmm0, [%1 + Aluno.nota01]
        addsd xmm0, [%1 + Aluno.nota02]
        addsd xmm0, [%1 + Aluno.nota03]
    %endmacro

    mov rax, [a1n1]
    mov rdi, [a1n2]
    mov rsi, [a1n3]
    nota aluno1, rax, rdi, rsi

    escreve msg1, tamMsg1
    le aluno1 + Aluno.nome, [maxTamNome]

    ; como o denominador é o mesmo para o cálculo da média de todos estudantes, podemos simplesmente somar todas as notas e no fim dividir.
    sub rsp, 8
    mov al, 0
    mov rdi, msg2
    lea rsi, [aluno1 + Aluno.nome]
    lea rdx, [aluno4 + Aluno.nome]
    call printf
    add rsp, 8

    sub rsp, 8
    somaNotas aluno1
    movsd xmm1, xmm0
    somaNotas aluno4
    addsd xmm0, xmm1

    mov rdi, msg4
    mov al, 1
    call printf
    add rsp, 8

    mov rax, 60
    mov rdi, 0
    syscall

    ;;;;;;;;; Estou tendo alguns problemas com esse código, então vou adiar a solução dele e vou focar em outras coisa e tentar usar structs em uma situação ainda mais simples.
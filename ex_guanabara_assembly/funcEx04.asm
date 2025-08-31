; Nesse arquivo eu defino algumas funções para a criação do loop.
section .text
    global verifica
; recebe o endereço do byte analisado em rsi
; retorna em rax (0 se não for nem texto nem número, 1, se ele for texto e 2 se for número)
verifica:

   mov bl, byte [rsi]
   cmp bl, '0'
   jl .nada
   cmp bl, '9'
   jle .numero
   cmp bl, 'A'
   jl .nada
   cmp bl, 'Z'
   jle .texto
   cmp bl, 'a'
   jl .nada
   cmp bl, 'z'
   jle .texto
   ;call .nada  ; não é uma boa prática nesse caso, pois call cria mais uma frame na stack e não há necessidade disso. jmp .nada é muito melhor.
   jmp .nada

   .texto:
   mov rax, 1
   ret

   .numero:
   mov rax, 2
   ret

   .nada:
   mov rax, 0
   ret

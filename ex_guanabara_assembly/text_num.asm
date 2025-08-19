section .text

; converte string para numero
; rdi = endereço do buffer
; esi = quantidade de caracteres que compoem o numero na base 10
; usa o ecx como iterador
; retorna em eax

num_string:
    xor eax, eax
    xor ecx, ecx
    xor edx, edx

.build_num:        ; o . antes do nome do loop torna esse rotolo local.
    imul eax, 10
    mov edx, byte [rdi + ecx]
    sub edx, '0'
    add eax, edx
    inc ecx
    cmp esi, ecx
    jl build_num
    ret
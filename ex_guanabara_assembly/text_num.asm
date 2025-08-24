section .text
global string_num

; converte string para numero
; rdi = endereço do buffer
; esi = quantidade de caracteres que compoem o numero na base 10
; usa o ecx como iterador
; retorna em eax

string_num:
    xor eax, eax
    xor rcx, rcx
    xor edx, edx

.build_num:        ; o . antes do nome do loop torna esse rotolo local.
    imul eax, 10
    mov dl, byte [rdi + rcx]
    sub edx, '0'
    add eax, edx
    inc ecx
    cmp ecx, esi
    jl .build_num
    ret
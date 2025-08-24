section .text
global num_string

; rdi = endereço do texto
; rcx = tamanho do buffer - 1
; deve conter o numero a ser convertido em eax
; retorna o tamanho real (quantidade de caracteres para representá-lo em base 10) do número em eax
num_string:
    xor ebx, ebx
    xor r8d, r8d
    mov ebx, 10
    .divide10:
    xor edx, edx
    div ebx
    add dl, '0'
    mov byte [rdi + rcx], dl
    dec rcx
    inc r8d
    test eax, eax
    jnz .divide10
    mov eax, r8d
    ret
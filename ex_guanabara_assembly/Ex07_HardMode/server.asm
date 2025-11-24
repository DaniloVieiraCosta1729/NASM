; ======================================================
;       TCP Server in x86 NASM Assembly - 23/11/2025
; ======================================================
section .note.GNU-stack noalloc noexec nowrite

section .data
    serverAddr: times 16 db 0
    clientAddr: times 16 db 0
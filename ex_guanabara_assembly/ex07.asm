; ======================= TÍTULO =======================
; Ex07 - Calcular a média. (Pedir o nome e as notas e retornar a média.)
; Para não ficar repetitivo demais, vamos usar um I/O com arquivos de texto.
; Além o I/O, vamos criar um CRUD com sqlite (com a ajuda de C).

section .data

    intro db "=============================== Class Management ===============================",10,10,0

    menuChoices db "[A]dd_Student  [U]pdate_Score  []"
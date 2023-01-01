.section .data
matrica: .word 1, 2, 3, 4, 5, 6, 7, 8, 9

.section .text
.globl main
main:
la x1, matrica # učitavanje adrese matrice u x1
addi x2, x0, 0 # postavljanje x2 na nulu
addi x3, x0, 0 # postavljanje x3 na nulu
addi x4, x0, 0 # postavljanje x4 na nulu
addi x5, x0, 0 # postavljanje x5 na nulu
addi x6, x0, 0 # postavljanje x6 na nulu
addi x7, x0, 0 # postavljanje x7 na nulu

petlja:
beq x2, x6, kraj # ako je x2 jednako x6, prelazimo na kraj
lw x8, 0(x1) # učitavanje elementa matrice u x8
blt x8, x3, manji # ako je x8 manji od x3, prelazimo na manji
bgt x8, x4, veci # ako je x8 veći od x4, prelazimo na veci
addi x2, x2, 1 # povećavamo x2 za 1
addi x1, x1, 4 # povećavamo x1 za 4 (veličina celog broja je 4 bajta)
j petlja # vraćamo se na početak petlje

manji:
addi x5, x2, 0 # postavljanje x5 na x2
addi x3, x8, 0 # postavljanje x3 na x8
addi x2, x2, 1 # povećavamo x2 za 1
addi x1, x1, 4 # povećavamo x1 za 4
j petlja # vraćamo se na početak petlje

veci:
addi x6, x2, 0 # postavljanje x6 na x2
addi x4, x8, 0 # postavljanje x4 na x8
addi x2, x2, 1 # povećavamo x2 za 1
addi x1, x1, 4 # povećavamo x1 za 4
j petlja # vraćamo se na početak petlje

kraj:
beq x5, x0, bez_manjeg # ako x5 jednako nuli, nema manjeg elementa
beq x6, x0, bez_veceg # ako x6 jednako nuli, nema većeg elementa
add
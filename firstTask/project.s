.data
  matrix:
    .word 1 2
    .word 3 4

  rows:
    .word 2

  columns:
    .word 2

.text
  main:
    # pocetna adresa matrice
    la a0, matrix
    # a1 = broj redova
    lw a1, rows
    # a2 = broj kolona
    lw a2, columns
    # i = 0
    li a3, 0
    # j = 0 
    li a4, 0
    # min(a5) = infinity
    li a5, 0x7FFFFFFF
    # max(a6) = -infinity
    li a6, 0x80000000

    #while i < rows
    whileOne:
    # initialize j
    li a4, 0
      # while j<columns
      whileTwo:
        #a7 = matrix[i][j]
        lw a7, 0(a0)
        blt a7, a5, setLow
        bgt a7, a6, setHigh
        addi a0, a0, 4
        addi a4, a4, 1
        bne a2, a4, whileTwo
      addi a3, a3, 1
      bne a1, a3, whileOne
      #kraj loopa, ubacivanje najmanjeg u adresu najveceg i ubacivanje najveceg u adresu najmanjeg
      sw a6, 0(s2)
      sw a5, 0(s3)
      j endProgram


  setLow:
    mv a5, a7
    mv s2, a0
    j whileTwo

  setHigh:
    mv s3, a0
    mv a6, a7
    j whileTwo

  endProgram:
    nop
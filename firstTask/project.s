.data
  matrix:       # deklaracija matrice
    .word 1 2   # vrednosti za prvi red
    .word 3 4   # vrednosti za drugi red

  rows:         # broj redova matrice
    .word 2

  columns:      # broj kolona matrice
    .word 2

.text
  main:
    
    la a0, matrix   # ucitavanje pocetne adrese matrice u registar a0
    
    lw a1, rows     # ucitavanje broja redova u registar a1
    
    lw a2, columns  # ucitavanje broja kolona u registar a2
   
    li a3, 0        # inicijalizacija i = 0
    
    li a4, 0        # inicijalizacija j = 0
    
    li a5, 0x7FFFFFFF   # inicijalizacija min(a5) = beskonacno
    
    li a6, 0x80000000  # inicijalizacija max(a6) = -beskonacno

    #while i < rows
    whileOne:
    
    li a4, 0          # inicijalizacija j = 0
      
      whileTwo:
       
        lw a7, 0(a0)  # ucitavanje vrednosti elementa matrice u registar a7
        blt a7, a5, setLow   # ako je vrednost manja od min(a5), skok na oznacenu metodu
        bgt a7, a6, setHigh  # ako je vrednost veca od max(a6), skok na oznacenu metodu
        addi a0, a0, 4  # pomeranje na sledeci element matrice (4 bajta po elementu)
        addi a4, a4, 1  # inkrementovanje j
        bne a2, a4, whileTwo   # ako j < columns, skok na pocetak unutrasnje petlje
      addi a3, a3, 1  # inkrementovanje i
      bne a1, a3, whileOne   # ako i < rows, skok na pocetak spoljasnje petlje
     
      sw a6, 0(s2)    # cuvanje najveceg elementa matrice na adresi najmanjeg
      sw a5, 0(s3)    # cuvanje najmanjeg elementa matrice na adresi najveceg
      j endProgram    # skok na kraj programa


  setLow:
    mv a5, a7   # a5 postaje vrednost elementa matrice (min(a5))
    mv s2, a0   # cuvanje adrese elementa sa min(a5)
    j whileTwo  # skok na pocetak unutrasnje petlje

  setHigh:
    mv s3, a0   # cuvanje adrese elementa sa max(a6)
    mv a6, a7   # a6 postaje vrednost elementa matrice (max(a6))
    j whileTwo  # skok na pocetak unutrasnje petlje

  endProgram:
    nop  
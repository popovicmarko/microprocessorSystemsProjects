.data
matrica: .word 2, 2, 3, 4, 1, 9, 7, 8, 3
rowsize: .word 3 
colsize: .word 3

.text
main: 

la x10, matrica # adress of first element (0x10000000)
add x11, x0, x10 # copy x10
add x30, x0, x10 # min address
add x31, x0, x10 # max address

lw x12, rowsize # load n from it's address in memory (0x10000024) in case of a 9 element matrix
lw x13, colsize # load m from it's address in memory (0x10000028) in case of a 9 element matrix
mul x6, x12, x13 # x6 = n * m

addi x7, x0, 1 # i = 1
addi x8, x0, 1 # j = 1

#matrix_loop:
 # bge x7, x6, end_matrix # end of matrix
  ##sw x7, 0(x11) # store i into matrix
  #sw x8, 0(x11)
  #addi x8, x8, -2
  #addi x7, x7, 1 # i++
  #addi x11, x11, 4 # next element
  #jal x0, matrix_loop
#end_matrix:
#  addi x7, x0, 0 # i = 0
#  addi x11, x10, 0 # copy x10

loop_min:
  bge x9, x6, end_min # end of matrix
  lw x28, 0(x11) # load current element
  lw x29, 0(x30) # load min element
  bgt x29, x28, swap_min # if min > current then swap
  jal x1, increment # jumps to function for altering i/j values
  addi x11, x11, 4 # next element
  jal x0, loop_min # loop
swap_min:
  addi x30, x11, 0 # update min
  jal x0, loop_min # loop
end_min:
  addi x7, x0, 1 # i = 1
  addi x8, x0, 1 # j = 1
  addi x9, x0, 1 # x9 = 1
  addi x11, x10, 0 # copy x10

loop_max:
  bge x9, x6, finish # end of matrix
  lw x28, 0(x11) # load current element
  lw x29, 0(x31) # load max element
  blt x29, x28, swap_max # if max < current then swap
  jal x1, increment # jumps to function for altering i/j values
  addi x11, x11, 4 # next element
  jal x0, loop_max # loop
swap_max:
  addi x31, x11, 0 # update max
  jal x0, loop_max # loop
finish:
  lw x28, 0(x30) # load numbers
  lw x29, 0(x31)
  sw x28, 0(x31) # swap numbers
  sw x29, 0(x30)

increment:
  mul x9, x7, x8 # multiplies i and j in order to check in the main loop if the current element is the last one
  addi x7, x7, 1 # i++
  bgt x7, x12, increase # checks if i has exceeded row size increase j and return i to 1
  jalr x1, x1, 0 # return where you left off in the main loop
increase:
  addi x8, x8, 1 # increases j by 1, but there is no need to check if the new number has exceeded the column size because x9 has reached the value needed to stop the main loop
  addi x7, x0, 1 # returns value of i to 1
  jalr x1, x1, 0 # return where you left off in the main loop

nop
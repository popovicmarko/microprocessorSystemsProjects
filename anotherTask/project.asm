.MODEL SMALL
.STACK 100h
.DATA
    array db 3, 8, 2, 5, 12, 16, 44, 2, 9, 100
    
.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        MOV CX, 0
        MOV CL, 10

        LEA SI, array

        
        MOV BX, 0
        
     BUBBLE_SORT:
        dec CX
        LEA SI, array
        CMP CX, SI
        JLE EXIT
        
        SWAP:
        CMP SI, CX
        JGE BUBBLE_SORT
        
        MOV BL, array[SI]
        MOV BH, array[SI+1]
        CMP BL, BH
        JLE INCREMENT
        
        MOV array[SI], BH
        MOV array[SI+1], BL
        INC SI
        
        JMP SWAP
        
        
     INCREMENT:
        INC SI
        JMP SWAP
     EXIT:
     LEA SI, array

     END
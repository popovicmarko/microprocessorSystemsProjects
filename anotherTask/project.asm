INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100h
.DATA        
    ARR DB 50 DUP(?)    ;declare array

.CODE
    MAIN PROC
        
        MOV AX,@DATA
        MOV DS,AX
        
        PRINT "Number of data(1-9): "
        MOV AH,1
        INT 21h
        AND AL,0FH  ; convert ascii value       
        
        XOR CX,CX    ;to set zero
        MOV CL,AL
        PUSH CX
        PUSH CX  
        LEA SI,ARR
        
        PRINTN        ;print new line
        PRINTN
        PRINT "Enter Data: "    ;print message       
     
     INPUT:         
         MOV AH,1
         INT 21h
        
         MOV ARR[SI],AL
         INC SI
         LOOP INPUT           ;looping 
         
         POP CX          
         LEA SI,ARR
         ADD CX,SI
        
     XOR BX,BX      
     SORT:            ;sorting label
          SUB CX,1
          LEA SI,ARR
          CMP CX,SI
          JLE EXIT
          
          SWAP:
            CMP SI,CX
            JGE SORT
                        
            MOV BL,ARR[SI]   ; bubble sort algorithm
            MOV BH,ARR[SI+1]
            CMP BL,BH
            JLE INCREMENT
            
            MOV ARR[SI],BH
            MOV ARR[SI+1],BL
            INC SI

            JMP SWAP  
         

      INCREMENT:
           INC SI
           JMP SWAP
      EXIT:
           LEA SI,ARR
           POP CX
           PRINTN
           PRINTN
           PRINT "After Sorting: "
         
      OUTPUT: 
            MOV DL,ARR[SI]  ;show output
            MOV AH,2
            INT 21h
            INC SI
            LOOP OUTPUT
        
     MAIN ENDP
END MAIN
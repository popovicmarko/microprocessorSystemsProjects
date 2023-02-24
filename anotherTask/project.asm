.MODEL SMALL  ; definisanje modela memorije
.STACK 100h   ; definisanje velicine steka
.DATA         ; definisanje segmenta podataka
    array db 3, 8, 2, 5, 12, 16, 44, 2, 9, 100  ; deklarisanje niza za sortiranje

.CODE         ; definisanje segmenta koda
    MAIN PROC  ; pocetak glavnog programa
        MOV AX, @DATA  ; ucitavanje adrese segmenta podataka u registar AX
        MOV DS, AX     ; ucitavanje adrese segmenta podataka u registar DS
        
        MOV CX, 0      ; postavljanje CX na 0
        MOV CL, 10     ; postavljanje CX na 10 (duzina niza)

        LEA SI, array  ; ucitavanje adrese niza u registar SI

        
        MOV BX, 0      ; postavljanje BX na 0
        
     BUBBLE_SORT:     ; oznaka za pocetak petlje sortiranja
        dec CX        ; smanjenje brojaca petlje za 1
        LEA SI, array  ; ucitavanje adrese niza u registar SI
        CMP CX, SI     ; uporedjivanje brojaca petlje sa adresom niza u SI
        JLE EXIT       ; ako je brojac petlje manji ili jednak adresi niza, izlazak iz petlje
        
        SWAP:          ; oznaka za pocetak zamene elemenata
        CMP SI, CX     ; uporedjivanje adresa dva elementa
        JGE BUBBLE_SORT ; ako su adrese dva elementa jednake, vracanje na pocetak petlje
        
        MOV BL, array[SI]      ; ucitavanje prvog elementa u registar BL
        MOV BH, array[SI+1]    ; ucitavanje drugog elementa u registar BH
        CMP BL, BH             ; uporedjivanje dva elementa
        JLE INCREMENT         ; ako je prvi manji ili jednak od drugog, skok na INCREMENT
        
        MOV array[SI], BH      ; smestanje drugog elementa na adresu prvog elementa
        MOV array[SI+1], BL    ; smestanje prvog elementa na adresu drugog elementa
        INC SI                 ; inkrementiranje registra SI (adrese niza)
        
        JMP SWAP               ; skok na pocetak zamene
        
     INCREMENT:               ; oznaka za inkrementiranje adrese niza
        INC SI                 ; inkrementiranje registra SI (adrese niza)
        JMP SWAP               ; skok na pocetak zamene
        
     EXIT:                    ; oznaka za kraj petlje
     LEA SI, array            ; ucitavanje adrese niza u registar SI

     END                     

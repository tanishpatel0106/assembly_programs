; Write an assembly language program to enter data/string thorough 
; keyboard, display on screen with z key defined as end of key for stop 
; data/string entry

CODE SEGMENT
ASSUME CS: CODE
        L1: MOV AH,01H  
        INT 21H         
        CMP AL, 
        JNZ L1  
        MOV AX,4C00H
        INT 21H
CODE ENDS
END L1
; Write an assembly language program to enter data/string thorough 
; keyboard, display on screen with z key defined as end of key for stop 
; data/string entry 

CODE SEGMENT
        ASSUME CS: CODE
L2:     MOV AH,08H 
        INT 21H 
        CMP AL,'z' 
        JZ L1 
        MOV DL, AL 
        MOV AH,02H 
        INT 21H 
        JMP L2
L1:     MOV AX,4C00H
        INT 21H
CODE ENDS
        END L2

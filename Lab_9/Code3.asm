; Write an assembly language program to enter data/string through keyboard 
; with display * on screen for each entry with z key defined as end of key for 
; stop data/string entry

CODE SEGMENT
        ASSUME CS: CODE
L2:     MOV AH,08H 
        INT 21H
        CMP AL, 'z' 
        JZ L1 
        MOV DL, '*' 
        MOV AH,02H
        INT 21H 
        JMP L2 
L1:     MOV AX,4C00H
        INT 21H
CODE    ENDS
        END L2
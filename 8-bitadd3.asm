DATA    SEGMENT
        N1 DB 99H
        N2 DB 88H
        N3 DW ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS:CODE, DS:DATA
START:  MOV AX,DATA
        MOV DS,AX
        MOV AH,00H
        MOV AL,N1
        ADD AL,N2
        JNC L1
        INC AH
L1:     MOV N3,AX
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
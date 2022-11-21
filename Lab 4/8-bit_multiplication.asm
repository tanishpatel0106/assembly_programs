DATA    SEGMENT
        N1 DB 99H
        N2 DB 88H
        N3 DW ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS: CODE
START:  MOV AX, CODE
        MOV DS, AX
        MOV AL, N1
        MOV BL, N2
        MUL BL
        MOV N3, AX
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
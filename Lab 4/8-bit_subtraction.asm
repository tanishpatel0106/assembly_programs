DATA    SEGMENT
        N1 DB 99H
        N2 DB 88H
        N3 DB ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
        START: MOV AX, DATA
        MOV DS, AX
        MOV AL, N1
        SUB AL, N2
        JNC L1
        NEG AL
L1:     MOV N3, AL
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
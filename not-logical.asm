DATA    SEGMENT
        N1 DB 99H
        N2 DB ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS:CODE, DS:DATA
START:  MOV AX,DATA
        MOV DS,AX
        MOV AL,N1
        NOT AL
        MOV N2,AL
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
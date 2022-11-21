DATA    SEGMENT
        N1 DW 9999H
        N2 DW 8888H
        N3 DW ?
        N4 DB ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
START:  MOV AX, DATA    ; Initialized DS register
        MOV DS, AX
        MOV BL,00H
        MOV AX, N1
        ADD AX, N2
        JNC L1
        INC BL
L1:     MOV N3, AX
        MOV N4, BL
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
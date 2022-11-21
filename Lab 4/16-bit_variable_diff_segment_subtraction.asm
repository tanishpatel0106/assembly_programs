DATA    SEGMENT
        N1 DW 9999H
        N2 DW 8888H
        N3 DW ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        MOV AX, N1
        SUB AX, N2
        JNC L1
        NEG AX
L1:     MOV N3, AX
        MOV AX,4C00H
        INT 21H
CODE    ENDS
END     START
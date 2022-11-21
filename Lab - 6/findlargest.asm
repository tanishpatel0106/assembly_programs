DATA    SEGMENT
        N1 DB 06H
        N2 DB 58H,99H,45H,23H,87H,76H
        N3 DB ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS:CODE, DS:DATA
START:  MOV AX,DATA
        MOV DS,AX
        MOV CL,N1
        MOV SI,OFFSET N2
        MOV AL,[SI]
L2:     INC SI
        CMP AL,[SI]
        JNC L1
        MOV AL,[SI]
L1:     DEC CL
        JNZ L2
        MOV N3,AL
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
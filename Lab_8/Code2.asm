; Write an assembly language program for find out factorial for the given data 
; byte (up to 4-words).
DATA SEGMENT
        N1 DW 0005H
        N2 DW 0000H
        N3 DW 0000H
        N4 DW 0000H 
        N5 DW 0000H
DATA ENDS
CODE SEGMENT
ASSUME CS: CODE, DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        MOV AX, N1
        MOV N2, AX 
        MOV CX, AX 
        DEC CX
        L1: PUSH CX 
        PUSH CX
        MOV AX, N2 
        ADD N3, DX 
        PUSH CX 
        MOV AX, N3 
        ADD N4, DX 
        PUSH CX 
        MOV AX, N4 
        ADD N5, DX 
        MOV AX, N5 
        L2: POP CX 
        DEC CX
        JNZ L1 ation 
        MOV AX,4C00H
        INT 21H
CODE ENDS
END START

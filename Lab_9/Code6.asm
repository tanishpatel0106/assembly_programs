; Write an assembly language program to display three ASCII strings using 
; DOS function 09H with use of MACRO

PRINT   MACRO MSG 
        MOV AH, 09H
        MOV DX, OFFSET MSG
        INT 21H
        ENDM    
DATA    SEGMENT 
        CR EQU 0DH
        LF EQU 0AH
        MSG1 DB 'MY NAME IS RAJU', CR, LF, '$'
        MSG2 DB 'HOW ARE YOU?', CR, LF, '$'
        MSG3 DB 'I AM FINE','$'
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
START: `MOV AX, DATA
        MOV DS, AX
        PRINT MSG1 
        PRINT MSG2 
        PRINT MSG3 
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
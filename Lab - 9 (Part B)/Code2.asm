;ALP to add two 4-digit numbers


PRINT   MACRO MSG
        MOV AH, 09H
        MOV DX, OFFSET MSG
        INT 21H
        ENDM
READ    MACRO NUM
        MOV AH,01
        INT 21H 
        SUB AL,30H
        MOV AH,00H
        MOV BX,03E8H
        MUL BX 
        MOV NUM, AX 
        MOV AH,01H 
        INT 21H
        SUB AL,30H 
        MOV AH,00H 
        MOV BX,0064H
        MUL BX
        ADD NUM, AX
        MOV AH,01H 
        INT 21H
        SUB AL,30H 
        MOV AH,00H 
        MOV BX,000AH
        MUL BX
        ADD NUM, AX 
        MOV AH,01H 
        INT 21H
        SUB AL,30H 
        MOV AH,00H 
        ADD NUM, AX 
        ENDM
DISPLAY MACRO RES
        MOV AX, RES 
        MOV DX,0000H
        MOV BX,2710H
        DIV BX
        MOV RES, DX 
        ADD AL,30H
        MOV DL, AL
        MOV AH,02H
        INT 21H
        MOV AX, RES 
        MOV DX,0000H
        MOV BX,03E8H
        DIV BX
        MOV RES, DX 
        ADD AL,30H
        MOV DL, AL
        MOV AH,02H
        INT 21H
        MOV AX, RES 
        MOV DX,0000H
        MOV BX,0064H
        DIV BX
        MOV RES, DX 
        ADD AL,30H
        MOV DL, AL
        MOV AH,02H
        INT 21H
        MOV AX, RES 
        MOV DX,0000H
        MOV BX,000AH
        DIV BX
        MOV RES, DX 
        ADD AL,30H
        MOV DL, AL
        MOV AH,02H
        INT 21H
        MOV AX, RES 
        ADD AL, 30H 
        MOV DL, AL
        MOV AH,02H
        INT 21H
        ENDM
DATA    SEGMENT
        CR EQU 0DH
        LF EQU 0AH
        MSG1 DB 'ENTER 4-DIGIT DECIMAL NUMBER1: ','$' 
        MSG2 DB CR, LF,'ENTER 4-DIGIT DECIMAL NUMBER2: ','$'
        MSG3 DB CR, LF,'RESULT OF TWO 4-DIGIT DECIMAL NUMBERS ADDITION: ','$'
        NUM1 DW ?
        NUM2 DW ?
        RES DW ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        PRINT MSG1
        READ NUM1
        PRINT MSG2
        READ NUM2
        MOV AX, NUM1
        ADD AX, NUM2
        MOV RES, AX
        PRINT MSG3
        DISPLAY RES
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
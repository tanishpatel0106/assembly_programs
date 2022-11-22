;ALP to add two 2-digit numbers

PRINT   MACRO MSG
        MOV AH, 09H
        MOV DX, OFFSET MSG
        INT 21H
        ENDM
READ    MACRO NUM
        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV BL,0AH
        MUL BL
        MOV NUM, AL
        MOV AH,01H 
        INT 21H
        SUB AL,30H 
        ADD NUM, AL
        ENDM 
DISPLAY MACRO RES
        MOV AL, RES 
        MOV AH,00H
        MOV BL,64H
        DIV BL
        MOV RES, AH 
        ADD AL,30H
        MOV DL, AL
        MOV AH,02H
        INT 21H 
        MOV AL, RES 
        MOV AH,00H 
        MOV BL,0AH 
        DIV BL
        MOV RES, AH 
        ADD AL,30H
        MOV DL, AL
        MOV AH, 02H 
        INT 21H 
        ADD RES, 30H
        MOV DL, RES 
        MOV AH,02H
        INT 21H
        ENDM
DATA    SEGMENT
        CR EQU 0DH
        LF EQU 0AH
        MSG1 DB 'ENTER 2-DIGIT DECIMAL NUMBER1: ','$' 
        MSG2 DB CR, LF,'ENTER 2-DIGIT DECIMAL NUMBER2: ','$'
        MSG3 DB CR, LF,'RESULT OF TWO 2-DIGIT DECIMAL NUMBER ADDITION: ','$'
        NUM1 DB ?
        NUM2 DB ?
        RES DB ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        PRINT MSG1
        READ NUM1 
        PRINT MSG2
        READ NUM2 
        MOV AL, NUM1
        ADD AL, NUM2
        MOV RES, AL
        PRINT MSG3 
        DISPLAY RES
        MOV AX,4C00H
        INT 21H 
CODE    ENDS
        END START
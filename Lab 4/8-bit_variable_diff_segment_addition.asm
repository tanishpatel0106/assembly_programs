DATA    SEGMENT
        N1 DB 99H       ; DS declared in separate user defined data segment
        N2 DB 88H
        N3 DW ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
START:  MOV AX, DATA    ; Initialized DS register
        MOV DS, AX
        MOV AH,00H      ; Initialized carry storage register by 00H
        MOV AL, N1      ; Load AL by N1 variable
        ADD AL, N2      ; Add N2 variable value into AL
        JNC L1          ; Check status of carry flag bit
        INC AH          ; increment AH content by 1 if there is carry
L1:     MOV N3, AX      ; store result into N3 variable
        MOV AX,4C00H    ; program termination by using DOS system
        INT 21H         ; function 4CH
CODE    ENDS
        END START
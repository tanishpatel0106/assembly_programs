CODE    SEGMENT
ASSUME  CS: CODE        ; Informs assembler CODE name used for CS
START:  MOV AL,99H      ; Load AL register by 99H data
        MOV AH,00H      ; Initialized carry storage register by 00H
        ADD AL,88H      ; Add 88H data into AL content
        JNC L1          ; check status of carry flag bit
        INC AH          ; increment AH content by 1 if there is carry
L1:     MOV BX, AX      ; store result into BX register
        MOV AX,4C00H    ; program termination by using DOS system
        INT 21H         ; function 4CH
CODE    ENDS
        END START
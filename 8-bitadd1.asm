CODE    SEGMENT
        ASSUME CS: CODE
START:  MOV AL, 99H          
        MOV AH, 00H
        ADD AL, 88H
        JNC L1
        INC AH
L1:     MOV BX, AX
        MOV AX, 4C00H
        INT 21H
CODE    ENDS
        END START
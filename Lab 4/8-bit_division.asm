DATA    SEGMENT
        N1 DW 0099H
        N2 DB 88H
        N3 DW ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS: CODE
START:  MOV AX, CODE    ; Initialized DS register
        MOV DS, AX
        MOV AX, N1      ; Load AX by N1 variable value (Dividend)
        MOV BL, N2      ; Load BL by N2 variable value (Divisor)
        DIV BL          ; Divide AX content by BL content
                        ; Result as AL – Quotient, AH – Remainder
        MOV N3, AX      ; Store result into N3 variable
        MOV AX,4C00H
        INT 21H
CODE    ENDS
END     START
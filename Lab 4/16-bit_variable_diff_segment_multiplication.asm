DATA    SEGMENT
        N1 DW 9999H
        N2 DW 8888H
        N3 DD ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        MOV SI, OFFSET N3   ; Initialized SI as a pointer for variable N3
        MOV AX, N1          ; Load AX by N1 variable
        MUL N2              ; Multiply N2 variable value by AX
                            ; result as DX (Upper word), AX (lower word)
        MOV [SI], AX        ; Store result into N3 variable (lower word)
        MOV [SI+2], DX      ; Store result into N3 variable (upper word)
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
DATA    SEGMENT
        N1 DD 00009999H
        N2 DW 8888H
        N3 DD ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
        START: MOV AX, DATA
        MOV DS, AX
        MOV SI, OFFSET N1   ; Initialized SI as a pointer for variable N1
        MOV DI, OFFSET N3   ; Initialized SI as a pointer for variable N3
        MOV AX, [SI]        ; Load AX by N1 variable (lower word)
        MOV DX, [SI+2]      ; Load DX by N1 variable (upper word)
        DIV N2              ; Divide N1 (DX:AX) value by N2 value
                            ; result as DX (remainder), AX (quotient)
        MOV [DI], AX        ; Store result into N3 variable (lower word)
        MOV [DI+2], DX      ; Store result into N3 variable (upper word)
        MOV AX,4C00H        ; program termination by using DOS system
        INT 21H             ; function 4CH
CODE    ENDS
        END START
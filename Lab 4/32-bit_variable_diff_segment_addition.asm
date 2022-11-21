DATA    SEGMENT
        N1 DD 12345678H
        N2 DD 0AABBCCDDH
        N3 DD ?
        N4 DB ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS: DATA
START:  MOV AX, DATA
        MOV DS, AX
        MOV SI, OFFSET N1   ; Initialized SI as a pointer for N1 variable
        MOV DI, OFFSET N2   ; Initialized SI as a pointer for N2 variable
        MOV BX, OFFSET N3   ; Initialized SI as a pointer for N3 variable
        MOV CL,00H          ; Initialized CL as carry storage register by 00H
        MOV AX, [SI]        ; Load AX with lower word of N1
        ADD AX, [DI]        ; Add lower word of N2 into AX content
        MOV [BX], AX        ; Store lower word result into lower word of N3
        MOV AX, [SI+2]      ; Load AX with upper word of N1
        ADC AX, [DI+2]      ; Add upper word of N2 and previous carry into
                            ; AX content
        JNC L1              ; Check status of carry flag bit
        INC CL              ; increment CL content by 1 if there is carry
L1:     MOV [BX+2], AX      ; Store upper word result into upper word of N3
        MOV N4, CL          ; Store upper byte of result into N4
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
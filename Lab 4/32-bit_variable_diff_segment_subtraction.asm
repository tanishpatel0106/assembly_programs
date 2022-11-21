DATA    SEGMENT
        N1 DD 12345678H
        N2 DD 0AABBCCDDH
        N3 DD ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS: DATA
START:  MOV AX, DATA
        MOV DS, AX
        MOV SI, OFFSET N1   ; Initialized SI as a pointer for N1 variable
        MOV DI, OFFSET N2   ; Initialized SI as a pointer for N2 variable
        MOV BX, OFFSET N3   ; Initialized SI as a pointer for N3 variable
        MOV AX, [SI]        ; Load AX with lower word of N1
        SUB AX, [DI]        ; Subtract lower word of N2 and previous
                            ; borrow from AX content
        MOV AX, [SI+2]      ; Load AX with upper word of N1
        SBB AX, [DI+2]      ; Subtract upper word of N2 from AX content
        JNC L1              ; Check status of carry flag bit (borrow)
        NOT WORD PTR [BX]   ; 2’S complement on result
        NOT AX              ; if result is negative
        ADD [BX], 01H
        JNC L1
        INC AX
L1:     MOV [BX+2], AX      ; Store upper word result into upper word of N3
        MOV AX,4C00H
        INT 21H
CODE    ENDS
END     START
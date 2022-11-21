DATA    SEGMENT
        N1 DB 03H
        N2 DB 34H,67H,0A5H
        N3 DW ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        MOV SI, OFFSET N2   ; Initialized SI as a pointer for N2 variable
        MOV AH,00H          ; Initialized AH as carry storage register by 00H
        MOV CL, N1          ; Initialized CL as counter for array data addition
        DEC CL
        MOV AL, [SI]        ; Load first data in AL
L2:     INC SI              ; Increment pointer SI for calling next data
        ADD AL, [SI]        ; add AL with next data & result stored into AL
        JNC L1              ; Check status of carry flag bit
        INC AH              ; Increment AH by 1 if carry flag bit is set
L1:     DEC CL              ; Decrement counter CL by 1
        JNZ L2              ; Check zero flag bit for counter CL
        MOV N3, AX          ; Store result into N3 variable
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
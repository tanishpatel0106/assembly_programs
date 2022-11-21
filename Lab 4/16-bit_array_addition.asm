DATA    SEGMENT
        N1 DB 04H
        N2 DW 1223H,4512H,5645H,6756H
        N3 DW ?
        N4 DB ?
DATA    ENDS
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        MOV CL, N1          ; Initialized CL as counter for array data addition
        DEC CL
        MOV SI, OFFSET N2   ; Initialized SI as a pointer for N2 variable
        MOV CH,00H          ; Initialized CH as carry storage register by 00H
        MOV AX, [SI]        ; Load first data in AX
L2:     INC SI              ; Modified pointer SI for calling next array data
        INC SI
        ADD AX, [SI]        ; add AX with next data & result stored into AX
        JNC L1              ; Check status of carry flag bit
        INC CH              ; Increment CH by 1 if carry flag bit is set
L1:     DEC CL              ; Decrement counter CL by 1
        JNZ L2              ; Check zero flag bit for counter CL
        MOV N3, AX          ; Store lower word of result into N3 variable
        MOV N4, CH          ; Store upper byte of result into N4 variable
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
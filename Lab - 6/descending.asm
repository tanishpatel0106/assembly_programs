DATA    SEGMENT
        N1 DB 05
        N2 DB 78H,45H,66H,58H,34H
DATA    ENDS
CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA
START:  MOV AX,DATA
        MOV DS,AX
        MOV CL,N1
L4:     MOV SI, OFFSET N2
        MOV CH,N1
        DEC CH
        MOV AL,[SI]
L3:     INC SI
        MOV BL,[SI]
        CMP AL,BL
        JNC L1
        DEC SI
        MOV [SI],AL
        INC SI
        MOV AL,BL
        JMP L2
L1:     DEC SI
        MOV [SI],BL
        INC SI
L2:     DEC CH
        JNZ L3
        MOV [SI],AL
        DEC CL
        JNZ L4
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
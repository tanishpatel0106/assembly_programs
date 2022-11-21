; // Program for Prime Number
DATA SEGMENT
    N1 DB 03H
    N2 DB 07H,0BH,10H
    N3 DB 3 DUP(?)
DATA ENDS
CODE SEGMENT
    ASSUME CS: CODE, DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        MOV CL, N1 
        MOV SI, OFFSET N2 
        MOV DI, OFFSET N3 
        L3: MOV BL,02H 
        L2: MOV AH,00H 
        MOV AL, [SI] 
        DIV BL 
        CMP AH,00H 
        INC BL 
        CMP BL, [SI] 
        JZ L1 
        JL L2 
        MOV DL, [SI] 
        MOV [DI], DL 
        INC DI 
        L1: INC SI 
        DEC CL  
        JNZ L3 
        MOV AX,4C00H
        INT 21H
    CODE ENDS 
END START

; Write an assembly language to display A to Z characters on screen using 
; DOS function 02H

CODE    SEGMENT
        ASSUME CS: CODE
START:  MOV CL,'A' 
L1:     MOV DL, CL  
        MOV AH,02H 
        INT 21H 
        INC CL 
        CMP CL, 'z' 
        JLE L1   
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START 
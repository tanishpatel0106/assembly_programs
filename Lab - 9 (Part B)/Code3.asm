;Program to reverse ASCII string

PRINT   MACRO MSG
        MOV AH, 09H
        MOV DX, OFFSET MSG
        INT 21H
        ENDM
DATA    SEGMENT
        CR EQU 0DH
        LF EQU 0AH
        MSG1 DB 'ENTER THE STRING: ','$'
        MSG2 DB CR, LF,'DISPLAY REVERSE STRING: ','$'
        STRING DB 20 DUP (00H)
        CNT DW 0000H
DATA    ENDS 
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        PRINT MSG1
        MOV SI, OFFSET STRING ; Initialized SI as a pointer for STRING 
        L2: MOV AH,08H ; Use of DOS function 08H for entering string
        INT 21H ; through keyboard (without echo)
        CMP AL,0DH ; Compare AL with 0DH (pressed key and Enter key)
        JZ L1 ; If ZF = 0, go to label L1 (end of key entry)
        MOV [SI], AL ; Store ASCII hex value of key pressed into STRING
        INC CNT ; Increment CNT by 1 (counter for key entry in STRING)
        INC SI ; Increment SI by 1 for next key entry store
        MOV DL, AL ; Use of DOS function 02H to display
        MOV AH,02H ; key pressed on screen (except enter key)
        INT 21H
        JMP L2 ; Jump to label L2 (for next key)
        L1: PRINT MSG2 
        MOV SI, OFFSET STRING ; Initialized SI as a pointer for STRING
        MOV BX, CNT ; Load BX with CNT variable
        L3: MOV DL, [SI+BX-1] ; Load DL with last key entry stored in STRING
        MOV AH,02H ; Use DOS function 02H for display last key
        INT 21H ; entry on screen
        DEC BX ; Decrement counter BX by 1 for next display on screen
        JNZ L3 ; If BX ≠ 0, go to label L3 (for call next key entry for display)
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
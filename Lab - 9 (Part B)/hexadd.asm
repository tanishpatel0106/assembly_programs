; macro for print any message
PRINT MACRO MSG
MOV AH, 09H
MOV DX, OFFSET MSG
INT 21H
ENDM
DATA SEGMENT
CR EQU 0DH
LF EQU 0AH
MSG1 DB '2-DIGIT HEXA-DECIMAL NO-1: ','$'
MSG2 DB CR, LF,'2-DIGIT HEXA-DECIMAL NO-2: ','$' 
MSG3 DB CR, LF,'2-DIGIT HEX NOS. ADDITION RESULT: ','$'
TEMP DB ?
NUM1 DB ?
NUM2 DB ?
RES DW ?
DATA ENDS
CODE SEGMENT
ASSUME CS: CODE, DS:DATA
START: MOV AX, DATA
MOV DS, AX
PRINT MSG1
CALL A2H ; Call procedure name A2H for NUM1
MOV AL, TEMP
MOV NUM1, AL
PRINT MSG2
CALL A2H ; Call procedure name A2H for NUM1
MOV AL, TEMP
MOV NUM2, AL 
MOV BL, NUM1
MOV BH,00H
ADD BL, NUM2
JNC E1
INC BH
E1: MOV RES, BX
PRINT MSG3
CALL H2A ; Call procedure for display result on screen
MOV AX,4C00H
INT 21H
; procedure for entering value of the number for addition through keyboard 
; in 00 - FF hexadecimal
A2H PROC NEAR ; A2H procedure read the data entering from
MOV AH, 01H ; keyboard using DOS function 01H and
INT 21H ; convert into hex decimal number
CMP AL, 39H ; Compare ASCII hex value of key pressed (AL) with 39H 
JA L1 ; If AL > 39H, go to label L1 (for A to F hex digit)
SUB AL, 30H ; If AL = 39H, subtract 30H from AL for 1st hex digit
JMP L2 ; Jump to label L2 for 1st hex digit weightage value
L1: SUB AL, 37H ; If AL > 39H, subtract 37H from AL for 1st hex digit
L2: MOV BL, 10H ; Load BL with 10H (place value of 1st hex digit)
MUL BL ; Multiply AL with BL (weightage value of 1st digit in AL)
MOV TEMP, AL ; Store 1st digit weightage value (AL) into TEMP
MOV AH, 01H ; Use DOS 01H for 2nd digit entry through keyboard
INT 21H
CMP AL, 39H ; Compare ASCII hex value of key pressed (AL) with 39H
JA L3 ; If AL > 39H, go to label L1 (for A to F hex digit)
SUB AL, 30H ; If AL = 39H, subtract 30H from AL for 2nd hex digit
JMP L4 ; Jump to label L2 for 2nd hex digit weightage value
L3: SUB AL, 37H ; If AL > 39H, subtract 37H from AL for 2nd hex digit 
L4: ADD TEMP, AL ; Add TEMP with AL (for obtain final number)
RET ; Return to main program (next instruction after call A2H)
A2H ENDP 
; procedure for displaying result of 3-digit hexadecimal number 000H - FFFH
H2A PROC NEAR ; H2A procedure for display RES (result of addition)
MOV AX, RES ; Load AX with RES value (lower word of dividend)
MOV DX, 0000H ; Load DX with 0000H value ((upper word of dividend)
MOV CX, 0100H ; Load CX with 0100H as divisor (place value of 1st digit)
DIV CX ; Divide DX:AX by CX
MOV RES, DX ; Store DX into RES for next division (Remainder)
CMP AL, 09H ; Compare AL with 09H
JA K1 ; If AL > 09H, go to label K1 (for A to F hex digit)
ADD AL, 30H ; If AL = 09H, add 30H to AL for 1st digit ASCII value
JMP K2 ; Jump to label K2 for 1st hex digit display on screen
K1: ADD AL, 37H ; If AL > 09H, add 37H to AL for 1st digit ASCII value
K2: MOV DL, AL ; Load DL with AL (1st digit ASCII hex)
MOV AH, 02H ; Use of DOS 02H for 1st hex digit ASCII hex value
INT 21H ; display on screen
MOV AX, RES ; Load AX with RES value (lower word of dividend)
MOV DX, 0000H ; Load DX with 0000H value ((upper word of dividend)
MOV CX, 0010H ; Load CX with 0010H as divisor (place value of 2nd digit)
DIV CX ; Divide DX:AX by CX
MOV RES, DX ; Store DX into RES for next division (Remainder)
CMP AL, 09H ; Compare AL with 09H
JA K3 ; If AL > 09H, go to label K3 (for A to F hex digit)
ADD AL, 30H ; If AL = 09H, add 30H to AL for 2nd digit ASCII value
JMP K4 ; Jump to label K4 for 2nd hex digit display on screen
K3: ADD AL, 37H ; If AL > 09H, add 37H to AL for 2nd digit ASCII value
K4: MOV DL, AL ; Load DL with AL (2nd digit ASCII hex)
MOV AH, 02H ; Use of DOS 02H for 2nd hex digit ASCII hex value
INT 21H ; display on screen 
MOV DX, RES ; Load DX with RES value (3rd hex digit)
CMP DL, 09H ; Compare DL with 09H
JA K5 ; If DL > 09H, go to label K5 (for A to F hex digit)
ADD DL, 30H ; If DL = 09H, add 30H to DL for 3rd digit ASCII value
JMP K6 ; Jump to label K6 for 3rd hex digit display on screen
K5: ADD DL, 37H ; If DL > 09H, add 37H to AL for 3rd digit ASCII value 
K6: MOV AH, 02H ; Use of DOS 02H for 3rd hex digit ASCII hex value
INT 21H ; display on screen
RET ; Return to main program (next instruction after call H2A)
H2A ENDP 
CODE ENDS
END START
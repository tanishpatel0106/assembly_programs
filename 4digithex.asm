                                                       ; macro for print any message
PRINT MACRO MSG
MOV AH, 09H
MOV DX, OFFSET MSG
INT 21H
ENDM
DATA SEGMENT
CR EQU 0DH
LF EQU 0AH
MSG1 DB '4-DIGIT HEXA-DECIMAL NO-1: ','$'
MSG2 DB CR, LF,'4-DIGIT HEXA-DECIMAL NO-2: ','$' 
MSG3 DB CR, LF,'4-DIGIT HEX NOS. ADDITION RESULT: ','$'
TEMP DW ?
NUM1 DW ?
NUM2 DW ?
RES DW ?
CRY DB ?
DATA ENDS
CODE SEGMENT
ASSUME CS: CODE, DS:DATA
START: MOV AX, DATA
MOV DS, AX
PRINT MSG1
CALL A2H ; Call procedure A2H for NUM1
MOV AX, TEMP
MOV NUM1, AX
PRINT MSG2
CALL A2H ; Call procedure A2H for NUM2
MOV AX, TEMP
MOV NUM2, AX 
MOV BX, NUM1
ADD BX, NUM2
JNC E1
INC CRY
E1: MOV RES, BX
PRINT MSG3
CALL H2A ; Call procedure H2A for display result on screen
MOV AX,4C00H
INT 21H
; procedure for entering value of the number for addition through keyboard 
; in 0000 - FFFF hexadecimal
A2H PROC NEAR ; A2H procedure read the data entering from
MOV AH,01H ; keyboard using DOS function 01H and
INT 21H ; convert into hex decimal number
CMP AL,39H ; Compare ASCII hex value of key pressed (AL) with 39H
JA L1 ; If AL > 39H, go to label L1 (for A to F hex digit)
SUB AL,30H ; If AL = 39H, subtract 30H from AL for 1st hex digit
JMP L2 ; Jump to label L2 for 1st hex digit weightage value
L1: SUB AL,37H ; If AL > 39H, subtract 37H from AL for 1st hex digit
L2: MOV AH,00H ; Load AH with 00H for converting into word
MOV BX,1000H ; Load BX with 1000H (place value of 1st hex digit)
MUL BX ; Multiply AX with BX (weightage value of 1st digit in AX)
MOV TEMP, AX ; Store 1st digit weightage value (AX) into TEMP
MOV AH,01H ; Use DOS 01H for 2nd digit entry through keyboard
INT 21H
CMP AL,39H ; Compare ASCII hex value of key pressed (AL) with 39H
JA L3 ; If AL > 39H, go to label L3 (for A to F hex digit)
SUB AL,30H ; If AL = 39H, subtract 30H from AL for 2nd hex digit
JMP L4 ; Jump to label L4 for 2nd hex digit weightage value
L3: SUB AL,37H ; If AL > 39H, subtract 37H from AL for 2nd hex digit
L4: MOV AH,00H ; Load AH with 00H for converting into word
MOV BX,0100H ; Load BX with 1000H (place value of 2nd hex digit)
MUL BX ; Multiply AX with BX (weightage value of 2nd digit in AX)
ADD TEMP, AX ; Add TEMP with AX (add weightage of 1st and 2nd digit)
MOV AH,01H ; Use DOS 01H for 3rd digit entry through keyboard
INT 21H
CMP AL,39H ; Compare ASCII hex value of key pressed (AL) with 39H
JA L5 ; If AL > 39H, go to label L5 (for A to F hex digit)
SUB AL,30H ; If AL = 39H, subtract 30H from AL for 3rd hex digit
JMP L6 ; Jump to label L6 for 3rd hex digit weightage value
L5: SUB AL,37H ; If AL > 39H, subtract 37H from AL for 3rd hex digit
L6: MOV AH,00H ; Load AH with 00H for converting into word
MOV BX,0010H ; Load BX with 0010H (place value of 3rd hex digit)
MUL BX ; Multiply AX with BX (weightage value of 3rd digit in AX)
ADD TEMP, AX ; Add TEMP with AX (weightage of 3rd digit + previous)
MOV AH,01H ; Use DOS 01H for 4th digit entry through keyboard
INT 21H
CMP AL,39H ; Compare ASCII hex value of key pressed (AL) with 39H
JA L7 ; If AL > 39H, go to label L7 (for A to F hex digit)
SUB AL,30H ; If AL = 39H, subtract 30H from AL for 4th hex digit
JMP L8 ; Jump to label L8 for 4th hex digit weightage value
L7: SUB AL,37H ; If AL > 39H, subtract 37H from AL for 4th hex digit 
L8: MOV AH,00H ; Load AH with 00H for converting into word
ADD TEMP, AX ; Add TEMP with AX (for obtain final number)
RET ; Return to main program (next instruction after call A2H)
A2H ENDP 
; procedure for displaying result of 5-digit hexadecimal number 00000H - FFFFFH
H2A PROC NEAR
MOV DL, CRY; Load AL with CRY value (carry as higher byte of my result)
ADD DL, 30H ; Add 30H into DL for ASCII hex value
MOV AH, 02H ; Use of DOS 02H for 1st hex digit ASCII hex value
INT 21H ; display on screen
MOV AX, RES ; Load AX with RES value (lower word of dividend)
MOV AX, RES ; Load AX with RES value (lower word of dividend)
MOV DX, 0000H ; Load DX with 0000H value ((upper word of dividend)
MOV CX, 1000H ; Load CX with 1000H as divisor (place value of 2nd digit)
DIV CX ; Divide DX:AX by CX
MOV RES, DX ; Store DX into RES for next division (Remainder)
CMP AL, 09H ; Compare AL with 09H
JA K1 ; If AL > 09H, go to label K1 (for A to F hex digit)
ADD AL, 30H ; If AL = 09H, add 30H to AL for 2nd digit ASCII value
JMP K2 ; Jump to label K2 for 2nd hex digit display on screen
K1: ADD AL, 37H ; If AL > 09H, add 37H to AL for 2nd digit ASCII value
K2: MOV DL, AL ; Load DL with AL (2nd digit ASCII hex)
MOV AH, 02H ; Use of DOS 02H for 2nd hex digit ASCII hex value
INT 21H ; display on screen
MOV AX, RES ; Load AX with RES value (lower word of dividend)
MOV DX, 0000H ; Load DX with 0000H value ((upper word of dividend)
MOV CX, 0100H ; Load CX with 0100H as divisor (place value of 3rd digit)
DIV CX ; Divide DX:AX by CX
MOV RES, DX ; Store DX into RES for next division (Remainder)
CMP AL, 09H ; Compare AL with 09H
JA K3 ; If AL > 09H, go to label K3 (for A to F hex digit)
ADD AL, 30H ; If AL = 09H, add 30H to AL for 3rd digit ASCII value
JMP K4 ; Jump to label K4 for 3rd hex digit display on screen
K3: ADD AL, 37H ; If AL > 09H, add 37H to AL for 3rd digit ASCII value
K4: MOV DL, AL ; Load DL with AL (3rd digit ASCII hex)
MOV AH, 02H ; Use of DOS 02H for 3rd hex digit ASCII hex value
INT 21H ; display on screen
MOV AX, RES ; Load AX with RES value (lower word of dividend)
MOV DX,0000H ; Load DX with 0000H value ((upper word of dividend)
MOV CX,0010H ; Load CX with 0100H as divisor (place value of 4th digit)
DIV CX ; Divide DX:AX by CX
MOV RES, DX ; Store DX into RES (Remainder)
CMP AL,09H ; Compare AL with 09H
JA K5 ; If AL > 09H, go to label K5 (for A to F hex digit)
ADD AL,30H ; If AL = 09H, add 30H to AL for 4th digit ASCII value
JMP K6 ; Jump to label K6 for 4th hex digit display on screen
K5: ADD AL,37H ; If AL > 09H, add 37H to AL for 4th digit ASCII value
K6: MOV DL, AL ; Load DL with AL (4th digit ASCII hex)
MOV AH,02H ; Use of DOS 02H for 4th hex digit ASCII hex value
INT 21H ; display on screen 
MOV DX, RES ; Load DX with RES value (5th hex digit)
CMP DL, 09H ; Compare DL with 09H
JA K7 ; If DL > 09H, go to label K7 (for A to F hex digit)
ADD DL, 30H ; If DL = 09H, add 30H to DL for 5th digit ASCII value
JMP K8 ; Jump to label K8 for 5th hex digit display on screen
K7: ADD DL, 37H ; If DL > 09H, add 37H to AL for 5th digit ASCII value 
K8: MOV AH, 02H ; Use of DOS 02H for 5th hex digit ASCII hex value
INT 21H ; display on screen
RET ; Return to main program (next instruction after call H2A)
H2A ENDP 
CODE ENDS
END START
#start=led_display.exe#     ; Call the output port with 5-digit LED display
#make_bin#
name    "led"
        MOV AX,0000H        ; Load AX with 0000H for reset
X1:     OUT 199, AX         ; Output port with LED display(address:199)
        MOV BL,30H          ; Delay program for display
X2:     DEC BL
        JNZ X2
        INC AX              ; Increment AX by 1 and given to display port
        CMP AX,0033H        ; Compare AX with 0033H data
        JNZ X1              ; If AX not equal to 0033H, AX value given to display port
        MOV AX, 0000H       ; Reset the output port with LED display
        OUT 199, AX
        HLT                 ; Halt the emulator
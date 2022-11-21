#start=simple.exe#          ; Call the simple 8 /16 – bit I/O port
#make_bin#
name "simple"
#start=led_display.exe#     ; Call the output port with 5-digit LED display
#make_bin#
name "led"
L1:     IN AX, 112          ; Read the 16-bit I/O port of 112 address
        OUT 199, AX         ; put AX content to display on 5-digit LED display port
        CMP AX, 1000        ; Compare AX with 1000 data
        JNZ L1              ; If not equal, again it read the 16-bit I/O port of 112 address
        HLT                 ; If equal, emulator halts
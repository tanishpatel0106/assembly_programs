#start=simple.exe#          ; Call the simple 8 /16 – bit I/O port
#make_bin#
name "simple"
#start=led_display.exe#     ; Call the output port with 5-digit LED display
#make_bin#
name "led"
L1:     IN AL, 110          ; Read the 8-bit I/O port of 110 address
        OUT 199, AL         ; put AL content to display on 5-digit LED display port
        CMP AL, 100         ; Compare AL with 100 data
        JNZ L1              ; If not equal, again it read the 8-bit I/O port 0f 110 address
        HLT                 ; If equal, emulator halts
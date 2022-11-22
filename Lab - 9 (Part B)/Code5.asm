;username and password

; macro for print any message
PRINT   MACRO MSG
        MOV AH, 09H
        MOV DX, OFFSET MSG
        INT 21H
        ENDM
DATA    SEGMENT
        CR EQU 0DH
        LF EQU 0AH
        ID DB 'TANISH', CR
        PD DB 'PASSWORD', CR
        MSG1 DB 'ENTER THE USER NAME: ','$'
        MSG2 DB CR, LF,'VALID USER ','$'
        MSG3 DB CR, LF,'INVALID USER','$'
        MSG4 DB CR, LF,'ENTER THE USER NAME AGAIN: ','$'
        MSG5 DB CR, LF,'ENTER THE PASSWORD: ','$'
        MSG6 DB CR, LF,'VALID PASSWORD','$'
        MSG7 DB CR, LF,'INVALID PASSWORD','$'
        MSG8 DB CR, LF,'ENTER THE PASSWORD AGAIN: ','$'
        MSG9 DB CR, LF,'YOU ARE AUTHORIZED USER','$'
        STRU DB 20 DUP (00H)
        STRP DB 20 DUP (00)
DATA    ENDS 
CODE    SEGMENT
        ASSUME CS: CODE, DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        ; User name entry and validate it
        PRINT MSG1
        ; User name entry
L5:     MOV SI, OFFSET STRU ; Initialized SI as a pointer for STRU
L1:     MOV AH,08H ; Use of DOS function 08H and 02H for keyboard input,
        INT 21H ; display on screen and stored in STRU (user name)
        MOV [SI], AL ; ENTER key used as an end of user name entry and also
        INC SI ; as end of user name ASCII string
        PUSH AX
        PUSH SI
        MOV DL, AL
        MOV AH,02H
        INT 21H
        POP SI
        POP AX
        CMP AL,0DH
        JNZ L1 
        ; User name validates
        MOV SI, OFFSET ID ; Initialized SI as a pointer for ID
        MOV DI, OFFSET STRU ; Initialized SI as a pointer for STRU
L3:     MOV AL, [SI] ; Compare stored user name with entered user name.
        CMP AL, [DI] ; If both are equal with same ENTER ASCII hex code
        JNE L2 ; as an end of both, then print MSG2
        INC SI ; If both are not equal, then print MSG3 
        INC DI ; and then print MSG4 and take entry of user name again
        CMP AL, CR
        JNE L3
        JE L4 
L2:     PRINT MSG3
        PRINT MSG4
        JMP L5
L4:     PRINT MSG2
        ; Password entry and validate it
        PRINT MSG5
        ; Password entry
L10:    MOV SI, OFFSET STRP ; Initialized SI as a pointer for STRP
L6:     MOV AH,08H ; Use of DOS function 08H and 02H for keyboard input,
        INT 21H ; display ‘ * ‘ on screen instead of each key entry and 
        MOV [SI], AL ; and stored actual key ASCII hex in STRP (password)
        INC SI ; ENTER key used as an end of user name entry and also
        PUSH AX ; as end of user name ASCII string
        PUSH SI
        MOV DL,'*'
        MOV AH,02H
        INT 21H
        POP SI
        POP AX
        CMP AL,0DH
        JNZ L6 
        ; Password validates
        MOV SI, OFFSET PD ; Initialized SI as a pointer for PD
        MOV DI, OFFSET STRP ; Initialized SI as a pointer for STRP
L9:     MOV AL, [SI] ; Compare stored password with entered password.
        CMP AL, [DI] ; If both are equal with same ENTER ASCII hex code
        JNE L7 ; as an end of both, then print MSG6
        INC SI ; If both are not equal, then print MSG7
        INC DI ; and then print MSG8 and take entry of user name again
        CMP AL, CR
        JNE L9
        JE L8 
L7:     PRINT MSG7
        PRINT MSG8
        JMP L10
L8:     PRINT MSG6
        PRINT MSG9
        MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START
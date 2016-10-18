; This program installs its own Ctrl-Break handler and
; prevents the user from using Ctrl-Break (or Ctrl-C)
; to halt the program. The program inputs and echoes
; keystrokes until the Esc key is pressed.
; Last update: 06/01/2006

INCLUDE Irvine16.inc

.data
StudentNum = 10
ByteBuffer BYTE ?
InputHint1 BYTE "Student ",0
InputHint2 BYTE "Input Score: ",0

FAIL BYTE "Fail",0dh,0ah,0
PASS BYTE "Pass",0dh,0ah,0
EXCELLENT BYTE "Excellent",0dh,0ah,0
Score BYTE 0
.code
main PROC
	mov   ax,@data
	mov   ds,ax
    mov eax, 0
    mov cx, StudentNum
studentloop:
    mov dx, OFFSET InputHint1
    call WriteString
    mov ax, StudentNum + 1
    sub ax, cx
    call WriteDec
    call Crlf
    mov dx, OFFSET InputHint2
    call WriteString
    mov Score, 0
readachar:
    mov ah, 1
    int 21h
    mov ByteBuffer, al
    
    cmp al,0dh
    je readacharend
    cmp al,0ah
    je readacharend
    mov al, Score
    mov bl, 10
    mul bl
    add al,ByteBuffer
    sub al, 48
    mov Score, al
    jmp readachar
readacharend:
    movzx eax, Score
    .IF eax < 60
        mov dx, OFFSET FAIL
    .ELSEIF eax >= 60 && eax <= 90
        mov dx, OFFSET PASS
    .ELSE
        mov dx, OFFSET EXCELLENT
    .ENDIF

    call WriteString    
    call Crlf
    dec cx
    cmp cx, 0
    jne studentloop


    ; Wait for a keystroke.
	mov	ah,0
	int	16h
	exit
main ENDP

END main
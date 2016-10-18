INCLUDE Irvine16.inc

;------------ Video Mode Constants -------------------
Mode_12 = 12h		; 640 X 480, 16 colors

.data
saveMode  BYTE  ?		; save the current video mode
currentX  WORD 100		; column number (X-coordinate)
currentY  WORD 100		; row number (Y-coordinate)
COLOR_CYAN = 1001b			; line color (cyan)
; When using a 2-color mode, set COLOR to 1 (white)

.code
main PROC
	mov	ax,@data
	mov	ds,ax

; Save the current video mode.
	mov	ah,0Fh
	int	10h
	mov	saveMode,al

; Switch to a graphics mode.
	mov	ah,0   			; set video mode
	mov	al,Mode_12
	int	10h

    mov ah, 0Ch
    mov al, COLOR_CYAN
    mov bh, 0

    mov cx, 0
    mov dx, 0
L:
    int 10h
    inc cx
    inc dx
    int 10h
    inc cx
    inc dx
    int 10h
    inc cx
    int 10h
    inc cx
    inc dx 

    cmp cx, 640
    jne L


; Wait for a keystroke.
	mov	ah,0
	int	16h

; Restore the starting video mode.
	mov	ah,0   			; set video mode
	mov	al,saveMode   		; saved video mode
	int	10h

	exit
main ENDP

END main

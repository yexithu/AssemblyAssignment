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

;------------------------------------------------------
DrawHorizLine PROC
;
; Draws a horizontal line starting at position X,Y with
; a given length and color.
; Receives: CX = X-coordinate, DX = Y-coordinate,
;           AX = length, and BL = color
; Returns: nothing
;------------------------------------------------------
.data
currX WORD ?

.code
	pusha
	mov  currX,cx	; save X-coordinate
	mov  cx,ax	; loop counter

DHL1:
	push cx		; save loop counter
	mov  al,bl	; color
	mov  ah,0Ch	; draw pixel
	mov  bh,0		; video page
	mov  cx,currX	; retrieve X-coordinate
	int  10h
	inc  currX	; move 1 pixel to the right
	pop  cx		; restore loop counter
	Loop DHL1

	popa
	ret
DrawHorizLine ENDP

;------------------------------------------------------
DrawVerticalLine PROC
;
; Draws a vertical line starting at position X,Y with
; a given length and color.
; Receives: CX = X-coordinate, DX = Y-coordinate,
;           AX = length, BL = color
; Returns: nothing
;------------------------------------------------------
.data
currY WORD ?

.code
	pusha
	mov  currY,dx	; save Y-coordinate
	mov  currX,cx	; save X-coordinate
	mov  cx,ax	; loop counter

DVL1:
	push cx		; save loop counter
	mov  al,bl	; color
	mov  ah,0Ch	; function: draw pixel
	mov  bh,0		; set video page
	mov  cx,currX	; set X-coordinate
	mov  dx,currY	; set Y-coordinate
	int  10h		; draw the pixel
	inc  currY	; move down 1 pixel
	pop  cx		; restore loop counter
	Loop DVL1

	popa
	ret
DrawVerticalLine ENDP

DrawRect PROC,
    left: WORD, 
    top: WORD, 
    right: WORD,
    bottom: WORD,
    color: BYTE
    pusha
    mov bl, color
    ;cx - x dx y ax l bl color
    mov ax, bottom
    sub ax, top
    mov cx, left
    mov dx, top
    call DrawVerticalLine
    mov ax, bottom
    sub ax, top
    mov dx, top
    mov cx, right
    call DrawVerticalLine

    mov ax, right
    sub ax, left
    
    mov cx, left
    mov dx, top
    call DrawHorizLine
    mov ax, right
    sub ax, left
    mov cx, left
    mov dx, bottom
    call DrawHorizLine

    popa    
    ret
DrawRect ENDP

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

    invoke DrawRect, 40, 40, 600, 440, red
    invoke DrawRect, 100, 100, 540, 380, COLOR_CYAN
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

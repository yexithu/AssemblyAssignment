TITLE Control-Break Handler             (Ctrlbrk.asm)

; This program installs its own Ctrl-Break handler and
; prevents the user from using Ctrl-Break (or Ctrl-C)
; to halt the program. The program inputs and echoes
; keystrokes until the Esc key is pressed.
; Last update: 06/01/2006

INCLUDE Irvine16.inc

.data
Mode_12 = 12h		; 640 X 480, 16 colors
saveMode  BYTE  ?		; save the current video mode\
COLOR = 1001b			; line color (cyan)
progTitle BYTE "Welcome to ASM"
TITLE_ROW = 10
TITLE_COLUMN = 36

.code
main PROC
	mov   ax,@data
	mov   ds,ax

install_handler:
	push  ds          	; save DS
	mov   ax,@code    	; initialize DS
	mov   ds,ax
	mov   ah,25h      	; set interrupt vector
	mov   al,01h      	; for interrupt 23h
	mov   dx,OFFSET intr_handler
	int   21h
	pop   ds          	; restore DS

    int 01h
    int 01h
    ; Wait for a keystroke.
	mov	ah,0
	int	16h

	exit
main ENDP

; The following procedure executes when
; Ctrl-Break (Ctrl-C) is pressed.

intr_handler PROC
; Write the program name, as text.
    pusha

    ; Save the current video mode.
	mov	ah,0Fh
	int	10h
	mov	saveMode,al

; Switch to a graphics mode.
	mov	ah,0   			; set video mode
	mov	al,Mode_12
	int	10h

	mov	ax,SEG progTitle
	mov	es,ax
	mov	bp,OFFSET progTitle

	mov	ah,13h			; function: write string
	mov	al,0				; mode: only character codes
	mov	bh,0				; video page 0
	mov	bl,7				; attribute = normal
	mov	cx,SIZEOF progTitle	; string length
	mov	dh,TITLE_ROW		; row (in character cells)
	mov	dl,TITLE_COLUMN	; column (in character cells)
	int	10h

    ; Wait for a keystroke.
	mov	ah,0
	int	16h

; Restore the starting video mode.  
	mov	ah,0   			; set video mode
	mov	al,saveMode   		; saved video mode
	int	10h


    popa
	iret
intr_handler ENDP
END main
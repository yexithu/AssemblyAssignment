INCLUDE Irvine16.inc

Write PROTO char:BYTE
.data
ESBUFFER WORD ?
BXBUFFER WORD ?
LINEPERPAGE = 8
ITEMPERLINE = 4
PAGECOUNT = 8
Index BYTE 0
SPACES BYTE "  ",0
SEMICOLON BYTE ":",0
HINT BYTE "Please press any key", 0dh,0ah,0
str1 BYTE "Date: ",0
str2 BYTE ",  Time: ",0
.code
main PROC
	mov	ax,@data
	mov	ds,ax

    call ClrScr

    mov eax, 0
    mov ecx, PAGECOUNT
pageloop:  
    
    push ecx
    mov ecx, LINEPERPAGE
    lineloop:

        push ecx
        mov ecx, ITEMPERLINE
        itemloop:
            mov ah,35h ; get interrupt vector
            mov al,Index
            int 21h ; call MS-DOS

            mov BXBUFFER,bx ; store the offset
            mov ESBUFFER,es ; store the segment

            mov ebx, TYPE BYTE
            call WriteHexB
            mov dx, OFFSET SPACES
            call WriteString
            movzx eax, ESBUFFER
            mov ebx, TYPE WORD
            call WriteHexB
            mov dx, OFFSET SEMICOLON
            call WriteString
            movzx eax, BXBUFFER
            mov ebx, TYPE WORD
            call WriteHexB
            mov dx, OFFSET SPACES
            call WriteString
            inc Index

            dec ecx
            cmp ecx, 0
            jne itemloop
        call Crlf
        pop ecx

        dec ecx
        cmp ecx, 0
        jne lineloop
    ; Wait for a keystroke.
    mov dx, OFFSET HINT
    call WriteString
	mov	ah,0
	int	16h
    pop ecx
    dec ecx
    cmp ecx, 0
    jne pageloop


    ; Display the date:
	mov   dx,OFFSET str1
	call  WriteString
	mov   ah,2Ah		; get system date
	int   21h
	movzx eax,dh		; month
	call  WriteDec
	INVOKE Write,'-'
	movzx eax,dl		; day
	call  WriteDec
	INVOKE Write,'-'
	movzx eax,cx		; year
	call  WriteDec

; Display the time:
	mov   dx,OFFSET str2
	call  WriteString
	mov   ah,2Ch		; get system time
	int   21h
	movzx eax,ch		; hours
	call  WritePaddedDec
	INVOKE Write,':'
	movzx eax,cl		; minutes
	call  WritePaddedDec
	INVOKE Write,':'
	movzx eax,dh		; seconds
	call  WritePaddedDec
	call  Crlf

; Wait for a keystroke.
	mov	ah,0
	int	16h

	exit
main ENDP

;---------------------------------------------
Write PROC char:BYTE
; Display a single character.
;---------------------------------------------
	push eax
	push edx
	mov  ah,2
	mov  dl,char
	int  21h
	pop  edx
	pop  eax
	ret
Write ENDP

;---------------------------------------------
WritePaddedDec PROC
; Display unsigned integer in EAX, padding
; to two digit positions with a leading zero.
;---------------------------------------------
	.IF eax < 10
	   push eax
	   push edx
	   mov  ah,2
	   mov  dl,'0'
	   int  21h
	   pop  edx
	   pop  eax
	.ENDIF

	call WriteDec
	ret
WritePaddedDec ENDP

END main

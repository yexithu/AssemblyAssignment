INCLUDE Irvine32.inc
.data
string BYTE "Color output is easy!", 
			 0dh, 0ah, 0

.code
main PROC
	call Clrscr

	mov edx, OFFSET string
	mov ecx, 4
	mov eax, 0
L:
	inc eax
	call SetTextColor

	call WriteString
	loop L

	mov eax, 15
	call SetTextColor
	exit
main ENDP
END main
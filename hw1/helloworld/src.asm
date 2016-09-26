INCLUDE Irvine32.inc
.data
string BYTE "Name: Xi Ye, Gender:male, ID: 2014013417, Class: SE41", 
			 0dh, 0ah, 0

.code
main PROC
	call Clrscr

	mov edx, OFFSET string
	call WriteString
	exit
main ENDP
END main
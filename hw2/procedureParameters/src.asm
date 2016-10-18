INCLUDE Irvine32.inc
.data
line1 BYTE "Stack Parameters", 0dh, 0ah, 0
line2 BYTE "---------------------------", 0dh, 0ah, 0
hint1 BYTE "Address ", 0
hint2 BYTE " = ", 0

.code
ShowParams PROC USES eax ebx edx
	mov edx, OFFSET line1
	call WriteString
	mov edx, OFFSET line2
	call WriteString

	mov ecx, eax
	mov ebx, ebp
	add ebx, 4
L:
	add ebx, 4

	mov edx, OFFSET hint1
	call WriteString

	mov eax, ebx
	call WriteHex

	mov edx, OFFSET hint2
	call WriteString

	mov eax, [ebx]
	call WriteHex

	call Crlf

	loop L

	call Crlf
	ret
ShowParams ENDP
	

SampleTwoPara PROC USES eax,
	first: DWORD, 
	second: DWORD
	mov eax, 2h
	call ShowParams
	ret
SampleTwoPara ENDP

SampleThreePara PROC USES eax,
	first: DWORD,
	second: DWORD,
	third: DWORD
	mov eax, 3
	call ShowParams
	ret
SampleThreePara ENDP

main PROC
	invoke SampleTwoPara, 1122h, 2233h
	invoke SampleThreePara, 3344h, 4455h, 5566h
	exit
main ENDP
END main
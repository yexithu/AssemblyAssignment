INCLUDE Irvine32.inc

.data
listX SDWORD 20, 20, 4, -4, 18
listY SDWORD -30, 30, 1, -2, -12

sizeTest = 5
argHint BYTE "Testing GCD of ",0
argAnd BYTE " and ",0
resHint BYTE "Result ",0

.code
gcd PROC USES ebx edx
	cmp eax,0
	JGE J1
	NEG eax
J1:
	cmp ebx,0
	JNE J2
		ret
J2:
	JGE J3
	NEG ebx
J3:


	.REPEAT
		mov edx,0
		DIV ebx
		;remainder edx
		mov eax,ebx
		mov ebx,edx
	.UNTIL !(ebx > 0)
	ret
gcd endp

main proc
	
	mov esi,0
	mov ecx,sizeTest

L:
	mov edx,OFFSET argHint
	call WriteString
	mov eax,listX[esi * TYPE listX]
	call WriteInt
	push eax
	mov edx,OFFSET argAnd
	call WriteString
	mov eax,listY[esi * TYPE listX]
	call WriteInt
	call Crlf
	mov ebx,eax
	pop eax
	mov edx,OFFSET resHint
	call WriteString
	call gcd
	call WriteInt
	call Crlf
	inc esi
	loop L
	invoke ExitProcess,0

main endp
end main
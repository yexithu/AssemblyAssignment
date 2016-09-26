.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
intArray WORD 600h, 500h, 400h, 300h, 200h
listSize = ($ -intArray) / TYPE intArray
resultNonLoop WORD 0
resultLoop WORD 0

.code
main proc

	;NonLoop
	mov esi,0
	mov ax,0
	add	ax,intArray[esi * TYPE intArray]
	inc esi
	add	ax,intArray[esi * TYPE intArray]
	inc esi
	add	ax,intArray[esi * TYPE intArray]
	inc esi
	add	ax,intArray[esi * TYPE intArray]
	inc esi
	add	ax,intArray[esi * TYPE intArray]
	mov resultNonLoop,ax	

	;LOOP
	mov ecx,listSize
	mov ax,0
	mov esi,0

L:
	add ax, intArray[esi * TYPE intArray]
	inc esi
	loop L
	mov resultLoop,ax	
	invoke ExitProcess,0

main endp
end main
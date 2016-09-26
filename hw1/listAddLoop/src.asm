.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
intArray WORD 600h, 500h, 400h, 300h, 200h
listSize = ($ -intArray) / TYPE intArray
result WORD 0

.code
main proc
	mov ecx,listSize
	mov ax,0
	mov esi,0

L:
	add ax, intArray[esi * TYPE intArray]
	inc esi
	loop L
	mov result,ax	
	invoke ExitProcess,0

main endp
end main
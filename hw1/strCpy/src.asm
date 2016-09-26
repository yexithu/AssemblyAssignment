.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
source BYTE 'Please copy this source string', 0
dst BYTE SIZEOF source DUP(0)

.code
main proc
	mov ecx, SIZEOF source
	mov esi,0	

L:
	mov al, source[esi]
	mov dst[esi], al
	inc esi
	loop L
	invoke ExitProcess,0

main endp
end main
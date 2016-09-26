INCLUDE Irvine32.inc

.data
fibSize = 15
step = TYPE DWORD
fibArray DWORD fibSize DUP(0)

.code
main proc
	mov fibArray[0],00000001h
	mov fibArray[step],00000001h
	mov esi,2 * step
	mov ecx,fibSize-2
	mov eax,fibArray[step]
L:
	add eax,fibArray[esi-2 * step]
	mov fibArray[esi],eax
	add esi,step
	loop L

	invoke ExitProcess,0

main endp
end main
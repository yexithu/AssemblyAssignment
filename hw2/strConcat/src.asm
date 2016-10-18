INCLUDE Irvine32.inc
.data
targetStr BYTE "ABCDE", 10 DUP(0)
sourceStr BYTE "FGHIJ", 0


.code
Str_concat PROC USES eax esi edi,
    dst: DWORD,
    src: DWORD
    
    ;Find the end of dst
    mov esi, dst
J1:
    mov al, [esi]
    cmp al, 0
    je J2
    inc esi
    jmp J1
J2:
    mov edi, src
J3:
    mov al, [edi]
    mov [esi], al
    inc esi
    inc edi
    cmp al, 0
    jne J3

    ret
Str_concat ENDP

main PROC
    invoke Str_concat, ADDR targetStr, ADDR sourceStr
    mov edx, OFFSET targetSTr
    call WriteString
    call Crlf
	exit
main ENDP
END main
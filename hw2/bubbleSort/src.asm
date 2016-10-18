INCLUDE Irvine32.inc
.data
array1 WORD 3, 1, 7, 4, 2, 9, 4, 3
array2 WORD 2, 4, 9, 8, 0, 3, 6, 1, 7, 5
.code

BubbleSort PROC USES eax ebx ecx edi esi,
    list: PTR WORD,
    n: WORD

    LOCAL flag: BYTE

    mov flag, 0
    movzx esi, n
    mov ecx, list


    mov ax, WORD PTR list

    .WHILE esi > 1
        mov flag, 0
        mov edi, 0

        dec esi
        .WHILE edi < esi
            mov ax, [ecx + edi * 2]
            mov bx, [ecx + edi * 2 + 2]
            .IF ax > bx
                mov flag, 1

                mov [ecx + edi * 2], bx
                mov [ecx + edi * 2 + 2], ax
            .ENDIF

            inc edi
        .ENDW 

        .IF flag == 0
            jmp quit
        .ENDIF
    .ENDW
quit:
    ret
BubbleSort ENDP
    
main PROC
    invoke BubbleSort, ADDR array1, LENGTHOF array1
    invoke BubbleSort, ADDR array2, LENGTHOF array2
	exit
main ENDP
END main
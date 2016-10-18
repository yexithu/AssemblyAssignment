; Date

INCLUDE Irvine16.inc

.data
intOffset  WORD ?
intSeg     WORD ?
itptStr    BYTE "Interrupt", 0
patternStr BYTE "Segment   :   Offset", 0

year       WORD ?
month      BYTE ?
date       BYTE ?
hour       BYTE ?
minute     BYTE ?
second     BYTE ?
dot        BYTE ".", 0
space      BYTE " ", 0
colon      BYTE ":", 0

.code
main PROC
    mov	ax, @data
    mov	ds, ax

    mov edx, OFFSET itptStr
    call WriteString
    mov edx, OFFSET patternStr
    call WriteString

    mov ecx, 256
    mov bl, 0

L1:
    mov eax, 0

    movzx eax, bl
    push ebx
    mov ebx, TYPE BYTE
    call WriteHexB
    pop ebx

    mov ah, 35h
    mov al, bl
    push ebx
    int 21h
    mov intOffset, bx
    mov intSeg, es
    pop ebx

    mov edx, OFFSET space
    call WriteString

    movzx eax, intSeg
    push ebx
    mov ebx, TYPE WORD
    call WriteHexB
    pop ebx

    mov edx, OFFSET space
    call WriteString

    movzx eax, intOffset
    push ebx
    mov ebx, TYPE WORD
    call WriteHexB
    pop ebx

    call crlf

    inc bl
    loop L1

    ; System Date
    mov ah, 2Ah
    int 21h
    mov year, cx
    mov month, dh
    mov date, dl

    mov eax, 0
    movzx eax, year
    call WriteDec
    mov edx, OFFSET dot
    call WriteString

    mov eax, 0
    movzx eax, month
    call WriteDec
    mov edx, OFFSET dot
    call WriteString

    mov eax, 0
    movzx eax, date
    call WriteDec
    mov edx, OFFSET space
    call WriteString

    mov ah, 2ch
    int 21h
    mov hour, ch
    mov minute, cl
    mov second, dh

    mov eax, 0
    movzx eax, hour
    call WriteDec
    mov edx, OFFSET colon
    call WriteString

    mov eax, 0
    movzx eax, minute
    call WriteDec
    mov edx, OFFSET colon
    call WriteString

    mov eax, 0
    movzx eax, second
    call WriteDec

    call crlf

    exit
main ENDP
END main

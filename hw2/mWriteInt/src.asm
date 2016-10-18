INCLUDE Irvine32.inc
.data
var1 SBYTE -128
var2 SBYTE -3
var3 SBYTE 127
var4 SWORD -32678
var5 SWORD 18
var6 SWORD 32677
var7 SDWORD -2147483648
var8 SDWORD 233
var9 SDWORD 2147483647
mWriteInt MACRO val
    push eax
    IF TYPE val EQ 4
        mov eax, val
    ELSE
        movsx eax, val
    ENDIF
    call WriteInt
    pop eax
ENDM

.code
main PROC
    mWriteInt var1
    call Crlf
    mWriteInt var2
    call Crlf
    mWriteInt var3
    call Crlf
    mWriteInt var4
    call Crlf
    mWriteInt var5
    call Crlf
    mWriteInt var6
    call Crlf
    mWriteInt var7
    call Crlf
    mWriteInt var8
    call Crlf
    mWriteInt var9
    call Crlf
	exit
main ENDP
END main
INCLUDE Irvine32.inc
.data

inputHint BYTE "student ",0

idHint BYTE "Please enter your student ID", 
			 0dh, 0ah, 0
idLabel BYTE "id: "
nameHint BYTE "Please enter your name", 
			 0dh, 0ah, 0
nameLabel BYTE "name: "
birthHint BYTE "Please enter your birthday(like 1996.01.01)",
             0dh, 0ah, 0
birthLabel BYTE "birthDay: "

fileName BYTE "students.txt", 0
fileHandle DWORD ?

strBuffer BYTE 30 DUP (0)
byteCount DWORD ?

LBreak BYTE 0dh, 0ah

.code

ReadAndWriteInfoLine PROC USES eax edx ecx,
    fHandle: DWORD,
    hint: PTR BYTE,
    tag: PTR BYTE,
    tagSize: DWORD

    mov edx, hint
    call WriteString
    
    mov edx, OFFSET strBuffer
    mov ecx, SIZEOF strBuffer
    call ReadString
    mov byteCount, eax

    mov eax, fHandle
    mov edx, tag
    mov ecx, tagSize
    call WriteToFile

    mov eax, fHandle
    mov edx, OFFSET strBuffer
    mov ecx, byteCount
    call WriteToFile

    mov eax, fHandle
    mov edx, OFFSET LBreak
    mov ecx, SIZEOF LBreak
    call WriteToFile
    ret
ReadAndWriteInfoLine ENDP

RecordStudent PROC USES eax edx ecx,
    fHandle: DWORD
    
    invoke ReadAndWriteInfoLine,
        fHandle,
        OFFSET idHint,
        OFFSET idLabel,
        SIZEOF idLabel
    
    invoke ReadAndWriteInfoLine,
        fHandle,
        OFFSET nameHint,
        OFFSET nameLabel,
        SIZEOF nameLabel
    
    invoke ReadAndWriteInfoLine,
        fHandle,
        OFFSET birthHint,
        OFFSET birthLabel,
        SIZEOF birthLabel

    mov eax, fHandle
    mov edx, OFFSET LBreak
    mov ecx, SIZEOF LBreak
    call WriteToFile

    ret
RecordStudent ENDP

main PROC

;CreateFiles
    mov edx, OFFSET fileName
    call CreateOutputFile
    mov fileHandle, eax

;Write Files
    mov ecx, 3
    mov eax, 0
L:
    mov edx, OFFSET inputHint
    call WriteString
    call WriteDec
    call Crlf
    
    invoke RecordStudent, fileHandle
    call Crlf
    inc eax
    loop L

;Close File
    mov eax, fileHandle
    call CloseFile

	exit
main ENDP
END main
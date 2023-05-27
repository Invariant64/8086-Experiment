; masm16

data segment
    inputSentenceMessage db 'Please input a sentence', '$' ;welcome message
    answerMessage db 'The answer is ', '$'

    sentenceBuffer db 0ffh, ?, 0ffh dup(?), '$' ;input buffer
    sentenceAdd db ?
    
    num dw 4118
data ends

stack segment para stack
    db 100h dup(0)
stack ends

code segment
    assume cs: code, ds: data, ss: stack
start:
    mov ax, data ;init
    mov ds, ax

    lea dx, inputSentenceMessage ;prompt
    call WriteString
    
    call Crlf ;enter
    
    lea dx, sentenceBuffer
    call ReadString
    call Crlf
    
    lea dx, sentenceBuffer + 2 ;append $ to the end of string
    add dl, [sentenceBuffer + 1]
    call EndString
    
    ;lea dx, sentenceBuffer + 2 ;echo the string
    ;call WriteString
    
    ;xor ax, ax
    ;mov al, [sentenceBuffer + 1] 
    ;call WriteUnsignedInteger
    
    xor ax, ax
    xor bx, bx
    inc ax
    ;mov bx, [sentenceBuffer + dx]
stat:
    mov dl, [sentenceBuffer + bx]
    cmp dl, 24h ; if string ends
    je end_of_stat
    cmp dl, 20h ; if char is space
    je stat_count
    inc bx
    jmp stat
stat_count:
    inc ax
    inc bx
    jmp stat
end_of_stat:
    ;call WriteUnsignedInteger

    ;mov dx, 20h
    ;call WriteChar
    
    mov bx, ax
    ;call WriteUnsignedInteger

    ;mov dx, 20h
    ;call WriteChar

    mov ax, [num]
    ; call WriteUnsignedInteger

    xor dx, dx
    div bx
    mov ax, dx
    inc ax
    
    lea dx, answerMessage
    call WriteString

    call WriteUnsignedInteger
    
    mov dx, 20h
    call WriteChar

    xor bx, bx
    xor cx, cx
    inc cl
find:
    cmp cl, al
    je write_word
    mov dl, [sentenceBuffer + bx]
    cmp dl, 20h
    je find_count
    inc bx
    jmp find
find_count:
    inc cx
    inc bx
    jmp find
write_word:
    mov dl, [sentenceBuffer + bx]
    cmp dl, 20h
    je write_end
    cmp dl, 24h
    je write_end
    call WriteChar
    inc bx
    jmp write_word
write_end:
    call Crlf ;enter

    call Terminate ;terminate the program


include ../common.asm
include ../us_io.asm

code ends

    end start

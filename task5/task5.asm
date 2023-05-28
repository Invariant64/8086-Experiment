data segment
    welcomeMessage db 'Please input a sentence', '$' ;welcome message
    answerMessage db 'the answer is ', '$'
    sentenceBuffer db 0ffh, ?, 0ffh dup(?), '$' ;input buffer
    stat db 26 dup(0) ;statistic
data ends

stack segment para stack
    db 100h dup(0)
stack ends

code segment
    assume cs: code, ds: data, ss: stack
start:
    mov ax, data ;init
    mov ds, ax

    lea dx, welcomeMessage ;prompt
    call WriteString
    call Crlf ;enter
    
    call ReadUnsignedInteger
    mov bx, ax
    call ReadChar
    call ReadUnsignedInteger
    mov ax, bx
    mov bx, 8
    mul bx

    lea dx, answerMessage
    call WriteString
    call WriteUnsignedInteger
    
    call Terminate ;terminate the program

include ../common.asm
include ../us_io.asm

code ends

    end start



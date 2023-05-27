; masm16

data segment
    welcomeMessage db 'Please input a number', '$' ;welcome message
    answerMessage db 'the answer is ', '$'
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
    mov ax, 1
p_start:    
    ;call WriteUnsignedInteger
    cmp bx, 1
    je p_end
    mul bx
    sub bx, 1
    jmp p_start
p_end:
    lea dx, answerMessage
    call WriteString
    call WriteUnsignedInteger

    call Terminate ;terminate the program

include ../common.asm
include ../us_io.asm

code ends

    end start


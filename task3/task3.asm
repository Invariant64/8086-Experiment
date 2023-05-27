data segment
    welcomeMessage db 'Please input a number', '$' ;welcome message
    answerMessage db 'the answer is ', '$'
    dot db '.', '$'
    
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
    
    xor ax, ax
    call ReadUnsignedInteger

    lea dx, answerMessage
    call WriteString

    mov bx, 9
    mul bx
    mov bx, 8
    div bx
    call WriteUnsignedInteger

    mov ax, dx
    
    lea dx, dot
    call WriteString
    
    xor cx, cx
    ;call WriteUnsignedInteger
add_001:
    test ax, 001b
    jz add_010
    add cx, 12
add_010:
    test ax, 010b
    jz add_100
    add cx, 25
add_100:
    test ax, 100b
    jz add_end
    add cx, 50
add_end:
    mov ax, cx
    call WriteUnsignedInteger
    cmp ax, 0
    jne p_end
    call WriteUnsignedInteger
p_end:
    call Terminate ;terminate the program

include ../common.asm
include ../us_io.asm

code ends

    end start



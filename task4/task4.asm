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
    
    lea dx, sentenceBuffer ;read a sentence
    call ReadString
    lea dx, sentenceBuffer + 2
    add dl, [sentenceBuffer + 1] 
    call EndString
    call Crlf ;enter

    xor ax, ax
    xor bx, bx ;init bx
    xor cx, cx
    mov cl, [sentenceBuffer + 1] ;get the length
stat_start:
    mov bx, cx
    mov al, [sentenceBuffer + 2 + bx] ;get a char
    cmp al, 'a' ;check if it is a letter
    jb stat_next
    cmp al, 'z'
    ja stat_next
    sub al, 'a' ;get the index

    mov bx, ax
    inc stat[bx] ;add 1 to the statistic
stat_next:
    sub cx, 1 ;next char
    cmp cx, -1
    jne stat_start

    lea dx, answerMessage ;prompt
    call WriteString

    xor bx, bx
output_start: ; output each alphabet by order
    cmp stat[bx], 0
    je output_next
    mov dl, bl
    add dl, 'a'
    call WriteChar
    sub stat[bx], 1
    jmp output_start
output_next:
    inc bx
    cmp bx, 26
    jb output_start
    
end_program:
    mov dl, '1'
    call WriteChar
    mov dl, '8'
    call WriteChar
    
    call Terminate ;terminate the program

include ../common.asm
include ../us_io.asm

code ends

    end start



; input an unsigned integer, saving in ax
ReadUnsignedInteger proc 
    push bp
    mov bp, sp
    push bx
    push cx
proc_start:
    xor ax, ax
    xor bx, bx
    xor cx, cx
proc_input:
    mov ah, 01h
    int 21h
proc_next:
    cmp al, 30h ; jump to save when input is illegal
    jb proc_save
    cmp al, 39h
    ja proc_save
    
    sub al, 30h ; bx multiply by 10
    shl bx, 1
    mov cx, bx
    shl bx, 1
    shl bx, 1
    add bx, cx

    add bl, al ; bl += al
proc_digital_in:
    mov ah, 01h
    int 21h
    jmp proc_next
proc_save:
    cmp al, 0dh
    ;jne proc_read_end
    mov ax, bx ; result saved in ax

proc_read_end:
    pop cx
    pop bx
    pop bp
    ret
ReadUnsignedInteger endp 

; Write an integer to standard output, the integer saved in ax
WriteUnsignedInteger proc
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    
    xor cx, cx
    mov bx, 10
proc_get_digit:
    xor dx, dx
    div bx
    add dl, 30h
    push dx ; result saved in stack
    inc cx ; cx stands for the digits of integer
    cmp ax, 0
    jne proc_get_digit
proc_output_digit:
    pop dx
    mov ah, 2
    int 21h
    loop proc_output_digit
proc_write_end:
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret
WriteUnsignedInteger endp
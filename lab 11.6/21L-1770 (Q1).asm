[org 0x0100]
jmp start

goose:      ;function to return -4
push bp
mov bp, sp
pusha

mov word [bp + 4], -4

popa
pop bp
ret


sky:        ;function to subtract two ints
    push bp
    mov bp, sp
    pusha

    mov ax, [bp + 4];
    sub ax, [bp + 6];
    mov [bp + 8], ax

    popa
    pop bp
    ret 4


sheep:      ;function to return 1 if parameter is -ve else 0
    push bp
    mov bp, sp
    pusha

    
    
    cmp word [bp + 4], 0
    jnl pos
        mov word [bp + 6], 1
        jmp exit

    pos:
    mov word [bp + 6], 0

  exit:
    popa
    pop bp
    ret 2

duck:
    push bp
    mov bp, sp
    pusha
    
    mov ax, [bp + 4];

    push word 0  ;for return value
    push word [bp + 4];
    call sheep
    pop bx

    cmp bx, 1
    jnz posit
    NOT ax
    inc ax
    
    posit:
     mov [bp + 6], ax

    popa
    pop bp
    ret 2

start:

push word 0 ;for return value
call goose
pop ax

push word 0  ;for return value
push word 56
push word 76
call sky
pop bx

push word 0  ;for return value
push -7
call sheep
pop cx

push word 0  ;for return value
push -32
call duck
pop dx

mov ax, 0x4c00
int 0x21
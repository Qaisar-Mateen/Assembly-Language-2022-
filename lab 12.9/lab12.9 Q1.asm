[org 0x0100]

jmp start

clear:
    push es
    push ax
    push cx
    push di

    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov ax, 0x0720 ;space
    mov cx, 2000
    
    cld
    rep stosw

    pop di
    pop cx
    pop ax
    pop es
    ret

star:
    push es
    push ax
    push cx
    push di

    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov ax, 0x072A
    mov word[es:di], ax
    mov cx, 79
    
movright:
    call Delay
    mov word[es:di], 0x0720
    add di, 2
    mov word[es:di], ax
    dec cx
    jnz movright

mov cx, 24

movdown:
call Delay
    mov word[es:di], 0x0720
    add di, 160
    mov word[es:di], ax
    dec cx
    jnz movdown

mov cx, 79

movleft:
call Delay
    mov word[es:di], 0x0720
    sub di, 2
    mov word[es:di], ax
    dec cx
    jnz movleft

mov cx, 24

movup:
call Delay
    mov word[es:di], 0x0720
    sub di, 160
    mov word[es:di], ax
    dec cx
    jnz movup


    pop di
    pop cx
    pop ax
    pop es
    ret

Delay: 
    push bx
    
    mov bx, 0xffff
    del:
        dec bx
        jnz del

    pop bx
    ret
    
start:

call clear
call star

mov ax, 0x4c00
int 0x21



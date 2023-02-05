[org 0x0100]

jmp start

allASCI:
    push es
    push ax
    push cx
    push di

    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov ax, 0x0700
    mov cx, 2000

l1:
   mov word[es:di], ax
   add di, 2
   inc al
   dec cx
   jnz l1

    pop di
    pop cx
    pop ax
    pop es

    ret

start:

call allASCI

mov ax, 0x4c00
int 0x21
[org 0x0100]

jmp start

print:
    push es
    push ax
    push cx
    push di

    mov ax, 0xb800
    mov es, ax
    mov di, 0 
    mov ax, 0x075F ; _
    mov cx, 1040
  
l1:
   mov [es:di], ax
   add di, 2
   dec cx
   jnz l1

 mov cx, 960
 mov ax, 0x072E ; _

l2:
   mov [es:di], ax
   add di, 2
   dec cx
   jnz l2


    pop di
    pop cx
    pop ax
    pop es
    ret

start:

   call print

mov ax, 0x4c00
int 0x21
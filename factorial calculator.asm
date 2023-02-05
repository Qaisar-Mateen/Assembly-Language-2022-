[org 0x0100]

jmp start

num: dw 4
facto: dw 0 

start:
mov ax, [num]; ax = 4
mov cx, ax ; cx = 4
dec cx ; cx-- , cx = 3
mov si, [num]

l1:
   mov bx,cx

   jmp l2
l1_back:
   mov ax, [facto]
   dec cx
   dec si
   cmp si, 1
   je end
   jmp l1


l2:
   add [facto], ax
   dec bx
   cmp bx, 1
   je l2
   jmp l1_back
 
end:
mov ax, 0x4c00
int 0x21


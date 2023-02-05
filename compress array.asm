[org 0x0100]

jmp start

arr: dw 2, 2, 2, 3, 4, 4, 5, 5, 5, 6
len: dw 20

start:
mov si, 0 ;non repeating ndex
mov di, 2 
mov ax, [arr]

l1:
   mov ax, [arr + di]
   cmp ax, [arr + si]
   je skip
   add si, 2
   mov [arr + si], ax
skip:
   add di, 2
   cmp di, 20
   je out1
   jmp l1

out1:
   l2:
      add si, 2
      mov word[arr + si], 0
      cmp si, 20
      je end
      jmp l2
end:
mov ax, 0x4c00 ;terminate
int 0x21
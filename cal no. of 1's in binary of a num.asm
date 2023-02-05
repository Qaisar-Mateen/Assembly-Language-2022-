[org 0x0100]

jmp start

num1: dw 0xB189
num2: dw 0xABA5
ones: dw 0

start:
mov ax, [num1]
mov cx, 0

l1:            ;calculating no. of ones in the binary of ax
     SHR ax, 1
     jnc skip
     inc cx
     skip:
     cmp ax, 0
     je endl1
     jmp l1

endl1:
mov [ones], cx ; no. of ones in binary of ax

mov dx, 0 ; will have map for xor

l2:      ; making the map
     STC
     RCL dx, 1
     dec cx
     jnz l2
mov bx, [num2]

XOR bx, dx ; complimenting last [ones] bits of bx

mov ax, 0x4c00
int 0x21

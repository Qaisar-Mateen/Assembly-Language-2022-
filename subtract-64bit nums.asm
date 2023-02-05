[org 0x100]

mov ax,[num1]
mov bx,[num2]
sub ax,bx
mov [result],ax

mov ax,[num1+2]
mov bx,[num2+2]
sbb ax,bx
mov [result+2],ax

mov ax,[num1+4]
mov bx,[num2+4]
sbb ax,bx
mov [result+4],ax

mov ax,[num1+6]
mov bx,[num2+6]
sbb ax,bx
mov [result+6],ax

mov ax,0x4c00
int 0x21 

num1: dd 0xE4C21AAF,0xABD41921
num2: dd 0x0ABCDEF0,0x12345678
result: dd 0x0,0x0
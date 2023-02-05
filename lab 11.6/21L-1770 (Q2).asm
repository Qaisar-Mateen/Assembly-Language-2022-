[org 0x0100]
jmp start

str0: dw 0, 2, 4, 6, 5, 7, 19
str1: dw 1, 2, 3, 4, 5, 6, 7
length: dw 7

Get_Sum:
    push bp
    mov bp, sp
    pusha

    mov bx, [bp + 6]
    mov cx, [bp + 4]
    mov ax, 0

    l:
    add ax, [bx];
    add bx, 2

    loop l

    mov word [bp + 8], ax

    popa
    push bp
    ret 4

start:

push word 0   ;space to return value
push str0
push word [length]
call Get_Sum
pop ax


push word 0   ;space to return value
push str1
push word [length]
call Get_Sum
pop ax

mov ax, 0x4c00
int 0x21
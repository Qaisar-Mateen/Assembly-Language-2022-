[org 0x0100]

mov ax, 0
mov si, 0 ;index to triverse set
mov di, 0 ;index to triverse subset
mov bx, 0 ;for indexing in check next function
mov cx, 0 ;to store index
mov dx, 1 ;for checking same element of set & subset

jmp find_index

end_index:
cmp dx, 1
jne en
mov word[index], -1 ;if not found
jmp ter
en:
mov [index], cx
ter:
mov ax, 0x4c00
int 0x21

set: dw 1, 2, 4, 1, 1, 2, 3, 1, 2, 5
subset: dw 1, 2, 3
size: dw 3
index: dw 0

find_index:
           mov ax, [set + si]
           cmp ax, [subset]
           mov bx, si
           je check_next
again:     add si, 2
           inc cx ;to get index in req form ie. 0=0 , 1=2, 2=4,3=6
           mov dx, 1
           mov di, 0
           cmp si, 20
           je end_index
           jmp find_index


check_next:
           mov ax, [set + bx + 2]
           add di, 2
           cmp [subset + di], ax
           jne skip
           inc dx ;dx++
      skip:cmp dx, [size]
           je end_index
           add bx, 2
           cmp di, 4
           je again
           jmp check_next
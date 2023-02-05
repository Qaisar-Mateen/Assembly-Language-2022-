[org 0x0100]

mov ax, 0x000D ; set 320x200 graphics mode
int 0x10 ; bios video services

mov ax, 0x0c07 ; put pixel in white color

xor bx, bx ; page number 0
mov di, 600 ; x position 200
mov si, 200 ; y position 200
mov bp, 5   ; draw 5 lines

lop1:
mov dx, si
mov cx, di

l1: int 0x10; bios video services
dec dx      ; decrease y position
loop l1     ; decrease x position and repeat
sub di, 100
dec bp
jnz lop1

xor bx, bx ; page number 0
mov di, 320 ; x position 320
mov si, 0   ; y position 0
mov bp, 5   ; draw 5 lines

lop2:
mov dx, si
mov cx, di

l2: int 0x10 ; bios video services
inc dx       ; increase y position
loop l2      ; decrease x position and repeat

sub di, 40
dec bp
jnz lop2

mov ah, 0 ; service 0 – get keystroke
int 0x16 ; bios keyboard services

mov ax, 0x0003 ; 80x25 text mode
int 0x10 ; bios video services

mov ax, 0x4c00 ; terminate program
int 0x21
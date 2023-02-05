[org 0x0100]

jmp start

down: db 0
time: db 0
buffer: dw 0
cordinate: dw 0

timer:
   push ax
   push es

   inc byte [cs:time]

   cmp byte [cs:time], 18
   jne quit
strt:
   mov ax, 0xb800
   mov es, ax

   mov byte [cs:time], 0

   mov bx, [cs:cordinate]
   mov ax, [CS:buffer]
   mov [es:bx], ax

   cmp byte [cs:down], 0
   jne subbs
   cmp bx, 158
   jge nextcmp
   add bx, 2
   jmp exit

   nextcmp:
   cmp bx, 3998
   jge nextcmp1
   add bx, 160
   jmp exit

   nextcmp1:
   cmp bx, 3998
   jne exit
   mov byte[cs:down], 1

subbs:
   cmp bx, 3840
   jng nextcmp2
   sub bx, 2
   jmp exit

   nextcmp2:
   cmp bx, 0
   jng nextcmp3
   sub bx, 160
   jmp exit

   nextcmp3:
   cmp bx, 0
   jne exit
   mov byte[cs:down], 0
   jmp strt

   exit:
   mov ax, [es:bx]
   mov [cs:buffer], ax
   mov [cs:cordinate], bx

   mov ax, 0x0F2A
   mov [es:bx], ax
   
quit:
   mov al, 0x20
   out 0x20, al   ;//E.O.T. signal to P.I.C.

   pop es
   pop ax
   iret

start:
    mov ax, 0
    mov es, ax

    cli ; disable interrupts

	mov word [es:8*4], timer ; store offset at n*4
	mov [es:8*4 + 2], cs ; store segment at n*4+

    mov ax, 0xb800
    mov es, ax
    mov ax , word [es:0]
    mov [buffer], ax

	sti ; enable interrupts
	
    mov dx, start ; end of resident portion
	add dx, 15 ; round up to next para
	shr dx, 4 ; divide by 16

	mov ax, 0x3100 ; terminate and stay resident
	int 0x21 
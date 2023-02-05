[org 0x0100]
 
jmp start

buffer: times 4000 db 0 ; space for 4000 bytes

pre_isr: dd 0          ;to store previous isr
;---------------------------------------------------------------------------
sleep:		push cx

		mov cx, 0xFFFF
delay:		loop delay

		pop cx
		ret
;--------------------------------------------------------------------
; subroutine to clear the screen
;--------------------------------------------------------------------
clrscr:		push es
			push ax
			push di

			mov ax, 0xb800
			mov es, ax					; point es to video base
			mov di, 0					; point di to top left column

nextloc:	mov word [es:di], 0x0720	; clear next char on screen
			add di, 2					; move to next screen location
			cmp di, 4000				; has the whole screen cleared
			jne nextloc					; if no clear next position

			pop di
			pop ax
			pop es
			ret
;--------------------------------------------------------------------

 ;-----------------------------------------------------------------
; subroutine to save the screen
;-----------------------------------------------------------------
saveScreen:	pusha	


			mov cx, 4000 ; number of screen locations

					

			mov ax, 0xb800
			mov ds, ax ; ds = 0xb800

			push cs
			pop es
		
			mov si, 0
			mov di, buffer

			cld ; set auto increment mode
			rep movsb ; save screen

			;[es:di] = [ds:si]
			

popa
			ret
;-----------------------------------------------------------------
;-----------------------------------------------------------------
; subroutine to restore the screen
;-----------------------------------------------------------------
restoreScreen:		pusha	


			mov cx, 4000 ; number of screen locations

			mov ax, 0xb800
			mov es, ax ; ds = 0xb800

			push cs
			pop ds
		
			mov si, buffer
			mov di, 0

			cld ; set auto increment mode
			rep movsb ; save screen

			;[es:di] = [ds:si]
			

popa
			ret	
;-----------------------------------------------------------------

kbHit:
   push ax

   in al, 0x60	
	
   cmp al, 0x30
   jne next

   call saveScreen
   call clrscr
   jmp quit

   next: 
   cmp al, 0xb0
   jne nomatch
   call sleep
   call sleep
   call sleep
   call sleep

   call restoreScreen

   jmp quit

nomatch:
    pop ax
    jmp far [cs:pre_isr]

quit: 
    mov al, 0x20
    out 0x20, al
    pop ax
    iret     

;-----------------------------------------------------------------

start: 

    xor ax, ax

    mov es, ax ;making es point to the bottom of IVT

    mov ax, [es:9*4]
    mov [pre_isr], ax

    mov ax, [es:9*4 + 2]
    mov [pre_isr + 2], ax

    cli
    mov word [es:9*4], kbHit
    mov word [es:9*4 + 2], cs

    sti

    mov dx, start
	add dx, 15 
	mov cl, 4
	shr dx, cl 

mov ax, 0x3100 ;//let it stay resident (TSR) code
int 0x21 
; sorting a list of ten numbers using bubble sort
;
; data before chnaging the code
; data = 2, 3, 6, -4, -1
;
;data after chnaging the code
;data = -4, -1, 2, 3, 6 
;
;

[org 0x0100]
jmp start

data: dw 6, -4, 3, -1, 2
swap: db 0

start:		mov cx, 10				; n = (5x2)-2

outerloop:	mov bx, data			; initialize start ptr
		sub cx, 2
		mov di, bx
		add di, cx				; endptr = startptr + n
		mov byte[swap], 0		; rest swap flag to no swaps

innerloop:	mov ax, [bx]			; load number in ax
		cmp ax, [bx+2]			; compare with next number
		jng noswap				; no swap if already in order
		
		mov dx, [bx+2]			; load second element in dx
		mov [bx+2], ax			; store first number in second
		mov [bx], dx			; store second number in first
		mov byte [swap], 1		; flag that a swap has been done

noswap:		add bx, 2				; advance bx to next index
		cmp bx, di				; are we at last index
		jne innerloop			; if not compare next two

	cmp byte [swap], 1		; check if a swap has been done
	je outerloop			; if yes make another pass

mov ax, 0x4c00 ; terminate program

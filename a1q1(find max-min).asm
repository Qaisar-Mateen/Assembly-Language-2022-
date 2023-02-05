;Find min and max elements from an array of 10 integers. Write two functions for
;-> Signed Numbers
;-> Unsigned Numbers
;----------------------------------------------------
[org 0x0100]

jmp start
;----------------------------------------------------

;------------------------
check_for_singed:    ;will find max/min for signed no.
l0:      cmp ax, [arr + si] ; checking if ax >= arr[si]
         jnl update_min

         cmp bx, [arr + si] ; checking if bx <= arr[si]
         jl update_max

back1:    add si, 2          ; si = si + 2    
         
         cmp si, 18
         jnz l0
         jmp back0
;------------------------

;------------------------
check_for_unsigned:  ;will find max/min for unsigned no.
l1:      cmp ax, [arr + si] ; checking if ax >= arr[si]
         ja update_min

         cmp bx, [arr + si] ; checking if bx <= arr[si]
         jna update_max

back2:    add si, 2          ; si = si + 2    
         
         cmp si, 18
         jnz l1
         jmp back0
;------------------------

;------------------------
update_max:  mov bx, [arr + si] ;update value for max
             cmp word[signed], 1
             je back1
             cmp word[signed], 0
             je back2
;------------------------

;------------------------
update_min:  mov ax, [arr + si] ; update value in min
             cmp word[signed], 1
             je back1
             cmp word[signed], 0
             je back2
;------------------------

;----------------------------------------------------
start: 
     mov ax, [arr]; this will store min no.
     mov bx, [arr]; this will store max no.
     mov si, 2    ; this will store index of array

     cmp word[signed], 1
     je check_for_singed
     
     cmp word[signed], 0
     je check_for_unsigned

back0:

mov [max], bx
mov [min], ax

mov ax, 0x4c00
int 0x21

signed: dw 1 ;if this is 0 the it will work for unsigned numbers else if it is 1 then it will work for signed numbers
arr: dw 5, -4, 7, -87, 34, 3, 2, 1, -7, 6 ; array of 10 integers
max: dw 0
min: dw 0
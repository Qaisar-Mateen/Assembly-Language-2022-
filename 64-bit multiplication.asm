[org 0x0100]
jmp start

;================================================
a: dd 0xABCDD4E1, 0x0 ; 64-bit                  |
b: dd 0xAB5C32        ; 32-bit                  |
result: dd 0x0, 0x0   ; 64-bit                  | 
;================================================

start:
      mov cx, 32 ; 32-bit (as b is 32 bit)

              mov bl,1
bit_wise:     test bl,[b]
              je skip_add

              mov ax, [a]
              add [result],ax
              mov ax, [a+2]
              adc [result+2], ax
              mov ax, [a+4]
              adc [result+4], ax
              mov ax, [a+6] 
              adc [result+6], ax       

skip_add:     shr word [b+2],1 ; so, shift b right instead
              rcr word [b],1 ; of shifting bl left

              shl word [a],1 
              rcl word [a+2],1
              rcl word [a+4],1
              rcl word [a+6],1
              dec cx
              jnz bit_wise

              mov ax, 0x4c00
              int 0x21

[org 0x0100]

jmp start
;---------------------------------------------

;--------------
intersection:
          mov ax, [set1 + si]
          cmp ax, 0      ;check if its the end of set
          je back0 
          jmp check_repeat
back1:    mov bx, 0
          add si, 2 ;next index of set1
          jmp intersection
;--------------

;--------------
check_repeat:   ;check if the element is present in both of the sets
            cmp ax, [set2 + bx]
            je move_to_inter
            add bx, 2
            cmp word[set2 + bx], 0
            je back1
            jmp check_repeat
;--------------

;--------------
move_to_inter:  ;put the required element in inter
             mov [inter + di], ax
             add di, 2
             jmp back1
;--------------

;---------------------------------------------
start:
mov ax, 0
mov bx, 0 ; index for set2 
mov si, 0 ; index for set1
mov di, 0 ; index for inter

jmp intersection

back0:
mov ax, 0x4c00
int 0x21

set1: dw 1, 4, 6, 0 
set2: dw 1, 3, 6, 8, 0

inter: dw 0, 0, 0, 0
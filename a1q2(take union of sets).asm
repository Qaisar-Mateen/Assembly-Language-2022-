[org 0x0100]

jmp start
;---------------------------------------------

;--------------
set1_in_U: ; put all elements of set1 in U 
          mov ax, [set1 + si]
          cmp ax, 0  ;check if set ends
          je back0 
          mov [U + di], ax
          add si, 2 ;next index of set1
          add di, 2 ;next index of U
          jmp set1_in_U
;--------------

;--------------
set2_in_U: ; puts all unique elements of set2 for U in U
          mov ax, [set2 + si]
          cmp ax, 0   ;check if set ends
          je back1
          mov bx, 0
          jmp check_U
back3:    add si, 2
          cmp word[repeat_f], 0
          je add_in_U
back4:    mov word[repeat_f], 0
          jmp set2_in_U
;--------------

;--------------
check_U:  ;check if element of set2 is unique for U
        cmp [U + bx], ax
        je repeat
        add bx, 2
        cmp word[U + bx], 0
        je back3
        jmp check_U
;--------------

;--------------
repeat:
       mov word[repeat_f], 1 ;setting repeat flag to 1
       jmp back3
;--------------    

;--------------
add_in_U:   ;adds element in U from set2
         mov [U + di], ax
         add di, 2
         jmp back4
;--------------     

;---------------------------------------------
start:
mov ax, 0
mov bx, 0 ; will be use for U's	 index in check_U section 
mov si, 0 ; index for set1 and 2
mov di, 0 ; index for union (U)

jmp set1_in_U

back0:
      mov si, 0 ;setting si=0 for set2
      jmp set2_in_U

back1:
mov ax, 0x4c00
int 0x21

repeat_f: dw 0
set1: dw 1, 4, 6, 0 
set2: dw 1, 3, 5, 8, 0

U: dw 0, 0, 0, 0, 0, 0, 0
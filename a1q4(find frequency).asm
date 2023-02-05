[org 0x0100]

jmp start
;----------------------------------------------

;--------------
frequency:  ;->this function will trivarse set and calculate the frequency of the first element of subset
          cmp ax, [set + si]
          je add_ind   ;will jump if equal
back1:    cmp si, [len]
          je back0
          add si, 2
          jmp frequency ;to loop
          
;--------------

;--------------
add_ind:    ;->this funcion will add one to bx(index)
        inc bx ;bx++
        jmp back1   
;--------------


;--------------
no_freq:     ;-> if the frequency is zero then put -1 in it
        mov bx, -1
        jmp back2
;--------------

;----------------------------------------------

start:
      mov ax, [subset];no. for which we will cal. frequency(index)
      mov bx, 0       ;to store frequency
      mov si, 0       ;to store index of set

      jmp frequency

back0:
      cmp bx, 0
      je no_freq
back2:
      mov [index], bx  
    
mov ax, 0x4c00 ;terminates program
int 0x21

len: dw 18 ;length of set in bytes.
set: dw 1, 2, 4, 1, 1, 2, 3, 1, 2, 5
subset: dw 1, 2, 3

index: dw 0
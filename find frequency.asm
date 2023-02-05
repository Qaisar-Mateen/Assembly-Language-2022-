[org 0x0100]

jmp start
;----------------------------------------------

;--------------
frequency:  ;->this function will trivarse set and calculate the frequency of the first element of subset
          cmp ax, [set + si]
          je inc_freq   ;will jump if equal
back1:    cmp si, [len]
          je back0
          add si, 2
          jmp frequency ;to loop
          
;--------------

;--------------
inc_freq:    ;->this funcion will add one to bx(frequency)
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
      mov ax, [num]  ;no. for which we will cal. frequency(index)
      mov bx, 0       ;to store frequency
      mov si, 0       ;to store index of set

      jmp frequency

back0:
      cmp bx, 0
      je no_freq
back2:
      mov [freq], bx  
    
mov ax, 0x4c00 ;terminates program
int 0x21

len: dw 10 ;length of set in bytes.
set: dw 2, 4, 2, 2, 6, 2
num: dw 2

freq: dw 0
[org 0x0100]

jmp start

msg_name:		db ' Enter your name: '           ;size after the string
name_size:              dw  18
msg_roll:		db ' Enter Roll-no.: '
roll_size:              dw  17
msg_course:		db ' Enter Course name: '
course_size:            dw  20
msg_sect:		db ' Enter Section: '
sect_size:              dw  16

name:		db '    Name: '           ;size after the string
name_s:              dw  10
roll:		db ' Roll-no: '
roll_s:              dw  10
course:		db '  Course: '
course_s:            dw  10
sect:		db ' Section: '
sect_s:              dw  10


buf_name:	db 70 						; Byte # 0: Max length of buffer
                db 0 						; Byte # 1: number of characters on return(actual size after writing)
times 70        db 0

buff_roll:      db 40, 0
times 40        db 0

buff_course:    db 60, 0
times 60        db 0

buff_sec:       db 30, 0
times 30        db 0

clear_s:

       push es
       push ax
       push di
       push cx

       mov ax, 0xb800
       mov es, ax
       mov ax, 0x0F20
       mov cx, 2000
       mov di, 0

       cld 
       rep stosw

       pop cx
       pop di
       pop ax
       pop es
       ret

print_BIOS:  ;;take cordinate to print size and string array as parameters

        push di
        mov di, sp

        push ax
        push bx
        push es
        push bp
        push dx

        mov ah, 0x13       ;bios print string service

        mov al, 0          ;to not update our cursor
        mov bh, 0          ;to print on page 0
        mov bl, 0x0F       ;attribute for string
        mov dx, [di + 8]   ;corndinate to print on

        push ds        ;es = ds
        pop es         

        mov bp, [di + 4]  ;putting string's ip in bp
        mov cx, [di + 6]  ;putting size in cx
        int 0x10

        pop dx
        pop bp
        pop es
        pop bx
        pop ax
        pop di
        ret 6

start:
        call clear_s
        push 1 ;bit 0 of al
        push 0
        push word[name_size]
        push msg_name
        call print_BIOS

        mov dx, buf_name 		       ; input buffer (ds:dx pointing to input buffer)
	mov ah, 0x0A 			       ; DOS' service A – buffered input
	int 0x21 			       ; dos services call

        ;mov bh, 0
	;mov bl, [buf_name+1] 		       ; read actual size in bx i.e. no of characters user entered
	;mov byte [buf_name + bx + 2], '$'      ; making our input string terminated
;-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==->>
        call clear_s
        push 1
        push 0
        push word[roll_size]
        push msg_roll
        call print_BIOS

        mov dx, buff_roll                      ;storing rollno. using dos service
        mov ah, 0x0A
        int 0x21             
;-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==->>

        call clear_s
        push 1
        push 0
        push word[course_size]
        push msg_course
        call print_BIOS

        mov dx, buff_course                     ;storing course name using dos service
        mov ah, 0x0A
        int 0x21
;-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==->>

        call clear_s
        push 1
        push 0
        push word[sect_size]
        push msg_sect
        call print_BIOS

        mov dx, buff_sec                        ;storing section using dos service
        mov ah, 0x0A
        int 0x21

;-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==->>
;                             printing the input                                   ||
;-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==->>

        call clear_s
        push 0
        push 0
        push word[name_s]
        push name
        call print_BIOS

        mov ax, 0
        mov al, [buf_name + 1] ;size
        mov bx, buf_name
        add bx, 2

        push 0
        push 10
        push ax
        push bx
        call print_BIOS
        ;------------------------

        push 0
        push 80;40
        push word[roll_s]
        push roll
        call print_BIOS

        mov ax, 0
        mov al, [buff_roll + 1] ;size
        mov bx, buff_roll
        add bx, 2

        push 0
        push 90;50
        push ax
        push bx
        call print_BIOS
        ;------------------------
        
        push 0
        push 160;80
        push word[course_s]
        push course
        call print_BIOS

        mov ax, 0
        mov al, [buff_course + 1] ;size
        mov bx, buff_course
        add bx, 2
        
        push 0
        push 170;90
        push ax
        push bx
        call print_BIOS
        ;------------------------

        push 1
        push 240;120
        push word[sect_s]
        push sect
        call print_BIOS

        mov ax, 0
        mov al, [buff_sec + 1] ;size
        mov bx, buff_sec
        add bx, 2
        
        push 1
        push 250;130
        push ax
        push bx
        call print_BIOS
        ;------------------------
        
	mov ax, 0x4c00 ; terminate program
	int 0x21 
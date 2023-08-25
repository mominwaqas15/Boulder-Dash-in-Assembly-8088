[org 0x0100]

jmp start

Name_Of_File db 'cave.txt', 0
FileHandling dw 0
Buffer_Array times 2000 db 0
MsgError db 'Error occurred!', 0
prev_isr: dd 0
horizontal_row: dw 0
x: dw 0
y: dw 0   
flag: dw 0
points: dw 0
time:  dw 500
message: db 'Congrats !!!! You Won The Game :)' ; string to be printed
length: dw 33 ; length of the string
message1: db 'Your Score is -> ' ; string to be printed
length1: dw 17
lost_message :db  'Oh no! You have been crushed by the boulder :( ';
lost_message_length : dw 47;


left_border:
 push es
 push ax
 push di
 mov ax, 0xb800
 mov es, ax ; point es to video base
 mov di, 0 ; point di to top left column
 mov ah, 11001010b
 mov al, 0x57
 nextloc1: mov word [es:di], ax ; clear next char on screen ax
 add di, 160 ; move to next screen location
 cmp di, 3520 ; has the whole screen cleared
 jne nextloc1 ; if no clear next position
 pop di
 pop ax
 pop es
 ret
 
 right_border:
 push es
 push ax
 push di
 mov ax, 0xb800
 mov es, ax ; point es to video base
 mov di, 158 ; point di to top left column
 mov ah, 11001010b
 mov al, 0x57
 nextloc2: mov word [es:di], ax ; clear next char on screen ax
 add di, 160 ; move to next screen location
 cmp di, 3678 ; has the whole screen cleared
 jne nextloc2 ; if no clear next position
 pop di
 pop ax
 pop es
 ret
 
 top_border:
 push es
 push ax
 push di
 mov ax, 0xb800
 mov es, ax ; point es to video base
 mov di, 0 ; point di to top left column
 mov ah, 11001010b
 mov al, 0x57
 nextloc3: mov word [es:di], ax ; clear next char on screen ax
 add di, 2 ; move to next screen location
 cmp di, 160 ; has the whole screen cleared
 jne nextloc3; if no clear next position
 pop di
 pop ax
 pop es
 ret
 
 bottom_border:
 push es
 push ax
 push di
 mov ax, 0xb800
 mov es, ax ; point es to video base
 mov di, 3360 ; point di to top left column
 mov ah, 11001010b
 mov al, 0x57
 nextloc4: mov word [es:di], ax ; clear next char on screen ax
 add di, 2 ; move to next screen location
 cmp di, 3520 ; has the whole screen cleared
 jne nextloc4; if no clear next position
 pop di
 pop ax
 pop es
 ret 

clrscr:
 push es
 push ax
 push di
 mov ax, 0xb800
 mov es, ax ; point es to video base
 mov di, 0 ; point di to top left column
 mov ah, 00101111b
 nextloc: mov word [es:di], 0x0720 ; clear next char on screen
 add di, 2 ; move to next screen location
 cmp di, 4000 ; has the whole screen cleared
 jne nextloc ; if no clear next position
 pop di
 pop ax
 pop es
 ret

printwin: 

push bp
mov bp, sp
push es
push ax
push cx
push si
push di

call clrscr


mov ax, 0xb800
mov es, ax ; point es to video base
mov di, 1000 ; point di to top left column
mov si, [bp+6] ; point si to string
mov cx, [bp+4] ; load length of string in cx
mov ah, 01001010b ; normal attribute fixed in al
nextcharwin:

 mov al, [si] ; load next char of string
mov [es:di], ax ; show this char on screen
add di, 2 ; move to next screen location
add si, 1 ; move to next char in string
loop nextcharwin ; repeat the operation cx times


pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 4


printlose: 

push bp
mov bp, sp
push es
push ax
push cx
push si
push di

call clrscr

mov ax, 0xb800
mov es, ax ; point es to video base
mov di, 1000 ; point di to top left column
mov si, [bp+6] ; point si to string
mov cx, [bp+4] ; load length of string in cx
mov ah, 00001100b ; normal attribute fixed in al
nextcharlose:

 mov al, [si] ; load next char of string
mov [es:di], ax ; show this char on screen
add di, 2 ; move to next screen location
add si, 1 ; move to next char in string
loop nextcharlose ; repeat the operation cx times


pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 4



Finished1:
;Exit the program
mov ax,0x4c00
int 0x21 ; call the DOS interrupt

printpoints: 
push bp
mov bp, sp
push es
push ax
push cx
push si
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, 3880 ; point di to top left column
mov si, [bp+6] ; point si to string
mov cx, [bp+4] ; load length of string in cx
mov ah, 01001001b ; normal attribute fixed in al
nextcharpoints:

 mov al, [si] ; load next char of string
mov [es:di], ax ; show this char on screen
add di, 2 ; move to next screen location
add si, 1 ; move to next char in string
loop nextcharpoints ; repeat the operation cx times


pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 4



print_num: push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov ax, [bp+4] ; load number in ax
mov bx, 10 ; use base 10 for division
mov cx, 0 ; initialize count of digits
nextdigit: mov dx, 0 ; zero upper half of dividend
div bx ; divide by 10
add dl, 0x30 ; convert digit into ascii value
push dx ; save ascii value on stack
inc cx ; increment count of values
cmp ax, 0 ; is the quotient zero
jnz nextdigit ; if no divide it again
mov di, 3916 ; point di to top left column
nextpos: pop dx ; remove a digit from the stack
mov dh, 00001010b ; use normal attribute
mov [es:di], dx ; print char on screen
add di, 2 ; move to next screen location
loop nextpos ; repeat for all digits on stack
pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 2


print_num1: push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov ax, [bp+4] ; load number in ax
mov bx, 10 ; use base 10 for division
mov cx, 0 ; initialize count of digits
nextdigit1: mov dx, 0 ; zero upper half of dividend
div bx ; divide by 10
add dl, 0x30 ; convert digit into ascii value
push dx ; save ascii value on stack
inc cx ; increment count of values
cmp ax, 0 ; is the quotient zero
jnz nextdigit1 ; if no divide it again
mov di, 3920 ; point di to top left column
nextpos1: pop dx ; remove a digit from the stack
mov dh, 0x07 ; use normal attribute
mov [es:di], dx ; print char on screen
add di, 2 ; move to next screen location
loop nextpos1 ; repeat for all digits on stack
pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 2


create_map:
 push bp
 mov bp, sp
 push es
 push ax
 push cx
 push si
 push di
 push bx
 mov ax, 0xb800
 mov es, ax ; point es to video base
 mov di, 0 ; point di to top left column
 mov si, Buffer_Array ; point si to string
 mov bx,0
 mov cx, 2000 ; load length of string in cx
 mov ah, 00001111b ; normal attribute fixed in al

nextchar: 
 mov al, [si] ; load next char of string
 cmp al,0x52
 je coordinate
 mov [es:di], ax ; show this char on screen
c_back:
 add di, 2 ; move to next screen location
 add si, 1 ; move to next char in string
 loop nextchar ; repeat the operation cx times
 pop bx
 pop di
 pop si
 pop cx
 pop ax
 pop es
 pop bp
 ret 

coordinate:
mov ah,10001010b
mov [es:di], ax
mov word[horizontal_row],di
mov ah, 00001111b 
 jmp c_back

print_points:
 push bp
 mov bp, sp
 push es
 push ax
 push cx
 push si
 push di
 push bx
 mov ax, 0xb800
 mov es, ax ; point es to video base
 mov di, 3900 ; point di to top left column
 mov al, byte[points] ; point si to string
 mov ah, 01111100b ; normal attribute fixed in al

 ;mov al, [si] ; load next char of string
 mov [es:di], ax ; show this char on screen
 pop bx
 pop di
 pop si
 pop cx
 pop ax
 pop es
 pop bp
 ret



kbisr: 

mov ax, word[points]
push ax ; place number on stack
call print_num ; call the print_num subroutine


push ax
push es
mov ax, 0xb800
mov es, ax ; point es to video memory
in al, 0x60 ; read a char from keyboard port
mov di,0
mov di,[horizontal_row]

cmp al, 0x48 ; is the up key 
jne nextcmp ; no, try next comparison
mov byte [es:di], ' ' ; yes, print L at top left
mov bx,[horizontal_row]
shr bx,1
mov byte[Buffer_Array+bx],' '
sub bx,80
mov si,Buffer_Array
add si,bx
mov al,[si]
cmp al,0x57;askii of W
je loop1
cmp al,0x42;askii of B
je loop2
cmp al,0x54; askii of T
jne t1
; Exit the program
  mov ax,0x4c00
  int 0x21 ; call the DOS interrupt
t1:
cmp al,0x44
jne loop3
mov dx,[points]
add dx,1
mov word[points],dx
loop3:
sub di,160
loop1:

mov al ,0x52
mov ah,10001010b
mov word [es:di], ax ; yes, print R at top left
mov word[horizontal_row],di
jmp bbb
loop2:

call clrscr
mov ax, lost_message
push ax ; push address of message
push word [lost_message_length] ; push message length
call printlose
mov ax,0x4c00
int 0x21
mov al ,0x52
mov ah,10001010b
mov word [es:di], ax ; yes, print R at top left
mov word[horizontal_row],di
bbb:
jmp match_not_found ; leave interrupt routine

nextcmp:
cmp al, 0x50 ; is the down key 
jne nextcmp2 ; no, try next comparison
mov byte [es:di], ' ' ; yes, print L at top left
mov bx,[horizontal_row]
shr bx,1
mov byte[Buffer_Array+bx],' '
add bx,80
mov si,Buffer_Array
add si,bx
mov al,[si]
cmp al,0x57;askii of W
je b2
cmp al,0x42;askii of B
je b2
cmp al,0x54; askii of T
jne t2
call clrscr ; call the clrscr subroutine

mov ax, message
push ax ; push address of message
push word [length] ; push message length
call printwin ; call the printstr subroutine
  mov ax,0x4c00
  int 0x21 ; call the DOS interrupt



; Exit the program

t2:
cmp al,0x44
jne bb2
mov dx,[points]
add dx,1
mov word[points],dx
bb2:
add di,160
b2:
mov al ,0x52
mov ah,10001010b
mov word [es:di], ax; yes, print R at top left
;mov word[Buffer_Array+bx],ax
mov word[horizontal_row],di
jmp match_not_found ; leave interrupt routine

nextcmp2:
cmp al, 0x4B ; is the left key 
jne nextcmp3 ; no, try next comparison
mov byte [es:di], ' ' ; yes, print L at top left
mov bx,[horizontal_row]
shr bx,1
mov byte[Buffer_Array+bx],' '
sub bx,1
mov si,Buffer_Array
add si,bx
mov al,[si]
cmp al,0x57;askii of W
je loop7
cmp al,0x42;askii of B
je loop7
cmp al,0x54; askii of T
jne loop5
call clrscr ; call the clrscr subroutine
mov ax, message
push ax ; push address of message
push word [length] ; push message length
call printwin ; call the printstr subroutine

mov ax, word[points]
push ax ; place number on stack
call print_num ; call the print_num subroutine


; Exit the program
  mov ax,0x4c00
  int 0x21 ; call the DOS interrupt
loop5:
cmp al,0x44
jne loop6
mov dx,[points]
add dx,1
mov word[points],dx
loop6:
sub di,2
loop7:
mov al ,0x52
mov ah,10001010b
mov word [es:di], ax ; yes, print R at top left
;mov word[Buffer_Array+bx],ax
mov word[horizontal_row],di
jmp match_not_found ; leave interrupt routine

nextcmp3: 
cmp al, 0x4D ; is the right key
jne match_not_found ; no, leave interrupt routine
mov byte [es:di], ' ' ; remove dirt
mov bx,[horizontal_row]
shr bx,1
mov byte[Buffer_Array+bx],' '
mov bx,[horizontal_row]
shr bx,1
mov si,Buffer_Array
add bx,1
add si,bx
mov al,[si]
cmp al,0x57;askii of W
je b4
cmp al,0x42;askii of B
je b4
cmp al,0x54; askii of T
jne t4
call clrscr ; call the clrscr subroutine

mov ax, message
push ax ; push address of message
push word [length] ; push message length
call printwin ; call the printstr subroutine

mov ax, word[points]
push ax ; place number on stack
call print_num ; call the print_num subroutine


; Exit the program
  mov ax,0x4c00
  int 0x21 ; call the DOS interrupt
t4:
cmp al,0x44
je s4
ss4:
add di,2
b4:
mov al ,0x52
mov ah,10001010b
mov word [es:di], ax ; yes, print R at top left
;push Buffer_Array
mov word[horizontal_row],di
jmp match_not_found
s4:
mov dx,[points]
add dx,1
mov word[points],dx
jmp ss4

match_not_found: ; mov al, 0x20s
; out 0x20, al
pop es
pop ax
jmp far [cs:prev_isr] ; call the original ISR
; iret


  
start:
  ; Open the file for reading
  mov ah, 0x3D ; service 3Dh = open file
  mov al,0
  mov dx, Name_Of_File ; Name_Of_File to open
  int 0x21 ; call the DOS interrupt
  ;jc error ; check for error
  mov word[FileHandling], ax ; save the file handle

  ; Read the file contents into the Buffer_Array
  mov ah, 0x3f ; service 3Fh = read from file
  mov bx, [FileHandling] ; file handle to read from
  mov cx, 2000 ; number of bytes to read
  mov dx, Buffer_Array ; Buffer_Array to read into
  int 0x21 ; call the DOS interrupt
  jc File_Close ; check for error

 call clrscr
 call create_map
 call left_border
 call right_border
 call top_border
 call bottom_border
 mov ax, word[points]
push ax ; place number on stack
call print_num ; call the print_num subroutine

mov ax, message1
push ax ; push address of message
push word [length1] ; push message length
call printpoints ; call the printstr subroutine
 

xor ax, ax
mov es, ax ; point es to IVT base
mov ax, [es:9*4]
mov [prev_isr], ax ; save offset of old routine
mov ax, [es:9*4+2]
mov [prev_isr+2], ax ; save segment of old routine
cli ; disable interrupts
mov word [es:9*4], kbisr ; store offset at n*4
break:
mov [es:9*4+2], cs ; store segment at n*4+2
sti ; enable interrupts
l1: 
mov ah, 0 ; service 0 – get keystroke
int 0x16 ; call BIOS keyboard service
cmp al, 27 ; is the Esc key pressed
jne l1 ; if no, check for next key

mov ax, [prev_isr] ; read old offset in ax
mov bx, [prev_isr+2] ; read old segment in bx
cli ; disable interrupts
mov [es:9*4], ax ; restore old offset from ax
mov [es:9*4+2], bx ; restore old segment from bx
sti


push Buffer_Array
call create_map
mov ax, word[points]
push ax ; place number on stack
call print_num ; call the print_num subroutine
 
mov ax, message1
push ax ; push address of message
push word [length] ; push message length
call printpoints ; call the printstr subroutine

File_Close:
  ; Close the file and exit
  mov ah, 0x3e ; service 3Eh = close file
  mov bx, [FileHandling] ; file handle to close
  int 0x21 ; call the DOS interrupt


Finished:
  ; Exit the program
  mov ax,0x4c00
  int 0x21 ; call the DOS interrupt

error:
  ; Handle error and exit
  mov ah, 0x09 ; service 09h = print string
  mov dx, MsgError ; pointer to error message
  int 0x21 ; call the DOS interrupt
  jmp File_Close ; close the file and exit program


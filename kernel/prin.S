TI_GDT equ 0
RPL0 equ 0
VEDIO_SELECTOR equ (0x03<<3)+TI_GDT+RPL0 
;init gdts

section .data
int_buffer dq 0 ;8byte buffer


[bits 32]

section .text 

global put_str
put_str:

   push ebx
   push ecx;copy 
   xor ecx, ecx;clr ecx
   mov ebx, [esp + 12]; get the position of string 
.goon:
   mov cl, [ebx]
   cmp cl, 0; if the end of the string
   jz .str_over
   push ecx; param
   call put_char
   add esp, 4; pull back
   inc ebx; point to the next 
   jmp .goon
.str_over:
   pop ecx
   pop ebx
   ret
   
global put_char
put_char:
    pushad;寄存器全入栈;
    mov ax,VEDIO_SELECTOR
    mov gs,ax
    mov dx,0x03d4 ;address re
    mov al,0x0e;high 8bits 
    out dx,al ;move 0x0e into 0x3d4
    mov dx,0x03ed5 ;data re
    in al,dx ;get value in port 0x3d5 to al
    mov ah,al ;store high 8bits

    mov dx,0x03d4 ;address re
    mov al,0x0f ;low 8bits
    out dx,al ;move 0x0e into 0x3d4
    mov dx,0x03ed5 ;data re
    in al,dx ;get value in port 0x3d5 to al

    mov bx,ax ;store 
    mov ecx ,[esp+36];get back the re which pushad did(4*8)=32 and with
    cmp cl ,0x0d
    jz .is_carriage_return
    cmp cl ,0x0a 
    jz .is_line_feed
    cmp cl,0x08
    jz .is_backspace
    jmp .put_other 

.is_backspace:
    dec bx 
    shl bx,1;bx*2-1
    mov byte [gs:bx],0x20;space
    inc bx 
    mov byte [gs:bx],0x07 ;black background white word
    shr bx,1
    jmp .set_cursor 


.put_other:
    shl bx,1
    mov [gs:bx],cl;ascii itself
    inc bx 
    mov byte [gs:bx], 0x07
    shr bx,1
    inc bx
    cmp bx,2000 ;the end of screen
    jl .set_cursor

.is_line_feed:
.is_carriage_return:
    xor dx,dx
    mov ax,bx
    mov si,80

    div si 


.is_carriage_end:
    add bx,80
    cmp bx,2000
.is_line_feed_end:
    jl .set_cursor


.roll_screen:; 1-24 -> 0-23
    cld
    mov ecx,960;(2000-80)*2/4
    mov esi,0xc00b80a0 ;1 ,0
    mov edi,0xc00b8000 ;0 ,0
    rep movsd
    mov ebx,3840 ;1920*2
    mov ecx,80; times to move (80words)

.cls:
    mov word [gs:ebx], 0x0720 ;black background white words :space
    add ebx,2
    loop .cls;move 80times
    mov bx ,1920;mov cursor to -1, 0

.set_cursor:
    ;high 8 bits 
    mov dx,0x03d4
    mov al,0x0e
    out dx ,al
    mov dx,0x03d5
    mov al,bh
    out dx,al

    ;low 8bits
    mov dx,0x03d4
    mov al,0x0f
    out dx ,al
    mov dx,0x03d5
    mov al,bl
    out dx,al
.put_char_done:
    popad
    ret

global cls_screen
cls_screen:
    pushad
    mov ax,VEDIO_SELECTOR
    mov gs,ax 
    mov ebx ,0

    


global put_int 
put_int:
    pushad;copy registers 
    mov ebp,esp
    mov eax,[ebp+4*9]
    mov edx,eax
    mov edi ,7
    mov ecx ,8
    mov ebx,int_buffer

.16based_4bits:
    and edx,0x0f
    cmp edx,9
    jg .is_A2F
    add edx,'0'


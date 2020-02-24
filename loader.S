%include "boot.inc"
section loader vstart=LOADER_BASE_ADDR
STACK_TOP  equ LOADER_BASE_ADDR
jmp start_loader



;init gdt 
GDT_BASE:   dd    0x00000000 
        dd    0x00000000

CODE_DESC:  dd    0x0000FFFF 
        dd    DESC_CODE_HIGH4

DATA_STACK_DESC:  dd    0x0000FFFF
            dd    DESC_DATA_HIGH4

VIDEO_DESC: dd    0x80000007	       ; limit=(0xbffff-0xb8000)/4k=0x7
        dd    DESC_VIDEO_HIGH4  ; 此时dpl为0


GDT_SIZE   equ   $ - GDT_BASE
GDT_LIMIT   equ   GDT_SIZE -	1 
times 60 dq 0  

SELECTOR_CODE equ (0x0001<<3) + TI_GDT + RPL0         ; 相当于(CODE_DESC - GDT_BASE)/8 + TI_GDT + RPL0
SELECTOR_DATA equ (0x0002<<3) + TI_GDT + RPL0	 ; 同上
SELECTOR_VIDEO equ (0x0003<<3) + TI_GDT + RPL0	 ; 同上 


gdt_ptr dw GDT_LIMIT
    dd GDT_BASE;初始化gdt的指针 47-15 内存起始地址base 15-0 limit

loader_message db 'loader in realmode'

start_loader:
;print loader_message
    mov sp,LOADER_BASE_ADDR
    mov bp,loader_message ;加载printer
    mov cx,18; loadermessage长度18
    mov ax,0x1301; ah 13 al 01
    mov bx,0x001f ;;BH页号 BL 颜色：蓝底粉字 1fh
    mov dx,0x1800
    int 0x10;中断
;open a20
    in al,0x92
    or al,0x02;00000010
    out 0x90,al

;load gdt 
    lgdt [gdt_ptr]

;set cr0 1
    mov eax,cr0
    or eac,0x00000001;set 
    mov cr0,eax
    jmp dword SELECTOR_CODE:p_mode

[bits 32]
p_mode:
    mov ax,SELECTOR_DATA
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov esp,SELECTOR_VIDEO
    mov gs,ax
    mov byte [gs:160],'P'

    jmp $



      

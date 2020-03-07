%include "boot.inc"
SECTION MBR vstart=0x7c00
    	mov ax,cs
	mov ds,ax
	mov es,ax
	mov ss,ax
	mov fs,ax
	mov sp,0x7c00
	mov ax,0xb800
	mov gs,ax
;初始化

	mov ax,0x600
	mov bx,0x700
	mov cx,0
	mov dx,0x184f
;清屏
	int 0x10

	
	
;	int 0x10
;	mov byte [gs:0x00],'r'
;	mov byte [gs:0x01],0xa4
;	mov byte [gs:0x02],'u'
;	mov byte [gs:0x03],0xa4
;	mov byte [gs:0x04],'n'
;	mov byte [gs:0x05],0xa4

;	mov byte [gs:0x06],' '
;	mov byte [gs:0x07],0xa4
;	mov byte [gs:0x08],'M'
;	mov byte [gs:0x09],0xa4
;	mov byte [gs:0x0a],'B'
;	mov byte [gs:0x0b],0xa4
;	mov byte [gs:0x0c],'R'
;	mov byte [gs:0x0d],0xa4

	mov eax,LOADER_START_SECTOR;起始扇区lba地址
	mov bx,LOADER_BASE_ADDR;place to write
	mov cx,4;number ro write//2.24change from 1 into 4 
	
	call rd_disk


	
	jmp LOADER_BASE_ADDR

rd_disk:
	mov esi,eax;copy eax
	mov di,cx ;copy cx
	
	mov dx,0x1f2
	mov al,cl
	out dx,al
	mov eax,esi;move back

;lba存入3~6
	mov dx,0x1f3
	out dx,al
	
	mov cl,8
	shr eax,cl
	mov dx,0x1f4
	out dx,al

	shr eax,cl
	mov dx,0x1f5
	out dx,al
	
	shr eax,cl
	and al,0x0f
	or al,0xe0
	mov dx,0x1f6
	out dx,al
;7写读命令 0x20

	mov dx,0x1f7
	mov al,0x20
	out dx,al
	
;check state of hard disk
.if_ready:
	in al,dx
	and al,0x88;第三位是1：ready 第七位q是一：忙:
	cmp al,0x08
	jnz .if_ready
	mov ax,di
	mov dx,256
	mul dx;dx与di即256*di

	mov cx,ax
	mov dx,0x1f0

.read_next:
	in ax,dx
	mov [bx],ax
	add bx,2
	loop .read_next
	ret
	

	
	times 510-($-$$) db 0
	db 0x55,0xaa





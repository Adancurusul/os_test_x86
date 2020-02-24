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

	mov ax,0600h
	mov bx,0700h
	mov cx,0
	mov dx,184fh

	int 10h;
;输出字符MBR
	mov byte [gs:0x00],'1'
	mov byte [gs:0x01],0xA4
	
	mov byte [gs:0x02],' '
	mov byte [gs:0x03],0xA4
	
	mov byte [gs:0x04],'M'
	mov byte [gs:0x05],0xA4

	mov byte [gs:0x06],'B'
	mov byte [gs:0x07],0xA4
	
	mov byte [gs:0x08],'R'
	mov byte [gs:0x09],0xA4

	mov eax,LOADER_START_SECTOR ;起始扇区的lba地址存入eax中
	mov bx,LOADER_BASE_ADDR ;写入内存的地址 存入bx中
	mov cx,1  ;待写入扇区数
	call rd_disk_m_16 ;跳转到读取程序

	jmp LOADER_BASE_ADDR

;读取硬盘内容的子程序
rd_disk_m_16:
	;设置读取的扇区数
	mov esi,eax
	mov di,cx	;备份
	
	mov dx,0x1f2
	mov al,cl
	out dx,al

	mov eax,esi
	;LBA地址存入0x1f3 - 0x1f6
	mov dx,0x1f3
	out dx,al
;LBA地址15～8位写入端口0x1f3
	mov cl,8
	shr eax,cl
	mov dx,0x1f4
	out dx,al
;LBA地址23～16位写入端口0x1f3
	shr eax,cl
	mov dx,0x1f5
	out dx,al
	
	shr eax,cl
	and al,0x0f
	or al,0xe0
	mov dx,0x1f6
	out dx,al

;在0x1f7端口写入命令
	mov dx,0x1f7
	mov al,0x20
	out dx,al

;检测硬盘的状态
.not_ready:

	nop
	in al,dx
	and al,0x08
	
	cmp al,0x08
	jnz .not_ready
;从0x1f0端口读数据
	mov ax,di
	mov dx,256
	mul dx
	mov cx,ax

	mov dx,0x1f0
.go_on_read:
	in ax,dx
	mov [bx],ax
	add bx,2
	loop .go_on_read
	ret


	times 510-($-$$) db 0
	db 0x55,0xaa

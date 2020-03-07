
BOOT_BIN_FILES=build/boot/mbr.bin \
	 build/boot/loader.bin

KERNEL_BIN_FILES=build/kernel.bin
IMG=my60.img
OBJS= \
build/main.o \
build/interrupt.o \
build/print.o \
build/kernel.o \
#build/interrupt.o \
#build/kernel.o \

BIN_FILES=$(BOOT_BIN_FILES) $(KERNEL_BIN_FILES)


build/kernel.o: kernel/src/kernel.S
	nasm -f elf -o build/kernel.o kernel/src/kernel.S

build/print.o: kernel/inc/print.S
	nasm -f elf -o build/print.o kernel/inc/print.S

build/interrupt.o: kernel/src/interrupt.c
	gcc -m32 -I kernel/inc -I kernel/src -c -fno-builtin -fno-stack-protector -o  build/interrupt.o kernel/src/interrupt.c
	#gcc -m32 -I ../inc -c -fno-builtin -o interrupt.o interrupt.c

build/main.o: kernel/main.c
	gcc -m32 -I kernel/inc  -c -fno-builtin -o build/main.o kernel/main.c

build/kernel.bin: $(OBJS)
	ld -m elf_i386 -Ttext 0xc0001500 -e main -o build/kernel.bin $(OBJS)

build/boot/mbr.bin: my_boot/mbr.S
	nasm -I my_boot/include/ -o build/boot/mbr.bin my_boot/mbr.S

build/boot/loader.bin: my_boot/loader.S
	nasm -I my_boot/include/ -o build/boot/loader.bin my_boot/loader.S

my60.img: build/kernel.bin 
	dd if=build/kernel.bin of=my60.img bs=512 count=200 seek=9 conv=notrunc


all:  $(BIN_FILES) $(IMG)


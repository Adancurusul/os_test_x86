
BOOT_BIN_FILES=build/boot/mbr.bin \
build/boot/loader.bin
KERNEL_BIN_FILES=build/kernel.bin
IMG=my60.img
OBJS= \
build/main.o \
build/interrupt.o \
build/print.o \
build/kernel.o \
build/switch.o \
build/timer.o \
build/debug.o \
build/memory.o \
build/bitmap.o \
build/string.o \
build/thread.o \
build/list.o \



BIN_FILES=$(BOOT_BIN_FILES) $(KERNEL_BIN_FILES)


build/kernel.o: kernel/src/kernel.S
	nasm -f elf -o build/kernel.o kernel/src/kernel.S

build/switch.o: kernel/src/switch.S
	nasm -f elf -o  build/switch.o kernel/src/switch.S

build/print.o: kernel/inc/print.S
	nasm -f elf -o build/print.o kernel/inc/print.S

build/boot/mbr.bin: my_boot/mbr.S
	nasm -I my_boot/include/ -o build/boot/mbr.bin my_boot/mbr.S

build/boot/loader.bin: my_boot/loader.S
	nasm -I my_boot/include/ -o build/boot/loader.bin my_boot/loader.S

build/memory.o: kernel/src/memory.c
	gcc -m32 -I kernel/inc -I kernel/src -c -fno-builtin -fno-stack-protector -o  build/memory.o kernel/src/memory.c

build/init.o: kernel/src/init.c
	gcc -m32 -I kernel/inc -I kernel/src -c -fno-builtin -fno-stack-protector -o  build/init.o kernel/src/init.c
		
build/list.o: kernel/src/list.c
	gcc -m32 -I kernel/inc -I kernel/src -c -fno-builtin -fno-stack-protector -o  build/list.o kernel/src/list.c

build/bitmap.o: kernel/src/bitmap.c
	gcc -m32 -I kernel/inc -I kernel/src -c -fno-builtin -fno-stack-protector -o  build/bitmap.o kernel/src/bitmap.c

build/interrupt.o: kernel/src/interrupt.c
	gcc -m32 -I kernel/inc -I kernel/src -c -fno-builtin -fno-stack-protector -o  build/interrupt.o kernel/src/interrupt.c


build/timer.o: kernel/src/timer.c
	gcc -m32 -I kernel/inc -I kernel/src -c -fno-builtin -fno-stack-protector -o build/timer.o kernel/src/timer.c

build/thread.o: kernel/src/thread.c
	gcc -m32 -I kernel/inc -I kernel/src -c -fno-builtin -fno-stack-protector -o build/thread.o kernel/src/thread.c

build/debug.o: kernel/src/debug.c
	gcc -m32 -I kernel/inc -I kernel/src -c -fno-builtin -fno-stack-protector -o build/debug.o kernel/src/debug.c

build/string.o: kernel/src/string.c
	gcc -m32 -I kernel/inc -I kernel/src -c -fno-builtin -fno-stack-protector -o build/string.o kernel/src/string.c

build/main.o: kernel/main.c
	gcc -m32 -I kernel/inc  -c -fno-builtin -o build/main.o kernel/main.c

build/kernel.bin: $(OBJS)
	ld -m elf_i386 -Ttext 0xc0001500 -e main -o build/kernel.bin $(OBJS)

my60.img: build/kernel.bin 
	dd if=build/kernel.bin of=my60.img bs=512 count=250 seek=9 conv=notrunc



all:  $(BIN_FILES) $(IMG)


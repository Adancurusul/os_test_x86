BOOT_BIN_FILES=build/boot/mbr.bin \
build/boot/loader.bin
#BOOT_BIN_FILES=$(wildcard  ./build/boot/*.bin)
KERNEL_BIN_FILES=build/kernel.bin
IMG=my60.img
INC=kernel/inc
INC_FILE=
SRC=kernel/src
BUILD_PATH=build/
SRC_ASM=$(wildcard ./kernel/src/*.S ./kernel/inc/.S)


INC_DIR = \
	-I ./include \
	-I ./src \


CC=gcc

$(build)%.o:kernel/src/%.c
	$(CC) -m32  $(INC_DIR) -c -fno-builtin -fno-stack-protector -o $@



all:
	@echo $(SRC_C)


#include "print.h"
#include "interrupt.h"
void init_all();
void main(void)
{
put_str("get into kernel \n");


init_all();
put_str("finish init ");
while(1);
}

void init_all(){

put_str("init modules ");
idt_init();//初始化idt（interrupt.c




}





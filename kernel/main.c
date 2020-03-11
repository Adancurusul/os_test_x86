
#include "debug.h"
#include "print.h"
#include "interrupt.h"
#include "timer.h"

void init_all();
void main(void) {
    put_str("I am kernel.\n");
    init_all();
    put_str("Init finished.\n");
    //asm volatile ("sti");
    put_str("Turn on the interrupt.\n");
    ASSERT(1==2);
    while (1);
}

void init_all() {
    put_str("init_all.\n");
    idt_init();
    timer_init();
}

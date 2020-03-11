#include "timer.h"
#include "io.h"
#include "print.h"
#include "stdint.h"

/*
void set_frequency(uint8_t port,uint8_t counter_number,uint8_t read_write_latch,uint8_t mode_to_count ,uint16_t counter_value){
    //write control word into 0x43
    outb(PIT_PORT,(uint8_t)(counter_number<<6|read_write_latch<<4|mode_to_count<<1));
    outb(port,(uint8_t)counter_value);//low 8bits
    outb(port,(uint8_t)counter_value>>8);//high
}
*/

void timer_init(){
    put_str("start to init timer\n");
        //write control word into 0x43
    outb(PIT_PORT,(uint8_t)(COUNTER_NUMBER<<6|READ_WRITE_LATCH<<4|MODE_TO_COUNT<<1));
    outb(PORT,(uint8_t)COUNTER_VALUE);//low 8bits
    outb(PORT,(uint8_t)COUNTER_VALUE>>8);//high
    put_str("timer init successully\n");

}
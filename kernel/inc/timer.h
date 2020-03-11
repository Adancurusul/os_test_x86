#define FREQUENCY 100
#define INITIAL_FREQUENCY 1193180
#define COUNTER_VALUE INITIAL_FREQUENCY/FREQUENCY
#define PORT 0x40
#define PIT_PORT 0x43
#define COUNTER_NUMBER 0//操作的计数器
#define MODE_TO_COUNT 2 //计数器模式
#define READ_WRITE_LATCH 3 //读写属性
void timer_init();
#include "print.h"
#include "timer.h"
#include "interrupt.h"
#include "debug.h"
#include "memory.h"
#include "thread.h"

void k_thread_function_a(void *);
void k_thread_function_b(void *);

int main(void)
{
    put_str("kernel\n\ntest\n.\n");

    init_all();

    thread_start("k_thread_a", 31, k_thread_function_a, "AAA ");
    thread_start("k_thread_b", 8, k_thread_function_b, "BBB ");
    put_str("okddddddddddddddddddddk");
    intr_enable();

    while (1)
    {
        put_str("main ");
    }

    return 0;
}

void init_all()
{
    put_str("init_all.\n");
    idt_init();
    mem_init();
    thread_init();
    timer_init();
}

void k_thread_function_a(void *args)
{
    // 这里必须是死循环，否则执行流并不会返回到main函数，所以CPU将会放飞自我，出发6号未知操作码异常
    while (1)
    {
        put_str((char *)args);
    }
}

void k_thread_function_b(void *args)
{
    while (1)
    {
        put_str((char *)args);
    }
}
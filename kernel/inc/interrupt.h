#include "stdint.h"
void idt_init();
enum intr_status{INTR_OFF,INTR_ON};
typedef void* intr_handler;
enum intr_status get_intr_status(void);
enum intr_status enable_intr(void);
enum intr_status disable_intr(void);
enum intr_status intr_set_status(enum intr_status);


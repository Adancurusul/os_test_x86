# include "global.h"
# include "debug.h"

uint32_t strlen(const char *str);
char *strcpy(char *dest, const char *src);
int8_t strcmp(const char* src1, const char* src2);
char * strstr(char* s1, const char* s2);
char* strchr(const char* str, uint8_t ch);
char *strcat(char *dest, const char *src);
char* strncpy(char* dest, const char* src, uint32_t len);
char* strncat(char* dest, const char* src, uint32_t len);
int8_t strncmp(const char* s1, const char* s2, uint32_t len);
void memset(void* buffer, uint8_t c, uint32_t count);
void * memcpy(void *dest,void *src,uint32_t count );
char* memmove(char* dest, const char* src, uint32_t len);
int memcmp(const char* dest, const char* src, uint32_t len);


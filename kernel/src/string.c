#include "string.h"
#include "global.h"
#include "stdint.h"
#include "print.h"

//长度
uint32_t strlen(const char *str)
{
    if (*str == '\0')
        return 0;
    else
        return strlen(str + 1) + 1;
}

//复制
char *strcpy(char *dest, const char *src)
{
      char *res = dest;
      ASSERT(dest);
      ASSERT(src);
      while (*dest++ = *src++) ;
      return res;
}


//比较大小
int8_t strcmp(const char* src1, const char* src2)
{
    while (*src1 == *src2)
    {
        if (*src1 == '\0')
            return 0; 
        src1 ++; 
        src2 ++; 
    } 
    return *src1 - *src2; 
} 

//查找子串
char* strstr(char* s1, const char* s2)
{
    char* p = s1;
    const char* q = s2;
    char* cur = NULL;

    ASSERT(s1);
    ASSERT(s2);
    if (*s2 == '\0')
        return s1;
    while (*p != '\0')
    {
        cur = p;
        while ((*p != '\0') && (*q != '\0') && (*p == *q))
        {
            p++;
            q++;
        }
        if (*q == '\0')
            return cur;
        p = cur + 1;
        q = s2;
    }
    return NULL;
}
//查找第一个字符的位置并返回指针

char* strchr(const char* str, uint8_t ch)
{
    const char* tmp = str;
    while (*tmp)
    {
        if (*tmp == ch)
            return tmp;
        tmp++;
    }
    return NULL;
}

//剪切到后面
char *strcat(char *dest, const char *src)
{
      char *res = dest;
      ASSERT(dest);
      ASSERT(src);
      while (*dest != '\0')
            dest++;
      while (*dest++ = *src);
      return res;
}

//复制len个数到指定位置
char* strncpy(char* dest, const char* src, uint32_t len)
{
    char* res = dest;
    ASSERT(dest);
    ASSERT(src);

    while (len--)
    {
        *res++ = *src++;
    }
    if (*(res) != '\0')
        *res = '\0';
    return dest;
}

char* strncat(char* dest, const char* src, uint32_t len)
{
    char* res = dest;
    ASSERT(dest);
    ASSERT(src);
    while (*dest != '\0')
        dest++;
    while (len--)
    {
        *dest = *src;
        dest++;
        src++;
    }
    return res;
}

int8_t strncmp(const char* s1, const char* s2, uint32_t len)
{
    ASSERT(s1);
    ASSERT(s2);
    while (len--)
    {
        if (*s1 == *s2)
        {
            s1++;
            s2++;
        }
        else
            return *s1 - *s2;
    }
    return 0;
}


//memset():把指定内存区域的前count个字节设置成字符c

void  memset(void* buffer, uint8_t c, uint32_t count)
{
    ASSERT(buffer != NULL);
    char * p = (uint8_t *)buffer;
    
    while(count-- >0)
        *p++ = c;
    //return buffer;
}
/*
void memset(void* buffer, uint8_t c, uint32_t count) {
    ASSERT(buffer != NULL);

    uint8_t* addr = (uint8_t*) buffer;
    while (count-- > 0) {
        *addr++ = c;
    }
}
*/

void * memcpy(void *dest,void *src,uint32_t count )
{
	if (dest == NULL || src == NULL)
	{
		return NULL;
	}
	char* pdest =(char*) dest;
	char* psrc = (char*)src;
	while (count--)
	{
		*pdest++ = *psrc++;
	}
	return dest;
}


char* memmove(char* dest, const char* src, uint32_t len)
{
	char* ret = dest;
	int offset = 0;
	ASSERT(dest != NULL);
	ASSERT(src != NULL);
	if(len > strlen(src))  //当len大于strlen(src)时
	{
		offset = len - strlen(src);
		len = strlen(src);
	}
 
	//判断内存是否重合，是则从后往前复制
	if(dest >= src && dest <= src + len - 1)
	{
		char* tem = NULL;
		dest = dest + len - 1;
		src = src + len - 1;
		tem = dest;
		while(len--)
		{
			*dest-- = *src--;
		}
		*tem = '\0';
	}
	else
	{
		while(len--)
		{
			*dest++ = *src++;
		}
		*dest = '\0';
	}
 
	if(offset > 0)
	{
		while(offset--)  //len大于strlen(src)的长度全部赋值为 '\0'
		{
			*dest++ = '\0';
		}
	}
	return ret;
}



int memcmp(const char* dest, const char* src, uint32_t len)
{
	ASSERT(dest != NULL);
	ASSERT(src != NULL);
	while(len--)
	{
		while(*dest++ == *src++)
		{
			if(*dest == '\0')
			{
				return 0;
			}
		}
	}
	if(*dest > *src)
	{
		return 1;
	}
	if(*dest < *src)
	{
		return -1;
	}
}


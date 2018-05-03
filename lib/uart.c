#include <string.h>
#include "stm8s_conf.h"

static char _buf[10];

int uart_write(const char *str)
{
	return strlen(str);
}

void test(void)
{
	memcpy(_buf, "Hello.", 6);
    uart_write(_buf);
}

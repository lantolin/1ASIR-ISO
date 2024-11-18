#include <stdio.h>
#include <stdlib.h>

int main()
{
    char* s;
    s = getenv("USER");
    printf("USER: %s\n", (s != NULL) ? s : "NULL");
    s = getenv("UNA_VARIABLE");
    printf("UNA_VARIABLE: %s\n", (s != NULL) ? s : "NULL");
    s = getenv("OTRA_VARIABLE");
    printf("OTRA_VARIABLE: %s\n", (s != NULL) ? s : "NULL");
}
#include <stdio.h>
#include <stdlib.h>

int main(void) {
    volatile char *p = malloc(100);

    for (int i = 0; ; i++) {
        printf("%d |", i);
        fflush(stdout);
        p[i] = 42;
    }
}

#include <linux/kernel.h>
#include <linux/module.h>

MODULE_LICENSE("GPL");

static int8_t* message = "DON'T PANIC? ... no, panic!";

int init_module(void){
    panic(message);
    return 0;
    }
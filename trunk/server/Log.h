#include <stdio.h>

#define debug(format, ...) \
    printf("[DEBUG] "); \
    println(format, ##__VA_ARGS__)

#define error(format, ...) \
    printf("[ERROR][%s:%d] ", __FILE__, __LINE__);     \
    println(format, ##__VA_ARGS__);                     \
    print_bt()

#define println(format, ...) \
    printf(format, ##__VA_ARGS__); \
    printf("\n")


void print_bt();


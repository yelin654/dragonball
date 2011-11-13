#include <stdio.h>

#define debug(format, ...) \
    printf("[DEBUG] "); \
    println(format, ##__VA_ARGS__);

#define error(format, ...) \
    printf("[ERROR] "); \
    println(format, ##__VA_ARGS__);

#define println(format, ...) \
    printf(format, ##__VA_ARGS__); \
    printf("\n");



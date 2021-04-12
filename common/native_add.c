#include <stdint.h>
#include <stdio.h>

__attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t a, int32_t b) {
    printf("native_add called\n");
    return a + b;
}
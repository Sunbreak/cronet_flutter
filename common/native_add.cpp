#include <stdio.h>

#include "native_add.h"

int32_t native_add(int32_t a, int32_t b) {
    printf("native_add called\n");
    return a + b;
}
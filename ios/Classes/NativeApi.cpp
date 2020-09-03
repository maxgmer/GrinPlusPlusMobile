#include <stdint.h>

int32_t counter = 0;

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
    return ++counter;
}
#ifndef FLUTTER_PLUGIN_NATIVE_ADD_H_
#define FLUTTER_PLUGIN_NATIVE_ADD_H_

#include <stdint.h>

#if defined(__cplusplus)
extern "C" {
#endif

__declspec(dllexport) int32_t native_add(int32_t a, int32_t b);

#if defined(__cplusplus)
}  // extern "C"
#endif

#endif // FLUTTER_PLUGIN_NATIVE_ADD_H_
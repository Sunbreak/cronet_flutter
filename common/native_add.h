#ifndef FLUTTER_PLUGIN_NATIVE_ADD_H_
#define FLUTTER_PLUGIN_NATIVE_ADD_H_

#include <stdint.h>

#if defined(__APPLE__)
#include "dart_api.h"
#else
#include "dart_api/dart_api.h"
#endif

DART_EXPORT int32_t native_add(int32_t a, int32_t b);

#endif // FLUTTER_PLUGIN_NATIVE_ADD_H_

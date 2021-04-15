#include "dart_api/dart_api.h"
#include "dart_api/dart_native_api.h"

#include "native_interop.hpp"

// Initialize `dart_api_dl.h`
DART_EXPORT intptr_t InitDartApiDL(void* data) {
  return Dart_InitializeApiDL(data);
}

Dart_Port send_port_;

DART_EXPORT void RegisterSendPort(Dart_Port send_port) {
  send_port_ = send_port;
}

bool PostCObject(Dart_CObject* cobject) {
  return Dart_PostCObject_DL(send_port_, cobject);
}
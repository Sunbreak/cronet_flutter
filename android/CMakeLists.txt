cmake_minimum_required(VERSION 3.4.1)  # for example

set(PLUGIN_NAME "cronet_flutter")

add_library(lib_cronet SHARED IMPORTED)
set_target_properties(lib_cronet PROPERTIES
  IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/src/main/cmakeLibs/${ANDROID_ABI}/libcronet.86.0.4240.198.so
)

add_library(${PLUGIN_NAME} SHARED
  "../common/dart_api/dart_api_dl.c"
  "../common/native_interop.cpp"
  "../common/sample_url_request_callback.cc"
  "../common/sample_executor.cc"
)

target_include_directories(${PLUGIN_NAME} INTERFACE
  "../common"
  "../common/dart_api"
  "../common/dart_api/internal"
  "../common/cronet"
)

target_link_libraries(${PLUGIN_NAME} lib_cronet)
cmake_minimum_required(VERSION 3.4.1)  # for example

set(PLUGIN_NAME "cronet_flutter")

add_library(${PLUGIN_NAME} SHARED
  "../common/dart_api/dart_api_dl.c"
  "../common/native_add.cpp"
)

target_include_directories(${PLUGIN_NAME} INTERFACE
  "../common"
  "../common/dart_api"
  "../common/dart_api/internal"
)
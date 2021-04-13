cmake_minimum_required(VERSION 3.15)
set(PROJECT_NAME "cronet_flutter")
project(${PROJECT_NAME} LANGUAGES C CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "cronet_flutter_plugin")

add_compile_definitions(WIN32)
add_compile_definitions(DART_SHARED_LIB)

add_library(${PLUGIN_NAME} SHARED
  "cronet_flutter_plugin.cpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/dart_api/dart_api_dl.c"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/native_add.cpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/sample_url_request_callback.cc"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/sample_executor.cc"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/dart_api"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/dart_api/internal"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/cronet")
find_library(CRONET_LIB cronet.86.0.4240.198.dll ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin ${CRONET_LIB})

# List of absolute paths to libraries that should be bundled with the plugin
set(cronet_flutter_bundled_libraries
 "${CMAKE_CURRENT_SOURCE_DIR}/cronet.86.0.4240.198.dll"
  PARENT_SCOPE
)

set(MSVC_DISABLED_WARNINGS_LIST
  "C4152" # nonstandard extension, function/data pointer conversion in expression
)
string(REPLACE "C" " -wd" MSVC_DISABLED_WARNINGS_STR ${MSVC_DISABLED_WARNINGS_LIST})
set(CMAKE_C_FLAGS   "-utf-8 -Wall -WX ${MSVC_DISABLED_WARNINGS_STR}")
set(CMAKE_CXX_FLAGS "-utf-8 -Wall -WX ${MSVC_DISABLED_WARNINGS_STR}")
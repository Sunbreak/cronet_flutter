cmake_minimum_required(VERSION 3.10)
set(PROJECT_NAME "cronet_flutter")
project(${PROJECT_NAME} LANGUAGES C CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "cronet_flutter_plugin")

add_library(${PLUGIN_NAME} SHARED
  "cronet_flutter_plugin.cc"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/dart_api/dart_api_dl.c"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/native_interop.cpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/sample_url_request_callback.cc"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/sample_executor.cc"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/sample_upload_data_provider.cc"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL DART_SHARED_LIB)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/dart_api"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/dart_api/internal"
  "${CMAKE_CURRENT_SOURCE_DIR}/../common/cronet")
find_library(CRONET_LIB libcronet.86.0.4240.198.so ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter)
target_link_libraries(${PLUGIN_NAME} PRIVATE PkgConfig::GTK)
target_link_libraries(${PLUGIN_NAME} PRIVATE ${CRONET_LIB})

# List of absolute paths to libraries that should be bundled with the plugin
set(cronet_flutter_bundled_libraries
  "${CMAKE_CURRENT_SOURCE_DIR}/libcronet.86.0.4240.198.so"
  PARENT_SCOPE
)

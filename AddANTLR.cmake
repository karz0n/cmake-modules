if(DEFINED ENV{ANTLR_ROOT})
  list(APPEND CMAKE_PREFIX_PATH $ENV{ANTLR_ROOT})
endif()

find_package(
  antlr4-runtime
  REQUIRED
  CONFIG
  NAMES
  antlr4
  CONFIGS
  antlr4-runtime-config.cmake)

find_package(
  antlr4-generator
  REQUIRED
  CONFIG
  NAMES
  antlr4
  CONFIGS
  antlr4-generator-config.cmake)

set(ANTLR4_JAR_LOCATION /usr/local/lib/antlr-4.8-complete.jar)

add_library(ANTLR4 INTERFACE)

target_include_directories(ANTLR4 INTERFACE ${ANTLR4_INCLUDE_DIR})

target_link_libraries(ANTLR4 INTERFACE antlr4_shared)

# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[
AddGPerfTools.cmake
-------

Creates targets to link with google performance tools.

Result Targets
^^^^^^^^^^^^^^^^

* GPerfTools::Profiler - profiler target
* GPerfTools::TCMalloc - tcmalloc target
* GPerfTools::TCMallocMinimal - tcmalloc with minimal weight
* GPerfTools::TCMallocAndProfiler - profiler and tcmalloc specific target

#]=======================================================================]

include(FindPkgConfig)

if(DEFINED ENV{GPerfTools_ROOT})
    list(APPEND CMAKE_PREFIX_PATH $ENV{GPerfTools_ROOT})
endif()

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(GPT_TCMALLOC_MODULE_NAME "libtcmalloc_debug")
    set(GPT_TCMALLOC_MINIMAL_MODULE_NAME "libtcmalloc_minimal_debug")
else()
    set(GPT_TCMALLOC_MODULE_NAME "libtcmalloc")
    set(GPT_TCMALLOC_MINIMAL_MODULE_NAME "libtcmalloc_minimal")
endif()

#
# Setup profiler target
#
pkg_check_modules(GPerfToolsProfiler REQUIRED IMPORTED_TARGET "libprofiler")
add_library(GPerfTools::Profiler ALIAS PkgConfig::GPerfToolsProfiler)

#
# Setup tcmalloc target
#
pkg_check_modules(
    GPerfToolsTCMalloc REQUIRED IMPORTED_TARGET ${GPT_TCMALLOC_MODULE_NAME}
)
add_library(GPerfTools::TCMalloc ALIAS PkgConfig::GPerfToolsTCMalloc)

#
# Setup tcmalloc minimal target
#
pkg_check_modules(
    GPerfToolsTCMallocMinimal REQUIRED IMPORTED_TARGET
    ${GPT_TCMALLOC_MINIMAL_MODULE_NAME}
)
add_library(
    GPerfTools::TCMallocMinimal ALIAS PkgConfig::GPerfToolsTCMallocMinimal
)

#
# Setup profiler and tcmalloc target (requires specific dynamic library)
#
find_library(
    GPT_TCMALLOC_AND_PROFILER_LIB NAMES "tcmalloc_and_profiler"
    PATHS ${GPerfToolsProfiler_LIBRARY_DIRS} ${GPerfToolsTCMalloc_LIBRARY_DIRS}
)

add_library(GPerfToolsTCMallocAndProfiler SHARED IMPORTED)
add_library(GPerfTools::TCMallocAndProfiler ALIAS GPerfToolsTCMallocAndProfiler)

if(GPerfToolsProfiler_INCLUDE_DIRS STREQUAL GPerfToolsTCMalloc_INCLUDE_DIRS)
    list(APPEND GPT_TCMALLOC_AND_PROFILER_INCLUDE_DIRS
         ${GPerfToolsProfiler_INCLUDE_DIRS}
    )
else()
    list(APPEND GPT_TCMALLOC_AND_PROFILER_INCLUDE_DIRS
         ${GPerfToolsProfiler_INCLUDE_DIRS}
    )
    list(APPEND GPT_TCMALLOC_AND_PROFILER_INCLUDE_DIRS
         ${GPerfToolsTCMalloc_INCLUDE_DIRS}
    )
endif()

set_target_properties(
    GPerfToolsTCMallocAndProfiler PROPERTIES IMPORTED_LOCATION
                                             ${GPT_TCMALLOC_AND_PROFILER_LIB}
)

target_include_directories(
    GPerfToolsTCMallocAndProfiler
    INTERFACE ${GPT_TCMALLOC_AND_PROFILER_INCLUDE_DIRS}
)

#
# Bring profile guide optimization (PGO) to the project.
#
#  Two mode are available
#     - training mode
#     - profiling mode
#
#  Training mode configure compiler to produce executable program with
#  special probes next to each basic block of the program. Each probe
#  counts the number of times a basic block runs or certain direction
#  is taken if we deal with a branch. This information is saved into
#  files and available to be consumed when profiling mode become active.
#
#  Profiling mode consume information produced when training mode was
#  active and produce executable program applying certain optimizations,
#  namely: function inlining, block ordering, register allocation.
#
#  Workflow
#  1. Turn on ENABLE_PGO_TRAINING
#  2. Compile program and run program using real dataset (reproduce most common behaviour)
#  3. Turn on ENABLE_PGO_PROFILING (ENABLE_PGO_TRAINING must be OFF)
#  4. Compile program to use profiling outcome
#

include_guard(GLOBAL)

if (NOT DEFINED ENABLE_PGO_TRAINING)
    option(ENABLE_PGO_TRAINING "Enable PGO in training mode" OFF)
endif()
if (NOT DEFINED ENABLE_PGO_PROFILING)
    option(ENABLE_PGO_PROFILING "Enable PGO in profiling mode" OFF)
endif()
if (NOT DEFINED PGO_OUTPUT_DIR)
    set(PGO_OUTPUT_DIR "profile-data" CACHE STRING "Output directory for PGO training artifacts")
endif()

if (ENABLE_PGO_TRAINING)
    message(STATUS "PGO training mode is active")
    if (ENABLE_PGO_PROFILING)
        message(FATAL_ERROR "PGO profiling mode is active")
    endif()
    if (CMAKE_COMPILER_IS_GNUCXX)
        set(PGO_COMPILE_FLAGS "-fprofile-generate=${CMAKE_BINARY_DIR}/${PGO_OUTPUT_DIR}")
    endif()
    if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        set(PGO_COMPILE_FLAGS "-fprofile-instr-generate -g -O0 -fprofile-arcs -ftest-coverage")
    endif()
    message(VERBOSE "PGO compile flags: ${PGO_COMPILE_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${PGO_COMPILE_FLAGS}")
endif()

if (ENABLE_PGO_PROFILING)
    message(STATUS "PGO profiling mode is active")
    if (ENABLE_PGO_TRAINING)
        message(FATAL_ERROR "PGO training mode is active")
    endif()
    if (CMAKE_COMPILER_IS_GNUCXX)
        set(PGO_COMPILE_FLAGS "-fprofile-use=${CMAKE_BINARY_DIR}/${PGO_OUTPUT_DIR} -fprofile-correction")
    endif()
    if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        set(PGO_COMPILE_FLAGS "-fprofile-instr-use -g -O0 -fprofile-arcs -ftest-coverage")
    endif()
    message(VERBOSE "PGO compile flags: ${PGO_COMPILE_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${PGO_COMPILE_FLAGS}")
endif()

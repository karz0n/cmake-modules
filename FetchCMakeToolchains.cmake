include(FetchContent)

if (NOT DEFINED FETCH_CMAKETOOLCHAINS_TAG)
    set(FETCH_CMAKETOOLCHAINS_TAG "fff0b5b9e989ca8d082e2508bf43078cf001b09a")
endif()

FetchContent_Declare(FetchCMakeModules
    GIT_REPOSITORY git@github.com:karz0n/cmake-toolchains.git
    GIT_TAG ${FETCH_CMAKETOOLCHAINS_TAG}
    SOURCE_DIR ${CMAKE_BINARY_DIR}/toolchains
)

FetchContent_MakeAvailable(FetchCMakeModules)

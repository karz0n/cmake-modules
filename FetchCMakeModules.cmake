include(FetchContent)

if (NOT DEFINED FETCH_CMAKEMODULES_TAG)
    set(FETCH_CMAKEMODULES_TAG "8b5a11f1ab34b9e564e3b865aec8b928263caad0")
endif()

FetchContent_Declare(FetchCMakeModules
    GIT_REPOSITORY git@github.com:karz0n/cmake-modules.git
    GIT_TAG ${FETCH_CMAKEMODULES_TAG}
)

FetchContent_GetProperties(FetchCMakeModules)
if (NOT fetchcmakemodules_POPULATED)
    FetchContent_Populate(FetchCMakeModules)
    list(APPEND CMAKE_MODULE_PATH ${fetchcmakemodules_SOURCE_DIR})
endif()
include(FetchContent)

if (NOT DEFINED FETCH_GOOGLETEST_TAG)
    # Version: release-1.11.0
    set(FETCH_GOOGLETEST_TAG "e2239ee6043f73722e7aa812a459f54a28552929")
endif()

FetchContent_Declare(FetchGoogleTest
    GIT_REPOSITORY git@github.com:google/googletest.git
    GIT_TAG ${FETCH_GOOGLETEST_TAG}
)

FetchContent_MakeAvailable(FetchGoogleTest)

include(GoogleTest)
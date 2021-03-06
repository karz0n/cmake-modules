# Determines whether the compiler supports C++11
function(check_for_cxx11 _VAR)
    set(${_VAR} 0 PARENT_SCOPE)

    message(STATUS "Checking for C++11 compiler")
    try_compile(
        _COMPILER_TEST_RESULT ${PROJECT_BINARY_DIR}
        ${CMAKE_CURRENT_LIST_DIR}/common/CxxTestCompiler.cpp CXX_STANDARD 11
        CXX_STANDARD_REQUIRED ON
    )

    if(NOT _COMPILER_TEST_RESULT AND CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        try_compile(
            _COMPILER_TEST_RESULT ${PROJECT_BINARY_DIR}
            ${CMAKE_CURRENT_LIST_DIR}/common/CxxTestCompiler.cpp
            CMAKE_FLAGS -DCMAKE_CXX_FLAGS="-stdlib=libc++" CXX_STANDARD 11
                        CXX_STANDARD_REQUIRED ON
        )
        if(_COMPILER_TEST_RESULT)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++"
                PARENT_SCOPE
            )
        else()
            message(STATUS "To enable C++11 install libc++ standard library")
        endif()
    endif()

    if(_COMPILER_TEST_RESULT)
        if((CMAKE_COMPILER_IS_GNUCXX AND NOT ${CMAKE_CXX_COMPILER_VERSION}
                                         VERSION_LESS 4.8.1)
           OR (CMAKE_CXX_COMPILER_ID STREQUAL "Clang"
               AND NOT ${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 3.3)
        )
            set(${_VAR} 1 PARENT_SCOPE)
            message(STATUS "Checking for C++11 compiler - available")
        endif()
    else()
        message(STATUS "Checking for C++11 compiler - unavailable")
    endif()
endfunction()

# Determines whether the compiler supports C++14
function(check_for_cxx14 _VAR)
    set(${_VAR} 0 PARENT_SCOPE)

    message(STATUS "Checking for C++14 compiler")
    try_compile(
        _COMPILER_TEST_RESULT ${PROJECT_BINARY_DIR}
        ${CMAKE_CURRENT_LIST_DIR}/common/CxxTestCompiler.cpp CXX_STANDARD 14
        CXX_STANDARD_REQUIRED ON
    )

    if(NOT _COMPILER_TEST_RESULT AND CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        try_compile(
            _COMPILER_TEST_RESULT ${PROJECT_BINARY_DIR}
            ${CMAKE_CURRENT_LIST_DIR}/common/CxxTestCompiler.cpp
            CMAKE_FLAGS -DCMAKE_CXX_FLAGS="-stdlib=libc++" CXX_STANDARD 14
                        CXX_STANDARD_REQUIRED ON
        )
        if(_COMPILER_TEST_RESULT)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++"
                PARENT_SCOPE
            )
        else()
            message(STATUS "To enable C++14 install libc++ standard library")
        endif()
    endif()

    if(_COMPILER_TEST_RESULT)
        if((CMAKE_COMPILER_IS_GNUCXX AND NOT ${CMAKE_CXX_COMPILER_VERSION}
                                         VERSION_LESS 6.1)
           OR (CMAKE_CXX_COMPILER_ID STREQUAL "Clang"
               AND NOT ${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 3.4)
        )
            set(${_VAR} 1 PARENT_SCOPE)
            message(STATUS "Checking for C++14 compiler - available")
        endif()
    else()
        message(STATUS "Checking for C++14 compiler - unavailable")
    endif()
endfunction()

# Determines whether the compiler supports C++17
function(check_for_cxx17 _VAR)
    set(${_VAR} 0 PARENT_SCOPE)

    message(STATUS "Checking for C++17 compiler")
    try_compile(
        _COMPILER_TEST_RESULT ${PROJECT_BINARY_DIR}
        ${CMAKE_CURRENT_LIST_DIR}/common/CxxTestCompiler.cpp CXX_STANDARD 17
        CXX_STANDARD_REQUIRED ON
    )

    if(NOT _COMPILER_TEST_RESULT AND CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        try_compile(
            _COMPILER_TEST_RESULT ${PROJECT_BINARY_DIR}
            ${CMAKE_CURRENT_LIST_DIR}/common/CxxTestCompiler.cpp
            CMAKE_FLAGS -DCMAKE_CXX_FLAGS="-stdlib=libc++" CXX_STANDARD 17
                        CXX_STANDARD_REQUIRED ON
        )
        if(_COMPILER_TEST_RESULT)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++"
                PARENT_SCOPE
            )
        else()
            message(STATUS "To enable C++17 install libc++ standard library")
        endif()
    endif()

    if(_COMPILER_TEST_RESULT)
        if((CMAKE_COMPILER_IS_GNUCXX AND NOT ${CMAKE_CXX_COMPILER_VERSION}
                                         VERSION_LESS 7.1)
           OR (CMAKE_CXX_COMPILER_ID STREQUAL "Clang"
               AND NOT ${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 8)
        )
            set(${_VAR} 1 PARENT_SCOPE)
            message(STATUS "Checking for C++17 compiler - available")
        endif()
    else()
        message(STATUS "Checking for C++17 compiler - unavailable")
    endif()
endfunction()

# Determines whether the compiler supports C++20
function(check_for_cxx20 _VAR)
    set(${_VAR} 0 PARENT_SCOPE)

    message(STATUS "Checking for C++20 compiler")
    try_compile(
        _COMPILER_TEST_RESULT ${PROJECT_BINARY_DIR}
        ${CMAKE_CURRENT_LIST_DIR}/common/CxxTestCompiler.cpp CXX_STANDARD 20
        CXX_STANDARD_REQUIRED ON
    )

    if(NOT _COMPILER_TEST_RESULT AND CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        try_compile(
            _COMPILER_TEST_RESULT ${PROJECT_BINARY_DIR}
            ${CMAKE_CURRENT_LIST_DIR}/common/CxxTestCompiler.cpp
            CMAKE_FLAGS -DCMAKE_CXX_FLAGS="-stdlib=libc++" CXX_STANDARD 17
                        CXX_STANDARD_REQUIRED ON
        )
        if(_COMPILER_TEST_RESULT)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++"
                PARENT_SCOPE
            )
        else()
            message(STATUS "To enable C++20 install libc++ standard library")
        endif()
    endif()

    if(_COMPILER_TEST_RESULT)
        if((CMAKE_COMPILER_IS_GNUCXX AND NOT ${CMAKE_CXX_COMPILER_VERSION}
                                         VERSION_LESS 11)
           OR (CMAKE_CXX_COMPILER_ID STREQUAL "Clang"
               AND NOT ${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 12)
        )
            set(${_VAR} 1 PARENT_SCOPE)
            message(STATUS "Checking for C++20 compiler - available")
        endif()
    else()
        message(STATUS "Checking for C++20 compiler - unavailable")
    endif()
endfunction()

function(enable_cxx11)
    set(CMAKE_CXX_STANDARD 11 PARENT_SCOPE)
    set(CMAKE_CXX_STANDARD_REQUIRED ON PARENT_SCOPE)
    set(CMAKE_CXX_EXTENSIONS OFF PARENT_SCOPE)
endfunction()

function(enable_cxx14)
    set(CMAKE_CXX_STANDARD 14 PARENT_SCOPE)
    set(CMAKE_CXX_STANDARD_REQUIRED ON PARENT_SCOPE)
    set(CMAKE_CXX_EXTENSIONS OFF PARENT_SCOPE)
endfunction()

function(enable_cxx17)
    set(CMAKE_CXX_STANDARD 17 PARENT_SCOPE)
    set(CMAKE_CXX_STANDARD_REQUIRED ON PARENT_SCOPE)
    set(CMAKE_CXX_EXTENSIONS OFF PARENT_SCOPE)
endfunction()

function(enable_cxx20)
    set(CMAKE_CXX_STANDARD 20 PARENT_SCOPE)
    set(CMAKE_CXX_STANDARD_REQUIRED ON PARENT_SCOPE)
    set(CMAKE_CXX_EXTENSIONS OFF PARENT_SCOPE)
endfunction()

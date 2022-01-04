include(CheckIPOSupported)

#
# Enable LTO (IPO) for given target
#
# Using: target_enable_lto(TARGET <TARGET_NAME>)
#
function(TARGET_ENABLE_LTO)
    set(oneValueArgs TARGET)
    cmake_parse_arguments(P "" "${oneValueArgs}" "" ${ARGN})

    check_ipo_supported(RESULT result OUTPUT output)
    if(result)
        get_target_property(TARGET_NAME ${P_TARGET} NAME)
        message(STATUS "Enabling LTO for '${TARGET_NAME}' target is successful")
        set_property(
            TARGET ${P_TARGET} PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE
        )
    endif()
endfunction()

# Find the native c-ares includes and libraries
#
#  CARES_INCLUDE_DIR - where to find ares.h, etc.
#  CARES_LIBRARIES   - List of libraries when using libcares.
#  CARES_FOUND       - True if libcares found.

if(CARES_INCLUDE_DIR)
    set(CARES_FIND_QUIETLY TRUE)
endif(CARES_INCLUDE_DIR)

find_path(CARES_INCLUDE_DIR ares.h)

find_library(CARES_LIBRARY NAMES libcares cares)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    CARES
    DEFAULT_MSG
    CARES_LIBRARY CARES_INCLUDE_DIR)

if(CARES_FOUND)
  set(CARES_LIBRARIES ${CARES_LIBRARY})
else(CARES_FOUND)
  set(CARES_LIBRARIES)
endif(CARES_FOUND)

mark_as_advanced(CARES_INCLUDE_DIR CARES_LIBRARY)

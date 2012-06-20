# - Find MySQL++
# Find MySQL++ includes and library
#
# MYSQL++_INCLUDE_DIR - Where to find mysql++.h, etc.
# MYSQL++_LIBRARIES   - List of libraries when using MySQL++.
# MYSQL++_FOUND       - True if MySQL++ found.

find_path (MYSQL++_INCLUDE_DIR mysql++/mysql++.h
    PATHS
    /usr/include
    /usr/local/include
)

find_library (MYSQL++_LIBRARIES
    NAMES mysqlpp
    PATHS /usr/lib /usr/local/lib
)

include (${CMAKE_CURRENT_LIST_DIR}/FindPackageHandleStandardArgs.cmake)
find_package_handle_standard_args (MySQL++ DEFAULT_MSG MYSQL++_LIBRARIES MYSQL++_INCLUDE_DIR)
  
mark_as_advanced (MYSQL++_INCLUDE_DIR MYSQL++_LIBRARIES)


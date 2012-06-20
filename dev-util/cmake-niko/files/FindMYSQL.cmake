# - Find mysqlclient
# Find the native MySQL includes and library
#
#  MYSQL_INCLUDE_DIR - Where to find mysql.h, etc.
#  MYSQL_LIBRARIES   - List of libraries when using MySQL.
#  MYSQL_FOUND       - True if MySQL found.

find_path (MYSQL_INCLUDE_DIR mysql/mysql.h
    PATHS
    /usr/include
    /usr/local/include
)

set (MYSQL_NAMES mysqlclient mysqlclient_r)
find_library (MYSQL_LIBRARIES
    NAMES ${MYSQL_NAMES}
    PATHS /usr/lib /usr/local/lib
    PATH_SUFFIXES mysql
)

include (${CMAKE_CURRENT_LIST_DIR}/FindPackageHandleStandardArgs.cmake)
find_package_handle_standard_args (MySQL DEFAULT_MSG MYSQL_LIBRARIES MYSQL_INCLUDE_DIR)

mark_as_advanced (MYSQL_INCLUDE_DIR MYSQL_LIBRARIES)


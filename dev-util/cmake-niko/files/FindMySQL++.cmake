# - Find MySQL++

if(MySQL++_INCLUDE_DIR AND MySQL++_LIBRARIES)
    set(MySQL++_FOUND TRUE)

else(MySQL++_INCLUDE_DIR AND MySQL++_LIBRARIES)
    find_path(MySQL++_INCLUDE_DIR mysql++.h
        /usr/include/mysql++
        /usr/local/include/mysql++
        $ENV{SystemDrive}/MySQL++
        )

    find_library(MySQL++_LIBRARIES NAMES mysqlpp
        PATHS
        /usr/lib
        /usr/local/lib
        $ENV{SystemDrive}/MySQL++/lib
        )

    if(MySQL++_INCLUDE_DIR AND MySQL++_LIBRARIES)
        set(MySQL++_FOUND TRUE)
        message(STATUS "Found MySQL++: ${MySQL++_INCLUDE_DIR}, ${MySQL++_LIBRARIES}")
    else(MySQL++_INCLUDE_DIR AND MySQL++_LIBRARIES)
        set(MySQL++_FOUND FALSE)
        message(STATUS "MySQL++ not found.")
    endif(MySQL++_INCLUDE_DIR AND MySQL++_LIBRARIES)

    mark_as_advanced(MySQL++_INCLUDE_DIR MySQL++_LIBRARIES)

endif(MySQL++_INCLUDE_DIR AND MySQL++_LIBRARIES)


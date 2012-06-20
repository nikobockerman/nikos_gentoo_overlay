#
# Find the CppUnit includes and library
#
# This module defines
# CPPUNIT_INCLUDE_DIR, where to find tiff.h, etc.
# CPPUNIT_LIBRARIES, the libraries to link against to use CppUnit.
# CPPUNIT_FOUND, If false, do not try to use CppUnit.

find_package (PkgConfig)
pkg_check_modules (PC_CPPUNIT cppunit)

find_path (CPPUNIT_INCLUDE_DIR cppunit/TestCase.h
    HINTS
    ${PC_CPPUNIT_INCLUDEDIR}
    ${PC_CPPUNIT_INCLUDE_DIRS}
)
find_library (CPPUNIT_LIBRARIES NAMES cppunit libcppunit
    HINTS
    ${PC_CPPUNIT_LIBDIR}
    ${PC_CPPUNIT_LIBRARY_DIRS}
)

include (${CMAKE_CURRENT_LIST_DIR}/FindPackageHandleStandardArgs.cmake)
find_package_handle_standard_args (CppUnit DEFAULT_MSG CPPUNIT_LIBRARIES CPPUNIT_INCLUDE_DIR)

mark_as_advanced(CPPUNIT_INCLUDE_DIR CPPUNIT_LIBRARIES)


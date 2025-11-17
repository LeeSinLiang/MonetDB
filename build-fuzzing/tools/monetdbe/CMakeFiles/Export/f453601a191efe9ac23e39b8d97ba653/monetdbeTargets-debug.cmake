#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "MonetDB::monetdbe" for configuration "Debug"
set_property(TARGET MonetDB::monetdbe APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(MonetDB::monetdbe PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_DEBUG "MonetDB::mapi;MonetDB::stream;MonetDB::bat;MonetDB::monetdb5;MonetDB::sql;MonetDB::mutils"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libmonetdbe.so.27.0.2"
  IMPORTED_SONAME_DEBUG "libmonetdbe.so.27"
  )

list(APPEND _cmake_import_check_targets MonetDB::monetdbe )
list(APPEND _cmake_import_check_files_for_MonetDB::monetdbe "${_IMPORT_PREFIX}/lib/libmonetdbe.so.27.0.2" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

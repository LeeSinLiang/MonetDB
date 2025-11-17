#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "MonetDB::sql" for configuration "Debug"
set_property(TARGET MonetDB::sql APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(MonetDB::sql PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_DEBUG "MonetDB::monetdb5;MonetDB::mapi;MonetDB::bat;MonetDB::mutils"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libmonetdbsql-11.56.0.so.16.1.4"
  IMPORTED_SONAME_DEBUG "libmonetdbsql-11.56.0.so.16"
  )

list(APPEND _cmake_import_check_targets MonetDB::sql )
list(APPEND _cmake_import_check_files_for_MonetDB::sql "${_IMPORT_PREFIX}/lib/libmonetdbsql-11.56.0.so.16.1.4" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

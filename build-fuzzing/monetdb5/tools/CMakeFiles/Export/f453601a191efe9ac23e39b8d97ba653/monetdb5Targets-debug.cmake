#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "MonetDB::monetdb5" for configuration "Debug"
set_property(TARGET MonetDB::monetdb5 APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(MonetDB::monetdb5 PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_DEBUG "MonetDB::stream;MonetDB::mapi;MonetDB::mutils;MonetDB::bat"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libmonetdb5-11.56.0.so.37.0.5"
  IMPORTED_SONAME_DEBUG "libmonetdb5-11.56.0.so.37"
  )

list(APPEND _cmake_import_check_targets MonetDB::monetdb5 )
list(APPEND _cmake_import_check_files_for_MonetDB::monetdb5 "${_IMPORT_PREFIX}/lib/libmonetdb5-11.56.0.so.37.0.5" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

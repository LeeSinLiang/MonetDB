#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "MonetDB::mutils" for configuration "Debug"
set_property(TARGET MonetDB::mutils APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(MonetDB::mutils PROPERTIES
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libmutils-11.56.0.so.1.0.1"
  IMPORTED_SONAME_DEBUG "libmutils-11.56.0.so.1"
  )

list(APPEND _cmake_import_check_targets MonetDB::mutils )
list(APPEND _cmake_import_check_files_for_MonetDB::mutils "${_IMPORT_PREFIX}/lib/libmutils-11.56.0.so.1.0.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

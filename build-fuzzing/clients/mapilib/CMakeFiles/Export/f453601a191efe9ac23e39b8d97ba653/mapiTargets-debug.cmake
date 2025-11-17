#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "MonetDB::mapi" for configuration "Debug"
set_property(TARGET MonetDB::mapi APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(MonetDB::mapi PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_DEBUG "MonetDB::stream;MonetDB::mutils"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libmapi-11.56.0.so.28.0.4"
  IMPORTED_SONAME_DEBUG "libmapi-11.56.0.so.28"
  )

list(APPEND _cmake_import_check_targets MonetDB::mapi )
list(APPEND _cmake_import_check_files_for_MonetDB::mapi "${_IMPORT_PREFIX}/lib/libmapi-11.56.0.so.28.0.4" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

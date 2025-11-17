#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "MonetDB::stream" for configuration "Debug"
set_property(TARGET MonetDB::stream APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(MonetDB::stream PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_DEBUG "MonetDB::mutils"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libstream-11.56.0.so.28.0.3"
  IMPORTED_SONAME_DEBUG "libstream-11.56.0.so.28"
  )

list(APPEND _cmake_import_check_targets MonetDB::stream )
list(APPEND _cmake_import_check_files_for_MonetDB::stream "${_IMPORT_PREFIX}/lib/libstream-11.56.0.so.28.0.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

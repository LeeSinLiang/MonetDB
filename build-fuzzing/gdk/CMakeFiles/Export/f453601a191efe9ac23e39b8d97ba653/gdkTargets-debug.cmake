#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "MonetDB::bat" for configuration "Debug"
set_property(TARGET MonetDB::bat APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(MonetDB::bat PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_DEBUG "MonetDB::stream;MonetDB::mutils"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libbat-11.56.0.so.30.1.4"
  IMPORTED_SONAME_DEBUG "libbat-11.56.0.so.30"
  )

list(APPEND _cmake_import_check_targets MonetDB::bat )
list(APPEND _cmake_import_check_files_for_MonetDB::bat "${_IMPORT_PREFIX}/lib/libbat-11.56.0.so.30.1.4" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

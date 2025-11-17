# Install script for directory: /home/user/MonetDB/sql/backends/monet5

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/llvm-objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "sql" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmonetdbsql-11.56.0.so.16.1.4"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmonetdbsql-11.56.0.so.16"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "/usr/local/lib")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/home/user/MonetDB/build-fuzzing/sql/backends/monet5/libmonetdbsql-11.56.0.so.16.1.4"
    "/home/user/MonetDB/build-fuzzing/sql/backends/monet5/libmonetdbsql-11.56.0.so.16"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmonetdbsql-11.56.0.so.16.1.4"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmonetdbsql-11.56.0.so.16"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHANGE
           FILE "${file}"
           OLD_RPATH "/home/user/MonetDB/build-fuzzing/monetdb5/tools:/home/user/MonetDB/build-fuzzing/clients/mapilib:/home/user/MonetDB/build-fuzzing/gdk:/home/user/MonetDB/build-fuzzing/common/stream:/home/user/MonetDB/build-fuzzing/common/utils:"
           NEW_RPATH "/usr/local/lib")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/llvm-strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "monetdbdev" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/user/MonetDB/build-fuzzing/sql/backends/monet5/libmonetdbsql-11.56.0.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "sql" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/monetdb" TYPE FILE FILES
    "/home/user/MonetDB/sql/backends/monet5/sql_import.h"
    "/home/user/MonetDB/sql/backends/monet5/../../include/sql_mem.h"
    "/home/user/MonetDB/sql/backends/monet5/../../include/sql_list.h"
    "/home/user/MonetDB/sql/backends/monet5/../../include/sql_hash.h"
    "/home/user/MonetDB/sql/backends/monet5/../../include/sql_stack.h"
    "/home/user/MonetDB/sql/backends/monet5/../../include/sql_catalog.h"
    "/home/user/MonetDB/sql/backends/monet5/../../include/sql_relation.h"
    "/home/user/MonetDB/sql/backends/monet5/../../include/sql_keyword.h"
    "/home/user/MonetDB/sql/backends/monet5/../../common/sql_types.h"
    "/home/user/MonetDB/sql/backends/monet5/../../common/sql_string.h"
    "/home/user/MonetDB/sql/backends/monet5/../../common/sql_backend.h"
    "/home/user/MonetDB/sql/backends/monet5/../../storage/sql_storage.h"
    "/home/user/MonetDB/sql/backends/monet5/../../storage/store_sequence.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/sql_tokens.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/sql_scan.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/sql_atom.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/sql_symbol.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/sql_semantic.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/sql_query.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/sql_qc.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/sql_mvc.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/sql_parser.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/sql_privileges.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/rel_file_loader.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/rel_optimizer.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/rel_rewriter.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/rel_prop.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/rel_exp.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/rel_rel.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/rel_basetable.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/rel_semantic.h"
    "/home/user/MonetDB/sql/backends/monet5/../../server/rel_dump.h"
    "/home/user/MonetDB/sql/backends/monet5/opt_backend.h"
    "/home/user/MonetDB/sql/backends/monet5/mal_backend.h"
    "/home/user/MonetDB/sql/backends/monet5/sql_statement.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "monetdbdev" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake/sqlTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake/sqlTargets.cmake"
         "/home/user/MonetDB/build-fuzzing/sql/backends/monet5/CMakeFiles/Export/f453601a191efe9ac23e39b8d97ba653/sqlTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake/sqlTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake/sqlTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake" TYPE FILE FILES "/home/user/MonetDB/build-fuzzing/sql/backends/monet5/CMakeFiles/Export/f453601a191efe9ac23e39b8d97ba653/sqlTargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake" TYPE FILE FILES "/home/user/MonetDB/build-fuzzing/sql/backends/monet5/CMakeFiles/Export/f453601a191efe9ac23e39b8d97ba653/sqlTargets-debug.cmake")
  endif()
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/user/MonetDB/build-fuzzing/sql/backends/monet5/generator/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/sql/backends/monet5/UDF/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/sql/backends/monet5/vaults/cmake_install.cmake")

endif()


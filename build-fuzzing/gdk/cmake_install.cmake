# Install script for directory: /home/user/MonetDB/gdk

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

if(CMAKE_INSTALL_COMPONENT STREQUAL "monetdbdev" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/user/MonetDB/build-fuzzing/gdk/monetdb-gdk.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "monetdb" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libbat-11.56.0.so.30.1.4"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libbat-11.56.0.so.30"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "/usr/local/lib")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/home/user/MonetDB/build-fuzzing/gdk/libbat-11.56.0.so.30.1.4"
    "/home/user/MonetDB/build-fuzzing/gdk/libbat-11.56.0.so.30"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libbat-11.56.0.so.30.1.4"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libbat-11.56.0.so.30"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHANGE
           FILE "${file}"
           OLD_RPATH "/home/user/MonetDB/build-fuzzing/common/stream:/home/user/MonetDB/build-fuzzing/common/utils:"
           NEW_RPATH "/usr/local/lib")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/llvm-strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "monetdbdev" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/user/MonetDB/build-fuzzing/gdk/libbat-11.56.0.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "monetdbdev" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/monetdb" TYPE FILE FILES
    "/home/user/MonetDB/gdk/gdk.h"
    "/home/user/MonetDB/gdk/gdk_system.h"
    "/home/user/MonetDB/gdk/gdk_posix.h"
    "/home/user/MonetDB/gdk/gdk_atoms.h"
    "/home/user/MonetDB/gdk/gdk_tracer.h"
    "/home/user/MonetDB/gdk/gdk_hash.h"
    "/home/user/MonetDB/gdk/gdk_bbp.h"
    "/home/user/MonetDB/gdk/gdk_utils.h"
    "/home/user/MonetDB/gdk/gdk_cand.h"
    "/home/user/MonetDB/gdk/gdk_calc.h"
    "/home/user/MonetDB/gdk/gdk_time.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "monetdbdev" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake/gdkTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake/gdkTargets.cmake"
         "/home/user/MonetDB/build-fuzzing/gdk/CMakeFiles/Export/f453601a191efe9ac23e39b8d97ba653/gdkTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake/gdkTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake/gdkTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake" TYPE FILE FILES "/home/user/MonetDB/build-fuzzing/gdk/CMakeFiles/Export/f453601a191efe9ac23e39b8d97ba653/gdkTargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake" TYPE FILE FILES "/home/user/MonetDB/build-fuzzing/gdk/CMakeFiles/Export/f453601a191efe9ac23e39b8d97ba653/gdkTargets-debug.cmake")
  endif()
endif()


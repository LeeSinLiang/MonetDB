# Install script for directory: /home/user/MonetDB

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
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake/monetdb_config_headerTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake/monetdb_config_headerTargets.cmake"
         "/home/user/MonetDB/build-fuzzing/CMakeFiles/Export/f453601a191efe9ac23e39b8d97ba653/monetdb_config_headerTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake/monetdb_config_headerTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake/monetdb_config_headerTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake" TYPE FILE FILES "/home/user/MonetDB/build-fuzzing/CMakeFiles/Export/f453601a191efe9ac23e39b8d97ba653/monetdb_config_headerTargets.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "monetdbdev" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/monetdb" TYPE FILE FILES "/home/user/MonetDB/build-fuzzing/monetdb_config.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "monetdbdev" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake" TYPE FILE FILES "/home/user/MonetDB/build-fuzzing/MonetDBConfig.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "monetdbdev" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/monetdb/cmake" TYPE FILE FILES "/home/user/MonetDB/build-fuzzing/MonetDBConfigVersion.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/user/MonetDB/build-fuzzing/common/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/clients/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/gdk/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/misc/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/monetdb5/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/sql/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/geom/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/tools/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/buildtools/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/fuzzers/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/ctest/cmake_install.cmake")
  include("/home/user/MonetDB/build-fuzzing/documentation/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/user/MonetDB/build-fuzzing/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")

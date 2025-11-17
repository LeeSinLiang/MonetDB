# Install script for directory: /home/user/MonetDB/monetdb5/mal

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

if(CMAKE_INSTALL_COMPONENT STREQUAL "serverdev" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/monetdb" TYPE FILE FILES
    "/home/user/MonetDB/monetdb5/mal/mal.h"
    "/home/user/MonetDB/monetdb5/mal/mal_authorize.h"
    "/home/user/MonetDB/monetdb5/mal/mal_client.h"
    "/home/user/MonetDB/monetdb5/mal/mal_errors.h"
    "/home/user/MonetDB/monetdb5/mal/mal_exception.h"
    "/home/user/MonetDB/monetdb5/mal/mal_function.h"
    "/home/user/MonetDB/monetdb5/mal/mal_import.h"
    "/home/user/MonetDB/monetdb5/mal/mal_instruction.h"
    "/home/user/MonetDB/monetdb5/mal/mal_builder.h"
    "/home/user/MonetDB/monetdb5/mal/mal_linker.h"
    "/home/user/MonetDB/monetdb5/mal/mal_listing.h"
    "/home/user/MonetDB/monetdb5/mal/mal_module.h"
    "/home/user/MonetDB/monetdb5/mal/mal_namespace.h"
    "/home/user/MonetDB/monetdb5/mal/mal_resolve.h"
    "/home/user/MonetDB/monetdb5/mal/mal_stack.h"
    "/home/user/MonetDB/monetdb5/mal/mal_type.h"
    "/home/user/MonetDB/monetdb5/mal/mal_prelude.h"
    "/home/user/MonetDB/monetdb5/mal/mel.h"
    )
endif()


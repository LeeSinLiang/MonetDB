#[[
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0.  If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright 2024, 2025 MonetDB Foundation;
#]]

# CMake configuration for MonetDB fuzzers
# This allows building fuzzers locally for development/testing

cmake_minimum_required(VERSION 3.12)

# Only build fuzzers if explicitly requested
option(BUILD_FUZZERS "Build fuzzing targets" OFF)

if(NOT BUILD_FUZZERS)
  return()
endif()

# Require Clang for fuzzing (libFuzzer is Clang-specific)
if(NOT CMAKE_C_COMPILER_ID MATCHES "Clang")
  message(WARNING "Fuzzers require Clang compiler. Skipping fuzzer build.")
  return()
endif()

# Fuzzing flags for Clang
set(FUZZER_FLAGS "-fsanitize=fuzzer,address,undefined")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${FUZZER_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${FUZZER_FLAGS}")

# MonetDBe fuzzer
add_executable(fuzz_monetdbe
  harnesses/fuzz_monetdbe.c
)

target_link_libraries(fuzz_monetdbe
  PRIVATE
    monetdbe
    monetdb5
    bat
    mapi
    stream
    mutils
)

target_include_directories(fuzz_monetdbe
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../tools/monetdbe
    ${CMAKE_CURRENT_SOURCE_DIR}/../gdk
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/stream
)

# Type conversion fuzzer
add_executable(fuzz_type_conversion
  harnesses/fuzz_type_conversion.c
)

target_link_libraries(fuzz_type_conversion
  PRIVATE
    bat
    mutils
)

target_include_directories(fuzz_type_conversion
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../gdk
)

# CSV parser fuzzer
add_executable(fuzz_csv_parser
  harnesses/fuzz_csv_parser.c
)

target_link_libraries(fuzz_csv_parser
  PRIVATE
    bat
    stream
    mutils
)

target_include_directories(fuzz_csv_parser
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../gdk
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/stream
)

# Installation (optional)
install(TARGETS
  fuzz_monetdbe
  fuzz_type_conversion
  fuzz_csv_parser
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  COMPONENT fuzzers
)

message(STATUS "Fuzzing targets configured. Build with: cmake --build . --target fuzz_monetdbe")

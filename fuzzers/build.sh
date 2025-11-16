#!/bin/bash
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0.  If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright 2024, 2025 MonetDB Foundation

# OSS-Fuzz build script for MonetDB
#
# This script is called by OSS-Fuzz to build the fuzzers.
# Environment variables set by OSS-Fuzz:
#   $CC, $CXX          - Compiler with fuzzing instrumentation
#   $CFLAGS, $CXXFLAGS - Compilation flags
#   $LIB_FUZZING_ENGINE - Fuzzing engine library (libFuzzer)
#   $OUT               - Output directory for fuzzers
#   $SRC               - Source directory

set -e  # Exit on error
set -x  # Print commands

# Source directory
PROJECT_DIR="${SRC}/MonetDB"
BUILD_DIR="${PROJECT_DIR}/build-fuzz"

# Create build directory
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

# Configure MonetDB with CMake
# Important flags:
#   -DCMAKE_BUILD_TYPE=Release - Optimize for fuzzing performance
#   -DASSERT=ON                - Enable assertions to catch bugs
#   -DSTRICT=OFF               - Disable strict warnings (fuzzer may trigger some)
#   -DTESTING=OFF              - Don't need test infrastructure
#   -DCINTEGRATION=ON          - Enable C UDF support
#   -DPY3INTEGRATION=OFF       - Disable Python (not needed for fuzzing)
#   -DRINTEGRATION=OFF         - Disable R (not needed for fuzzing)
#   -DODBC=OFF                 - Don't build ODBC driver
#   -DGEOM=OFF                 - Don't build geom module
#   -DSANITIZER=OFF            - OSS-Fuzz handles sanitizers

cmake "${PROJECT_DIR}" \
  -DCMAKE_INSTALL_PREFIX="${BUILD_DIR}/install" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER="${CC}" \
  -DCMAKE_C_FLAGS="${CFLAGS}" \
  -DASSERT=ON \
  -DSTRICT=OFF \
  -DTESTING=OFF \
  -DCINTEGRATION=ON \
  -DPY3INTEGRATION=OFF \
  -DRINTEGRATION=OFF \
  -DODBC=OFF \
  -DGEOM=OFF \
  -DSANITIZER=OFF \
  -DWITH_PCRE=ON \
  -DWITH_OPENSSL=OFF

# Build MonetDB
cmake --build . -j$(nproc)
cmake --build . --target install

# Library paths
INSTALL_DIR="${BUILD_DIR}/install"
LIB_DIR="${INSTALL_DIR}/lib"
INCLUDE_DIR="${INSTALL_DIR}/include/monetdb"

# Link flags for fuzzers
MONETDB_LIBS="-L${LIB_DIR} -lmonetdbe -lmonetdb5 -lbat -lmapi -lstream -lmutils"
MONETDB_INCLUDES="-I${INCLUDE_DIR} -I${INSTALL_DIR}/include"

# Build fuzzer: fuzz_monetdbe
${CC} ${CFLAGS} ${MONETDB_INCLUDES} \
  "${PROJECT_DIR}/fuzzers/harnesses/fuzz_monetdbe.c" \
  ${LIB_FUZZING_ENGINE} ${MONETDB_LIBS} \
  -lpthread -lm -ldl -lrt \
  -o "${OUT}/fuzz_monetdbe"

# Build fuzzer: fuzz_type_conversion
${CC} ${CFLAGS} ${MONETDB_INCLUDES} \
  "${PROJECT_DIR}/fuzzers/harnesses/fuzz_type_conversion.c" \
  ${LIB_FUZZING_ENGINE} ${MONETDB_LIBS} \
  -lpthread -lm -ldl -lrt \
  -o "${OUT}/fuzz_type_conversion"

# Build fuzzer: fuzz_csv_parser
${CC} ${CFLAGS} ${MONETDB_INCLUDES} \
  "${PROJECT_DIR}/fuzzers/harnesses/fuzz_csv_parser.c" \
  ${LIB_FUZZING_ENGINE} ${MONETDB_LIBS} \
  -lpthread -lm -ldl -lrt \
  -o "${OUT}/fuzz_csv_parser"

# Copy seed corpora to output directory
if [ -d "${PROJECT_DIR}/fuzzers/seeds/sql" ]; then
  zip -j "${OUT}/fuzz_monetdbe_seed_corpus.zip" "${PROJECT_DIR}/fuzzers/seeds/sql"/*
fi

if [ -d "${PROJECT_DIR}/fuzzers/seeds/numbers" ]; then
  zip -j "${OUT}/fuzz_type_conversion_seed_corpus.zip" "${PROJECT_DIR}/fuzzers/seeds/numbers"/*
  zip -j "${OUT}/fuzz_type_conversion_seed_corpus.zip" "${PROJECT_DIR}/fuzzers/seeds/strings"/*
fi

if [ -d "${PROJECT_DIR}/fuzzers/seeds/csv" ]; then
  zip -j "${OUT}/fuzz_csv_parser_seed_corpus.zip" "${PROJECT_DIR}/fuzzers/seeds/csv"/*
fi

# Copy library dependencies for runtime
cp "${LIB_DIR}"/*.so* "${OUT}/" 2>/dev/null || true

echo "MonetDB fuzzers built successfully!"

# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0.  If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright 2024, 2025 MonetDB Foundation

# OSS-Fuzz Dockerfile for MonetDB
# This defines the build environment for fuzzing MonetDB

FROM gcr.io/oss-fuzz-base/base-builder

# Install MonetDB build dependencies
RUN apt-get update && apt-get install -y \
    bison \
    cmake \
    pkg-config \
    python3 \
    python3-pip \
    libbz2-dev \
    liblz4-dev \
    libpcre2-dev \
    libreadline-dev \
    liblzma-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Clone MonetDB repository
RUN git clone --depth 1 https://github.com/MonetDB/MonetDB.git MonetDB

# Set working directory
WORKDIR MonetDB

# Copy build script
COPY build.sh $SRC/

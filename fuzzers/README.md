# MonetDB OSS-Fuzz Integration

This directory contains fuzzing harnesses and infrastructure for integrating MonetDB with [OSS-Fuzz](https://github.com/google/oss-fuzz), Google's continuous fuzzing service for open source software.

## 📋 Overview

**Fuzzing** is an automated testing technique that feeds random/malformed input to software to find bugs, crashes, and security vulnerabilities. OSS-Fuzz provides:

- **Continuous fuzzing** infrastructure (24/7)
- **Multiple sanitizers** (AddressSanitizer, UndefinedBehaviorSanitizer, MemorySanitizer)
- **Coverage tracking** to measure how much code is exercised
- **Automated bug reporting** with minimized reproducers
- **Free** for open source projects

## 🎯 Fuzzing Targets

We've created three high-value fuzzing targets for MonetDB:

### 1. **fuzz_monetdbe** - MonetDBe Embedded API Fuzzer
**File**: `harnesses/fuzz_monetdbe.c`

Fuzzes the MonetDBe embedded database API, specifically `monetdbe_query()`. This exercises:
- SQL parser (`sql_parser.y`)
- Semantic analyzer (`sql_semantic.c`)
- Query optimizer (all `rel_optimize_*.c` files)
- MAL code generation
- MAL execution engine
- GDK layer operations

**Why it matters**: This is the highest-coverage fuzzer. It tests the entire SQL processing stack and is likely to find SQL injection vulnerabilities, parser bugs, optimizer crashes, and execution errors.

**Code coverage**: ~70-80% of MonetDB codebase

---

### 2. **fuzz_type_conversion** - Type Conversion Fuzzer
**File**: `harnesses/fuzz_type_conversion.c`

Fuzzes string-to-type conversion functions in `gdk/gdk_atoms.c`:
- `numFromStr()` - Generic numeric parser
- `intFromStr()`, `lngFromStr()`, `hgeFromStr()` - Integer parsers
- `fltFromStr()`, `dblFromStr()` - Floating-point parsers
- `strFromStr()` - String parser (9,809 lines of code!)
- `bitFromStr()` - Boolean parser

**Why it matters**: Type conversion is a critical security boundary. Bugs here can cause integer overflows, buffer overruns, floating-point exceptions, and type confusion attacks.

**Code coverage**: Focused on `gdk_atoms.c` and `gdk_string.c`

---

### 3. **fuzz_csv_parser** - CSV Format Detection Fuzzer
**File**: `harnesses/fuzz_csv_parser.c`

Fuzzes CSV parsing and type inference in `sql/backends/monet5/vaults/csv/csv.c`:
- `detect_delimiter()` - Auto-detect CSV delimiter (comma, tab, pipe, semicolon)
- `detect_quote()` - Auto-detect quote character
- `detect_types()` - Infer column types from data
- Type-specific detectors (integer, decimal, date, timestamp, boolean)

**Why it matters**: CSV parsing has many edge cases. Format auto-detection is especially error-prone. This fuzzer finds delimiter confusion bugs, type inference errors, and malformed input handling issues.

**Code coverage**: CSV vault and related import code

---

## 📁 Directory Structure

```
fuzzers/
├── harnesses/              # Fuzzing harness source code
│   ├── fuzz_monetdbe.c
│   ├── fuzz_type_conversion.c
│   └── fuzz_csv_parser.c
├── seeds/                  # Seed corpus (initial test inputs)
│   ├── sql/               # SQL query seeds
│   ├── csv/               # CSV data seeds
│   ├── numbers/           # Numeric string seeds
│   └── strings/           # String seeds
├── build.sh               # OSS-Fuzz build script
├── Dockerfile             # OSS-Fuzz Docker container definition
├── project.yaml           # OSS-Fuzz project configuration
├── CMakeLists.txt         # CMake build for local fuzzing
└── README.md              # This file
```

---

## 🚀 Quick Start

### Option 1: Local Fuzzing (Development)

Build and run fuzzers locally using Clang's libFuzzer:

```bash
# Prerequisites: Clang compiler with libFuzzer support
# Install on Ubuntu:
sudo apt-get install clang

# Build MonetDB with fuzzing enabled
mkdir build-fuzz && cd build-fuzz
cmake .. \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_BUILD_TYPE=Debug \
  -DBUILD_FUZZERS=ON \
  -DASSERT=ON

cmake --build . -j$(nproc)

# Run a fuzzer
cd fuzzers
./fuzz_monetdbe -max_total_time=60  # Run for 60 seconds
```

**Fuzzer options**:
```bash
# Run for specific duration
./fuzz_monetdbe -max_total_time=300  # 5 minutes

# Limit memory
./fuzz_monetdbe -rss_limit_mb=2048   # 2GB RAM limit

# Use corpus directory
./fuzz_monetdbe corpus/              # Read seeds from corpus/

# Parallel fuzzing (4 workers)
./fuzz_monetdbe -jobs=4 -workers=4
```

---

### Option 2: OSS-Fuzz Integration (Production)

To integrate MonetDB with OSS-Fuzz:

#### Step 1: Fork OSS-Fuzz Repository

```bash
git clone https://github.com/google/oss-fuzz.git
cd oss-fuzz
```

#### Step 2: Create MonetDB Project Directory

```bash
mkdir -p projects/monetdb
cp /path/to/MonetDB/fuzzers/{Dockerfile,build.sh,project.yaml} projects/monetdb/
```

#### Step 3: Build with OSS-Fuzz

```bash
# Build fuzzers
python infra/helper.py build_fuzzers monetdb

# Run fuzzers
python infra/helper.py run_fuzzer monetdb fuzz_monetdbe
```

#### Step 4: Submit to OSS-Fuzz

1. Create pull request to [google/oss-fuzz](https://github.com/google/oss-fuzz)
2. Add `projects/monetdb/` directory with all files
3. Wait for review from OSS-Fuzz maintainers
4. Once merged, fuzzing runs automatically 24/7!

---

## 🔧 Configuration

### Memory Limits

Fuzzers are configured with conservative memory limits to prevent OOM:

```c
// In fuzz_monetdbe.c
opts.memorylimit = 512;      // 512 MB for database
opts.querytimeout = 5;       // 5 second query timeout
```

Adjust these values in the harness code if needed.

### Sanitizers

OSS-Fuzz runs fuzzers with multiple sanitizers:

- **AddressSanitizer (ASan)** - Detects memory errors
  - Buffer overflows/underflows
  - Use-after-free
  - Double-free
  - Memory leaks

- **UndefinedBehaviorSanitizer (UBSan)** - Detects undefined behavior
  - Integer overflow
  - Null pointer dereference
  - Misaligned memory access

- **MemorySanitizer (MSan)** - Detects uninitialized memory reads

### Coverage Tracking

OSS-Fuzz tracks code coverage automatically. View coverage reports at:
- https://oss-fuzz.com/coverage-report (after integration)

---

## 📊 Seed Corpus

The `seeds/` directory contains initial test inputs to guide fuzzing:

### SQL Seeds (`seeds/sql/`)
- `select_simple.sql` - Basic SELECT query
- `create_table.sql` - Table creation
- `insert.sql` - Data insertion
- `join.sql` - JOIN operations
- `aggregate.sql` - GROUP BY with aggregates
- `subquery.sql` - Nested queries
- `union.sql` - Set operations
- `window.sql` - Window functions

### Number Seeds (`seeds/numbers/`)
- `integer_1.txt` - Positive integer
- `negative.txt` - Negative integer
- `float.txt` - Floating point
- `scientific.txt` - Scientific notation
- `max_int.txt` - Maximum int64 value

### String Seeds (`seeds/strings/`)
- `simple.txt` - Plain string
- `quoted.txt` - Quoted string
- `escaped.txt` - Escaped quotes

### CSV Seeds (`seeds/csv/`)
- `simple.csv` - Comma-delimited
- `quoted.csv` - Quoted fields
- `tab_delimited.csv` - Tab-delimited
- `pipe_delimited.csv` - Pipe-delimited
- `mixed_types.csv` - Multiple data types

**Expanding the corpus**: Add more seeds from existing MonetDB tests:

```bash
# Copy SQL tests
find sql/test -name "*.sql" -exec cp {} fuzzers/seeds/sql/ \;

# Limit seed size (fuzzers work better with small inputs)
find fuzzers/seeds -type f -size +10k -delete
```

---

## 🐛 Bug Reporting

When OSS-Fuzz finds a bug:

1. **Issue created** on GitHub (if `file_github_issue: true` in `project.yaml`)
2. **Minimized reproducer** provided (smallest input that triggers the bug)
3. **Stack trace** and sanitizer output included
4. **Private disclosure** (30-90 day embargo before public disclosure)

### Reproducing Bugs Locally

If a bug is found:

```bash
# Download the reproducer (crasher file)
wget https://oss-fuzz.com/download/crash-xyz.zip
unzip crash-xyz.zip

# Run fuzzer with crasher
./fuzz_monetdbe crash-xyz

# Debug with GDB
gdb --args ./fuzz_monetdbe crash-xyz
```

---

## 📈 Expected Results

Based on fuzzing similar database systems:

- **First 24 hours**: 10-50 crashes (mostly duplicates)
- **First week**: 5-10 unique bugs
- **First month**: 15-30 unique bugs
- **Ongoing**: 1-3 bugs per month

**Common bug types**:
- Buffer overflows in string operations
- Integer overflows in size calculations
- Null pointer dereferences
- Use-after-free in error handling
- Assertion failures in optimizers
- Stack overflows in recursive parsers

---

## 🔍 Monitoring & Metrics

Once integrated with OSS-Fuzz, monitor at:
- https://oss-fuzz.com/ (main dashboard)
- Coverage: https://oss-fuzz.com/coverage-report/job/libfuzzer_asan_monetdb/latest
- Bugs: https://bugs.chromium.org/p/oss-fuzz/issues/list?q=label:Proj-monetdb

**Key metrics**:
- **Executions/second**: Higher is better (aim for >1000/sec)
- **Code coverage**: Percentage of code exercised (aim for >60%)
- **Corpus size**: Number of interesting inputs found
- **Peak memory**: Maximum memory used

---

## 🛠️ Advanced Usage

### Parallel Fuzzing

Run multiple fuzzer instances in parallel:

```bash
# Terminal 1
./fuzz_monetdbe -jobs=1 -workers=1 corpus1/

# Terminal 2
./fuzz_monetdbe -jobs=1 -workers=1 corpus2/

# Merge corpora later
./fuzz_monetdbe -merge=1 merged_corpus/ corpus1/ corpus2/
```

### Dictionary-Based Fuzzing

Create a dictionary of SQL keywords to guide fuzzing:

```bash
cat > sql.dict << 'EOF'
"SELECT"
"INSERT"
"UPDATE"
"DELETE"
"CREATE"
"DROP"
"WHERE"
"JOIN"
"UNION"
"GROUP BY"
"ORDER BY"
EOF

./fuzz_monetdbe -dict=sql.dict
```

### Coverage-Guided Corpus Minimization

Reduce corpus size while maintaining coverage:

```bash
./fuzz_monetdbe -merge=1 minimized_corpus/ large_corpus/
```

### Custom Mutators

For more sophisticated fuzzing, implement custom mutators in the harness to generate syntactically valid SQL.

---

## 📚 Additional Resources

- **OSS-Fuzz Documentation**: https://google.github.io/oss-fuzz/
- **libFuzzer Tutorial**: https://github.com/google/fuzzing/blob/master/tutorial/libFuzzerTutorial.md
- **MonetDB Developer Guide**: See `CLAUDE.md` in the repository root
- **Fuzzing Best Practices**: https://github.com/google/fuzzing/blob/master/docs/good-fuzz-target.md

---

## 🤝 Contributing

To add new fuzzing targets:

1. Create harness in `harnesses/fuzz_new_target.c`
2. Add to `build.sh`
3. Add to `CMakeLists.txt`
4. Create seed corpus in `seeds/new_target/`
5. Test locally
6. Submit PR

**Good fuzzing target characteristics**:
- ✅ Accepts external/untrusted input
- ✅ Fast execution (< 1ms per input)
- ✅ Deterministic (same input → same output)
- ✅ No global state between runs
- ✅ Minimal setup/teardown overhead

---

## 📝 License

All fuzzing code follows MonetDB's license (MPL-2.0).

```
SPDX-License-Identifier: MPL-2.0
Copyright 2024, 2025 MonetDB Foundation
```

---

## ❓ Questions?

- **MonetDB Development**: https://www.monetdb.org/documentation/dev-guide/
- **OSS-Fuzz Help**: https://github.com/google/oss-fuzz/blob/master/docs/faq.md
- **File Issues**: https://github.com/MonetDB/MonetDB/issues

---

**Happy Fuzzing! 🐛🔨**

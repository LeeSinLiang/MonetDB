# MonetDB Developer Guide for AI Assistants

This document provides a comprehensive guide to the MonetDB codebase for AI assistants helping with development, debugging, and analysis tasks.

## Table of Contents

1. [Repository Overview](#repository-overview)
2. [Architecture Overview](#architecture-overview)
3. [Directory Structure](#directory-structure)
4. [Build System](#build-system)
5. [Development Workflow](#development-workflow)
6. [Coding Conventions](#coding-conventions)
7. [Testing Infrastructure](#testing-infrastructure)
8. [Query Execution Pipeline](#query-execution-pipeline)
9. [Key Data Structures](#key-data-structures)
10. [Common Development Tasks](#common-development-tasks)
11. [Important File Locations](#important-file-locations)
12. [Git Workflow](#git-workflow)
13. [Resources](#resources)

---

## Repository Overview

**MonetDB** is a high-performance, open-source column-store database system designed for query-intensive applications. It was originally developed at CWI (Centrum Wiskunde & Informatica) and is now maintained by MonetDB Solutions.

### Key Characteristics

- **License**: Mozilla Public License 2.0 (MPL-2.0)
- **Language**: Primarily C99, with Python for build/testing
- **Build System**: CMake 3.12+
- **Architecture**: Three-layer system (GDK → MonetDB5/MAL → SQL)
- **Paradigm**: Column-oriented storage with vectorized execution

### Project Structure

MonetDB consists of three main architectural layers:

1. **GDK (Goblin Database Kernel)** - Low-level storage and computation
2. **MonetDB5/MAL** - Intermediate language and execution engine
3. **SQL Layer** - SQL query processing and optimization

---

## Architecture Overview

### Three-Layer Architecture

```
┌─────────────────────────────────────────┐
│         SQL Layer (sql/)                │
│  - SQL Parser & Semantic Analysis      │
│  - Relational Algebra Generation        │
│  - Query Optimization                   │
│  - Code Generation                      │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│      MonetDB5/MAL (monetdb5/)           │
│  - MAL Virtual Machine                  │
│  - MAL Optimizer Pipeline               │
│  - Runtime Modules                      │
│  - Expression Evaluation                │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│         GDK Layer (gdk/)                │
│  - BAT (Binary Association Table)       │
│  - Storage Management                   │
│  - Primitive Operations                 │
│  - Join, Select, Aggregate, Sort        │
└─────────────────────────────────────────┘
```

### Query Execution Flow

```
SQL Text
   ↓ (sql_parser.y)
SQL Parse Tree
   ↓ (sql_semantic.c)
Semantic Analysis
   ↓ (rel_*.c)
Relational Algebra Tree
   ↓ (rel_optimizer.c, rel_optimize_*.c)
Optimized Relational Algebra
   ↓ (sql/backends/monet5/generator/)
MAL Program
   ↓ (monetdb5/optimizer/opt_*.c)
Optimized MAL Program
   ↓ (mal_interpreter.c)
MAL Execution
   ↓ (gdk_*.c)
GDK Operations on BATs
   ↓
Results (BATs)
```

---

## Directory Structure

### Core Engine Directories

#### `/gdk` - Goblin Database Kernel (Storage Layer)

The foundational layer implementing columnar storage and primitive operations.

**Key Components:**
- `gdk_bat.c` - BAT (Binary Association Table) management
- `gdk_bbp.c` - BAT Buffer Pool (memory/disk management)
- `gdk_storage.c` - Persistent storage operations
- `gdk_logger.c` - Transaction logging and recovery
- `gdk_join.c` - Join algorithms (157KB - hash join, merge join, etc.)
- `gdk_select.c` - Selection/filtering operations
- `gdk_group.c` - Grouping operations
- `gdk_aggr.c` - Aggregation functions (128KB)
- `gdk_sort.c`, `gdk_qsort.c` - Sorting algorithms
- `gdk_string.c` - String operations (523KB - comprehensive string library)
- `gdk_calc*.c` - Arithmetic and comparison operations
- `gdk_analytic*.c` - Window functions and analytics
- `gdk_hash.c` - Hash table operations
- `gdk_strimps.c` - STRing Index for Pattern Matching

**Main Header:** `gdk.h` (60KB - complete GDK API)

#### `/monetdb5` - MonetDB5 Virtual Machine

The intermediate layer providing MAL execution and optimization.

**Sub-directories:**

1. **`mal/`** - MAL Virtual Machine Core
   - `mal_interpreter.c` - MAL instruction interpreter
   - `mal_parser.c/h` - MAL language parser
   - `mal_client.c` - Client connection management
   - `mal_module.c` - Module system
   - `mal_function.c` - Function definitions
   - `mal_type.c` - Type system
   - `mal_dataflow.c` - Dataflow execution
   - `mal_authorize.c` - Security and authorization

2. **`optimizer/`** - MAL Optimization Pipeline (20+ optimizers)
   - `opt_pushselect.c` - Filter push-down
   - `opt_projectionpath.c` - Projection optimization
   - `opt_multiplex.c` - Vectorization
   - `opt_mergetable.c` - Merge table optimization
   - `opt_candidates.c` - Candidate list optimization
   - `opt_reorder.c` - Operation reordering
   - `opt_commonTerms.c` - Common subexpression elimination
   - `opt_querylog.c` - Query logging

3. **`modules/`** - Runtime Modules
   - `kernel/algebra.c` - Relational algebra operations
   - `kernel/aggr.c` - Aggregation functions
   - `kernel/batstr.c` - String operations in MAL
   - `kernel/mmath.c` - Mathematical functions

4. **`extras/`** - Language Integrations
   - `rapi/` - R integration
   - `mal_optimizer_template/` - Custom optimizer template

#### `/sql` - SQL Query Processing Layer

The top layer handling SQL parsing, optimization, and translation to MAL.

**Sub-directories:**

1. **`server/`** - SQL Query Engine (42 C files, 58K+ lines)
   - **Parser:**
     - `sql_parser.y` - Bison/Yacc grammar for SQL
     - `sql_semantic.c` - Semantic analysis (1237 lines)
     - `sql_symbol.c` - Symbol table management

   - **Relational Algebra:**
     - `rel_exp.c` - Expression handling
     - `rel_rel.c` - Relation operations
     - `rel_select.c` - SELECT statement processing
     - `rel_updates.c` - INSERT/UPDATE/DELETE
     - `rel_psm.c` - Procedural SQL (stored procedures, functions)
     - `rel_basetable.c` - Base table handling

   - **Optimization:**
     - `rel_optimizer.c` - Main optimizer
     - `rel_optimize_*.c` - Individual optimization passes
     - `rel_statistics.c` - Statistics gathering
     - `rel_prop.c` - Properties and cardinality estimation

   - **Advanced Features:**
     - `rel_distribute.c` - Distributed query support
     - `rel_unnest.c` - Subquery unnesting
     - `rel_remote.c` - Remote table operations
     - `rel_partition.c` - Partitioning support

   - **Catalog:**
     - `sql_catalog.h/c` - Metadata management
     - `sql_partition.c` - Partition catalog

2. **`backends/monet5/`** - SQL to MAL Translation
   - `generator/` - Code generation from SQL relational algebra to MAL
   - `UDF/` - User-Defined Functions
     - `capi/` - C UDF interface
     - `pyapi3/` - Python 3 integration
   - `vaults/` - External data sources
     - `csv/` - CSV file handling
     - `odbc/` - ODBC federation
     - `fits/`, `netcdf/`, `shp/` - Scientific data formats

3. **`test/`** - Extensive test suite
   - 119 test subdirectories
   - BugTracker tests (organized by year: 2009-2024)
   - FeatureRequests tests
   - TPC benchmarks (TPC-H, TPC-DS, SSBM)
   - Specialized tests (transactions, window functions, etc.)

4. **`storage/`** - Storage Backend
   - `bat/` - BAT-based storage implementation

5. **`odbc/`** - ODBC Driver
   - Full ODBC 3.0 implementation

6. **`jdbc/`** - JDBC Driver
   - Java Database Connectivity driver

### Client & Tools Directories

#### `/clients` - Client Libraries

- `mapilib/` - MAPI (MonetDB API) protocol implementation
- `mapiclient/` - mclient (command-line SQL client)
- `odbc/` - ODBC driver
- `ruby/` - Ruby bindings
- `examples/` - Example code (C, Perl, PHP)

#### `/tools` - Server Tools

- `mserver/` - MonetDB server executable
- `monetdbe/` - MonetDB Embedded (in-process database library)
- `merovingian/` - Cluster management daemon
  - `daemon/` - Cluster manager
  - `client/` - Management client
  - `utils/` - Cluster utilities

### Supporting Directories

#### `/common` - Shared Utilities

- `options/` - Command-line parsing
- `stream/` - I/O stream abstraction (files, sockets, compression)
- `utils/` - General utilities (strings, memory, etc.)

#### `/cmake` - Build System Configuration

- `monetdb-options.cmake` - Build option definitions
- `monetdb-versions.cmake` - Version management
- `monetdb-findpackages.cmake` - Dependency discovery
- `monetdb-toolchain.cmake` - Compiler settings
- `monetdb-functions.cmake` - Custom CMake functions

#### `/testing` - Test Infrastructure

- `Mtest.py.in` (191KB) - Main test runner
- `sqllogictest.py` - SQL logic test executor
- `sqltest.py` - Generic SQL testing
- `mapicursor.py` - MAPI test utilities

#### `/documentation` - Sphinx Documentation

- Sphinx-based documentation (ReadTheDocs)
- `conf.py` - Sphinx configuration
- `monetdbe/` - Embedded API docs

#### `/geom` - Geometric Types

- GEOS-based geometric data type module

#### `/misc` - Miscellaneous

- Python utilities
- SELinux policies
- Bash completions

---

## Build System

### CMake Build Configuration

MonetDB uses CMake 3.12+ as its build system.

#### Standard Build Process

```bash
# Out-of-tree build (recommended)
mkdir build
cd build
cmake /path/to/MonetDB/source
cmake --build .
cmake --build . --target install
```

#### Custom Install Prefix

```bash
cmake -DCMAKE_INSTALL_PREFIX=/path/to/install /path/to/source
cmake --build .
cmake --build . --target install
```

### Important Build Options

| Option | Description | Default |
|--------|-------------|---------|
| `ASSERT` | Enable assertions | ON (dev), OFF (release) |
| `STRICT` | Enable strict compiler flags | ON (dev), OFF (release) |
| `TESTING` | Enable test infrastructure | OFF |
| `CINTEGRATION` | C UDF support | ON (except Windows) |
| `PY3INTEGRATION` | Python 3 integration | Auto-detect |
| `RINTEGRATION` | R integration | Auto-detect |
| `ODBC` | Build ODBC driver | Auto-detect |
| `GEOM` | Geometric module (requires libgeos) | Auto-detect |
| `INT128` | 128-bit integer support | Auto-detect |
| `SANITIZER` | GCC address sanitizer | OFF |

**Compression & Libraries:**
- `WITH_BZ2`, `WITH_LZ4`, `WITH_LZMA`, `WITH_ZLIB` - Compression
- `WITH_OPENSSL` - TLS support
- `WITH_PCRE` - Regular expression support
- `WITH_READLINE` - Interactive readline
- `WITH_CURL` - HTTP support
- `WITH_XML2` - XML support

**Scientific Formats:**
- `FITS`, `NETCDF`, `SHP` - Scientific data formats

#### Example Development Build

```bash
mkdir build && cd build
cmake .. \
  -DCMAKE_INSTALL_PREFIX=$HOME/monetdb \
  -DCMAKE_BUILD_TYPE=Debug \
  -DASSERT=ON \
  -DSTRICT=ON \
  -DTESTING=ON \
  -DSANITIZER=OFF
cmake --build . -j$(nproc)
cmake --build . --target install
```

### Dependencies

**Required:**
- CMake 3.12+
- GCC or Clang (C99 support)
- Bison (parser generation)
- Python 3.5+ (build system, testing)
- pkg-config

**Recommended:**
- libbz2, liblz4, liblzma, zlib (compression)
- OpenSSL (TLS)
- PCRE2 (regex)
- Readline (interactive features)

**Optional:**
- Python 3 dev + NumPy (Python integration)
- R-base-dev (R integration)
- libgeos, libgdal, libproj (geospatial)
- ODBC libraries (ODBC driver)
- NetCDF, CFITSIO (scientific formats)
- Valgrind (debugging)
- cmocka (unit testing)

---

## Development Workflow

### Version Control

MonetDB uses Git with a Mercurial mirror. The repository is actively developed with multiple branches.

**Main Development Pattern:**
- Work on feature branches
- Merge into development branches (e.g., `Dec2025`, `Mar2025`)
- Regular merges between branches

**Commit Message Style:**
- Concise first line (imperative mood)
- Focus on "what" and "why", not "how"
- Reference bug/issue numbers when applicable

Examples from recent commits:
```
add projects around referenced sub relations let dce optimizer reduce the sub relations
fix q77 of tpcds
Merge with Dec2025 branch
```

### Contribution Guidelines

⚠️ **Important:** MonetDB does NOT accept GitHub Pull Requests.

**Contribution Process:**
1. Report bugs via GitHub Issues: https://github.com/MonetDB/MonetDB/issues
2. See developer guide: https://www.monetdb.org/documentation/dev-guide/
3. Use official contribution channels (Mercurial-based workflow)

**Code of Conduct:**
- Follows Contributor Covenant (see `CODE_OF_CONDUCT.md`)

---

## Coding Conventions

### EditorConfig Settings

MonetDB uses `.editorconfig` for consistent formatting:

#### C/C++ Files (`.c`, `.h`, `.y`)

```ini
indent_style = tab
tab_width = 4          # Except GDK/clients: 8
indent_size = tab
trim_trailing_whitespace = true
charset = utf-8
max_line_length = 120  # Except GDK/clients: 72
end_of_line = lf
insert_final_newline = true
```

**Exception:** `gdk/**`, `clients/mapilib/**`, `clients/odbc/**` use:
- `tab_width = 8`
- `max_line_length = 72`

#### Python Files (`.py`)

```ini
indent_style = space
indent_size = 4
trim_trailing_whitespace = true
charset = utf-8
```

#### CMake Files

```ini
indent_style = space
indent_size = 2
trim_trailing_whitespace = true
```

### C Code Style Conventions

#### Header Format

All C files must include the MPL-2.0 license header:

```c
/*
 * SPDX-License-Identifier: MPL-2.0
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0.  If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Copyright 2024, 2025 MonetDB Foundation;
 * Copyright August 2008 - 2023 MonetDB B.V.;
 * Copyright 1997 - July 2008 CWI.
 */
```

#### Include Order

```c
#include "monetdb_config.h"  // Always first
#include "module_header.h"   // Module's own header
#include <standard_headers>  // Standard C headers
#include "other_headers.h"   // Other project headers
```

#### Naming Conventions

- **Functions:** `lowercase_with_underscores` or `camelCase` (depends on module)
- **Types:** `typedef struct { ... } type_name;`
- **Macros:** `UPPERCASE_WITH_UNDERSCORES`
- **Constants:** `UPPERCASE_WITH_UNDERSCORES`

#### Code Structure Patterns

1. **Module Organization:**
   - Public API in `module.h`
   - Private implementation in `module.c`
   - Internal details in `module_private.h`

2. **Error Handling:**
   - Return `GDK_SUCCEED` or `GDK_FAIL` for status
   - Use `GDKerror()` for error messages
   - NULL returns for allocation failures

3. **Memory Management:**
   - Use `GDKmalloc()`, `GDKfree()` instead of stdlib
   - Reference counting for BATs
   - Explicit cleanup paths

### Comments and Documentation

- **File Headers:** Module purpose and overview
- **Function Comments:** Purpose, parameters, return values
- **Complex Logic:** Explain "why", not just "what"
- **TODO/FIXME:** Mark unfinished or problematic code

Example:
```c
/* stream
 * ======
 * Niels Nes
 * An simple interface to streams
 *
 * Processing files, streams, and sockets is quite different on Linux
 * and Windows platforms. To improve portability between both, we advise
 * to replace the stdio actions with the stream functionality provided
 * here.
 */
```

---

## Testing Infrastructure

### Test Framework: Mtest.py

MonetDB uses a Python-based testing framework called **Mtest.py**.

#### Test Organization

Tests are located in `Tests/` subdirectories throughout the codebase:
- `/gdk/Tests/` - GDK layer tests
- `/monetdb5/Tests/` - MAL tests
- `/sql/test/` - SQL tests (119 subdirectories!)

#### Test Types Supported

1. **SQL Tests** (`.sql` files)
   - SQL queries with expected output
   - Format: `.sql` + `.stable.out` + `.stable.err`

2. **MAL Tests** (`.mal`, `.malC` files)
   - MAL programs
   - `.malC` files are compiled MAL

3. **Python Tests** (`.py` files)
   - Custom Python test scripts

4. **Shell Scripts** (`.sh`, `.bat`)
   - Platform-specific shell tests

5. **SQLLogicTest** (`.test` files)
   - Standard SQL logic tests

#### Test Configuration Files

- **`All`** - Lists all tests to run in directory
- **`test.stable.out`** - Expected stdout
- **`test.stable.err`** - Expected stderr
- **`test.options5`** - MonetDB5 server options
- **`test.modules`** - Required modules
- **`test.reqtests`** - Test dependencies

#### Running Tests

```bash
# Build with testing enabled
cmake -DTESTING=ON ..
cmake --build .

# Run CTest
ctest

# Or use Mtest.py directly
cd sql/test/sometest
Mtest.py test_name
```

#### Test Naming Conventions

- Descriptive names indicating what is being tested
- BugTracker tests: `Bug-YYYY/Bug-NNNN.sql`
- Feature tests: descriptive names (e.g., `groupby_expr.sql`)

### SQL Test Example Structure

```
sql/test/example/
├── All                    # List of tests
├── test1.sql              # Test SQL
├── test1.stable.out       # Expected output
├── test1.stable.err       # Expected errors
├── test1.options5         # Server options (optional)
└── test2.sql
```

### Continuous Integration

GitHub Actions workflow (`.github/workflows/linux.yml`):

- **Platforms:** Ubuntu, macOS, Windows
- **Compilers:** GCC, Clang, MSVC
- **Schedule:** Nightly builds (1:15 AM UTC)
- **Triggers:** Push to branches, pull requests, manual dispatch

**CI Build Configuration:**
```yaml
cmake .. \
  -DCMAKE_INSTALL_PREFIX=$HOME/MDB \
  -DPY3INTEGRATION=OFF \
  -DRINTEGRATION=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DASSERT=OFF
```

---

## Query Execution Pipeline

Understanding the query execution pipeline is crucial for debugging and optimization work.

### 1. SQL Parsing (`sql/server/`)

**Entry Point:** `sql_parser.y` (Bison grammar)

**Flow:**
```
SQL Text → Lexer/Parser → Parse Tree → Symbol Table
```

**Key Files:**
- `sql_parser.y` - Grammar definition
- `sql_symbol.c` - Symbol table management
- `sql_tokens.h` - Token definitions

### 2. Semantic Analysis (`sql/server/`)

**Entry Point:** `sql_semantic.c`

**Flow:**
```
Parse Tree → Type Checking → Name Resolution → Semantic Tree
```

**Functions:**
- Type validation
- Name resolution (tables, columns, functions)
- Constraint checking
- Privilege verification

### 3. Relational Algebra Generation (`sql/server/rel_*.c`)

**Entry Point:** `rel_select.c`, `rel_updates.c`, etc.

**Flow:**
```
Semantic Tree → Relational Operators → Relational Algebra Tree
```

**Key Operators:**
- `rel_project` - Projection
- `rel_select` - Selection/Filter
- `rel_join` - Join operations
- `rel_groupby` - Grouping and aggregation
- `rel_ddl` - DDL operations

**Key Files:**
- `rel_exp.c` - Expression nodes
- `rel_rel.c` - Relation nodes
- `rel_select.c` - SELECT processing
- `rel_updates.c` - DML operations

### 4. SQL-Level Optimization (`sql/server/rel_optimize_*.c`)

**Entry Point:** `rel_optimizer.c`

**Optimizations:**
- Predicate push-down
- Projection push-down
- Join reordering
- Subquery unnesting (`rel_unnest.c`)
- Dead code elimination
- Constant folding
- Expression simplification

**Key Files:**
- `rel_optimizer.c` - Main optimizer driver
- `rel_optimize_*.c` - Individual passes
- `rel_statistics.c` - Statistics for cost estimation
- `rel_prop.c` - Property tracking

### 5. Code Generation (`sql/backends/monet5/`)

**Entry Point:** `generator/` directory

**Flow:**
```
Optimized Relational Algebra → MAL Code Generator → MAL Program
```

**Process:**
- Traverse relational algebra tree
- Generate MAL instructions for each operator
- Create MAL function
- Register function in MAL catalog

**Key Concepts:**
- Each SQL statement becomes a MAL function
- Nested queries → nested MAL function calls
- SQL functions compiled separately

### 6. MAL Optimization (`monetdb5/optimizer/`)

**Entry Point:** `optimizer.c`, `opt_pipes.c`

**Pipeline:** Series of optimization passes

**Key Optimizations:**
- `opt_pushselect.c` - Further filter push-down
- `opt_candidates.c` - Candidate list optimization
- `opt_multiplex.c` - Vectorization
- `opt_projectionpath.c` - Projection path optimization
- `opt_mergetable.c` - Merge table handling
- `opt_commonTerms.c` - Common subexpression elimination
- `opt_deadcode.c` - Dead code elimination
- `opt_reorder.c` - Instruction reordering

**Configuration:**
- Optimization pipelines defined in `opt_pipes.c`
- Different pipelines for different scenarios
- Can be controlled with `SET OPTIMIZER` statement

### 7. MAL Execution (`monetdb5/mal/`)

**Entry Point:** `mal_interpreter.c`

**Flow:**
```
MAL Program → Instruction Dispatch → Module Functions → Results
```

**Execution Modes:**
- **Sequential:** Instruction-by-instruction
- **Dataflow:** Parallel execution using dependency graph (`mal_dataflow.c`)

**Key Files:**
- `mal_interpreter.c` - Instruction interpreter
- `mal_dataflow.c` - Dataflow scheduler
- `mal_runtime.c` - Runtime support

### 8. GDK Operations (`gdk/`)

**Entry Point:** Various `gdk_*.c` files

**Operations:**
- `gdk_select.c` - Filter BATs
- `gdk_join.c` - Join BATs
- `gdk_group.c` - Group BATs
- `gdk_aggr.c` - Aggregate BATs
- `gdk_sort.c` - Sort BATs
- `gdk_project.c` - Project BATs

**Pattern:**
```c
BAT* operation(BAT *input1, BAT *input2, ..., parameters)
{
    // Allocate result BAT
    // Iterate over input(s)
    // Compute results
    // Return result BAT
}
```

---

## Key Data Structures

### BAT (Binary Association Table)

**Location:** `gdk/gdk.h`, `gdk/gdk_bat.c`

The fundamental data structure in MonetDB. A BAT is a two-column table:
- **Head** (historically used, now often virtual OID sequence)
- **Tail** (actual data values)

**Structure (simplified):**
```c
typedef struct {
    oid hseqbase;          // Head sequence base (OID)
    Heap *theap;           // Tail heap (data storage)
    Heap *tvheap;          // Variable-size data (strings, etc.)
    BUN count;             // Number of tuples
    int batCacheid;        // Buffer pool identifier
    str ttype;             // Tail type
    // ... many more fields
} BAT;
```

**Key Operations:**
- `COLnew()` - Create new BAT
- `BATdescriptor()` - Get BAT from buffer pool
- `BBPincref()` / `BBPdecref()` - Reference counting
- `BATcount()` - Get tuple count

### Relational Algebra Node

**Location:** `sql/include/sql_relation.h`

Represents a node in the relational algebra tree.

**Types:**
- `op_basetable` - Base table scan
- `op_project` - Projection
- `op_select` - Selection/filtering
- `op_join` - Join (inner, left, right, full)
- `op_groupby` - Grouping and aggregation
- `op_union`, `op_inter`, `op_except` - Set operations
- `op_ddl` - DDL operations
- `op_insert`, `op_update`, `op_delete` - DML operations

### SQL Expression

**Location:** `sql/include/sql_relation.h`, `sql/server/rel_exp.c`

Represents expressions in SQL queries.

**Types:**
- Column references
- Constants
- Function calls
- Aggregations
- Arithmetic/comparison operations
- Subqueries

### MAL Instruction

**Location:** `monetdb5/mal/mal_instruction.h`

Represents a single MAL instruction.

**Structure:**
```c
typedef struct {
    char *fcnname;         // Function name
    int argc, retc;        // Argument count, return count
    int *argv;             // Argument indices
    // ... more fields
} InstrRecord, *InstrPtr;
```

### SQL Catalog

**Location:** `sql/include/sql_catalog.h`

In-memory representation of database metadata.

**Key Structures:**
- `sql_schema` - Database schema
- `sql_table` - Table definition
- `sql_column` - Column definition
- `sql_key` - Primary/foreign keys
- `sql_idx` - Indexes
- `sql_func` - Functions/procedures

---

## Common Development Tasks

### Adding a New Optimizer

**Location:** `monetdb5/optimizer/` or `sql/server/`

1. Create `opt_myoptimizer.c` and `opt_myoptimizer.h`
2. Implement optimization logic
3. Add to optimizer pipeline in `opt_pipes.c`
4. Add to CMakeLists.txt
5. Write tests in `Tests/`

**Template available:** `monetdb5/extras/mal_optimizer_template/`

### Adding a New SQL Function

**Process:**

1. **SQL-level function:**
   - Add to system catalog initialization
   - Implement in SQL or as MAL function

2. **MAL-level function:**
   - Add to appropriate module in `monetdb5/modules/`
   - Update module initialization

3. **GDK-level function:**
   - Implement in appropriate `gdk_*.c` file
   - Export in header file
   - Create MAL wrapper in modules

**Example locations:**
- Math functions: `monetdb5/modules/kernel/mmath.c`
- String functions: `gdk/gdk_string.c`, `monetdb5/modules/kernel/batstr.c`
- Aggregates: `gdk/gdk_aggr.c`, `monetdb5/modules/kernel/aggr.c`

### Adding a New Data Type

**Steps:**

1. **GDK Level** (`gdk/gdk_atoms.c`):
   - Define atom type
   - Implement tostr, fromstr, hash, cmp functions
   - Register with `BATatoms[]`

2. **SQL Level** (`sql/server/sql_types.c`):
   - Add SQL type mapping
   - Define casts and operations

3. **MAL Level**:
   - Add type to MAL type system
   - Implement operations as MAL functions

### Debugging a Query

**Approach:**

1. **Enable query logging:**
   ```sql
   SET optimizer = 'sequential_pipe';  -- Simpler pipeline
   ```

2. **View MAL plan:**
   ```sql
   EXPLAIN <query>;
   ```

3. **Examine relational algebra:**
   - Set breakpoint in `rel_optimizer.c`
   - Print tree with debug functions

4. **Trace execution:**
   - Use GDB with MonetDB server
   - Set breakpoints in relevant GDK functions
   - Monitor BAT operations

5. **Check logs:**
   - Server logs in `$dbfarm/database/log`
   - Use `--set mapi_debug=1` for protocol debugging

### Fixing a Performance Issue

**Process:**

1. **Profile the query:**
   ```sql
   CALL sys.querylog_enable();
   <run query>
   SELECT * FROM sys.querylog_history;
   ```

2. **Analyze execution plan:**
   - Check for missing indexes
   - Look for suboptimal join orders
   - Identify missing statistics

3. **Check optimizer decisions:**
   - Add debug output to optimizer passes
   - Verify cost estimates

4. **Investigate GDK operations:**
   - Profile with `perf` or `valgrind --tool=callgrind`
   - Identify hot spots in GDK operations

5. **Consider optimizations:**
   - Add new optimizer pass
   - Improve algorithm in GDK
   - Add specialized operator

---

## Important File Locations

### Configuration Files

| File | Purpose |
|------|---------|
| `monetdb_config.h.in` | Build configuration template |
| `.editorconfig` | Code formatting rules |
| `CMakeLists.txt` | Root build configuration |
| `MonetDB.spec` | RPM package specification |
| `.github/workflows/linux.yml` | CI/CD configuration |

### Key Headers

| Header | Description | Lines |
|--------|-------------|-------|
| `gdk/gdk.h` | Complete GDK API | ~60KB |
| `monetdb5/mal/mal.h` | MAL system interface | ~8KB |
| `monetdb5/mal/mal_instruction.h` | MAL instruction format | ~9KB |
| `monetdb5/mal/mal_client.h` | Client management | - |
| `sql/include/sql_catalog.h` | SQL metadata structures | - |
| `sql/include/sql_relation.h` | Relational algebra | - |
| `sql/include/sql_list.h` | List utilities | - |

### Core Implementation Files

| File | Purpose | Size |
|------|---------|------|
| `gdk/gdk_join.c` | Join algorithms | 157KB |
| `gdk/gdk_aggr.c` | Aggregation functions | 128KB |
| `gdk/gdk_string.c` | String operations | 523KB |
| `gdk/gdk_logger.c` | Transaction logging | 104KB |
| `sql/server/sql_semantic.c` | Semantic analysis | 1237 lines |
| `monetdb5/mal/mal_interpreter.c` | MAL execution | - |

### Documentation

| File | Content |
|------|---------|
| `README.rst` | Build and install instructions |
| `design.txt` | Internal design notes |
| `documentation/` | Sphinx documentation |
| `CODE_OF_CONDUCT.md` | Contributor guidelines |

---

## Git Workflow

### Current Branch

When working on MonetDB, AI assistants should:

1. **Check current branch:**
   ```bash
   git branch
   ```

2. **Work on designated feature branches:**
   - Branch naming: descriptive names
   - Claude branches: `claude/claude-md-*` pattern

3. **Commit practices:**
   - Clear, concise commit messages
   - Atomic commits (one logical change per commit)
   - Reference issues/bugs when applicable

4. **Merging:**
   - Regular merges from main development branches
   - Resolve conflicts carefully
   - Test after merging

### Branch Structure

- Development branches: `Dec2025`, `Mar2025`, etc. (release-oriented)
- Feature branches: topic-specific development
- Remote tracking: `origin/branch-name`

### Common Git Commands

```bash
# Check status
git status

# View recent commits
git log --oneline --graph -20

# Create feature branch
git checkout -b feature/description

# Commit changes
git add <files>
git commit -m "description"

# Push to remote
git push -u origin branch-name

# Merge from main branch
git merge Dec2025

# View diff
git diff
git diff --staged
```

---

## Resources

### Official Documentation

- **Website:** https://www.monetdb.org/
- **Documentation:** https://www.monetdb.org/documentation/
- **Developer Guide:** https://www.monetdb.org/documentation/dev-guide/
- **ReadTheDocs:** https://www.monetdb.org/documentation/ (Sphinx-based)

### Source Code

- **Mercurial (primary):** https://dev.monetdb.org/hg/MonetDB/
- **GitHub (mirror):** https://github.com/MonetDB/MonetDB
  - Updated hourly
  - Issue tracker active
  - Pull requests NOT accepted

### Community

- **Bug Reports:** https://github.com/MonetDB/MonetDB/issues
- **Mailing Lists:** See website for details
- **Code of Conduct:** `CODE_OF_CONDUCT.md` (Contributor Covenant)

### Academic Papers

MonetDB has extensive academic research behind it. Key topics:
- Column-store architecture
- Vectorized execution
- MonetDB/X100 (vectorization)
- Query optimization techniques

### Related Projects

- **MonetDB Solutions:** https://www.monetdbsolutions.com
- **CWI Database Architectures:** https://www.cwi.nl/research/groups/database-architectures

---

## Tips for AI Assistants

### Understanding Code Flow

1. **Start with SQL layer** (`sql/server/`) to understand query processing
2. **Follow to MAL layer** (`monetdb5/`) for execution plans
3. **Dive into GDK** (`gdk/`) for actual computations

### Navigating Large Files

- Use function-level understanding before diving into implementation
- Check header files first for API contracts
- Look for comments explaining algorithms

### Testing Changes

1. Always build with `ASSERT=ON` during development
2. Run relevant tests in `Tests/` directories
3. Use `SANITIZER=ON` for memory checking
4. Write new tests for new features

### Performance Considerations

- MonetDB is column-oriented: think in terms of BAT operations
- Vectorization is key: process entire columns, not rows
- Memory management matters: BATs can be large
- Avoid unnecessary copies: use views when possible

### Common Pitfalls

- **Reference Counting:** Always match `BBPincref()` with `BBPdecref()`
- **Memory Leaks:** Use `GDKfree()` for `GDKmalloc()` allocations
- **BAT Consistency:** Maintain sorted/hashed properties
- **Type Safety:** Verify type compatibility in operations
- **Error Handling:** Check return values, use `GDKerror()` properly

### When in Doubt

1. Search for similar existing code
2. Check test files for usage examples
3. Read module headers for API documentation
4. Look at recent commits for patterns
5. Consult `design.txt` for architectural notes

---

## Version Information

**Document Version:** 1.0
**MonetDB Version:** Tracked via `cmake/monetdb-versions.cmake`
**Last Updated:** 2025-11-16
**Maintained by:** AI Assistant Community Guidelines

---

## License

This document follows the same license as MonetDB:

**SPDX-License-Identifier: MPL-2.0**

This documentation is provided under the Mozilla Public License 2.0.
Copyright 2025 MonetDB Community Documentation Contributors.

---

*This CLAUDE.md file is intended to help AI assistants understand and work with the MonetDB codebase effectively. It should be updated as the codebase evolves.*

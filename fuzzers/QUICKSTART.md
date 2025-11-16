# MonetDB Fuzzing Quick Start Guide

## 🚀 Get Started in 5 Minutes

This guide will help you run MonetDB fuzzers locally in under 5 minutes.

---

## Prerequisites

Install Clang compiler (includes libFuzzer):

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install clang cmake build-essential

# macOS
brew install llvm cmake

# Fedora/RHEL
sudo dnf install clang cmake
```

---

## Step 1: Build MonetDB with Fuzzing Enabled

```bash
cd /path/to/MonetDB

# Create fuzzing build directory
mkdir build-fuzzing
cd build-fuzzing

# Configure with fuzzing enabled
cmake .. \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_BUILD_TYPE=Debug \
  -DBUILD_FUZZERS=ON \
  -DASSERT=ON \
  -DTESTING=OFF

# Build (this takes 5-10 minutes)
cmake --build . -j$(nproc)
```

---

## Step 2: Run Your First Fuzzer

```bash
# Navigate to fuzzer directory
cd fuzzers

# Run MonetDBe fuzzer for 60 seconds
./fuzz_monetdbe -max_total_time=60

# You should see output like:
# INFO: Running with entropic power schedule (0xFF, 100).
# INFO: Seed: 1234567890
# INFO: -max_len is not provided; libFuzzer will not generate inputs larger than 4096 bytes
# #1	pulse  cov: 123 ft: 456 corp: 1/1b exec/s: 0 rss: 45Mb
# #8	NEW    cov: 234 ft: 567 corp: 2/5b lim: 4 exec/s: 0 rss: 46Mb L: 4/4 MS: 1 InsertByte-
# ...
```

**What this output means**:
- `cov: 234` - Code coverage (higher is better)
- `corp: 2/5b` - Corpus has 2 inputs, 5 bytes total
- `exec/s: 1234` - Executions per second (speed)
- `NEW` - Found new interesting input

---

## Step 3: Run All Fuzzers

```bash
# Type conversion fuzzer
./fuzz_type_conversion -max_total_time=60

# CSV parser fuzzer
./fuzz_csv_parser -max_total_time=60
```

---

## Step 4: Use Seed Corpus (Optional)

```bash
# Run with SQL seed corpus
./fuzz_monetdbe ../fuzzers/seeds/sql/

# Run with number seeds
./fuzz_type_conversion ../fuzzers/seeds/numbers/
```

---

## 🐛 If a Crash is Found

When a fuzzer finds a bug, it will:
1. Print a stack trace
2. Save the crashing input to a file (e.g., `crash-abcd1234`)

**Reproduce the crash**:
```bash
# Run fuzzer with crash file
./fuzz_monetdbe crash-abcd1234

# Debug with GDB
gdb --args ./fuzz_monetdbe crash-abcd1234
(gdb) run
(gdb) bt  # Get backtrace
```

**Report the bug**:
- File an issue at: https://github.com/MonetDB/MonetDB/issues
- Include: crash file, stack trace, MonetDB version

---

## 🔧 Common Options

### Time Limits
```bash
# Run for 5 minutes
./fuzz_monetdbe -max_total_time=300

# Run indefinitely (Ctrl+C to stop)
./fuzz_monetdbe
```

### Memory Limits
```bash
# Limit to 2GB RAM
./fuzz_monetdbe -rss_limit_mb=2048
```

### Parallel Fuzzing
```bash
# Run with 4 parallel workers
./fuzz_monetdbe -jobs=4 -workers=4
```

### Corpus Management
```bash
# Save interesting inputs to corpus directory
mkdir corpus
./fuzz_monetdbe -max_total_time=300 corpus/

# Later runs will use these inputs
./fuzz_monetdbe corpus/
```

---

## 📊 Interpreting Results

### Good Signs
- ✅ High executions/second (>1000/sec)
- ✅ Coverage increasing over time
- ✅ No crashes found

### Warning Signs
- ⚠️ Low exec/s (<100/sec) - fuzzer is too slow
- ⚠️ Coverage plateau - might need better seeds
- ⚠️ Memory growing continuously - memory leak

### Crash Found!
- 🐛 Review stack trace
- 🐛 Minimize input if possible
- 🐛 Report to MonetDB team

---

## 🎯 Next Steps

1. **Run longer**: `./fuzz_monetdbe -max_total_time=3600` (1 hour)
2. **Try all fuzzers**: Each targets different code paths
3. **Add more seeds**: Copy SQL tests to `seeds/sql/`
4. **Enable more sanitizers**: Try `-fsanitize=memory,undefined`
5. **Integrate with CI**: Add fuzzing to GitHub Actions

---

## 💡 Pro Tips

### Tip 1: Combine Multiple Seed Directories
```bash
./fuzz_monetdbe seeds/sql/ -merge=1 combined_corpus/
```

### Tip 2: Reproduce Flaky Bugs
```bash
# Set fixed seed for determinism
./fuzz_monetdbe -seed=12345 crash-file
```

### Tip 3: Focus on New Code
```bash
# Only fuzz specific SQL features
echo "WITH cte AS (SELECT 1) SELECT * FROM cte" > seeds/sql/cte.sql
./fuzz_monetdbe seeds/sql/
```

### Tip 4: Minimize Crash Input
```bash
# Reduce crash file to smallest reproducer
./fuzz_monetdbe -minimize_crash=1 -exact_artifact_path=minimized crash-abcd1234
```

---

## 🆘 Troubleshooting

### "Command not found: ./fuzz_monetdbe"

Build wasn't successful. Check:
```bash
# Verify clang is installed
clang --version

# Rebuild with verbose output
cmake --build . -j$(nproc) -- VERBOSE=1
```

### "rss_limit_mb exceeded"

Fuzzer hit memory limit. Increase:
```bash
./fuzz_monetdbe -rss_limit_mb=4096
```

### "Slow unit" warnings

Some inputs are slow. Add timeout:
```bash
./fuzz_monetdbe -timeout=1  # 1 second per input
```

### No coverage increase

Need better seeds:
```bash
# Copy complex queries from tests
find ../sql/test -name "*.sql" -exec cp {} seeds/sql/ \;
```

---

## 📞 Get Help

- **OSS-Fuzz Docs**: https://google.github.io/oss-fuzz/
- **libFuzzer Docs**: https://llvm.org/docs/LibFuzzer.html
- **MonetDB Issues**: https://github.com/MonetDB/MonetDB/issues

---

**Ready to find bugs? Start fuzzing! 🚀**

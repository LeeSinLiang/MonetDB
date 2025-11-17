unsigned char _46_profiler_sql[25] = {
"create schema profiler;\n"
};
#include "monetdb_config.h"
#include "sql_import.h"
#ifdef _MSC_VER
#undef read
#pragma section(".CRT$XCU",read)
#endif
LIB_STARTUP_FUNC(init_46_profiler_sql)
{ sql_register("46_profiler", _46_profiler_sql); }

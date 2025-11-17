unsigned char _77_storage_sql[246] = {
"CREATE FUNCTION sys.persist_unlogged(sname STRING, tname STRING)\n"
"RETURNS TABLE(\n"
"	\"table\" STRING,\n"
"	\"table_id\" INT,\n"
"	\"rowcount\" BIGINT\n"
")\n"
"EXTERNAL NAME sql.persist_unlogged;\n"
"GRANT EXECUTE ON FUNCTION sys.persist_unlogged(string, string) TO PUBLIC;\n"
};
#include "monetdb_config.h"
#include "sql_import.h"
#ifdef _MSC_VER
#undef read
#pragma section(".CRT$XCU",read)
#endif
LIB_STARTUP_FUNC(init_77_storage_sql)
{ sql_register("77_storage", _77_storage_sql); }

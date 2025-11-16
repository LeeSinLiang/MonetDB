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

/*
 * OSS-Fuzz harness for MonetDBe embedded API
 *
 * This fuzzer targets the MonetDBe query execution API, which is the
 * primary entry point for SQL query processing. It exercises:
 * - SQL parser (sql_parser.y)
 * - Semantic analyzer (sql_semantic.c)
 * - Query optimizer (rel_optimizer.c)
 * - MAL code generation
 * - MAL execution engine
 * - GDK operations
 *
 * This provides the highest code coverage of any single fuzzing target.
 */

#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

#include "monetdbe.h"

/* Global database handle to avoid repeated initialization overhead */
static monetdbe_database db = NULL;
static int db_initialized = 0;

/* Initialize database once per fuzzing session */
static int init_database(void) {
	monetdbe_options opts = {0};

	/* Configure for fuzzing:
	 * - Limit memory usage to prevent OOM
	 * - Set query timeout to prevent hangs
	 * - Disable unnecessary features
	 */
	opts.memorylimit = 512;  /* 512 MB memory limit */
	opts.querytimeout = 5;   /* 5 second timeout */
	opts.sessiontimeout = 10;
	opts.nr_threads = 1;     /* Single-threaded for reproducibility */

	if (monetdbe_open(&db, ":memory:", &opts) != 0) {
		return -1;
	}

	db_initialized = 1;
	return 0;
}

/* Cleanup database (called by atexit or explicitly) */
static void cleanup_database(void) {
	if (db_initialized && db) {
		monetdbe_close(db);
		db = NULL;
		db_initialized = 0;
	}
}

/* Main fuzzing entry point called by libFuzzer */
int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
	monetdbe_result *result = NULL;
	monetdbe_cnt affected_rows = 0;
	char *query = NULL;
	char *error = NULL;

	/* Input validation */
	if (size == 0 || size > 100000) {
		return 0;  /* Skip empty or excessively large inputs */
	}

	/* Initialize database on first run */
	if (!db_initialized) {
		if (init_database() != 0) {
			return 0;
		}
		atexit(cleanup_database);
	}

	/* Ensure null-terminated string for SQL query */
	query = (char *)malloc(size + 1);
	if (!query) {
		return 0;
	}
	memcpy(query, data, size);
	query[size] = '\0';

	/* Execute the query - this is the main fuzzing target */
	error = monetdbe_query(db, query, &result, &affected_rows);

	/* Cleanup result if query succeeded */
	if (result) {
		monetdbe_cleanup_result(db, result);
	}

	/* Free error string if returned */
	if (error) {
		/* In MonetDBe, errors are returned as strings that need to be freed */
		free(error);
	}

	free(query);

	return 0;
}

/* Optional: Initialize once at startup (alternative to lazy init) */
int LLVMFuzzerInitialize(int *argc, char ***argv) {
	(void)argc;
	(void)argv;

	/* Could initialize database here instead of lazily */
	return 0;
}

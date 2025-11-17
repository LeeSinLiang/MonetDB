/*
 * SPDX-License-Identifier: MPL-2.0
 *
 * Standalone version of MonetDBe fuzzer for testing without libFuzzer
 * This version reads input from files or stdin instead of using libFuzzer
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "monetdbe.h"

static monetdbe_database db = NULL;

static int init_database(void) {
	monetdbe_options opts = {0};
	opts.memorylimit = 512;
	opts.querytimeout = 5;
	opts.sessiontimeout = 10;
	opts.nr_threads = 1;

	if (monetdbe_open(&db, ":memory:", &opts) != 0) {
		return -1;
	}
	return 0;
}

static void cleanup_database(void) {
	if (db) {
		monetdbe_close(db);
		db = NULL;
	}
}

int main(int argc, char **argv) {
	FILE *fp = stdin;
	char *query = NULL;
	size_t query_size = 0;
	size_t bytes_read;

	/* Open file if provided */
	if (argc > 1) {
		fp = fopen(argv[1], "rb");
		if (!fp) {
			fprintf(stderr, "Failed to open %s\n", argv[1]);
			return 1;
		}
	}

	/* Read entire input */
	if (fp != stdin) {
		fseek(fp, 0, SEEK_END);
		query_size = ftell(fp);
		fseek(fp, 0, SEEK_SET);

		if (query_size == 0 || query_size > 100000) {
			fprintf(stderr, "Invalid input size: %zu\n", query_size);
			fclose(fp);
			return 1;
		}

		query = malloc(query_size + 1);
		if (!query) {
			fprintf(stderr, "Failed to allocate memory\n");
			fclose(fp);
			return 1;
		}

		bytes_read = fread(query, 1, query_size, fp);
		query[bytes_read] = '\0';
	} else {
		/* Read from stdin */
		size_t capacity = 4096;
		query = malloc(capacity);
		if (!query) {
			fprintf(stderr, "Failed to allocate memory\n");
			return 1;
		}

		query_size = 0;
		while (1) {
			if (query_size + 1024 > capacity) {
				capacity *= 2;
				char *new_query = realloc(query, capacity);
				if (!new_query) {
					free(query);
					fprintf(stderr, "Failed to reallocate memory\n");
					return 1;
				}
				query = new_query;
			}

			bytes_read = fread(query + query_size, 1, 1024, fp);
			if (bytes_read == 0) break;
			query_size += bytes_read;

			if (query_size > 100000) {
				fprintf(stderr, "Input too large\n");
				free(query);
				return 1;
			}
		}
		query[query_size] = '\0';
	}

	if (fp != stdin) {
		fclose(fp);
	}

	/* Initialize database */
	if (init_database() != 0) {
		fprintf(stderr, "Failed to initialize database\n");
		free(query);
		return 1;
	}

	/* Execute query */
	monetdbe_result *result = NULL;
	monetdbe_cnt affected_rows = 0;
	char *error = monetdbe_query(db, query, &result, &affected_rows);

	if (error) {
		printf("Query error: %s\n", error);
		free(error);
	} else {
		printf("Query executed successfully\n");
		if (result) {
			printf("Result: %zu columns, %lld rows\n", result->ncols, (long long)result->nrows);
			monetdbe_cleanup_result(db, result);
		}
	}

	/* Cleanup */
	free(query);
	cleanup_database();

	return 0;
}

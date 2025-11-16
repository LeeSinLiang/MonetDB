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
 * OSS-Fuzz harness for type conversion functions
 *
 * This fuzzer targets string-to-type conversion functions in gdk_atoms.c.
 * These functions parse untrusted string input and convert to typed values:
 * - Integer parsing (bte, sht, int, lng, hge)
 * - Floating point parsing (flt, dbl)
 * - Pointer parsing (DANGEROUS)
 * - String parsing
 * - Boolean parsing
 *
 * These are critical security boundaries where input validation must be perfect.
 */

#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

#include "monetdb_config.h"
#include "gdk.h"

/* Initialize GDK once */
static int gdk_initialized = 0;

static int init_gdk(void) {
	if (gdk_initialized) {
		return 0;
	}

	/* Initialize GDK with minimal configuration */
	if (GDKinit(NULL, 0, 1, NULL, 0) != GDK_SUCCEED) {
		return -1;
	}

	gdk_initialized = 1;
	return 0;
}

static void cleanup_gdk(void) {
	if (gdk_initialized) {
		GDKexit();
		gdk_initialized = 0;
	}
}

int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
	char *str = NULL;
	size_t len;
	ssize_t result;

	/* Input validation */
	if (size == 0 || size > 10000) {
		return 0;
	}

	/* Initialize GDK on first run */
	if (!gdk_initialized) {
		if (init_gdk() != 0) {
			return 0;
		}
		atexit(cleanup_gdk);
	}

	/* Create null-terminated string */
	str = (char *)malloc(size + 1);
	if (!str) {
		return 0;
	}
	memcpy(str, data, size);
	str[size] = '\0';

	/* Test all numeric type parsers */
	{
		bte *bte_val = NULL;
		len = size;
		result = bteFromStr(NULL, str, &len, &bte_val, false);
		if (result > 0 && bte_val) {
			GDKfree(bte_val);
		}
	}

	{
		sht *sht_val = NULL;
		len = size;
		result = shtFromStr(NULL, str, &len, &sht_val, false);
		if (result > 0 && sht_val) {
			GDKfree(sht_val);
		}
	}

	{
		int *int_val = NULL;
		len = size;
		result = intFromStr(NULL, str, &len, &int_val, false);
		if (result > 0 && int_val) {
			GDKfree(int_val);
		}
	}

	{
		lng *lng_val = NULL;
		len = size;
		result = lngFromStr(NULL, str, &len, &lng_val, false);
		if (result > 0 && lng_val) {
			GDKfree(lng_val);
		}
	}

#ifdef HAVE_HGE
	{
		hge *hge_val = NULL;
		len = size;
		result = hgeFromStr(NULL, str, &len, &hge_val, false);
		if (result > 0 && hge_val) {
			GDKfree(hge_val);
		}
	}
#endif

	{
		flt *flt_val = NULL;
		len = size;
		result = fltFromStr(NULL, str, &len, &flt_val, false);
		if (result > 0 && flt_val) {
			GDKfree(flt_val);
		}
	}

	{
		dbl *dbl_val = NULL;
		len = size;
		result = dblFromStr(NULL, str, &len, &dbl_val, false);
		if (result > 0 && dbl_val) {
			GDKfree(dbl_val);
		}
	}

	{
		bit *bit_val = NULL;
		len = size;
		result = bitFromStr(NULL, str, &len, &bit_val, false);
		if (result > 0 && bit_val) {
			GDKfree(bit_val);
		}
	}

	/* Test string parser (handles escaping, quotes, etc.) */
	{
		str *str_val = NULL;
		len = size;
		result = strFromStr(NULL, str, &len, &str_val, false);
		if (result > 0 && str_val) {
			GDKfree(str_val);
		}
	}

	/* Note: We intentionally do NOT test ptrFromStr() as it's too dangerous
	 * to fuzz arbitrary pointer values */

	free(str);

	return 0;
}

int LLVMFuzzerInitialize(int *argc, char ***argv) {
	(void)argc;
	(void)argv;
	return 0;
}

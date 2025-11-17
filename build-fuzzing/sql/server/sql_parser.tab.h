/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_SQL_HOME_USER_MONETDB_BUILD_FUZZING_SQL_SERVER_SQL_PARSER_TAB_H_INCLUDED
# define YY_SQL_HOME_USER_MONETDB_BUILD_FUZZING_SQL_SERVER_SQL_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int sqldebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    STRING = 258,                  /* STRING  */
    XSTRING = 259,                 /* XSTRING  */
    IDENT = 260,                   /* IDENT  */
    aTYPE = 261,                   /* aTYPE  */
    RANK = 262,                    /* RANK  */
    MARGFUNC = 263,                /* MARGFUNC  */
    sqlINT = 264,                  /* sqlINT  */
    OIDNUM = 265,                  /* OIDNUM  */
    HEXADECIMALNUM = 266,          /* HEXADECIMALNUM  */
    OCTALNUM = 267,                /* OCTALNUM  */
    BINARYNUM = 268,               /* BINARYNUM  */
    INTNUM = 269,                  /* INTNUM  */
    APPROXNUM = 270,               /* APPROXNUM  */
    USING = 271,                   /* USING  */
    GLOBAL = 272,                  /* GLOBAL  */
    CAST = 273,                    /* CAST  */
    CONVERT = 274,                 /* CONVERT  */
    CHARACTER = 275,               /* CHARACTER  */
    VARYING = 276,                 /* VARYING  */
    LARGE = 277,                   /* LARGE  */
    OBJECT = 278,                  /* OBJECT  */
    VARCHAR = 279,                 /* VARCHAR  */
    CLOB = 280,                    /* CLOB  */
    sqlTEXT = 281,                 /* sqlTEXT  */
    BINARY = 282,                  /* BINARY  */
    sqlBLOB = 283,                 /* sqlBLOB  */
    sqlDECIMAL = 284,              /* sqlDECIMAL  */
    sqlFLOAT = 285,                /* sqlFLOAT  */
    TINYINT = 286,                 /* TINYINT  */
    SMALLINT = 287,                /* SMALLINT  */
    BIGINT = 288,                  /* BIGINT  */
    HUGEINT = 289,                 /* HUGEINT  */
    sqlINTEGER = 290,              /* sqlINTEGER  */
    sqlDOUBLE = 291,               /* sqlDOUBLE  */
    sqlREAL = 292,                 /* sqlREAL  */
    PRECISION = 293,               /* PRECISION  */
    PARTIAL = 294,                 /* PARTIAL  */
    SIMPLE = 295,                  /* SIMPLE  */
    ACTION = 296,                  /* ACTION  */
    CASCADE = 297,                 /* CASCADE  */
    RESTRICT = 298,                /* RESTRICT  */
    sqlBOOL = 299,                 /* sqlBOOL  */
    BOOL_FALSE = 300,              /* BOOL_FALSE  */
    BOOL_TRUE = 301,               /* BOOL_TRUE  */
    CURRENT_DATE = 302,            /* CURRENT_DATE  */
    CURRENT_TIMESTAMP = 303,       /* CURRENT_TIMESTAMP  */
    CURRENT_TIME = 304,            /* CURRENT_TIME  */
    LOCALTIMESTAMP = 305,          /* LOCALTIMESTAMP  */
    LOCALTIME = 306,               /* LOCALTIME  */
    BIG = 307,                     /* BIG  */
    LITTLE = 308,                  /* LITTLE  */
    NATIVE = 309,                  /* NATIVE  */
    ENDIAN = 310,                  /* ENDIAN  */
    LEX_ERROR = 311,               /* LEX_ERROR  */
    GEOMETRY = 312,                /* GEOMETRY  */
    GEOMETRYSUBTYPE = 313,         /* GEOMETRYSUBTYPE  */
    ALL = 314,                     /* ALL  */
    ANY = 315,                     /* ANY  */
    SOME = 316,                    /* SOME  */
    DATA = 317,                    /* DATA  */
    USER = 318,                    /* USER  */
    CURRENT_USER = 319,            /* CURRENT_USER  */
    SESSION_USER = 320,            /* SESSION_USER  */
    LOCAL = 321,                   /* LOCAL  */
    BEST = 322,                    /* BEST  */
    EFFORT = 323,                  /* EFFORT  */
    CURRENT_ROLE = 324,            /* CURRENT_ROLE  */
    sqlSESSION = 325,              /* sqlSESSION  */
    CURRENT_SCHEMA = 326,          /* CURRENT_SCHEMA  */
    CURRENT_TIMEZONE = 327,        /* CURRENT_TIMEZONE  */
    sqlDELETE = 328,               /* sqlDELETE  */
    UPDATE = 329,                  /* UPDATE  */
    SELECT = 330,                  /* SELECT  */
    INSERT = 331,                  /* INSERT  */
    MATCHED = 332,                 /* MATCHED  */
    LOGIN = 333,                   /* LOGIN  */
    LATERAL = 334,                 /* LATERAL  */
    LEFT = 335,                    /* LEFT  */
    RIGHT = 336,                   /* RIGHT  */
    FULL = 337,                    /* FULL  */
    OUTER = 338,                   /* OUTER  */
    NATURAL = 339,                 /* NATURAL  */
    CROSS = 340,                   /* CROSS  */
    JOIN = 341,                    /* JOIN  */
    INNER = 342,                   /* INNER  */
    COMMIT = 343,                  /* COMMIT  */
    ROLLBACK = 344,                /* ROLLBACK  */
    SAVEPOINT = 345,               /* SAVEPOINT  */
    RELEASE = 346,                 /* RELEASE  */
    WORK = 347,                    /* WORK  */
    CHAIN = 348,                   /* CHAIN  */
    NO = 349,                      /* NO  */
    PRESERVE = 350,                /* PRESERVE  */
    ROWS = 351,                    /* ROWS  */
    START = 352,                   /* START  */
    TRANSACTION = 353,             /* TRANSACTION  */
    READ = 354,                    /* READ  */
    WRITE = 355,                   /* WRITE  */
    ONLY = 356,                    /* ONLY  */
    ISOLATION = 357,               /* ISOLATION  */
    LEVEL = 358,                   /* LEVEL  */
    UNCOMMITTED = 359,             /* UNCOMMITTED  */
    COMMITTED = 360,               /* COMMITTED  */
    sqlREPEATABLE = 361,           /* sqlREPEATABLE  */
    SERIALIZABLE = 362,            /* SERIALIZABLE  */
    DIAGNOSTICS = 363,             /* DIAGNOSTICS  */
    sqlSIZE = 364,                 /* sqlSIZE  */
    STORAGE = 365,                 /* STORAGE  */
    SNAPSHOT = 366,                /* SNAPSHOT  */
    ASYMMETRIC = 367,              /* ASYMMETRIC  */
    SYMMETRIC = 368,               /* SYMMETRIC  */
    ORDER = 369,                   /* ORDER  */
    ORDERED = 370,                 /* ORDERED  */
    BY = 371,                      /* BY  */
    IMPRINTS = 372,                /* IMPRINTS  */
    ESCAPE = 373,                  /* ESCAPE  */
    UESCAPE = 374,                 /* UESCAPE  */
    HAVING = 375,                  /* HAVING  */
    sqlGROUP = 376,                /* sqlGROUP  */
    ROLLUP = 377,                  /* ROLLUP  */
    CUBE = 378,                    /* CUBE  */
    sqlNULL = 379,                 /* sqlNULL  */
    GROUPING = 380,                /* GROUPING  */
    SETS = 381,                    /* SETS  */
    FROM = 382,                    /* FROM  */
    FOR = 383,                     /* FOR  */
    MATCH = 384,                   /* MATCH  */
    EXTRACT = 385,                 /* EXTRACT  */
    SEQUENCE = 386,                /* SEQUENCE  */
    INCREMENT = 387,               /* INCREMENT  */
    RESTART = 388,                 /* RESTART  */
    CONTINUE = 389,                /* CONTINUE  */
    MAXVALUE = 390,                /* MAXVALUE  */
    MINVALUE = 391,                /* MINVALUE  */
    CYCLE = 392,                   /* CYCLE  */
    NEXT = 393,                    /* NEXT  */
    VALUE = 394,                   /* VALUE  */
    CACHE = 395,                   /* CACHE  */
    GENERATED = 396,               /* GENERATED  */
    ALWAYS = 397,                  /* ALWAYS  */
    IDENTITY = 398,                /* IDENTITY  */
    SERIAL = 399,                  /* SERIAL  */
    BIGSERIAL = 400,               /* BIGSERIAL  */
    AUTO_INCREMENT = 401,          /* AUTO_INCREMENT  */
    SCOLON = 402,                  /* SCOLON  */
    AT = 403,                      /* AT  */
    XMLCOMMENT = 404,              /* XMLCOMMENT  */
    XMLCONCAT = 405,               /* XMLCONCAT  */
    XMLDOCUMENT = 406,             /* XMLDOCUMENT  */
    XMLELEMENT = 407,              /* XMLELEMENT  */
    XMLATTRIBUTES = 408,           /* XMLATTRIBUTES  */
    XMLFOREST = 409,               /* XMLFOREST  */
    XMLPARSE = 410,                /* XMLPARSE  */
    STRIP = 411,                   /* STRIP  */
    WHITESPACE = 412,              /* WHITESPACE  */
    XMLPI = 413,                   /* XMLPI  */
    XMLQUERY = 414,                /* XMLQUERY  */
    PASSING = 415,                 /* PASSING  */
    XMLTEXT = 416,                 /* XMLTEXT  */
    NIL = 417,                     /* NIL  */
    REF = 418,                     /* REF  */
    ABSENT = 419,                  /* ABSENT  */
    EMPTY = 420,                   /* EMPTY  */
    DOCUMENT = 421,                /* DOCUMENT  */
    ELEMENT = 422,                 /* ELEMENT  */
    CONTENT = 423,                 /* CONTENT  */
    XMLNAMESPACES = 424,           /* XMLNAMESPACES  */
    NAMESPACE = 425,               /* NAMESPACE  */
    XMLVALIDATE = 426,             /* XMLVALIDATE  */
    RETURNING = 427,               /* RETURNING  */
    LOCATION = 428,                /* LOCATION  */
    ID = 429,                      /* ID  */
    ACCORDING = 430,               /* ACCORDING  */
    XMLSCHEMA = 431,               /* XMLSCHEMA  */
    URI = 432,                     /* URI  */
    XMLAGG = 433,                  /* XMLAGG  */
    FILTER = 434,                  /* FILTER  */
    CORRESPONDING = 435,           /* CORRESPONDING  */
    TEMP = 436,                    /* TEMP  */
    TEMPORARY = 437,               /* TEMPORARY  */
    MERGE = 438,                   /* MERGE  */
    REMOTE = 439,                  /* REMOTE  */
    REPLICA = 440,                 /* REPLICA  */
    UNLOGGED = 441,                /* UNLOGGED  */
    ASC = 442,                     /* ASC  */
    DESC = 443,                    /* DESC  */
    AUTHORIZATION = 444,           /* AUTHORIZATION  */
    CHECK = 445,                   /* CHECK  */
    CONSTRAINT = 446,              /* CONSTRAINT  */
    CREATE = 447,                  /* CREATE  */
    COMMENT = 448,                 /* COMMENT  */
    NULLS = 449,                   /* NULLS  */
    FIRST = 450,                   /* FIRST  */
    LAST = 451,                    /* LAST  */
    TYPE = 452,                    /* TYPE  */
    PROCEDURE = 453,               /* PROCEDURE  */
    FUNCTION = 454,                /* FUNCTION  */
    sqlLOADER = 455,               /* sqlLOADER  */
    AGGREGATE = 456,               /* AGGREGATE  */
    RETURNS = 457,                 /* RETURNS  */
    EXTERNAL = 458,                /* EXTERNAL  */
    sqlNAME = 459,                 /* sqlNAME  */
    DECLARE = 460,                 /* DECLARE  */
    CALL = 461,                    /* CALL  */
    LANGUAGE = 462,                /* LANGUAGE  */
    ANALYZE = 463,                 /* ANALYZE  */
    SQL_EXPLAIN = 464,             /* SQL_EXPLAIN  */
    SQL_TRACE = 465,               /* SQL_TRACE  */
    PREP = 466,                    /* PREP  */
    PREPARE = 467,                 /* PREPARE  */
    EXEC = 468,                    /* EXEC  */
    EXECUTE = 469,                 /* EXECUTE  */
    DEALLOCATE = 470,              /* DEALLOCATE  */
    REL_UNNEST = 471,              /* REL_UNNEST  */
    REL_REWRITE = 472,             /* REL_REWRITE  */
    PHYSICAL = 473,                /* PHYSICAL  */
    SHOW = 474,                    /* SHOW  */
    DETAILS = 475,                 /* DETAILS  */
    DEFAULT = 476,                 /* DEFAULT  */
    DISTINCT = 477,                /* DISTINCT  */
    DROP = 478,                    /* DROP  */
    TRUNCATE = 479,                /* TRUNCATE  */
    FOREIGN = 480,                 /* FOREIGN  */
    RENAME = 481,                  /* RENAME  */
    ENCRYPTED = 482,               /* ENCRYPTED  */
    UNENCRYPTED = 483,             /* UNENCRYPTED  */
    PASSWORD = 484,                /* PASSWORD  */
    GRANT = 485,                   /* GRANT  */
    REVOKE = 486,                  /* REVOKE  */
    ROLE = 487,                    /* ROLE  */
    ADMIN = 488,                   /* ADMIN  */
    INTO = 489,                    /* INTO  */
    IS = 490,                      /* IS  */
    KEY = 491,                     /* KEY  */
    ON = 492,                      /* ON  */
    OPTION = 493,                  /* OPTION  */
    OPTIONS = 494,                 /* OPTIONS  */
    PATH = 495,                    /* PATH  */
    PRIMARY = 496,                 /* PRIMARY  */
    PRIVILEGES = 497,              /* PRIVILEGES  */
    PUBLIC = 498,                  /* PUBLIC  */
    REFERENCES = 499,              /* REFERENCES  */
    SCHEMA = 500,                  /* SCHEMA  */
    SET = 501,                     /* SET  */
    AUTO_COMMIT = 502,             /* AUTO_COMMIT  */
    RETURN = 503,                  /* RETURN  */
    LEADING = 504,                 /* LEADING  */
    TRAILING = 505,                /* TRAILING  */
    BOTH = 506,                    /* BOTH  */
    ALTER = 507,                   /* ALTER  */
    ADD = 508,                     /* ADD  */
    TABLE = 509,                   /* TABLE  */
    COLUMN = 510,                  /* COLUMN  */
    TO = 511,                      /* TO  */
    UNIQUE = 512,                  /* UNIQUE  */
    VALUES = 513,                  /* VALUES  */
    VIEW = 514,                    /* VIEW  */
    WHERE = 515,                   /* WHERE  */
    WITH = 516,                    /* WITH  */
    WITHIN = 517,                  /* WITHIN  */
    WITHOUT = 518,                 /* WITHOUT  */
    RECURSIVE = 519,               /* RECURSIVE  */
    sqlDATE = 520,                 /* sqlDATE  */
    TIME = 521,                    /* TIME  */
    TIMESTAMP = 522,               /* TIMESTAMP  */
    INTERVAL = 523,                /* INTERVAL  */
    CENTURY = 524,                 /* CENTURY  */
    DECADE = 525,                  /* DECADE  */
    YEAR = 526,                    /* YEAR  */
    QUARTER = 527,                 /* QUARTER  */
    DOW = 528,                     /* DOW  */
    DOY = 529,                     /* DOY  */
    MONTH = 530,                   /* MONTH  */
    WEEK = 531,                    /* WEEK  */
    DAY = 532,                     /* DAY  */
    HOUR = 533,                    /* HOUR  */
    MINUTE = 534,                  /* MINUTE  */
    SECOND = 535,                  /* SECOND  */
    EPOCH = 536,                   /* EPOCH  */
    ZONE = 537,                    /* ZONE  */
    LIMIT = 538,                   /* LIMIT  */
    OFFSET = 539,                  /* OFFSET  */
    SAMPLE = 540,                  /* SAMPLE  */
    SEED = 541,                    /* SEED  */
    FETCH = 542,                   /* FETCH  */
    CASE = 543,                    /* CASE  */
    WHEN = 544,                    /* WHEN  */
    THEN = 545,                    /* THEN  */
    ELSE = 546,                    /* ELSE  */
    NULLIF = 547,                  /* NULLIF  */
    COALESCE = 548,                /* COALESCE  */
    IFNULL = 549,                  /* IFNULL  */
    IF = 550,                      /* IF  */
    ELSEIF = 551,                  /* ELSEIF  */
    WHILE = 552,                   /* WHILE  */
    DO = 553,                      /* DO  */
    ATOMIC = 554,                  /* ATOMIC  */
    BEGIN = 555,                   /* BEGIN  */
    END = 556,                     /* END  */
    COPY = 557,                    /* COPY  */
    RECORDS = 558,                 /* RECORDS  */
    DELIMITERS = 559,              /* DELIMITERS  */
    STDIN = 560,                   /* STDIN  */
    STDOUT = 561,                  /* STDOUT  */
    FWF = 562,                     /* FWF  */
    CLIENT = 563,                  /* CLIENT  */
    SERVER = 564,                  /* SERVER  */
    INDEX = 565,                   /* INDEX  */
    REPLACE = 566,                 /* REPLACE  */
    AS = 567,                      /* AS  */
    TRIGGER = 568,                 /* TRIGGER  */
    OF = 569,                      /* OF  */
    BEFORE = 570,                  /* BEFORE  */
    AFTER = 571,                   /* AFTER  */
    ROW = 572,                     /* ROW  */
    STATEMENT = 573,               /* STATEMENT  */
    sqlNEW = 574,                  /* sqlNEW  */
    OLD = 575,                     /* OLD  */
    EACH = 576,                    /* EACH  */
    REFERENCING = 577,             /* REFERENCING  */
    OVER = 578,                    /* OVER  */
    PARTITION = 579,               /* PARTITION  */
    CURRENT = 580,                 /* CURRENT  */
    EXCLUDE = 581,                 /* EXCLUDE  */
    FOLLOWING = 582,               /* FOLLOWING  */
    PRECEDING = 583,               /* PRECEDING  */
    OTHERS = 584,                  /* OTHERS  */
    TIES = 585,                    /* TIES  */
    RANGE = 586,                   /* RANGE  */
    UNBOUNDED = 587,               /* UNBOUNDED  */
    GROUPS = 588,                  /* GROUPS  */
    WINDOW = 589,                  /* WINDOW  */
    QUALIFY = 590,                 /* QUALIFY  */
    X_BODY = 591,                  /* X_BODY  */
    MAX_MEMORY = 592,              /* MAX_MEMORY  */
    MAX_WORKERS = 593,             /* MAX_WORKERS  */
    OPTIMIZER = 594,               /* OPTIMIZER  */
    DAYNAME = 595,                 /* DAYNAME  */
    MONTHNAME = 596,               /* MONTHNAME  */
    TIMESTAMPADD = 597,            /* TIMESTAMPADD  */
    TIMESTAMPDIFF = 598,           /* TIMESTAMPDIFF  */
    ODBC_TIMESTAMPADD = 599,       /* ODBC_TIMESTAMPADD  */
    ODBC_TIMESTAMPDIFF = 600,      /* ODBC_TIMESTAMPDIFF  */
    SQL_BIGINT = 601,              /* SQL_BIGINT  */
    SQL_BINARY = 602,              /* SQL_BINARY  */
    SQL_BIT = 603,                 /* SQL_BIT  */
    SQL_CHAR = 604,                /* SQL_CHAR  */
    SQL_DATE = 605,                /* SQL_DATE  */
    SQL_DECIMAL = 606,             /* SQL_DECIMAL  */
    SQL_DOUBLE = 607,              /* SQL_DOUBLE  */
    SQL_FLOAT = 608,               /* SQL_FLOAT  */
    SQL_GUID = 609,                /* SQL_GUID  */
    SQL_HUGEINT = 610,             /* SQL_HUGEINT  */
    SQL_INTEGER = 611,             /* SQL_INTEGER  */
    SQL_INTERVAL_DAY = 612,        /* SQL_INTERVAL_DAY  */
    SQL_INTERVAL_DAY_TO_HOUR = 613, /* SQL_INTERVAL_DAY_TO_HOUR  */
    SQL_INTERVAL_DAY_TO_MINUTE = 614, /* SQL_INTERVAL_DAY_TO_MINUTE  */
    SQL_INTERVAL_DAY_TO_SECOND = 615, /* SQL_INTERVAL_DAY_TO_SECOND  */
    SQL_INTERVAL_HOUR = 616,       /* SQL_INTERVAL_HOUR  */
    SQL_INTERVAL_HOUR_TO_MINUTE = 617, /* SQL_INTERVAL_HOUR_TO_MINUTE  */
    SQL_INTERVAL_HOUR_TO_SECOND = 618, /* SQL_INTERVAL_HOUR_TO_SECOND  */
    SQL_INTERVAL_MINUTE = 619,     /* SQL_INTERVAL_MINUTE  */
    SQL_INTERVAL_MINUTE_TO_SECOND = 620, /* SQL_INTERVAL_MINUTE_TO_SECOND  */
    SQL_INTERVAL_MONTH = 621,      /* SQL_INTERVAL_MONTH  */
    SQL_INTERVAL_SECOND = 622,     /* SQL_INTERVAL_SECOND  */
    SQL_INTERVAL_YEAR = 623,       /* SQL_INTERVAL_YEAR  */
    SQL_INTERVAL_YEAR_TO_MONTH = 624, /* SQL_INTERVAL_YEAR_TO_MONTH  */
    SQL_LONGVARBINARY = 625,       /* SQL_LONGVARBINARY  */
    SQL_LONGVARCHAR = 626,         /* SQL_LONGVARCHAR  */
    SQL_NUMERIC = 627,             /* SQL_NUMERIC  */
    SQL_REAL = 628,                /* SQL_REAL  */
    SQL_SMALLINT = 629,            /* SQL_SMALLINT  */
    SQL_TIME = 630,                /* SQL_TIME  */
    SQL_TIMESTAMP = 631,           /* SQL_TIMESTAMP  */
    SQL_TINYINT = 632,             /* SQL_TINYINT  */
    SQL_VARBINARY = 633,           /* SQL_VARBINARY  */
    SQL_VARCHAR = 634,             /* SQL_VARCHAR  */
    SQL_WCHAR = 635,               /* SQL_WCHAR  */
    SQL_WLONGVARCHAR = 636,        /* SQL_WLONGVARCHAR  */
    SQL_WVARCHAR = 637,            /* SQL_WVARCHAR  */
    SQL_TSI_FRAC_SECOND = 638,     /* SQL_TSI_FRAC_SECOND  */
    SQL_TSI_SECOND = 639,          /* SQL_TSI_SECOND  */
    SQL_TSI_MINUTE = 640,          /* SQL_TSI_MINUTE  */
    SQL_TSI_HOUR = 641,            /* SQL_TSI_HOUR  */
    SQL_TSI_DAY = 642,             /* SQL_TSI_DAY  */
    SQL_TSI_WEEK = 643,            /* SQL_TSI_WEEK  */
    SQL_TSI_MONTH = 644,           /* SQL_TSI_MONTH  */
    SQL_TSI_QUARTER = 645,         /* SQL_TSI_QUARTER  */
    SQL_TSI_YEAR = 646,            /* SQL_TSI_YEAR  */
    ODBC_DATE_ESCAPE_PREFIX = 647, /* ODBC_DATE_ESCAPE_PREFIX  */
    ODBC_TIME_ESCAPE_PREFIX = 648, /* ODBC_TIME_ESCAPE_PREFIX  */
    ODBC_TIMESTAMP_ESCAPE_PREFIX = 649, /* ODBC_TIMESTAMP_ESCAPE_PREFIX  */
    ODBC_GUID_ESCAPE_PREFIX = 650, /* ODBC_GUID_ESCAPE_PREFIX  */
    ODBC_FUNC_ESCAPE_PREFIX = 651, /* ODBC_FUNC_ESCAPE_PREFIX  */
    ODBC_OJ_ESCAPE_PREFIX = 652,   /* ODBC_OJ_ESCAPE_PREFIX  */
    POSITION = 653,                /* POSITION  */
    SUBSTRING = 654,               /* SUBSTRING  */
    TRIM = 655,                    /* TRIM  */
    SPLIT_PART = 656,              /* SPLIT_PART  */
    WITH_LA = 657,                 /* WITH_LA  */
    INTO_LA = 658,                 /* INTO_LA  */
    OUTER_UNION = 659,             /* OUTER_UNION  */
    TO_LA = 660,                   /* TO_LA  */
    UNION = 661,                   /* UNION  */
    EXCEPT = 662,                  /* EXCEPT  */
    INTERSECT = 663,               /* INTERSECT  */
    OR = 664,                      /* OR  */
    AND = 665,                     /* AND  */
    NOT = 666,                     /* NOT  */
    COMPARISON = 667,              /* COMPARISON  */
    NOT_BETWEEN = 668,             /* NOT_BETWEEN  */
    BETWEEN = 669,                 /* BETWEEN  */
    NOT_IN = 670,                  /* NOT_IN  */
    sqlIN = 671,                   /* sqlIN  */
    NOT_EXISTS = 672,              /* NOT_EXISTS  */
    EXISTS = 673,                  /* EXISTS  */
    NOT_LIKE = 674,                /* NOT_LIKE  */
    LIKE = 675,                    /* LIKE  */
    NOT_ILIKE = 676,               /* NOT_ILIKE  */
    ILIKE = 677,                   /* ILIKE  */
    LEFT_SHIFT = 678,              /* LEFT_SHIFT  */
    RIGHT_SHIFT = 679,             /* RIGHT_SHIFT  */
    LEFT_SHIFT_ASSIGN = 680,       /* LEFT_SHIFT_ASSIGN  */
    RIGHT_SHIFT_ASSIGN = 681,      /* RIGHT_SHIFT_ASSIGN  */
    CONCATSTRING = 682,            /* CONCATSTRING  */
    UMINUS = 683,                  /* UMINUS  */
    GEOM_OVERLAP = 684,            /* GEOM_OVERLAP  */
    GEOM_OVERLAP_OR_ABOVE = 685,   /* GEOM_OVERLAP_OR_ABOVE  */
    GEOM_OVERLAP_OR_BELOW = 686,   /* GEOM_OVERLAP_OR_BELOW  */
    GEOM_OVERLAP_OR_LEFT = 687,    /* GEOM_OVERLAP_OR_LEFT  */
    GEOM_OVERLAP_OR_RIGHT = 688,   /* GEOM_OVERLAP_OR_RIGHT  */
    GEOM_BELOW = 689,              /* GEOM_BELOW  */
    GEOM_ABOVE = 690,              /* GEOM_ABOVE  */
    GEOM_DIST = 691,               /* GEOM_DIST  */
    GEOM_MBR_EQUAL = 692           /* GEOM_MBR_EQUAL  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 163 "sql_parser.y"

	int		i_val,bval;
	lng		l_val,operation;
	lng		lpair[2];
	double		fval;
	char *		sval;
	symbol*		sym;
	dlist*		l;
	sql_subtype	type;

#line 512 "/home/user/MonetDB/build-fuzzing/sql/server/sql_parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif




int sqlparse (mvc *m);


#endif /* !YY_SQL_HOME_USER_MONETDB_BUILD_FUZZING_SQL_SERVER_SQL_PARSER_TAB_H_INCLUDED  */

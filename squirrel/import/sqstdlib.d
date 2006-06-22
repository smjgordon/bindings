/*
Copyright (c) 2003-2006 Alberto Demichelis

This software is provided 'as-is', without any
express or implied warranty. In no event will the
authors be held liable for any damages arising from
the use of this software.

Permission is granted to anyone to use this software
for any purpose, including commercial applications,
and to alter it and redistribute it freely, subject
to the following restrictions:

		1. The origin of this software must not be
		misrepresented; you must not claim that
		you wrote the original software. If you
		use this software in a product, an
		acknowledgment in the product
		documentation would be appreciated but is
		not required.

		2. Altered source versions must be plainly
		marked as such, and must not be
		misrepresented as being the original
		software.

		3. This notice may not be removed or
		altered from any source distribution.

D port by Carlos Ballesteros Velasco

*/

module sqstdlib;

private import squirrel;

extern(C):

// sqstdaux.h
void sqstd_seterrorhandlers(HSQUIRRELVM v);
void sqstd_printcallstack(HSQUIRRELVM v);

// sqstdblob.h
SQUserPointer sqstd_createblob(HSQUIRRELVM v, SQInteger size);
SQRESULT sqstd_getblob(HSQUIRRELVM v,SQInteger idx,SQUserPointer *ptr);
SQInteger sqstd_getblobsize(HSQUIRRELVM v,SQInteger idx);
SQRESULT sqstd_register_bloblib(HSQUIRRELVM v);

// sqstdio.h

int SQSTD_STREAM_TYPE_TAG = 0x80000000;

struct SQStream {
	SQInteger Read(void *, SQInteger);
	SQInteger Write(void *, SQInteger);
	SQInteger Flush();
	SQInteger Tell();
	SQInteger Len();
	SQInteger Seek(SQInteger, SQInteger);
	bool IsValid();
	bool EOS();
}

enum {
	SQ_SEEK_CUR = 0,
	SQ_SEEK_END = 1,
	SQ_SEEK_SET = 2
}

typedef void* SQFILE;

SQFILE sqstd_fopen(SQChar *,SQChar *);
SQInteger sqstd_fread(SQUserPointer, SQInteger, SQInteger, SQFILE);
SQInteger sqstd_fwrite(SQUserPointer, SQInteger, SQInteger, SQFILE);
SQInteger sqstd_fseek(SQFILE , SQInteger , SQInteger);
SQInteger sqstd_ftell(SQFILE);
SQInteger sqstd_fflush(SQFILE);
SQInteger sqstd_fclose(SQFILE);
SQInteger sqstd_feof(SQFILE);

SQRESULT sqstd_createfile(HSQUIRRELVM v, SQFILE file,SQBool own);
SQRESULT sqstd_getfile(HSQUIRRELVM v, SQInteger idx, SQFILE *file);

//compiler helpers
SQRESULT sqstd_loadfile(HSQUIRRELVM v,SQChar *filename,SQBool printerror);
SQRESULT sqstd_dofile(HSQUIRRELVM v,SQChar *filename,SQBool retval,SQBool printerror);
SQRESULT sqstd_writeclosuretofile(HSQUIRRELVM v,SQChar *filename);

SQRESULT sqstd_register_iolib(HSQUIRRELVM v);

// sqstdmath.h

SQRESULT sqstd_register_mathlib(HSQUIRRELVM v);

// sqstdstring.h

typedef uint SQRexBool;
typedef void * SQRex;

struct SQRexMatch {
	SQChar *begin;
	SQInteger len;
}

SQRex *sqstd_rex_compile(SQChar *pattern,SQChar **error);
void sqstd_rex_free(SQRex *exp);
SQBool sqstd_rex_match(SQRex* exp,SQChar* text);
SQBool sqstd_rex_search(SQRex* exp,SQChar* text, SQChar** out_begin, SQChar** out_end);
SQBool sqstd_rex_searchrange(SQRex* exp,SQChar* text_begin,SQChar* text_end,SQChar** out_begin, SQChar** out_end);
SQInteger sqstd_rex_getsubexpcount(SQRex* exp);
SQBool sqstd_rex_getsubexp(SQRex* exp, SQInteger n, SQRexMatch *subexp);
SQRESULT sqstd_register_stringlib(HSQUIRRELVM v);

// sqstdsystem.h
SQInteger sqstd_register_systemlib(HSQUIRRELVM v);

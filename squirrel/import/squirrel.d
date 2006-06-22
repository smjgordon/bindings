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

module squirrel;

extern (C):

alias int  SQInteger;
alias int  SQInt32;
alias uint SQUnsignedInteger;
alias uint SQHash;

alias float SQFloat;
alias void* SQUserPointer;
alias SQUnsignedInteger SQBool;
alias SQInteger SQRESULT;
alias char SQChar;

enum {
	SQFalse	= 0,
	SQTrue	= 1
}

struct SQVM;
struct SQTable;
struct SQArray;
struct SQString;
struct SQClosure;
struct SQGenerator;
struct SQNativeClosure;
struct SQUserData;
struct SQFunctionProto;
struct SQRefCounted;
struct SQClass;
struct SQInstance;
struct SQDelegable;

char[] SQUIRREL_VERSION   = "Squirrel 2.1 stable (D version)";
char[] SQUIRREL_COPYRIGHT = "Copyright (C) 2003-2006 Alberto Demichelis";
char[] SQUIRREL_AUTHOR    = "Alberto Demichelis";

enum {
	SQ_VMSTATE_IDLE      = 0,
	SQ_VMSTATE_RUNNING   = 1,
	SQ_VMSTATE_SUSPENDED = 2
}

enum {
	SQUIRREL_EOB = 0,
	SQ_BYTECODE_STREAM_TAG = 0xFAFA
}

enum {
	SQOBJECT_REF_COUNTED = 0x08000000,
	SQOBJECT_NUMERIC     = 0x04000000,
	SQOBJECT_DELEGABLE   = 0x02000000,
	SQOBJECT_CANBEFALSE  = 0x01000000
}

int SQ_MATCHTYPEMASKSTRING = -99999;

int _RT_MASK = 0x00FFFFFF;
int _RAW_TYPE(int t) { return t & _RT_MASK; }

enum {
	_RT_NULL          = 0x00000001,
	_RT_INTEGER       = 0x00000002,
	_RT_FLOAT         = 0x00000004,
	_RT_BOOL          = 0x00000008,
	_RT_STRING        = 0x00000010,
	_RT_TABLE         = 0x00000020,
	_RT_ARRAY         = 0x00000040,
	_RT_USERDATA      = 0x00000080,
	_RT_CLOSURE       = 0x00000100,
	_RT_NATIVECLOSURE = 0x00000200,
	_RT_GENERATOR     = 0x00000400,
	_RT_USERPOINTER   = 0x00000800,
	_RT_THREAD        = 0x00001000,
	_RT_FUNCPROTO     = 0x00002000,
	_RT_CLASS         = 0x00004000,
	_RT_INSTANCE      = 0x00008000,
	_RT_WEAKREF       = 0x00010000
}

enum {
	OT_NULL =			(0x00000001|0x01000000),
	OT_INTEGER =		(0x00000002|0x04000000|0x01000000),
	OT_FLOAT =			(0x00000004|0x04000000|0x01000000),
	OT_BOOL =			(0x00000008|0x01000000),
	OT_STRING =			(0x00000010|0x08000000),
	OT_TABLE =			(0x00000020|0x08000000|0x02000000),
	OT_ARRAY =			(0x00000040|0x08000000),
	OT_USERDATA =		(0x00000080|0x08000000|0x02000000),
	OT_CLOSURE =		(0x00000100|0x08000000),
	OT_NATIVECLOSURE =	(0x00000200|0x08000000),
	OT_GENERATOR =		(0x00000400|0x08000000),
	OT_USERPOINTER =	0x00000800,
	OT_THREAD =			(0x00001000|0x08000000) ,
	OT_FUNCPROTO =		(0x00002000|0x08000000), //internal usage only
	OT_CLASS =			(0x00004000|0x08000000),
	OT_INSTANCE =		(0x00008000|0x08000000|0x02000000),
	OT_WEAKREF =		(0x00010000|0x08000000)
} alias int SQObjectType;

int ISREFCOUNTED(int t) { return t & SQOBJECT_REF_COUNTED; }

union SQObjectValue {
	SQTable *pTable;
	SQArray *pArray;
	SQClosure *pClosure;
	SQGenerator *pGenerator;
	SQNativeClosure *pNativeClosure;
	SQString *pString;
	SQUserData *pUserData;
	SQInteger nInteger;
	SQFloat fFloat;
	SQUserPointer pUserPointer;
	SQFunctionProto *pFunctionProto;
	SQRefCounted *pRefCounted;
	SQDelegable *pDelegable;
	SQVM *pThread;
	SQClass *pClass;
	SQInstance *pInstance;
	void *pWeakRef;
}

struct SQObject {
	SQObjectValue _unVal;
	SQObjectType _type;
}

struct SQStackInfos{
	SQChar* funcname;
	SQChar* source;
	SQInteger line;
}

typedef SQVM* HSQUIRRELVM;
typedef SQObject HSQOBJECT;
typedef SQInteger (*SQFUNCTION)(HSQUIRRELVM);
typedef SQInteger (*SQRELEASEHOOK)(SQUserPointer,SQInteger size);
typedef void (*SQCOMPILERERROR)(HSQUIRRELVM, SQChar *, SQChar *, SQInteger, SQInteger);
typedef void (*SQPRINTFUNCTION)(HSQUIRRELVM, SQChar * ,...);
typedef SQInteger (*SQWRITEFUNC)(SQUserPointer,SQUserPointer,SQInteger);
typedef SQInteger (*SQREADFUNC)(SQUserPointer,SQUserPointer,SQInteger);
typedef SQInteger (*SQLEXREADFUNC)(SQUserPointer);

struct SQRegFunction{
	SQChar *name;
	SQFUNCTION f;
	SQInteger nparamscheck;
	SQChar *typemask;
}


/*vm*/
extern HSQUIRRELVM sq_open(SQInteger initialstacksize);
extern HSQUIRRELVM sq_newthread(HSQUIRRELVM friendvm, SQInteger initialstacksize);
extern void sq_seterrorhandler(HSQUIRRELVM v);
extern void sq_close(HSQUIRRELVM v);
extern void sq_setforeignptr(HSQUIRRELVM v,SQUserPointer p);
extern SQUserPointer sq_getforeignptr(HSQUIRRELVM v);
extern void sq_setprintfunc(HSQUIRRELVM v, SQPRINTFUNCTION printfunc);
extern SQPRINTFUNCTION sq_getprintfunc(HSQUIRRELVM v);
extern SQRESULT sq_suspendvm(HSQUIRRELVM v);
extern SQRESULT sq_wakeupvm(HSQUIRRELVM v,SQBool resumedret,SQBool retval,SQBool raiseerror);
extern SQInteger sq_getvmstate(HSQUIRRELVM v);

/*compiler*/
extern SQRESULT sq_compile(HSQUIRRELVM v,SQLEXREADFUNC read,SQUserPointer p, SQChar *sourcename,SQBool raiseerror);
extern SQRESULT sq_compilebuffer(HSQUIRRELVM v, SQChar *s,SQInteger size, SQChar *sourcename,SQBool raiseerror);
extern void sq_enabledebuginfo(HSQUIRRELVM v, SQBool enable);
extern void sq_notifyallexceptions(HSQUIRRELVM v, SQBool enable);
extern void sq_setcompilererrorhandler(HSQUIRRELVM v,SQCOMPILERERROR f);

/*stack operations*/
extern void sq_push(HSQUIRRELVM v,SQInteger idx);
extern void sq_pop(HSQUIRRELVM v,SQInteger nelemstopop);
extern void sq_poptop(HSQUIRRELVM v);
extern void sq_remove(HSQUIRRELVM v,SQInteger idx);
extern SQInteger sq_gettop(HSQUIRRELVM v);
extern void sq_settop(HSQUIRRELVM v,SQInteger newtop);
extern void sq_reservestack(HSQUIRRELVM v,SQInteger nsize);
extern SQInteger sq_cmp(HSQUIRRELVM v);
extern void sq_move(HSQUIRRELVM dest,HSQUIRRELVM src,SQInteger idx);

/*object creation handling*/
extern SQUserPointer sq_newuserdata(HSQUIRRELVM v,SQUnsignedInteger size);
extern void sq_newtable(HSQUIRRELVM v);
extern void sq_newarray(HSQUIRRELVM v,SQInteger size);
extern void sq_newclosure(HSQUIRRELVM v,SQFUNCTION func,SQUnsignedInteger nfreevars);
extern SQRESULT sq_setparamscheck(HSQUIRRELVM v,SQInteger nparamscheck, SQChar *typemask);
extern SQRESULT sq_bindenv(HSQUIRRELVM v,SQInteger idx);
extern void sq_pushstring(HSQUIRRELVM v, SQChar *s,SQInteger len);
extern void sq_pushfloat(HSQUIRRELVM v,SQFloat f);
extern void sq_pushinteger(HSQUIRRELVM v,SQInteger n);
extern void sq_pushbool(HSQUIRRELVM v,SQBool b);
extern void sq_pushuserpointer(HSQUIRRELVM v,SQUserPointer p);
extern void sq_pushnull(HSQUIRRELVM v);
extern SQObjectType sq_gettype(HSQUIRRELVM v,SQInteger idx);
extern SQInteger sq_getsize(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_getbase(HSQUIRRELVM v,SQInteger idx);
extern SQBool sq_instanceof(HSQUIRRELVM v);
extern void sq_tostring(HSQUIRRELVM v,SQInteger idx);
extern void sq_tobool(HSQUIRRELVM v, SQInteger idx, SQBool *b);
extern SQRESULT sq_getstring(HSQUIRRELVM v,SQInteger idx, SQChar **c);
extern SQRESULT sq_getinteger(HSQUIRRELVM v,SQInteger idx,SQInteger *i);
extern SQRESULT sq_getfloat(HSQUIRRELVM v,SQInteger idx,SQFloat *f);
extern SQRESULT sq_getbool(HSQUIRRELVM v,SQInteger idx,SQBool *b);
extern SQRESULT sq_getthread(HSQUIRRELVM v,SQInteger idx,HSQUIRRELVM *thread);
extern SQRESULT sq_getuserpointer(HSQUIRRELVM v,SQInteger idx,SQUserPointer *p);
extern SQRESULT sq_getuserdata(HSQUIRRELVM v,SQInteger idx,SQUserPointer *p,SQUserPointer *typetag);
extern SQRESULT sq_settypetag(HSQUIRRELVM v,SQInteger idx,SQUserPointer typetag);
extern SQRESULT sq_gettypetag(HSQUIRRELVM v,SQInteger idx,SQUserPointer *typetag);
extern void sq_setreleasehook(HSQUIRRELVM v,SQInteger idx,SQRELEASEHOOK hook);
extern SQChar *sq_getscratchpad(HSQUIRRELVM v,SQInteger minsize);
extern SQRESULT sq_getclosureinfo(HSQUIRRELVM v,SQInteger idx,SQUnsignedInteger *nparams,SQUnsignedInteger *nfreevars);
extern SQRESULT sq_setnativeclosurename(HSQUIRRELVM v,SQInteger idx, SQChar *name);
extern SQRESULT sq_setinstanceup(HSQUIRRELVM v, SQInteger idx, SQUserPointer p);
extern SQRESULT sq_getinstanceup(HSQUIRRELVM v, SQInteger idx, SQUserPointer *p,SQUserPointer typetag);
extern SQRESULT sq_newclass(HSQUIRRELVM v,SQBool hasbase);
extern SQRESULT sq_createinstance(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_setattributes(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_getattributes(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_getclass(HSQUIRRELVM v,SQInteger idx);
extern void sq_weakref(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_getdefaultdelegate(HSQUIRRELVM v,SQObjectType t);

/*object manipulation*/
extern void sq_pushroottable(HSQUIRRELVM v);
extern void sq_pushregistrytable(HSQUIRRELVM v);
extern SQRESULT sq_setroottable(HSQUIRRELVM v);
/*SQUIRREL_API SQRESULT sq_createslot(HSQUIRRELVM v,SQInteger idx);*/
SQRESULT sq_newslot(HSQUIRRELVM v, SQInteger idx, SQBool bstatic);
extern SQRESULT sq_deleteslot(HSQUIRRELVM v,SQInteger idx,SQBool pushval);
extern SQRESULT sq_set(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_get(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_rawget(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_rawset(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_rawdeleteslot(HSQUIRRELVM v,SQInteger idx,SQBool pushval);
extern SQRESULT sq_arrayappend(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_arraypop(HSQUIRRELVM v,SQInteger idx,SQBool pushval);
extern SQRESULT sq_arrayresize(HSQUIRRELVM v,SQInteger idx,SQInteger newsize);
extern SQRESULT sq_arrayreverse(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_setdelegate(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_getdelegate(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_clone(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_setfreevariable(HSQUIRRELVM v,SQInteger idx,SQUnsignedInteger nval);
extern SQRESULT sq_next(HSQUIRRELVM v,SQInteger idx);
extern SQRESULT sq_getweakrefval(HSQUIRRELVM v,SQInteger idx);

/*calls*/
extern SQRESULT sq_call(HSQUIRRELVM v,SQInteger params,SQBool retval,SQBool raiseerror);
extern SQRESULT sq_resume(HSQUIRRELVM v,SQBool retval,SQBool raiseerror);
extern SQChar *sq_getlocal(HSQUIRRELVM v,SQUnsignedInteger level,SQUnsignedInteger idx);
extern SQChar *sq_getfreevariable(HSQUIRRELVM v,SQInteger idx,SQUnsignedInteger nval);
extern SQRESULT sq_throwerror(HSQUIRRELVM v, SQChar *err);
extern void sq_reseterror(HSQUIRRELVM v);
extern void sq_getlasterror(HSQUIRRELVM v);

/*raw object handling*/
extern SQRESULT sq_getstackobj(HSQUIRRELVM v,SQInteger idx,HSQOBJECT *po);
extern void sq_pushobject(HSQUIRRELVM v,HSQOBJECT obj);
extern void sq_addref(HSQUIRRELVM v,HSQOBJECT *po);
extern SQBool sq_release(HSQUIRRELVM v,HSQOBJECT *po);
extern void sq_resetobject(HSQOBJECT *po);
extern SQChar *sq_objtostring(HSQOBJECT *o);
extern SQBool sq_objtobool(HSQOBJECT *o);
extern SQInteger sq_objtointeger(HSQOBJECT *o);
extern SQFloat sq_objtofloat(HSQOBJECT *o);
extern SQRESULT sq_getobjtypetag(HSQOBJECT *o,SQUserPointer * typetag);

/*GC*/
extern SQInteger sq_collectgarbage(HSQUIRRELVM v);

/*serialization*/
extern SQRESULT sq_writeclosure(HSQUIRRELVM vm,SQWRITEFUNC writef,SQUserPointer up);
extern SQRESULT sq_readclosure(HSQUIRRELVM vm,SQREADFUNC readf,SQUserPointer up);

/*mem allocation*/
extern void *sq_malloc(SQUnsignedInteger size);
extern void *sq_realloc(void* p,SQUnsignedInteger oldsize,SQUnsignedInteger newsize);
extern void sq_free(void *p,SQUnsignedInteger size);

/*debug*/
extern SQRESULT sq_stackinfos(HSQUIRRELVM v,SQInteger level,SQStackInfos *si);
extern void sq_setdebughook(HSQUIRRELVM v);

/*UTILITY MACRO*/
bool sq_isnumeric(SQObject o) { return (o._type&SQOBJECT_NUMERIC) != 0; }
bool sq_istable(SQObject o) { return (o._type==OT_TABLE); }
bool sq_isarray(SQObject o) { return (o._type==OT_ARRAY); }
bool sq_isfunction(SQObject o) { return (o._type==OT_FUNCPROTO); }
bool sq_isclosure(SQObject o) { return (o._type==OT_CLOSURE); }
bool sq_isgenerator(SQObject o) { return (o._type==OT_GENERATOR); }
bool sq_isnativeclosure(SQObject o) { return (o._type==OT_NATIVECLOSURE); }
bool sq_isstring(SQObject o) { return (o._type==OT_STRING); }
bool sq_isinteger(SQObject o) { return (o._type==OT_INTEGER); }
bool sq_isfloat(SQObject o) { return (o._type==OT_FLOAT); }
bool sq_isuserpointer(SQObject o) { return (o._type==OT_USERPOINTER); }
bool sq_isuserdata(SQObject o) { return (o._type==OT_USERDATA); }
bool sq_isthread(SQObject o) { return (o._type==OT_THREAD); }
bool sq_isnull(SQObject o) { return (o._type==OT_NULL); }
bool sq_isclass(SQObject o) { return (o._type==OT_CLASS); }
bool sq_isinstance(SQObject o) { return (o._type==OT_INSTANCE); }
bool sq_isbool(SQObject o) { return (o._type==OT_BOOL); }
bool sq_isweakref(SQObject o) { return (o._type==OT_WEAKREF); }
SQObjectType sq_type(SQObject o) { return (o._type); }

/* deprecated */
SQChar *_SC(char[] c) { return cast(SQChar *)c.ptr; }

SQRESULT sq_createslot(HSQUIRRELVM v, SQInteger n) { return sq_newslot(v,n,SQFalse); }

enum {
	SQ_OK    = 0,
	SQ_ERROR = -1
}

bool SQ_FAILED(SQRESULT res) { return (res < 0); }
bool SQ_SUCCEEDED(SQRESULT res) { return (res >= 0); }

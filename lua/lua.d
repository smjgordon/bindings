/************************************************

   lua 5.0.2
   file created using h2d by Clay Smith
   all changes from h2d are commented out
   and all additions are commented about with
   add: note
   
************************************************/

module lua.lua; 


// add: imports
private import std.c.stdarg, 
               std.string; 

private import lua.lauxlib;     

// add: constants
const char[] LUA_VERSION   = "Lua 5.0.2";
const char[] LUA_COPYRIGHT	= "Copyright (C) 1994-2004 Tecgraf, PUC-Rio";
const char[] LUA_AUTHORS 	= "R. Ierusalimschy, L. H. de Figueiredo & W. Celes";

/* option for multiple returns in `lua_pcall' and `lua_call' */
int LUA_MULTRET =	-1; 


/*
** pseudo-indices
*/
int LUA_REGISTRYINDEX	= -10000;
int LUA_GLOBALSINDEX	   = -10001;
int lua_upvalueindex(int i) {	return LUA_GLOBALSINDEX-i; }


/* error codes for `lua_load' and `lua_pcall' */
enum
{
   LUA_ERRRUN =   1,
   LUA_ERRFILE =  2,
   LUA_ERRSYNTAX = 3,
   LUA_ERRMEM =   4,
   LUA_ERRERR =   5
}

extern (C) {
struct lua_State;
//alias lua_State lua_State;

typedef int (*lua_CFunction) (lua_State *L);

// the compiler tells me so (alias lua.lua.lua_Chunkreader cannot be const)
typedef /*const*/ char * (*lua_Chunkreader) (lua_State *L, void *ud, size_t *sz);

typedef int (*lua_Chunkwriter) (lua_State *L, /*const*/ void* p,
                                size_t sz, void* ud);
         
/* add: hd2 ignored all defs
** basic types
*/
enum
{
   LUA_TNONE = -1, 
   LUA_TNIL = 0,
   LUA_TBOOLEAN = 1,
   LUA_TLIGHTUSERDATA = 2,	
   LUA_TNUMBER = 3,	
   LUA_TSTRING = 4,	
   LUA_TTABLE = 5,	
   LUA_TFUNCTION = 6,	
   LUA_TUSERDATA = 7,	
   LUA_TTHREAD = 8	
}

/* minimum Lua stack available to a C function */
const int LUA_MINSTACK = 20;                                             
                                
alias double lua_Number;
extern lua_State *lua_open ();
extern void lua_close (lua_State *L);
extern lua_State *lua_newthread (lua_State *L);

extern lua_CFunction lua_atpanic (lua_State *L, lua_CFunction panicf);





extern int lua_gettop (lua_State *L);
extern void lua_settop (lua_State *L, int idx);
extern void lua_pushvalue (lua_State *L, int idx);
extern void lua_remove (lua_State *L, int idx);
extern void lua_insert (lua_State *L, int idx);
extern void lua_replace (lua_State *L, int idx);
extern int lua_checkstack (lua_State *L, int sz);

extern void lua_xmove (lua_State *from, lua_State *to, int n);






extern int lua_isnumber (lua_State *L, int idx);
extern int lua_isstring (lua_State *L, int idx);
extern int lua_iscfunction (lua_State *L, int idx);
extern int lua_isuserdata (lua_State *L, int idx);
extern int lua_type (lua_State *L, int idx);
extern  char *lua_typename (lua_State *L, int tp);

extern int lua_equal (lua_State *L, int idx1, int idx2);
extern int lua_rawequal (lua_State *L, int idx1, int idx2);
extern int lua_lessthan (lua_State *L, int idx1, int idx2);

extern lua_Number lua_tonumber (lua_State *L, int idx);
extern int lua_toboolean (lua_State *L, int idx);
extern  char *lua_tostring (lua_State *L, int idx);
extern size_t lua_strlen (lua_State *L, int idx);
extern lua_CFunction lua_tocfunction (lua_State *L, int idx);
extern void *lua_touserdata (lua_State *L, int idx);
extern lua_State *lua_tothread (lua_State *L, int idx);
extern  void *lua_topointer (lua_State *L, int idx);





extern void lua_pushnil (lua_State *L);
extern void lua_pushnumber (lua_State *L, lua_Number n);
extern void lua_pushlstring (lua_State *L,  char *s, size_t l);
extern void lua_pushstring (lua_State *L,  char *s);
extern  char *lua_pushvfstring (lua_State *L,  char *fmt,
                                                    va_list argp);
extern  char *lua_pushfstring (lua_State *L,  char *fmt, ...);
extern void lua_pushcclosure (lua_State *L, lua_CFunction fn, int n);
extern void lua_pushboolean (lua_State *L, int b);
extern void lua_pushlightuserdata (lua_State *L, void *p);





extern void lua_gettable (lua_State *L, int idx);
extern void lua_rawget (lua_State *L, int idx);
extern void lua_rawgeti (lua_State *L, int idx, int n);
extern void lua_newtable (lua_State *L);
extern void *lua_newuserdata (lua_State *L, size_t sz);
extern int lua_getmetatable (lua_State *L, int objindex);
extern void lua_getfenv (lua_State *L, int idx);





extern void lua_settable (lua_State *L, int idx);
extern void lua_rawset (lua_State *L, int idx);
extern void lua_rawseti (lua_State *L, int idx, int n);
extern int lua_setmetatable (lua_State *L, int objindex);
extern int lua_setfenv (lua_State *L, int idx);





extern void lua_call (lua_State *L, int nargs, int nresults);
extern int lua_pcall (lua_State *L, int nargs, int nresults, int errfunc);
extern int lua_cpcall (lua_State *L, lua_CFunction func, void *ud);
extern int lua_load (lua_State *L, lua_Chunkreader reader, void *dt,
                         char *chunkname);

extern int lua_dump (lua_State *L, lua_Chunkwriter writer, void *data);





extern int lua_yield (lua_State *L, int nresults);
extern int lua_resume (lua_State *L, int narg);




extern int lua_getgcthreshold (lua_State *L);
extern int lua_getgccount (lua_State *L);
extern void lua_setgcthreshold (lua_State *L, int newthreshold);





extern  char *lua_version ();

extern int lua_error (lua_State *L);

extern int lua_next (lua_State *L, int idx);

extern void lua_concat (lua_State *L, int n);



/* add: added macros that h2d ignored
** ===============================================================
** some useful macros
** ===============================================================
*/

//#define lua_boxpointer(L,u) (*(void **)(lua_newuserdata(L, sizeof(void *))) = (u))
void * lua_boxpointer(lua_State *L, void ** u)
{
   return *cast(void**)lua_newuserdata(L, (void*).sizeof) = u;
}

//#define lua_unboxpointer(L,i)	
void * lua_unboxpointer(lua_State *L, int i)
{
   return *cast(void **)lua_touserdata(L, i);
}


//#define lua_pop(L,n)		lua_settop(L, -(n)-1)
void lua_pop(lua_State *L, int n)
{
   lua_settop(L, -n-1); 
}

/*
#define lua_register(L,n,f) \
	(lua_pushstring(L, n), \
	 lua_pushcfunction(L, f), \
	 lua_settable(L, LUA_GLOBALSINDEX))
*/

void lua_register(lua_State *L, char *n, lua_CFunction f)
{
   lua_pushstring(L, n); 
   lua_pushcfunction(L, f);
   lua_settable(L, LUA_GLOBALSINDEX); 
}

//#define lua_pushcfunction(L,f)	lua_pushcclosure(L, f, 0)

void lua_pushcfunction(lua_State *L, lua_CFunction f)
{
   lua_pushcclosure(L, f, 0); 
}

//#define lua_isfunction(L,n)	(lua_type(L,n) == LUA_TFUNCTION)

bool lua_isfunction(lua_State *L, int n)
{
   return (lua_type(L,n) == LUA_TFUNCTION);
}

//#define lua_istable(L,n)	(lua_type(L,n) == LUA_TTABLE)

bool lua_istable(lua_State *L, int n)
{
   return (lua_type(L,n) == LUA_TTABLE);
}

//#define lua_islightuserdata(L,n)	(lua_type(L,n) == LUA_TLIGHTUSERDATA)

bool lua_islightuserdata(lua_State *L, int n)	
{
   return (lua_type(L,n) == LUA_TLIGHTUSERDATA);
}

//#define lua_isnil(L,n)		(lua_type(L,n) == LUA_TNIL)

bool lua_isnil(lua_State *L, int n)
{
   return (lua_type(L,n) == LUA_TNIL);
}

//#define lua_isboolean(L,n)	(lua_type(L,n) == LUA_TBOOLEAN)

bool lua_isboolean(lua_State *L, int n)
{
   return (lua_type(L,n) == LUA_TBOOLEAN);
}

//#define lua_isnone(L,n)		(lua_type(L,n) == LUA_TNONE)

bool lua_isnone(lua_State *L, int n)
{
   return (lua_type(L,n) == LUA_TNONE);
}

//#define lua_isnoneornil(L, n)	(lua_type(L,n) <= 0)
bool lua_isnoneornil(lua_State *L, int n)
{
   return (lua_type(L,n) <= 0);
}

/*
#define lua_pushliteral(L, s)	\
	lua_pushlstring(L, "" s, (sizeof(s)/sizeof(char))-1)
*/

void lua_pushliteral(lua_State *L, char[] s)
{
  
	lua_pushlstring(L, toStringz("" ~ s), (s.sizeof/char.sizeof)-1);
}


extern int lua_pushupvalues (lua_State *L);
//struct lua_Debug ;
//alias lua_Debug lua_Debug;


/*
** compatibility macros and functions
*/

//#define lua_getregistry(L)	lua_pushvalue(L, LUA_REGISTRYINDEX)
void lua_getregistry(lua_State *L)
{
   lua_pushvalue(L, LUA_REGISTRYINDEX); 
}

//#define lua_setglobal(L,s)	\
//   (lua_pushstring(L, s), lua_insert(L, -2), lua_settable(L, LUA_GLOBALSINDEX))

void lua_setglobal(lua_State *L, char *s)
{
   lua_pushstring(L, s); 
   lua_insert(L, -2); 
   lua_settable(L, LUA_GLOBALSINDEX); 
}

//#define lua_getglobal(L,s)	\
//		(lua_pushstring(L, s), lua_gettable(L, LUA_GLOBALSINDEX))

void lua_getglobal(lua_State *L, char *s)
{  
   lua_pushstring(L, s); 
   lua_gettable(L, LUA_GLOBALSINDEX);
}

/* compatibility with ref system */

/* pre-defined references */
const int LUA_NOREF	= (-2);
const int LUA_REFNIL	= (-1); 

//#define lua_ref(L,lock)	((lock) ? luaL_ref(L, LUA_REGISTRYINDEX) : \
//      (lua_pushstring(L, "unlocked references are obsolete"), lua_error(L), 0))

int lua_ref(lua_State *L, int lock)
{
   if (lock)
      return luaL_ref(L, LUA_REGISTRYINDEX);
   else
   {  
      lua_pushstring(L, "unlocked references are obsolete");
      lua_error(L);
      return 0;
   }
}

//#define lua_unref(L,ref)	luaL_unref(L, LUA_REGISTRYINDEX, (ref))
void lua_unref(lua_State *L, int ref)
{
   luaL_unref(L, LUA_REGISTRYINDEX, (ref)); 
}

//#define lua_getref(L,ref)	lua_rawgeti(L, LUA_REGISTRYINDEX, ref)
void lua_getref(lua_State *L, int ref)
{
   lua_rawgeti(L, LUA_REGISTRYINDEX, ref);
}


/*
** {======================================================================
** useful definitions for Lua kernel and libraries
** =======================================================================
*/

/* formats for Lua numbers */
const char[] LUA_NUMBER_SCAN = "%lf";
const char[]  LUA_NUMBER_FMT = "%.14g";

/*
** Event codes
*/
enum
{
   LUA_HOOKCALL = 0,
   LUA_HOOKRET = 1,
   LUA_HOOKLINE = 2,
   LUA_HOOKCOUNT = 3,
   LUA_HOOKTAILRET = 4
}


/*
** Event masks
*/
const int LUA_MASKCALL =	(1 << LUA_HOOKCALL);
const int LUA_MASKRET  =   (1 << LUA_HOOKRET);
const int LUA_MASKLINE =	(1 << LUA_HOOKLINE);
const int LUA_MASKCOUNT =	(1 << LUA_HOOKCOUNT);

typedef void (*lua_Hook) (lua_State *L, lua_Debug *ar);


extern int lua_getstack (lua_State *L, int level, lua_Debug *ar);
extern int lua_getinfo (lua_State *L,  char *what, lua_Debug *ar);
extern  char *lua_getlocal (lua_State *L,  lua_Debug *ar, int n);
extern  char *lua_setlocal (lua_State *L,  lua_Debug *ar, int n);
extern  char *lua_getupvalue (lua_State *L, int funcindex, int n);
extern  char *lua_setupvalue (lua_State *L, int funcindex, int n);

extern int lua_sethook (lua_State *L, lua_Hook func, int mask, int count);
extern lua_Hook lua_gethook (lua_State *L);
extern int lua_gethookmask (lua_State *L);
extern int lua_gethookcount (lua_State *L);



/* }====================================================================== */


/*
** {======================================================================
** Debug API
** =======================================================================
*/


struct lua_Debug {
  int event;
  const char *name;
  const char *namewhat;
  const char *what;
  const char *source;
  int currentline;
  int nups;
  int linedefined;
  char short_src[60];

  int i_ci;
}

} // extern (C)




const int LUA_IDSIZE = 60;


/******************************************************************************
* Copyright (C) 1994-2004 Tecgraf, PUC-Rio.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining
* a copy of this software and associated documentation files (the
* "Software"), to deal in the Software without restriction, including
* without limitation the rights to use, copy, modify, merge, publish,
* distribute, sublicense, and/or sell copies of the Software, and to
* permit persons to whom the Software is furnished to do so, subject to
* the following conditions:
*
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
* TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
******************************************************************************/

/************************************************

   lua 5.0.2
   file created using h2d by Clay Smith
   all changes from h2d are commented out
   and all additions are commented about with
   add: note
   
************************************************/

module lua.lauxlib; 

import lua.lua; 
const int BUFSIZ = 0x4000; // add (BUFSIZ)

extern (C) {
struct luaL_reg {
  const char *name;
  lua_CFunction func;
};
//alias luaL_reg luaL_reg;



/*LUA_API*/ void luaL_openlib (lua_State *L,  char *libname,
                                luaL_reg *l, int nup);
/*LUA_API*/ int luaL_getmetafield (lua_State *L, int obj,  char *e);
/*LUA_API*/ int luaL_callmeta (lua_State *L, int obj,  char *e);
/*LUA_API*/ int luaL_typerror (lua_State *L, int narg,  char *tname);
/*LUA_API*/ int luaL_argerror (lua_State *L, int numarg,  char *extramsg);
/*LUA_API*/  char *luaL_checklstring (lua_State *L, int numArg, size_t *l);
/*LUA_API*/  char *luaL_optlstring (lua_State *L, int numArg,
                                            char *def, size_t *l);
/*LUA_API*/ lua_Number luaL_checknumber (lua_State *L, int numArg);
/*LUA_API*/ lua_Number luaL_optnumber (lua_State *L, int nArg, lua_Number def);

/*LUA_API*/ void luaL_checkstack (lua_State *L, int sz,  char *msg);
/*LUA_API*/ void luaL_checktype (lua_State *L, int narg, int t);
/*LUA_API*/ void luaL_checkany (lua_State *L, int narg);

/*LUA_API*/ int luaL_newmetatable (lua_State *L,  char *tname);
/*LUA_API*/ void luaL_getmetatable (lua_State *L,  char *tname);
/*LUA_API*/ void *luaL_checkudata (lua_State *L, int ud,  char *tname);

/*LUA_API*/ void luaL_where (lua_State *L, int lvl);
/*LUA_API*/ int luaL_error (lua_State *L,  char *fmt, ...);

/*LUA_API*/ int luaL_findstring ( char *st,  char * lst[]);

/*LUA_API*/ int luaL_ref (lua_State *L, int t);
/*LUA_API*/ void luaL_unref (lua_State *L, int t, int ref);

/*LUA_API*/ int luaL_getn (lua_State *L, int t);
/*LUA_API*/ void luaL_setn (lua_State *L, int t, int n);

/*LUA_API*/ int luaL_loadfile (lua_State *L,  char *filename);
/*LUA_API*/ int luaL_loadbuffer (lua_State *L,  char *buff, size_t sz,
                                 char *name);
struct luaL_Buffer {
  char *p;
  int lvl;
  lua_State *L;
  char buffer[BUFSIZ];
};
//alias luaL_Buffer luaL_Buffer;



/*LUA_API*/ void luaL_buffinit (lua_State *L, luaL_Buffer *B);
/*LUA_API*/ char *luaL_prepbuffer (luaL_Buffer *B);
/*LUA_API*/ void luaL_addlstring (luaL_Buffer *B,  char *s, size_t l);
/*LUA_API*/ void luaL_addstring (luaL_Buffer *B,  char *s);
/*LUA_API*/ void luaL_addvalue (luaL_Buffer *B);
/*LUA_API*/ void luaL_pushresult (luaL_Buffer *B);



/* add: macros
** ===============================================================
** some useful macros
** ===============================================================
*/

//#define luaL_argcheck(L, cond,numarg,extramsg) if (!(cond)) \
//                                              luaL_argerror(L, numarg,extramsg)

void luaL_argcheck(lua_State *L, bool cond, int numarg, char* extramsg)
{
   if (!(cond))
      luaL_argerror(L, numarg, extramsg); 
} 

//#define luaL_checkstring(L,n)	(luaL_checklstring(L, (n), NULL))
char *luaL_checkstring(lua_State *L, int n)
{
   return luaL_checklstring(L, n, null); 
}

//#define luaL_optstring(L,n,d)	(luaL_optlstring(L, (n), (d), NULL))

char* luaL_optstring(lua_State *L, int n, char *d)
{
   return luaL_optlstring(L, n, d, null); 
}

//#define luaL_checkint(L,n)	((int)luaL_checknumber(L, n))
lua_Number luaL_checkint(lua_State *L, int n)
{
   return cast(int)luaL_checknumber(L, n);
}

//#define luaL_checklong(L,n)	((long)luaL_checknumber(L, n))
lua_Number luaL_checklong(lua_State *L, int n)
{
   return cast(long)luaL_checknumber(L, n);
}

//#define luaL_optint(L,n,d)	((int)luaL_optnumber(L, n,(lua_Number)(d)))
lua_Number luaL_optint(lua_State *L, int n, lua_Number d)
{
   return cast(int)luaL_optnumber(L, n, d);
}

//#define luaL_optlong(L,n,d)	((long)luaL_optnumber(L, n,(lua_Number)(d)))
lua_Number luaL_optlong(lua_State *L, int n, lua_Number d)
{
   return cast(long)luaL_optnumber(L, n, d);
}

alias BUFSIZ LUAL_BUFFERSIZE;	  

/*
#define luaL_putchar(B,c) \
  ((void)((B)->p < ((B)->buffer+LUAL_BUFFERSIZE) || luaL_prepbuffer(B)), \
   (*(B)->p++ = (char)(c)))
*/
// someone posted online this is the translation of the macro
// i'm not so sure, but it might be right

void luaL_putchar(luaL_Buffer *B, char c)
{
   if (B.p >= &B.buffer[LUAL_BUFFERSIZE-1]) luaL_prepbuffer(B);
   B.p += c;
}

//#define luaL_addsize(B,n)	((B)->p += (n))
void luaL_addsize(luaL_Buffer *B, int n)
{
   B.p += n; 
}


/*LUA_API*/ int lua_dofile (lua_State *L,  char *filename);
/*LUA_API*/ int lua_dostring (lua_State *L,  char *str);
/*LUA_API*/ int lua_dobuffer (lua_State *L,  char *buff, size_t sz,
                                char *n);
                                
/*
** Compatibility macros and functions
*/


alias luaL_checklstring    luaL_check_lstr; 	
alias luaL_optlstring      luaL_opt_lstr; 	 
alias luaL_checknumber     luaL_check_number; 	 
alias luaL_optnumber       luaL_opt_number;	
alias luaL_argcheck        luaL_arg_check;	
alias luaL_checkstring     luaL_check_string;	
alias luaL_optstring       luaL_opt_string;	
alias luaL_checkint        luaL_check_int;	
alias luaL_checklong       luaL_check_long;	
alias luaL_optint          luaL_opt_int;	
alias luaL_optlong         luaL_opt_long;	
                                
}






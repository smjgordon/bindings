/*
** $Id: lualib.h,v 1.28 2003/03/18 12:24:26 roberto Exp $
** Lua standard libraries
** See Copyright Notice in lua.h
*/



/************************************************

   lua 5.0.2
   file created using h2d by Clay Smith
   all changes from h2d are commented out
   and all additions are commented about with
   add: note
   
************************************************/

module lua.lualib; 

import lua.lua; 

extern (C) {

const char[] LUA_COLIBNAME	 = "coroutine";
const char[] LUA_TABLIBNAME =	"table";
const char[] LUA_IOLIBNAME =	"io";
const char[] LUA_OSLIBNAME =	"os";
const char[] LUA_STRLIBNAME=	"string";
const char[] LUA_MATHLIBNAME=	"math";
const char[] LUA_DBLIBNAME	=  "debug";

/*LUA_API*/ int luaopen_base (lua_State *L);


/*LUA_API*/  int luaopen_table (lua_State *L);



/*LUA_API*/  int luaopen_io (lua_State *L);


/*LUA_API*/  int luaopen_string (lua_State *L);


/*LUA_API*/  int luaopen_math (lua_State *L);


/*LUA_API*/  int luaopen_debug (lua_State *L);


/*LUA_API*/  int luaopen_loadlib (lua_State *L);

// add: the following compatibility code
/* compatibility code */
alias luaopen_base      lua_baselibopen;
alias luaopen_table     lua_tablibopen;
alias luaopen_io        lua_iolibopen;
alias luaopen_string    lua_strlibopen;
alias luaopen_math      lua_mathlibopen;
alias luaopen_debug     lua_dblibopen;

}

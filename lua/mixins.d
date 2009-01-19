/*******************************************************************************

	copyright:      Copyright (c) 2008 Matthias Walter. All rights reserved

    authors:        Matthias Walter, Andreas Hollandt

*******************************************************************************/

module lua.mixins;

private import lua.common;
public import lua.error;
private import lua.utils;
public import lua.utils;
public import lua.lauxlib;
private import lua.lua;

/*******************************************************************************

	Returns the lua-mangled name of a given class.

*******************************************************************************/

public static mstring mangleClass (cstring class_name)
{
    mstring result = "d_class_" ~ class_name;
    foreach (i, c; result)
    {
        if (c == '.')
            result[i] = '_';
    }
    return result;
}

/*******************************************************************************

	Returns the lua-mangled name of a given function.

*******************************************************************************/

public static mstring mangleFunction (cstring function_name)
{
    mstring result = "d_function_" ~ function_name;
    foreach (i, c; result)
    {
        if (c == '.')
            result[i] = '_';
    }
    return result;
}

/*******************************************************************************

	Internal mixin function for registering a method. Needs a line number to
	make the resulting wrapper function unique.

	Params:
	lua_state = Name of a LuaState variable
	class_name = Name of the class, the methods belongs to
	method_name = Name of the method
	lua_name = Method-name in Lua
	line_number = Line number used in the wrapper function name

*******************************************************************************/

public static istring mixinLuaRegisterMethodAtLine (cstring lua_state, cstring class_name, cstring method_name, cstring lua_name, int line_number)
{
    istring wrapper = cast(istring) (`lua_wrapper_` ~ mangleClass (class_name) ~ "_" ~ method_name ~ "_" ~ int2string (line_number));

    return cast(istring) (`{`
        ~ `  extern (C) static int ` ~ wrapper ~ ` (lua_State *L)`
        ~ `  {`
        ~ `    auto state = LuaState.states[L];`
        ~ `    try`
        ~ `    {`
        ~ `      void* userdata = luaL_checkudata (L, 1, "` ~ mangleClass (class_name) ~ `");` // Check, whether it's the correct userdata
        ~ `      luaL_argcheck (L, userdata !is null, 1, "class pointer expected");`
        ~ `      lua_remove (L, 1);` // Remove the userdata
        ~ `      return (cast (` ~class_name ~ ` *) userdata).` ~ method_name ~ ` (state);` // Call the wrapped
        ~ `    }`
        ~ `    catch (Exception e)`
        ~ `    {`
        ~ `      auto f = new LuaForwardException (state, e, "` ~ class_name ~ `.` ~ method_name ~ `", __FILE__, __LINE__);`
        ~ `      LuaForwardException.exceptions[cast (void*) f] = f;`
        ~ `      return luaL_error (L, lua.utils.toStringz ("LFE=" ~ lua.mixins.int2string (cast (size_t) cast(void*)  f) ~ ";"));`
        ~ `    }`
        ~ `  }`
        ~ `  ` ~ lua_state ~ `.loadClassMetatable ("` ~ class_name ~ `");`
        ~ `  ` ~ lua_state ~ `.registerMethod ("` ~ lua_name ~ `", cast (LuaCFunction) &` ~ wrapper ~ `);`
        ~ `  ` ~ lua_state ~ `.pop ();`
        ~ `}`);
}

/*******************************************************************************

	Mixin function for registering a method, like in the following example:
	---
	class MyClass
	{
		public int method (LuaState L)
		{
			...
		}
	}

	auto L = new LuaState ();

	// Register the class
	L.registerClass !(MyClass);
	// Register the method
	mixin (mixinLuaRegisterMethod ("L", "Module.MyClass.method", "meth"));

	// Wrap a class instance and push it onto the stack
	L.wrapClass (new MyClass ());
	// Make it a global variable.
	L.setGlobal ("instance");
	// Use it in Lua
	L.doString ("instance.meth ('abc', 1, 2);");
	---

	Params:
	lua_state = Name of a LuaState variable
	class_dot_method = Fully qualified name of the class and method divided by a dot
	lua_name = Method-name in Lua

*******************************************************************************/

public static istring mixinLuaRegisterMethod (cstring lua_state, cstring class_dot_method, cstring lua_name)
{
    int pos = rfind (class_dot_method, '.');
    cstring class_name = class_dot_method [0 .. pos];
    cstring method_name = class_dot_method [pos+1 .. $];
    return cast(istring) (`mixin (mixinLuaRegisterMethodAtLine ("` ~ lua_state ~ `", "` ~ class_name ~ `", "` ~ method_name ~ `", "` ~ lua_name ~ `", __LINE__));`);
}

/*******************************************************************************

	Internal mixin function for Pushing a global D function. This is a mixin,
	because it creates a C wrapper routine. It needs a line number to make
	the resulting wrapper function unique.

	Params:
	lua_state = Name of a LuaState variable
	name = Name of the D function
	line_number = Line number used in the wrapper function name

*******************************************************************************/

public static istring mixinLuaPushFunctionAtLine (cstring lua_state, cstring name, int line_number)
{
    istring wrapper = cast(istring) ("lua_wrapper_" ~ mangleFunction (name) ~ "_" ~ int2string (line_number));

    return cast(istring) (``
        ~ `{`
        ~ `  extern (C) static int `  ~ wrapper ~ ` (lua_State *L)`
        ~ `  {`
        ~ `    auto state = LuaState.states[L];`
        ~ `    try`
        ~ `    {`
        ~ `      return ` ~ name ~ ` (state);`
        ~ `    }`
        ~ `    catch (Exception e)`
        ~ `    {`
        ~ `      auto f = new LuaForwardException (state, e, "` ~ name ~ `", __FILE__, __LINE__);`
        ~ `      LuaForwardException.exceptions[cast (void*) f] = f;`
        ~ `      return luaL_error (L, lua.utils.toStringz ("LFE=" ~ lua.mixins.int2string (cast (size_t) cast(void*)  f) ~ ";"));`
        ~ `    }`
        ~ `  }`
        ~ `  ` ~ lua_state ~ `.pushCFunction (cast (int function (lua_State *L)) &` ~ wrapper ~ `);`
        ~ `}`);
}

/*******************************************************************************

	Mixin function for Pushing a global D function. This is a mixin, because
	it creates a C wrapper routine. Use it like in the following example:
	---
	static int func (LuaState L)
	{
		...
	}

	auto L = new LuaState ();

	// Push the function
	mixin (mixinLuaPushFunction ("L", "Module.func"));
	L.setGlobal ("myfunction");

	// Use it in Lua
	L.dotring ("myfunction ('abc', 1, 2);");
	---

	Params:
	lua_state = Name of a LuaState variable
	name = Fully qualified name of the function

*******************************************************************************/

public static istring mixinLuaPushFunction (cstring lua_state, cstring name)
{
    return cast(istring) (`mixin (mixinLuaPushFunctionAtLine ("` ~ lua_state ~ `", "` ~ name ~ `", __LINE__));`);
}

/*******************************************************************************

	Internal mixin function for registering a global D function. This is a
	mixin, because it creates a C wrapper routine. It needs a line number
	to make the resulting wrapper function unique.

	Params:
	lua_state = Name of a LuaState variable
	name = Name of the D function
	lua_library_dot_name = Lua module and function name seperated by a dot
	line_number = Line number used in the wrapper function name

*******************************************************************************/

public static istring mixinLuaRegisterFunctionAtLine (cstring lua_state, cstring name, cstring lua_library_dot_name, int line_number)
{
    int pos = rfind (lua_library_dot_name, '.');
    cstring lua_library = pos < 0 ? "null" : "\"" ~ lua_library_dot_name[0 .. pos] ~ "\"";
    cstring lua_function = lua_library_dot_name[pos+1 .. $];
    cstring wrapper = "lua_wrapper_" ~ mangleFunction (name) ~ "_" ~ int2string (line_number);

    return cast(istring) (``
		~ `{`
		~ `  extern (C) static int `  ~ wrapper ~ ` (lua_State* L)`
		~ `  {`
		~ `    auto state = LuaState.states[L];`
		~ `    try`
		~ `    {`
		~ `      return ` ~ name ~ ` (state);`
		~ `    }`
		~ `    catch (Exception e)`
		~ `    {`
		~ `      auto f = new LuaForwardException (state, e, "` ~ name ~ `", __FILE__, __LINE__);`
		~ `      LuaForwardException.exceptions[cast (void*) f] = f;`
		~ `      return luaL_error (L, lua.utils.toStringz ("LFE=" ~ lua.mixins.int2string (cast (size_t) cast(void*)  f) ~ ";"));`
		~ `    }`
		~ `  }`
		~ `  ` ~ lua_state ~ `.registerFunction ("` ~ lua_function ~ `", cast (int function (lua_State* L)) &` ~ wrapper ~ `, ` ~ lua_library ~ `);`
		~ `}`);
}

/*******************************************************************************

	Mixin function for registering a global D function. This is a mixin,
	because it creates a C wrapper routine. Use it like in the following
	example:
	---
	static int func (LuaState L)
	{
		...
	}

	auto L = new LuaState ();

	// Push the function
	mixin (mixinLuaRegisterFunction ("L", "Module.func", "a.b.c.myfunction));

	// Use it in Lua
	L.dotring ("a.b.c.myfunction ('abc', 1, 2);");
	---

	Params:
	lua_state = Name of a LuaState variable
	name = Fully qualified name of the function
	lua_library_dot_name = Lua module and function name seperated by a dot

*******************************************************************************/

public static istring mixinLuaRegisterFunction (cstring lua_state, cstring name, cstring lua_library_dot_name)
{
    return cast(istring) (`mixin (mixinLuaRegisterFunctionAtLine ("` ~ lua_state ~ `", "` ~ name ~ `", "` ~ lua_library_dot_name ~ `", __LINE__));`);
}

/*******************************************************************************

	Internal mixin function for registering a D constructor. This is a mixin,
	because it creates a C wrapper routine. It needs a line number to make
	the resulting wrapper function unique.

	Params:
	lua_state = Name of a LuaState variable
	class_name = Name of the D class
	lua_library_dot_name = Lua module and function name seperated by a dot
	line_number = Line number used in the wrapper function name

*******************************************************************************/

public static istring mixinLuaRegisterConstructorAtLine (cstring lua_state, cstring class_name, cstring lua_library_dot_name, int line_number)
{
    int pos = rfind (lua_library_dot_name, '.');
    cstring lua_library = pos < 0 ? "" : "\"" ~ lua_library_dot_name[0 .. pos] ~ "\"";
    cstring lua_function = lua_library_dot_name[pos+1 .. $];
    cstring wrapper = "lua_wrapper_" ~ mangleClass (class_name) ~ "_ctor_" ~ int2string (line_number);

    return cast(istring) (``
        ~ `{`
        ~ `  extern (C) static int ` ~ wrapper ~ ` (lua_State *L)`
        ~ `  {`
        ~ `    auto state = LuaState.states[L];`
        ~ `    try`
        ~ `    {`
        ~ `      auto instance = new ` ~ class_name ~ ` (state);`
        ~ `      state.wrapClass (instance);`
        ~ `      return 1;`
        ~ `    }`
        ~ `    catch (Exception e)`
        ~ `    {`
        ~ `      auto f = new LuaForwardException (state, e, "` ~ class_name ~ `.this", __FILE__, __LINE__);`
        ~ `      LuaForwardException.exceptions[cast (void*) f] = f;`
        ~ `      return luaL_error (L, lua.utils.toStringz ("LFE=" ~ lua.mixins.int2string (cast (size_t) cast(void*)  f) ~ ";"));`
        ~ `    }`
        ~ `  }`
        ~ `  ` ~ lua_state ~ `.registerFunction ("` ~ lua_function ~ `", cast (int function (lua_State *L)) &` ~ wrapper ~ `, ` ~ lua_library ~ `);`
        ~ `}`);
}

/*******************************************************************************

	Mixin function for registering a D constructor. This is a mixin,
	because it creates a C wrapper routine. Use it like in the following
	example:
	---
	class MyClass
	{
		public this (LuaState L)
		{
			...
		}
	}

	auto L = new LuaState ();

	// Register the class
	L.registerClass !(MyClass);
	// Register the method
	mixin (mixinLuaRegisterConstructor ("L", "Module.MyClass", "mylib.createmyclass"));

	// Use it in Lua
	L.doString ("instance = mylib.createmyclass ('abc', 1, 2);");
	---

	Params:
	lua_state = Name of a LuaState variable
	name = Fully qualified name of the function
	lua_library_dot_name = Lua module and function name seperated by a dot

*******************************************************************************/

public static istring mixinLuaRegisterConstructor (cstring lua_state, cstring class_name, cstring lua_library_dot_name)
{
    return cast(istring) (`mixin (mixinLuaRegisterConstructorAtLine ("` ~ lua_state ~ `", "` ~ class_name ~ `", "` ~ lua_library_dot_name ~ `", __LINE__));`);
}

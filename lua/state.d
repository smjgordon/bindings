/*******************************************************************************

	copyright:	Copyright (c) 2008 Matthias Walter. All rights reserved

	authors:	Matthias Walter, Andreas Hollandt, Clemens Hofreither

*******************************************************************************/

module lua.state;

private import lua.common;
private import lua.lua, lua.lualib, lua.lauxlib;
private import lua.buffer, lua.mixins, lua.error, lua.data, lua.utils;

version (Tango)
{
	private import tango.stdc.stdio : fputs, stdout;
}
else
{
	private import std.string : fputs, stdout;
}

/*******************************************************************************

	LuaStandardLibraries defines Constants for the different modules, which
	add basic functionality to a state. They can be OR'ed together to combine
	them.

	Use it as an argument to LuaState.openLibraries to select them.

*******************************************************************************/

public enum LuaStandardLibraries : int
{
	BASE = 0,
	TABLE = 1,
	STRING = 2,
	MATH = 4,
	OS = 8,
	IO = 16,
	DEBUG = 32,
	PACKAGE = 64,
	SAFE = BASE | TABLE | STRING | MATH | OS | PACKAGE,
	ALL = BASE | TABLE | STRING | MATH | OS | PACKAGE | IO | DEBUG
}

/*******************************************************************************

	LuaType defines Constants for the different Lua-internal types.

*******************************************************************************/

public enum LuaType : int
{
	NONE = LUA_TNONE,
	NIL = LUA_TNIL,
	NUMBER = LUA_TNUMBER,
	BOOL = LUA_TBOOLEAN,
	STRING = LUA_TSTRING,
	TABLE = LUA_TTABLE,
	FUNCTION = LUA_TFUNCTION,
	USERDATA = LUA_TUSERDATA,
	THREAD = LUA_TTHREAD,
	LIGHTUSERDATA = LUA_TLIGHTUSERDATA
}

/*******************************************************************************

	LuaGarbageCollectorCommand defines Commands for the LuaState.gc function,
	which controls the garbage collector of a LuaState.

*******************************************************************************/

public enum LuaGarbageCollectorCommand : int
{
	STOP = LUA_GCSTOP,
	RESTART = LUA_GCRESTART,
	COLLECT = LUA_GCCOLLECT,
	COUNT = LUA_GCCOUNT,
	STEP = LUA_GCSTEP,
	SET_PAUSE = LUA_GCSETPAUSE,
	SET_STEP_MULTIPLIER = LUA_GCSETSTEPMUL
}

/// Type of Function with C-linkage which can interface to Lua directly.

alias lua_CFunction LuaCFunction;

/// Type of Integers in Lua

alias lua_Integer LuaInteger;

/// Type of Floats in Lua

alias lua_Number LuaNumber;

/// Registration struct for registering C-linkage functions with Lua

struct LuaRegistry
{
	istring name;
	LuaCFunction cfunction;
	int category;
}

/// Delegate type for redirecting Lua's stdout to the D host program.

alias void delegate (cstring output) LuaPrint;

/*******************************************************************************

	LuaState wraps a Lua state which keeps the whole state of the Lua
	interpreter. It is thread-safe, as there are no global variables in the
	C library and no unsynchronized static variables in the D wrapper.

	Nearly all of the standard Lua functions are wrapped or reimplemented
	somehow. There are the following exceptions:

	The panic function cannot be changed, which is due to the longjmp
	implementation of the Lua library. Thus you should always use protected
	calls as an initial call to Lua code. If you still want the application
	to panic then, you simply do not catch the exceptions thrown by this
	call, which should terminate your application. Thus, there is no
	wrapper for the lua_atpanic function.

	Also, you cannot set a user-supplied allocation function. As Lua has
	its own garbage collector and all other C variables are directly
	freed by the wrapper classes, this is unnecessary. Thus, there is also
	no wrapper for lua_setallocf and lua_getallocf.

	Some string manipulation/construction routines are not wrapped, because
	this is more easily done in D directly or using the standard library of
	your choice. This has impact on lua_pushfstring, lua_pushvfstring and
	luaL_gsub.

*******************************************************************************/

class LuaState
{
	/// Wrapper Lua state
	private lua_State* state_;

	/// Writer delegate, the Lua stdout
	private LuaPrint write_;
	
	/// Whether the LuaState was created as a sub-thread of another state by calling newThread().
	private bool is_thread_state_;

	/// Constant to pass instead of a number of expected results, if this number is unknown.
	public const int MULTIPLE_RETURN_VALUES = LUA_MULTRET;

	/*******************************************************************************

		Constructs a state with an optional printer delegate. If the latter is
		null, stdout is not redirected.

		Params:
		write = Optional printer delegate.

		Remarks:
		Replaces lua_open, lua_newstate and luaL_newstate.

	 *******************************************************************************/

	public this (LuaPrint write = null)
	{
		this.state_ = lua_open ();
		this.write_ = (write is null) ? &writeDefault : write;

		openLibraries (LuaStandardLibraries.BASE);

		LuaState.states[this.state_] = this;
	}

	/*******************************************************************************

		Internal Constructor for Lua thread creation.

		Params:
		write = Printer delegate
		state = Lua state

	*******************************************************************************/

	private this (LuaPrint write, lua_State* state)
	{
		this.write_ = write;
		this.state_ = state;

		LuaState.states[this.state_] = this;
	}

	/*******************************************************************************

		Destructor

		Remarks:
		Replaces lua_close.

	*******************************************************************************/

	private ~this ()
	{
		LuaState.states.remove (this.state_);

		// bugfix by Clemens:
		// states which represent child threads may not be destroyed
		if (!is_thread_state_)
		{
			lua_close (this.state_);
		}
	}

	/*******************************************************************************

		Returns:
		The internal wrapped lua_State object.

		Remarks:
		If you really need to use this function, please contact	the author. For
		most functionality there should be a corresponding wrapper function.

	*******************************************************************************/

	public lua_State* state ()
	{
		return this.state_;
	}

	/*******************************************************************************

		Opens the specified standard libraries and adds their functionality to this state.
		See the LuaStandardLibraries enum for possible choices.

		Params:
		categories = choice of standard libraries

		Remarks:
		Replaces luaL_openlibs.

	*******************************************************************************/

	public LuaState openLibraries (LuaStandardLibraries categories = LuaStandardLibraries.ALL)
	{
		static LuaRegistry[] lualibs = [
			 { "", &luaopen_base, LuaStandardLibraries.BASE },
			 { LUA_TABLIBNAME, &luaopen_table, LuaStandardLibraries.TABLE },
			 { LUA_IOLIBNAME, &luaopen_io, LuaStandardLibraries.IO },
			 { LUA_OSLIBNAME, &luaopen_os, LuaStandardLibraries.OS },
			 { LUA_STRLIBNAME, &luaopen_string, LuaStandardLibraries.STRING },
			 { LUA_MATHLIBNAME, &luaopen_math, LuaStandardLibraries.MATH },
			 { LUA_DBLIBNAME, &luaopen_debug, LuaStandardLibraries.DEBUG },
			 { LUA_LOADLIBNAME, &luaopen_package, LuaStandardLibraries.PACKAGE }
		];

		openLibraries (lualibs, categories);

		registerFunction ("print", &print);

		return this;
	}

	/*******************************************************************************

		Opens all of the given libraries, which match the given categories bits,
		and adds their functionality to this state.

		Params:
		libraries = Array of possible libraries
		categories = Choice to open. Default is -1, which opens all.

	*******************************************************************************/

	public LuaState openLibraries (LuaRegistry[] libraries, int categories = -1)
	{
		foreach (LuaRegistry reg; libraries)
		{
			if (reg.category == 0 || (reg.category & categories) != 0)
			{
				openLibrary (reg.name, reg.cfunction);
			}
		}
		return this;
	}

	/*******************************************************************************

		Opens one library, adding its functionality to this state. The
		registration function must take the library name as its only
		argument.

		Params:
		library_name = Name of the library
		registration_function = C-linkage function to call for registration

	******************************************************************************/

	public LuaState openLibrary (cstring library_name, LuaCFunction registration_function)
	{
		pushCFunction (registration_function);
		pushString (library_name);
		call (false, 1, 0);

		return this;
	}

	/*******************************************************************************

		Internal method to pass the given data to the writer delegate.

		Params:
		data = Output to write.

	******************************************************************************/

	private void write (cstring data)
	{
		this.write_ (data);
	}

	/*******************************************************************************

		Standard writer function, if none is specified in Constructor.

		Params:
		output = Output to write.

	******************************************************************************/

	private void writeDefault (cstring output)
	{
		fputs (toStringz (output), stdout);
	}

	/*******************************************************************************

		Calls the C function with only one element in its stack, a LightUserdata,
		specified as an argument. It does not change the stack. All values
		returned by the function are discarded. For behavior on errors and the
		description of proctection schemes, see the other call method.
		
		Params:
		protection = whether this is a protected call.
		cfunction = Pointer to a C function.
		userdata = Pointer to C data.
		
		Remarks:
		Replaces lua_cpcall.

	******************************************************************************/

	public LuaState call (bool protection, LuaCFunction cfunction, void* userdata)
	{
		pushCFunction (cfunction);
		pushLightUserdata (userdata);
		call (protection, 1, 0);

		return this;
	}

	/*******************************************************************************

		Method to call a Lua function, using the following protocol:

		First, the function to be called is pushed onto the stack; then, the
		arguments to the function are pushed in direct order; that is, the first
		argument is pushed first. Finally you call this method with
		the number of arguments that you pushed onto the stack and the expected
		number of return values. All arguments and the function value are popped
		from the stack when the function is called. The function results are
		pushed onto the stack when the function returns. The number of results is
		adjusted to the expected number, unless the latter is
		MULTIPLE_RETURN_VALUES, which is the default. In this case, all results
		from the function are pushed. Lua takes care that the returned values fit
		into the stack space. The function results are pushed onto the stack in
		direct order (the first result is pushed first), so that after the call
		the last result is on the top of the stack.

		There are two different protection schemes, which define behavior on
		errors:

		Protected calls catch errors inside the called function (and all further
		called functions) and throw according exceptions. Lua errors result in
		LuaCodeExceptions and exceptions in D routines which are correctly wrapped
		via the lua mixins result in LuaForwardExceptions.

		Unprotected calls do not catch errors, but quietly propagate them to the
		next protected call in the call stack. If there is no such protected call,
		the application panics, exiting with status 1 and an error message.

		The author of this library suggests the following rules for protection:

		1. If the called routine and its subroutines are really safe,
		   use an unprotected call.
		2. If this call happens to be called as the first function on the Lua
		   call stack, use a protected call.
		3. If this is not the first function on the call stack (e.g. in a library
		   function called by some Lua code, which is called by a protected call)
		   you have the choice. Unprotected calls should be slightly faster, but
		   on error, a protected call would add one LuaForwardException to the
		   exception stack, which may help to identify error sources.

		Params:
		protection = whether this is a protected call.
		arguments = number of function arguments on the stack. Default is 0
		results = expected number of return values. Default is a variable number.

		Remarks:
		Replaces lua_call and lua_pcall.

	******************************************************************************/

	public LuaState call (bool protection, uint arguments = 0, int results = MULTIPLE_RETURN_VALUES)
	{
		if (protection)
		{
			int errors = lua_pcall (this.state_, arguments, results, 0);
			if (errors != 0)
			{
				istring error = popString ();

				// parse the error string to extract the address of the exception
				istring pointer_string = null;
				for (int start = error.length-6; start >= 0; start--)
				{
					if (error[start .. start + 4] == "LFE=")
					{
						for (int end = start+5; end < error.length; end++)
						{
							if (error[end] == ';')
							{
								pointer_string = error[start+4 .. end];
								break;
							}
						}
						break;
					}
				}

				if (pointer_string !is null)
				{
					void* p = cast (void*) string2int !(size_t) (pointer_string);
					LuaForwardException e = LuaForwardException.exceptions[p];
					LuaForwardException.exceptions.remove (p);
					e.forward ("LuaState.call");
					throw e;
				}
				else
				{
					throw new LuaCodeException (error, __FILE__, __LINE__);
				}
			}
		}
		else
		{
			lua_call (this.state_, arguments, results);
		}

		return this;
	}

	/*******************************************************************************

		Loads and runs the given string.

		Params:
		protection = whether this is a protected call. See LuaState.call
		code = Lua code to run.
		arguments = number of function arguments on the stack. Default is 0
		results = expected number of return values. Default is a variable number.
		chunk_name = Name of the code chunk.

		Remarks:
		Replaces luaL_dostring.

	******************************************************************************/

	public LuaState doString (bool protection, cstring code, uint arguments = 0, int results = MULTIPLE_RETURN_VALUES, cstring chunk_name = null)
	{
		load (code, chunk_name);

		return call (protection, arguments, results);
	}

	/// ditto

	public LuaState doString (bool protection, cstring code, cstring chunk_name, uint arguments = 0, int results = MULTIPLE_RETURN_VALUES)
	{
		return doString (protection, code, arguments, results, chunk_name);
	}

	/*******************************************************************************

		Loads and runs the given file.

		Params:
		protection = whether this is a protected call. See LuaState.call
		filename = Lua file to run.
		arguments = number of function arguments on the stack. Default is 0
		results = expected number of return values. Default is a variable number.

		Remarks:
		Replaces luaL_dofile.

	******************************************************************************/

	public LuaState doFile (bool protection, cstring filename, uint arguments = 0, int results = MULTIPLE_RETURN_VALUES)
	{
		loadFile (filename);

		return call (protection, arguments, results);
	}

	/*******************************************************************************

		If the object at the specified index has a metatable with the specified
		field, this method calls this field and passes the object as its only
		argument. In this case this function returns true and pushes the returned
		value onto the stack. If there is no metatable or no metamethod, this
		function returns false without pushing any value on the stack.

		Remarks:
		Replaces luaL_callmeta.

	******************************************************************************/

	public bool callMeta (int index, cstring field)
	{
		return luaL_callmeta (this.state_, index, toStringz (field)) != 0;
	}

	/*******************************************************************************

		If the function argument is number, returns this number cast to an int.
		If this argument is absent or is nil, returns the default value.
		Otherwise, raises an error.

		Remarks:
		Replaces luaL_optint, luaL_optlong and luaL_optinteger.

	******************************************************************************/

	public LuaInteger optInteger (uint argument, LuaInteger default_value)
	{
		return luaL_optint (this.state_, argument, default_value);
	}

	/*******************************************************************************

		If the function argument is number, returns this number.
		If this argument is absent or is nil, returns the default value.
		Otherwise, raises an error.

		Remarks:
		Replaces luaL_optnumber.

	******************************************************************************/

	public LuaNumber optNumber (uint argument, LuaNumber default_value)
	{
		return luaL_optnumber (this.state_, argument, default_value);
	}

	/*******************************************************************************

		If the function argument is a string, returns this string. If this
		argument is absent or is nil, returns the default value. Otherwise,
		raises an error.

		Remarks:
		Replaces luaL_optlstring and luaL_optstring.

	******************************************************************************/

	public istring optString (uint argument, cstring default_value)
	{
		size_t len;
		ichar* ptr = luaL_optlstring (this.state_, argument, toStringz (default_value), &len);

		return ptr[0 .. len];
	}

	/*******************************************************************************

		Checks whether the function argument is a string and searches for this
		string in the array value_list. Returns the index in the array where the
		string was found. Raises an error if the argument is not a string or if
		the string cannot be found.

		If default_value is not null, the function uses default_value as a default
		value when there is no argument or if this argument is nil.

		This is a useful function for mapping strings to enums. (The usual
		convention in Lua libraries is to use strings instead of numbers to
		select options.)

		Remarks:
		Replaces luaL_checkoption.

	******************************************************************************/

	public int checkOption (uint argument, char[][] value_list, cstring default_value = null)
	{
		istring name = (default_value !is null) ? optString (argument, default_value) : checkString (argument);

		foreach (i, s; value_list)
		{
			if (s == name)
				return i;
		}

		throw new LuaCodeException ("Invalid option: '" ~ name ~ "'", __FILE__, __LINE__);
	}

	/*******************************************************************************

		Raises a Lua error specified by the message argument. If the latter is
		null, this method takes the object on top of the stack as the error
		message. This method does a long jump, and therefore never returns.

		Params:
		message = The message to pass as the error code.

		Remarks:
		Replaces lua_error and luaL_error.

	******************************************************************************/

	public int raiseError (cstring message = null)
	{
		if (message !is null)
		{
			pushString (message);
		}
		return lua_error (this.state_);
	}

	/*******************************************************************************

		Raises a Lua error due to a bad function argument, where the function
		name is taken from the call stack.

		bad argument #<argument> to <function> (<message>)

		This method does a long jump, and therefore never returns.

		Params:
		argument = Which argument is wrong or missing.
		message = The error message.

		Remarks:
		Replaces luaL_argerror.

	******************************************************************************/

	public int argumentError (uint argument, cstring message)
	{
		return luaL_argerror (this.state_, argument, toStringz (message));
	}

	/*******************************************************************************

		Raises an error with a message like the following:

	 	<loc>: bad argument <argument> to '<func>' (<typename> expected, got <rt>)

		where loc is produced by LuaState.where, func is the name of the current
		function, and rt is the type name of the actual argument.

		This method does a long jump, and therefore never returns.

		Params:
		argument = Which argument is wrong or missing.
		typename = The expected type name.

		Remarks:
		Replaces luaL_typerror.

	******************************************************************************/

	public int typeError (uint argument, cstring typename)
	{
		return luaL_typerror (this.state_, argument, toStringz (typename));
	}

	/*******************************************************************************

		Constructs a LuaBuffer and attaches it to this state.

		Returns:
		The constructed Lua buffer.

	*******************************************************************************/

	public LuaBuffer createBuffer ()
	{
		return new LuaBuffer (this);
	}

	/*******************************************************************************

		Dumps a function as a binary chunk. Receives a Lua function on the top
		of the stack and produces a binary chunk that, if loaded again, results
		in a function equivalent to the one dumped. As it produces parts of the
		chunk, dump call the delegate with the given data to write them.

		The value returned is the error code returned by the last call to the
		delegate; 0 means no errors.

		This method does not pop the Lua function from the stack.

		Params:
		dg = Writer delegate

		Remarks:
		Replaces lua_dump.

	*******************************************************************************/

	public int dump (int delegate (cstring data) dg)
	{
		return lua_dump (this.state_, &writer, &dg);
	}

	/*******************************************************************************

		Dumps a function as a binary chunk. It works exactly like the above dump
		method, but instead of passing the data to a delegate, it returns the
		complete result in one character array.

	*******************************************************************************/

	public mstring dump ()
	{
		mstring result = [];

		int dumper (cstring data)
		{
			result ~= data;
			return 0;
		}

		dump (&dumper);

		return result;
	}

	/*******************************************************************************

		Loads a Lua chunk. If there are no errors, load pushes the compiled
		chunk as a Lua function on top of the stack. Otherwise, it raises
		either a LuaCodeException, if the code cannot be compiled or a
		LuaFatalException on other errors.

		This function only loads a chunk; it does not run it. It automatically
		detects whether the chunk is text or binary, and loads it accordingly.

		The load method uses a user-supplied reader delegate to read the chunk,
		which must return either data or null when called. The latter means,
		that there is no further data to read.

		The chunk_name argument gives a name to the chunk, which is used for
		error messages and in debug information.
		
		---
		auto L = new LuaState;
		L.doString (true, `
		function fac (n)
		  if n == 0 then
			return 1;
		  else
			return n * fac(n-1);
		  end
		end
		`);

		L.getGlobal ("fac"); // put function onto stack
		char[] data = L.dump (); // dump it
		L.pop (); // pop it
		L.load (data, "foo"); // reload function as chunk 'foo'
		L.setGlobal ("fac2"); // save it as the global function fac2
		---

		Params:
		dg = Reader delegate
		chunk_name = Name of this chunk

		Remarks:
		Replaces lua_load.

	*******************************************************************************/

	public LuaState load (cstring delegate () dg, cstring chunk_name = null)
	{
		int errors = lua_load (this.state_, &reader, &dg, toStringz (chunk_name));

		if (errors != 0)
		{
			if (errors == LUA_ERRSYNTAX)
				throw new LuaCodeException ("Syntax error during pre-compilation: " ~ popString, __FILE__, __LINE__);
			else
				throw new LuaFatalException (errors, __FILE__, __LINE__);
		}

		return this;
	}

	/*******************************************************************************

		Loads a Lua chunk. It works exactly like the above dump method, but
		instead of reading the data from a delegate, the whole data must be
		supplied at once in the first argument.

		Params:
		data = Either Lua code or a dumped Lua function.
		chunk_name = Name of this chunk

		Remarks:
		Replaces luaL_loadstring and luaL_loadbuffer.

	*******************************************************************************/

	public LuaState load (cstring data, cstring chunk_name = null)
	{
		bool done = false;

		load (
			  {
				  if (!done)
				  {
					  done = true;
				  }
				  else
				  {
					  data = "";
				  }
				  return data;
			  },
			  chunk_name );

		return this;
	}

	/*******************************************************************************

		Loads a file as a Lua chunk. This function uses the load method to load
		the chunk in the file named filename. If filename is null, then it loads
		from the standard input. The first line in the file is ignored if it
		starts with a #.

		In addition to the exceptions, load can throw, this method can also throws
		a LuaFatalException if it cannot opens the file.

		As the load method, this method only loads the chunk; it does not run it.

		Params:
		filename = File containing Lua code.
		
		Throws:
		LuaIOException, if an error occured while reading the file.
		LuaCodeException, if an error occured during pre-compilation.

		Remarks:
		Replaces luaL_loadfile.

	*******************************************************************************/

	public LuaState loadFile (cstring filename)
	{
		int errors = luaL_loadfile (this.state_, toStringz (filename));
		if (errors != 0)
		{
			if (errors == LUA_ERRSYNTAX)
				throw new LuaCodeException ("Syntax error during pre-compilation: " ~ popString, __FILE__, __LINE__);
			else if (errors == LUA_ERRFILE)
				throw new LuaIOException ("I/O error: loadFile failed to read \"" ~ filename ~ "\"!", __FILE__, __LINE__);
			else
				throw new LuaFatalException (errors, __FILE__, __LINE__);
		}
		return this;
	}

	/*******************************************************************************

		Controls the garbage collector.

		This method performs several tasks, according to the value of the
		command parameter:

	 	 * STOP: Stops the garbage collector.
	 	 * RESTART: Restarts the garbage collector.
	 	 * COLLECT: Performs a full garbage-collection cycle.
	 	 * COUNT: Returns the current amount of memory (in Kbytes) in use by Lua.
	 	 * STEP: Performs an incremental step of garbage collection. The step
	 	   "size" is controlled by data (larger values mean more steps) in a
	 	   non-specified way. If you want to control the step size you must
	 	   experimentally tune the value of data. The function returns 1 if the
	 	   step finished a garbage-collection cycle.
	 	 * SET_PAUSE: Sets data/100 as the new value for the pause of the
	 	   collector. The function returns the previous value of the pause.
	 	 * SET_STEP_MULTIPLIER: Sets data/100 as the new value for the step
	 	   multiplier of the collector. The function returns the previous
	 	   value of the step multiplier.

		Params:
		command = What the method should do.
		data = Parameter for STEP, SET_PAUSE and SET_STEP_MULTIPLIER.

		Remarks:
		Replaces lua_gc.

	*******************************************************************************/

	public int gc (LuaGarbageCollectorCommand command, int data = 0)
	{
		return lua_gc (this.state_, command, data);
	}

	/*******************************************************************************

		Returns true if the two values in acceptable indices a and b are
		primitively equal (that is, without calling metamethods). Otherwise
		returns false. Also returns 0 if any of the indices are non valid.

		Params:
		a = first index
		b = second index

		Remarks:
		Replaces lua_rawequal

	*******************************************************************************/

	public bool rawEqual (int a, int b)
	{
		return lua_rawequal (this.state_, a, b) != 0;
	}

	/*******************************************************************************

		Similar to getTable, but does a raw access (i.e., without metamethods):

		It pushes onto the stack the value t[k], where t is the value at the
		given valid index and k is the value at the top of the stack.

		This method pops the key from the stack (putting the resulting value in
		its place). Contrary to Lua and the getTable method, this method does
		not trigger any metamethods.

		Params:
		index = Index of the table.

		Remarks:
		Replaces lua_rawget

	*******************************************************************************/

	public LuaState rawGet (int index)
	{
		lua_rawget (this.state_, index);

		return this;
	}

	/*******************************************************************************

		Pushes onto the stack the value t[n], where t is the value at the given
		valid index. The access is raw; that is, it does not invoke metamethods.

		Params:
		index = Index of the table.
		n = Index in the table.

		Remarks:
		Replaces lua_rawgeti

	*******************************************************************************/

	public LuaState rawGetIndex (int index, int n)
	{
		lua_rawgeti (this.state_, index, n);

		return this;
	}

	/*******************************************************************************

		Similar to setTable, but does a raw assignment (i.e., without metamethods):

		Does the equivalent to t[k] = v, where t is the value at the given valid
		index, v is the value at the top of the stack, and k is the value just
		below the top.

		This function pops both the key and the value from the stack. Contrary to
		Lua and the getTable method, this method does not trigger any metamethods.

		Params:
		index = Index of the table.

		Remarks:
		Replaces lua_rawset

	*******************************************************************************/

	public LuaState rawSet (int index)
	{
		lua_rawset (this.state_, index);

		return this;
	}

	/*******************************************************************************

		Does the equivalent of t[n] = v, where t is the value at the given
		valid index and v is the value at the top of the stack.

		This method pops the value from the stack. The assignment is raw; that
		is, it does not invoke metamethods.

		Params:
		index = Index of the table.
		n = Index in the table.

		Remarks:
		Replaces lua_rawseti

	*******************************************************************************/

	public LuaState rawSetIndex (int index, int n)
	{
		lua_rawseti (this.state_, index, n);

		return this;
	}

	/*******************************************************************************

		Checks whether condition is true. If not, calls argumentError

		Params:
		condition = Condition to check.
		argument = Corresponding argument.
		message = The error message.

		Remarks:
		Replaces luaL_argcheck.

	*******************************************************************************/

	public LuaState checkArgument (bool condition, uint argument, cstring message)
	{
		luaL_argcheck (this.state_, condition, argument, toStringz (message));

		return this;
	}

	public alias checkArgument argCheck;

	/*******************************************************************************

		Checks whether the function has an argument of any type (including nil)
		at the given position.

		Params:
		argument = Position to check.

		Remarks:
		Replaces luaL_checkany.

	*******************************************************************************/

	public LuaState checkAny (int argument)
	{
		luaL_checkany (this.state_, argument);

		return this;
	}

	/*******************************************************************************

		Returns true if the given acceptable index is not valid (that is, it
		refers to an element outside the current stack), and false otherwise.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_isnone.

	 *******************************************************************************/

	public bool isNone (int index)
	{
		return lua_isnone (this.state_, index) != 0;
	}

	/*******************************************************************************

		Returns true if the value at the given acceptable index is nil, and
		false otherwise.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_isnil.

	*******************************************************************************/

	public bool isNil (int index)
	{
		return lua_isnil (this.state_, index) != 0;
	}

	/*******************************************************************************

		Returns true if the given acceptable index is not valid (that is, it
		refers to an element outside the current stack) or if the value at this
		index is nil, and false otherwise.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_isnoneornil.

	*******************************************************************************/

	public bool isNoneOrNil (int index)
	{
		return lua_isnoneornil (this.state_, index) != 0;
	}

	/*******************************************************************************

		Returns the "length" of the value at the given acceptable index:

		* For strings, this is the string length.
		* For tables, this is the result of the length operator ('#').
		* For userdata, this is the size of the block of memory allocated for it.
		* For other values, it is 0.

		Params:
		index = Index of the value.

		Remarks:
		Replaces lua_objlen.

	*******************************************************************************/

	public size_t objectLength (int index)
	{
		return lua_objlen (this.state_, index);
	}

	/*******************************************************************************

		Pushes a nil value onto the stack.

		Remarks:
		Replaces lua_pushnil.

	*******************************************************************************/

	public LuaState pushNil ()
	{
		lua_pushnil (this.state_);

		return this;
	}

	/*******************************************************************************

		Pushes a copy of the element at the given valid index onto the stack.

		Remarks:
		Replaces lua_pushvalue.

	*******************************************************************************/

	public LuaState pushValue (int index)
	{
		lua_pushvalue (this.state_, index);

		return this;
	}

	/*******************************************************************************

		Accepts any acceptable index, or 0, and sets the stack top to this index.
		If the new top is larger than the old one, then the new elements are
		filled with nil. If index is 0, then all stack elements are removed.

		Params:
		index = New stack size.

		Remarks:
		Replaces lua_settop.

	*******************************************************************************/

	public LuaState setTop (int index)
	{
		lua_settop (this.state_, index);

		return this;
	}

	/*******************************************************************************

		Returns the index of the top element in the stack. Because indices
		start at 1, this result is equal to the number of elements in the stack
		(and so 0 means an empty stack).

		Remarks:
		Replaces lua_gettop.

	*******************************************************************************/

	public int getTop ()
	{
		return lua_gettop (this.state_);
	}

	public alias getTop top;


	/*******************************************************************************

		Grows the stack size to top + needed elements, raising an error if the
		stack cannot grow to that size. message is an additional text to go into
		the error message.

		Params:
		needed = Needed stack slots.
		message = Optional message to add to the error message.

		Remarks:
		Replaces lua_checkstack and luaL_checkstack.

	*******************************************************************************/

	public LuaState checkStack (uint needed, cstring message = "")
	{
		if (lua_checkstack (this.state_, needed) == false)
			throw new LuaFatalException ("Fatal error: checkStack failed to grow stack! " ~ message, __FILE__, __LINE__);

		return this;
	}

	/*******************************************************************************

		Pops amount elements from the stack.

		Params:
		amount = Number of elements to pop. Default is 1.

		Remarks:
		Replaces lua_pop.

	*******************************************************************************/

	public LuaState pop (uint amount = 1)
	{
		lua_pop (this.state_, amount);

		return this;
	}

	/*******************************************************************************

		Removes the element at the given valid index, shifting down the elements
		above this index to fill the gap. Cannot be called with a pseudo-index,
		because a pseudo-index is not an actual stack position.

		Params:
		index = Index to remove.

		Remarks:
		Replaces lua_remove.

	*******************************************************************************/

	public LuaState remove (int index)
	{
		lua_remove (this.state_, index);

		return this;
	}

	/*******************************************************************************

		Moves the top element into the given position (and pops it), without
		shifting any element (therefore replacing the value at the given position).

		Params:
		index = Index to replace.

		Remarks:
		Replaces lua_replace.

	*******************************************************************************/

	public LuaState replace (int index)
	{
		lua_replace (this.state_, index);

		return this;
	}

	/*******************************************************************************

		Checks whether the function argument has the type.

		Params:
		argument = Function argument to check.
		type = Expected type.

		Remarks:
		Replaces luaL_checktype.

	*******************************************************************************/

	public LuaState checkType (int argument, LuaType type)
	{
		luaL_checktype (this.state_, argument, type);

		return this;
	}

	/*******************************************************************************

		Returns the type of the value in the given acceptable index, or
		LuaType.NONE for a non-valid index (that is, an index to an "empty" stack
		position).

		Params:
		index = Index of the value.

		Remarks:
		Replaces lua_type.

	*******************************************************************************/

	public LuaType type (int index)
	{
		return cast (LuaType) lua_type (this.state_, index);
	}

	/*******************************************************************************

		Returns the name of the type encoded by the value type, which must be
		one the values returned by type.

		Params:
		type = A Lua type.

		Remarks:
		Replaces lua_typename.
		luaL_typename is not wrapped, you must thus call typeName with the result
		of type

	*******************************************************************************/

	public istring typeName (LuaType type)
	{
		ichar* string = lua_typename (this.state_, type);
		return string [0 .. strlenz (string)];
	}

	/*******************************************************************************

		Checks whether the function argument argument is a number and returns
		this number cast to a LuaInteger.

		Params:
		argument = Function argument to check.

		Remarks:
		Replaces luaL_checkinteger, luaL_checkint and luaL_checklong.

	*******************************************************************************/

	public LuaInteger checkInteger (int argument)
	{
		return luaL_checkinteger (this.state_, argument);
	}

	/*******************************************************************************

		Converts the Lua value at the given acceptable index to the signed
		integral type LuaInteger. The Lua value must be a number or a string
		convertible to a number; otherwise, toInteger returns 0.

		If the number is not an integer, it is truncated in some non-specified way.

		Params:
		index = Index of the value.

		Remarks:
		Replaces lua_tointeger.

	*******************************************************************************/

	public LuaInteger toInteger (int index)
	{
		return lua_tointeger (this.state_, index);
	}

	/*******************************************************************************

		Pushes a number with the specified value onto the stack.

		Params:
		value = Integer to push.

		Remarks:
		Replaces lua_pushinteger.

	*******************************************************************************/

	public LuaState pushInteger (LuaInteger value)
	{
		lua_pushinteger (this.state_, value);

		return this;
	}

	/*******************************************************************************

		Checks whether the function argument is a number and returns this number.

		Params:
		argument = Function argument to check.

		Remarks:
		Replaces luaL_checknumber.

	*******************************************************************************/

	public LuaNumber checkNumber (int index)
	{
		return luaL_checknumber (this.state_, index);
	}

	/*******************************************************************************

		Converts the Lua value at the given acceptable index to the type LuaNumber.
		The Lua value must be a number or a string convertible to a number;
		otherwise, toNumber returns 0.

		Params:
		index = Index of the value.

		Remarks:
		Replaces lua_tonumber.

	*******************************************************************************/

	public LuaNumber toNumber (int index)
	{
		return lua_tonumber (this.state_, index);
	}

	/*******************************************************************************

		Pushes a number with the specified value onto the stack.

		Params:
		value = Number to push.

		Remarks:
		Replaces lua_pushnumber.

	*******************************************************************************/

	public LuaState pushNumber (LuaNumber value)
	{
		lua_pushnumber (this.state_, value);

		return this;
	}

	/*******************************************************************************

		Returns true if the value at the given acceptable index is a number or
		a string convertible to a number, and false otherwise.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_isnumber.

	*******************************************************************************/

	public bool isNumber (int index)
	{
		return lua_isnumber (this.state_, index) != 0;
	}

	/*******************************************************************************

		Returns true if the value at the given acceptable index has type
		boolean, and false otherwise.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_isboolean.

	*******************************************************************************/

	public bool isBool (int index)
	{
		return lua_isboolean (this.state_, index) != 0;
	}

	/*******************************************************************************

		Pushes a boolean with the specified value onto the stack.

		Params:
		value = Boolean value to push.

		Remarks:
		Replaces lua_pushboolean.

	*******************************************************************************/

	public LuaState pushBool (bool value)
	{
		lua_pushboolean (this.state_, value);

		return this;
	}

	/*******************************************************************************

		Converts the Lua value at the given acceptable index to a bool value.
		Like all tests in Lua, toBool returns true for any Lua value different
		from false and nil; otherwise it returns false. It also returns false
		when called with a non-valid index. (If you want to accept only actual
		boolean values, use isBool to test the value's type.)

		Params:
		index = Index of the value.

		Remarks:
		Replaces lua_toboolean.

	*******************************************************************************/

	public bool toBool (int index)
	{
		return lua_toboolean (this.state_, index) != 0;
	}

	/*******************************************************************************

		Checks whether the function argument is a string and returns this string.

		Params:
		argument = Function argument to check.

		Remarks:
		Replaces luaL_checkstring.

	*******************************************************************************/

	public istring checkString (int index)
	{
		uint len;
		ichar* str = luaL_checklstring (this.state_, index, &len);
		return str[0 .. len];
	}

	/*******************************************************************************

		Returns true if the value at the given acceptable index is a string or
		a number (which is always convertible to a string), and false otherwise.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_isstring.

	*******************************************************************************/

	public bool isString (int index)
	{
		return lua_isstring (this.state_, index) != 0;
	}

	/*******************************************************************************

		Pushes the string onto the stack. Lua makes (or reuses) an internal copy
		of the given string, so the memory can be freed or reused immediately
		after the function returns.

		Params:
		string = String to push.

		Remarks:
		Replaces lua_pushstring, lua_pushliteral and lua_pushlstring.

	*******************************************************************************/

	public LuaState pushString (cstring string)
	{
		lua_pushlstring (this.state_, string.ptr, string.length);

		return this;
	}

	/*******************************************************************************

		Converts the Lua value at the given acceptable index to a string. The Lua
		value must be a string or a number; otherwise, the function returns null.
		If the value is a number, then toString also changes the actual value in
		the stack to a string. (This change confuses next when toString is applied
		to keys during a table traversal.)

		toString returns a fully aligned pointer to a string inside the Lua state.
		This string always has a zero ('\0') after its last character (as in C),
		but may contain other zeros in its body.
		Because Lua has garbage collection, there is no guarantee that the pointer
		returned by toString will be valid after the corresponding value
		is removed from the stack.

		Params:
		index = Index of the value.

		Remarks:
		Replaces lua_tostring and lua_tolstring.

	*******************************************************************************/

	public istring toString (int index)
	{
		uint len;
		ichar* str = lua_tolstring (this.state_, index, &len);
		return str[0 .. len];
	}

	/*******************************************************************************

		Returns the same as toString(-1) and pops the value afterwards.

	*******************************************************************************/

	public istring popString ()
	{
		istring result = toString (-1);
		pop ();
		return result;
	}

	/*******************************************************************************

		Returns true if the value at the given acceptable index is a function
		(either C, D or Lua), and false otherwise.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_isfunction.

	*******************************************************************************/

	public bool isFunction (int index)
	{
		return lua_isfunction (this.state_, index) != 0;
	}

	/*******************************************************************************

		Converts a value at the given acceptable index to a C function. That
		value must be a C function; otherwise, returns null.

		Params:
		index = Index of the value.

		Remarks:
		Replaces lua_tocfunction.

	*******************************************************************************/

	public LuaCFunction toCFunction (int index)
	{
		return lua_tocfunction (this.state_, index);
	}

	/*******************************************************************************

		Pushes a new C closure onto the stack.

		When a C function is created, it is possible to associate some values
		with it, thus creating a C closure; these values are then accessible
		to the function whenever it is called. To associate values with a C
		function, first these values should be pushed onto the stack (when there
		are multiple values, the first value is pushed first).Then
		pushCClosure is called to create and push the C function onto the stack,
		with the argument upvalues telling how many values should be associated
		with the function. pushCClosure also pops these values from the stack.

		Params:
		cfunction = C function to push.
		upvalues = Number of upvalues.

		Remarks:
		Replaces lua_pushcclosure and lua_pushcfunction.

	*******************************************************************************/

	public LuaState pushCClosure (LuaCFunction cfunction, int upvalues = 0)
	{
		lua_pushcclosure (this.state_, cfunction, upvalues);

		return this;
	}
	public alias pushCClosure pushCFunction;

	/*******************************************************************************

		Returns true if the value at the given acceptable index is a C or D
		function, and false otherwise.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_iscfunction.

	*******************************************************************************/

	public bool isCFunction (int index)
	{
		return lua_iscfunction (this.state_, index) != 0;
	}

	/*******************************************************************************

		Pushes onto the stack the environment table of the value at the given index.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_getfenv.

	*******************************************************************************/

	public LuaState getFunctionEnvironment (int index)
	{
		lua_getfenv (this.state_, index);

		return this;
	}

	/*******************************************************************************

		Pops a table from the stack and sets it as the new environment for the
		value at the given index. If the value at the given index is neither a
		function nor a thread nor a userdata, it a LuaCodeException is thrown.

		Params:
		index = Index of the object

		Remarks:
		Replaces lua_setfenv.

	*******************************************************************************/

	public LuaState setFunctionEnvironment (int index)
	{
		if (lua_setfenv (this.state_, index) == 0)
			throw new LuaCodeException ("Cannot set function environment for " ~ typeName (type (index)), __FILE__, __LINE__);

		return this;
	}

	/*******************************************************************************

		Returns true if the value at the given acceptable index is a table,
		and false otherwise.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_istable.

	*******************************************************************************/

	public bool isTable (int index)
	{
		return lua_istable (this.state_, index) != 0;
	}

	/*******************************************************************************

		Creates a new empty table and pushes it onto the stack. The new table
		has the specified space for array-elements and record-elements, which
		both default to 0.

		Params:
		array_elements = Number of array elements
		record_elements = Number of record elements

		Remarks:
		Replaces lua_createtable and lua_newtable.

	*******************************************************************************/

	public LuaState createTable (uint array_elements = 0, uint record_elements = 0)
	{
		lua_createtable (this.state_, array_elements, record_elements);

		return this;
	}

	public alias createTable newTable;

	/*******************************************************************************

		Does the equivalent to t[k] = v, where t is the value at the given valid
		index, v is the value at the top of the stack, and k is the value just
		below the top.

		This method pops both the key and the value from the stack. As in Lua,
		this function may trigger a metamethod for the "newindex" event.

		Params:
		index = Index of the table.

		Remarks:
		Replaces lua_settable.

	*******************************************************************************/

	public LuaState setTable (int index)
	{
		lua_settable (this.state_, index);

		return this;
	}

	/*******************************************************************************

	 	Pushes onto the stack the value t[k], where t is the value at the given
	 	valid index and k is the value at the top of the stack.

		This method pops the key from the stack (putting the resulting value in
		its place). As in Lua, this function may trigger a metamethod for the
		"index" event.

		Params:
		index = Index of the table.

		Remarks:
		Replaces lua_gettable.

	*******************************************************************************/

	public LuaState getTable (int index)
	{
		lua_gettable (this.state_, index);

		return this;
	}

	/*******************************************************************************

	 	Pops a key from the stack, and pushes a key-value pair from the table at the
	 	given index (the "next" pair after the given key), returning true. If there
	 	are no more elements in the table, then next returns false (and pushes
	 	nothing).

		A typical traversal looks like this:
		---
		L.pushNil ();
		while (L.next (t))
		{
			Stdout.formatln ("Key: {}, Value: {}", L.typeName (L.type (-2)), L.typeName (L.type (-1)));
			L.pop ();
		}
		 ---

		While traversing a table, do not call toString directly on a key, unless you
		know that the key is actually a string. Recall that toString changes the value
		at the given index; this confuses the next call to next.

		Params:
		index = Index of the table.

		Remarks:
		Replaces lua_next.

	*******************************************************************************/

	public bool next (int index)
	{
		return lua_next (this.state_, index) != 0;
	}

	/*******************************************************************************

	 	Creates and returns a reference, in the table at index t, for the object
	 	at the top of the stack (and pops the object).

		A reference is a unique integer key. As long as you do not manually add
		integer keys into table t, createReference ensures the uniqueness of the
		key it returns. You can retrieve an object referred by reference r by
		calling rawGetIndex (t, r). Function releaseReference frees a reference
		and its associated object.

		If the object at the top of the stack is nil, createReference returns
		the constant LUA_REFNIL. The constant LUA_NOREF is guaranteed to be
		different from any reference returned by createReference.

		Params:
		index = Index of the table.

		Remarks:
		Replaces luaL_ref.

	*******************************************************************************/

	public int createReference (int index)
	{
		return luaL_ref (this.state_, index);
	}

	/*******************************************************************************

	 	Releases reference ref from the table at index t (see createReference).
	 	The entry is removed from the table, so that the referred object can be
	 	collected. The reference ref is also freed to be used again.

		If ref is LUA_NOREF or LUA_REFNIL, releaseReference does nothing.

		Params:
		table_index = Index of the table.
		reference = Reference

		Remarks:
		Replaces luaL_unref.

	*******************************************************************************/

	public LuaState releaseReference (int table_index, int reference)
	{
		luaL_unref (this.state_, table_index, reference);

		return this;
	}

	/*******************************************************************************

	 	Pushes onto the stack the value t[k], where t is the value at the given
	 	valid index. As in Lua, this function may trigger a metamethod for the
	 	"index" event.

		Params:
		index = Index of the table.
		key = Name of the field.

		Remarks:
		Replaces lua_getfield.

	*******************************************************************************/

	public LuaState getField (int index, cstring key)
	{
		lua_getfield (this.state_, index, toStringz (key));

		return this;
	}

	/*******************************************************************************

		Does the equivalent to t[k] = v, where t is the value at the given valid
   		index and v is the value at the top of the stack.

		This function pops the value from the stack. As in Lua, this function may
		trigger a metamethod for the "newindex" event.

		Params:
		index = Index of the table.
		key = Name of the field.

		Remarks:
		Replaces lua_setfield.

	*******************************************************************************/

	public LuaState setField (int index, cstring key)
	{
		lua_setfield (this.state_, index, toStringz (key));

		return this;
	}

	/*******************************************************************************

		Pops a value from the stack and sets it as the new value of global name.

		Params:
		index = Index of the table.
		key = Name of the field.

		Remarks:
		Replaces lua_setglobal.

	*******************************************************************************/

	public LuaState setGlobal (cstring name)
	{
		lua_setfield (this.state_, LUA_GLOBALSINDEX, toStringz (name));

		return this;
	}

	/*******************************************************************************

		Pushes onto the stack the value of the global name.

		Params:
		key = Name of the field.

		Remarks:
		Replaces lua_getglobal.

	*******************************************************************************/

	public LuaState getGlobal (cstring key)
	{
		int last_dot = -1;
		foreach (i, c; key)
		{
			if (c == '.')
			{
				if (last_dot < 0)
				{
					lua_getfield (this.state_, LUA_GLOBALSINDEX, (key[0 .. i] ~ '\0').ptr);
					last_dot = i;
				}
				else
				{
					lua_getfield (this.state_, -1, (key[last_dot + 1 .. i] ~ '\0').ptr);
					lua_remove (this.state_, -2);
					last_dot = i;
				}
			}
		}

		if (last_dot < 0)
			lua_getfield (this.state_, LUA_GLOBALSINDEX, toStringz (key));
		else
		{
			lua_getfield (this.state_, -1, (key[last_dot + 1 .. $] ~ '\0').ptr);
			lua_remove (this.state_, -2);
		}

		return this;
	}

	/*******************************************************************************

		If the registry already has the key name, returns false. Otherwise,
		creates a new table to be used as a metatable for userdata, adds it to
		the registry with key name, and returns true.

		In both cases pushes onto the stack the final value associated with name
		in the registry.

		Params:
		name = Name of the metatable.

		Remarks:
		Replaces luaL_newmetatable.

	*******************************************************************************/

	public bool newMetatable (cstring name)
	{
		return luaL_newmetatable (this.state_, toStringz (name)) != 0;
	}

	/*******************************************************************************

	 	Pushes onto the stack the metatable of the value at the given acceptable
	 	index, returning true. If the index is not valid, or if the value does
	 	not have a metatable, the function returns false and pushes nothing on
	 	the stack.

		Params:
		index = Index of the object.

		Remarks:
		Replaces lua_getmetatable.

	*******************************************************************************/

	public bool getMetatable (int index)
	{
		return lua_getmetatable (this.state_, index) != 0;
	}

	/*******************************************************************************

	 	Pushes onto the stack the metatable associated with name in the registry.

		Params:
		name = Name of the metatable.

		Remarks:
		Replaces luaL_getmetatable.

	*******************************************************************************/

	public LuaState getMetatable (cstring name)
	{
		luaL_getmetatable (this.state_, toStringz (name));

		return this;
	}

	/*******************************************************************************

 		Pops a table from the stack and sets it as the new metatable for the
 		value at the given acceptable index.

		Params:
		index = Index of the value.

		Remarks:
		Replaces lua_setmetatable.

	*******************************************************************************/

	public LuaState setMetatable (int index)
	{
		lua_setmetatable (this.state_, index);

		return this;
	}

	/*******************************************************************************

		Pushes onto the stack the field from the metatable of the object at the
		given index, returning true. If the object does not have a metatable, or if
		the metatable does not have this field, returns false and pushes nothing.

		Params:
		index = Index of the value.
		field = Field to access.

		Remarks:
		Replaces luaL_getmetafield.

	*******************************************************************************/

	public int getMetafield (int index, cstring field)
	{
		return luaL_getmetafield (this.state_, index, toStringz (field));
	}

	/*******************************************************************************

		This function allocates a new block of memory with the given size, pushes
		onto the stack a new full userdata with the block address, and returns
		this address.

		Userdata represents C values in Lua. A full userdata represents a block
		of memory. It is an object (like a table): you must create it, it can
		have its own metatable, and you can detect when it is being collected.
		A full userdata is only equal to itself (under raw equality).

		When Lua collects a full userdata with a gc metamethod, Lua calls the
		metamethod and marks the userdata as finalized. When this userdata is
		collected again then Lua frees its corresponding memory.

		Params:
		size = Memory size to allocate.

		Remarks:
		Replaces lua_newuserdata.

	*******************************************************************************/

	public void* newUserdata (uint size)
	{
		return lua_newuserdata (this.state_, size);
	}

	/*******************************************************************************

		If the value at the given acceptable index is a full userdata, returns
		its block address. If the value is a light userdata, returns its pointer.
		Otherwise, returns null.

		Params:
		index = Index of the value.

		Remarks:
		Replaces lua_touserdata.

	******************************************************************************/

	public void* toUserdata (int index)
	{
		return lua_touserdata (this.state_, index);
	}

	/*******************************************************************************

		Returns true if the value at the given acceptable index is a userdata
		(either full or light), and false otherwise.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_isuserdata.

	******************************************************************************/

	public bool isUserdata (int index)
	{
		return lua_isuserdata (this.state_, index) != 0;
	}

	/*******************************************************************************

		Checks whether the function argument is a userdata of the type name.

		Params:
		argument = Function argument to check.

		Remarks:
		Replaces luaL_checkudata.

	******************************************************************************/

	public void* checkUserdata (int argument, cstring name)
	{
		return luaL_checkudata (this.state_, argument, toStringz (name));
	}

	/*******************************************************************************

		Returns true if the value at the given acceptable index is a light
		userdata, and false otherwise.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_islightuserdata.

	*******************************************************************************/

	public bool isLightUserdata (int index)
	{
		return lua_islightuserdata (this.state_, index) != 0;
	}

	/*******************************************************************************

		Pushes a light userdata onto the stack.

		Userdata represent C values in Lua. A light userdata represents a pointer.
		It is a value (like a number): you do not create it, it has no individual
		metatable, and it is not collected (as it was never created). A light
		userdata is equal to "any" light userdata with the same C address.

		Params:
		pointer = The address to push

		Remarks:
		Replaces lua_pushlightuserdata.

	*******************************************************************************/

	public LuaState pushLightUserdata (void* pointer)
	{
		lua_pushlightuserdata (this.state_, pointer);

		return this;
	}

	/*******************************************************************************

		Moves the top element into the given valid index, shifting up the
		elements above this index to open space. Cannot be called with a
		pseudo-index, because a pseudo-index is not an actual stack position.

		Params:
		index = Index to move to top element to.

		Remarks:
		Replaces lua_insert.

	*******************************************************************************/

	public LuaState insert (int index)
	{
		lua_insert (this.state_, index);

		return this;
	}

	/*******************************************************************************

		Concatenates the amount values at the top of the stack, pops them, and
		leaves the result at the top. If amount is 1, the result is the single
		value on the stack (that is, the function does nothing); if n is 0,
		the result is the empty string. Concatenation is performed following
		the usual semantics of Lua.

		Params:
		amount = Number of stack positions to concatenate.

		Remarks:
		Replaces lua_concat.

	*******************************************************************************/

	public LuaState concat (uint amount)
	{
		lua_concat (this.state_, amount);

		return this;
	}

	/*******************************************************************************

 		Returns true if the two values in acceptable indices a and b are equal,
 		following the semantics of the Lua == operator (that is, may call
 		metamethods). Otherwise returns false. Also returns false if any of the
 		indices is non valid.

		Params:
		a = First index
		b = Second index

		Remarks:
		Replaces lua_equal.

	*******************************************************************************/

	public bool equal (int a, int b)
	{
		return lua_equal (this.state_, a, b) != 0;
	}

	/*******************************************************************************

		Returns true if the value at acceptable index a is smaller than the value
		at acceptable index b, following the semantics of the Lua < operator
		(that is, may call metamethods). Otherwise returns false. Also returns
		false if any of the indices is non valid.

		Params:
		a = First index
		b = Second index

		Remarks:
		Replaces lua_lessthan.

	*******************************************************************************/

	public bool lessthan (int a, int b)
	{
		return lua_lessthan (this.state_, a, b) != 0;
	}

	/*******************************************************************************

	 	Converts the value at the given acceptable index to a Lua thread
	 	(represented as LuaState). This value must be a thread; otherwise,
	 	the function returns null.

		Params:
		index = Index of the thread object.

		Remarks:
		Replaces lua_tothread.

	*******************************************************************************/

	public LuaState toThread (int index)
	{
		lua_State* state = lua_tothread (this.state_, index);
		if (state is null)
			return null;
		else
		{
			auto thread = new LuaState (this.write_, state);
			thread.is_thread_state_ = true;
			return thread;
		}
	}

	/*******************************************************************************

		Returns true if the value at the given acceptable index is a thread,
		and false otherwise.

		Params:
		index = Index to check.

		Remarks:
		Replaces lua_isthread.

	*******************************************************************************/

	public bool isThread (int index)
	{
		return lua_isthread (this.state_, index) != 0;
	}

	/*******************************************************************************

		Creates a new thread, pushes it on the stack, and returns a LuaState that
		represents this new thread. The new state returned by this function shares
		with the original state all global objects (such as tables), but has an
		independent execution stack.

		There is no explicit function to close or to destroy a thread. Threads are
		subject to garbage collection, like any Lua object.

		Remarks:
		Replaces lua_newthread.

	*******************************************************************************/

	public LuaState newThread ()
	{
		auto thread = new LuaState (this.write_, lua_newthread (this.state_));
		thread.is_thread_state_ = true;
		return thread;
	}

	/*******************************************************************************

		Pushes the thread represented by the argument onto the stack. Returns
		true if this thread is the main thread of its state.

		Remarks:
		Replaces lua_pushthread.

	*******************************************************************************/

	public bool pushThread (LuaState thread)
	{
		return lua_pushthread (thread.state_) == 1;
	}

	/*******************************************************************************

		Yields a coroutine.

		This function should only be called as the return expression of a
		function, as follows:
		---
	 	return L.yield (result_number);
	 	---

		When a function calls yield in that way, the running coroutine suspends
		its execution, and the call to resume that started this coroutine returns.
		The parameter results is the number of values from the stack that are
		passed as results to resume.

		Params:
		results = Number of results

		Remarks:
		Replaces lua_yield.

	*******************************************************************************/

	public int yield (int results)
	{
		return lua_yield (this.state_, results);
	}

	/*******************************************************************************

		Starts and resumes a coroutine in a given thread.

		To start a coroutine, you first create a new thread (see newThread);
		then you push onto its stack the main function plus any arguments; then
		you call resume, with the number of arguments. This call returns when
		the coroutine suspends or finishes its execution. When it returns, the
		stack contains all values passed to yield, or all values returned by the
		body function. resume returns true if the coroutine yields, false if the
		coroutine finishes its execution without errors.

		To restart a coroutine, you put on its stack only the values to be passed
		as results from yield, and then call resume.

		Params:
		arguments = Arguments to the coroutine.

		Remarks:
		Replaces lua_resume.

	*******************************************************************************/

	public bool resume (uint arguments)
	{
		int errors = lua_resume (this.state_, arguments);
		if (errors == 0)
			return false;
		else if (errors == LUA_YIELD)
			return true;
		else
			throw new LuaFatalException (errors, __FILE__, __LINE__);
	}

	/*******************************************************************************

		Returns the status of the thread.

		The status can be false for a normal thread or true if the thread is
		suspended.

		Remarks:
		Replaces lua_status.

	*******************************************************************************/

	public bool status ()
	{
		int errors = lua_status (this.state_);
		if (errors == 0)
			return false;
		else if (errors == LUA_YIELD)
			return true;
		else
			throw new LuaFatalException (errors, __FILE__, __LINE__);
	}

	/*******************************************************************************

		Exchange values between different threads of the same global state.

		This function pops amount values from the stack of from_thread,
		and pushes them onto the stack of to_thread.

		Remarks:
		Replaces lua_xmove.

	*******************************************************************************/

	public static void xmove (LuaState from_thread, LuaState to_thread, int amount)
	{
		lua_xmove (from_thread.state_, to_thread.state_, amount);
	}

	/*******************************************************************************

		Converts the value at the given acceptable index to a generic pointer
		(void*). The value may be a userdata, a table, a thread, or a function;
		otherwise, toPointer returns null. Different objects will give different
		pointers. There is no way to convert the pointer back to its original value.

		Typically this function is used only for debug information.

		Params:
		index = Index of the object.

		Remarks:
		Replaces lua_xmove.

	*******************************************************************************/

	public void* toPointer (int index)
	{
		return lua_topointer (this.state_, index);
	}

	/*******************************************************************************

		Returns the Activation Record of a given level. It contains information
		about the function like name, type (C vs. Lua), position in source, etc.

		Level 0 is the current running function, whereas level n+1 is the
		function that has called level n.

		Returns null, if level is greater than the stack depth.

		Params:
		level = Level of the function.

		Remarks:
		Replaces lua_getstack.

	*******************************************************************************/

	public LuaActivationRecord getActivationRecord (uint level)
	{
		lua_Debug record;

		if (lua_getstack (this.state_, level, &record))
			return new LuaActivationRecord (this.state_, &record);
		else
			return null;
	}

	/*******************************************************************************

		Returns the current Call Trace which contains all Activation Records.

	*******************************************************************************/

	public LuaCallTrace getCallTrace ()
	{
		return new LuaCallTrace (this);
	}

	/*******************************************************************************

		Returns the current Stack Trace which contains all Objects on the stack.

	*******************************************************************************/

	public LuaStackTrace getStackTrace ()
	{
		return new LuaStackTrace (this);
	}

	/*******************************************************************************

		Returns a LuaObject (more precisely a subclass of it) of the value at
		the given index. Nil, Threads, Numbers, Bool, Strings, LightUserdata, Tables and
		C functions are complete and independent of this Lua state, Userdata only
		contains the pointer and Lua functions are not supported yet.

		This is useful for stack traces (see getStackTrace) and to save a Lua
		value (or whole tables) in a binary format. See LuaObject's methods.

		Example:
		---
		auto L = new LuaState;
		L.pushNil ();
		L.pushNumber (2.0);
		L.pushInteger (3);
		
		Stdout.formatln ("{} {} {}", L.getObject (-3), L.getObject (-2), L.getObject (-1));
		---

	*******************************************************************************/

	// TODO: Support Lua functions (They should be dumped / loaded)

	public LuaObject getObject (int index)
	{
		LuaType type = type (index);
		switch (type)
		{
			case LuaType.NIL: return new LuaNilObject ();
			case LuaType.NUMBER: return new LuaNumberObject (toNumber (index));
			case LuaType.BOOL: return new LuaBoolObject (toBool (index));
			case LuaType.STRING: return new LuaStringObject (toString (index));
			case LuaType.USERDATA: return new LuaUserdataObject (toUserdata (index), false);
			case LuaType.LIGHTUSERDATA: return new LuaUserdataObject (toUserdata (index), true);
			case LuaType.FUNCTION: return new LuaFunctionObject (toCFunction (index));
			case LuaType.TABLE: return new LuaTableObject (this, index);
			default: return null;
		}
	}

	/*******************************************************************************

		Pushes onto the stack the given object.

		Remarks:
		This does not work for plain Userdata and Lua function!

	*******************************************************************************/

	public void pushObject (LuaObject obj)
	{
		obj.push (this);
	}

	/*******************************************************************************

		Pushes onto the stack a string identifying the current position of the
		control at the given level in the call stack. Typically this string has
		the following format:

	 	chunkname:currentline:

		Level 0 is the running function, level 1 is the function that called the
		running function, etc.

		This function is used to build a prefix for error messages.

		Params:
		level = Debug level

		Remarks:
		Replaces luaL_where.

	*******************************************************************************/

	public LuaState where (int level)
	{
		luaL_where (this.state_, level);

		return this;
	}

	/*******************************************************************************

	 	Registers all functions from the given list under the given Lua library
	 	name that match the category bit-mask.

		Params:
		functions = List of functions with associated category
		library_name = Name of the library
		categories = Bit-mask to select the functions to register, default is to select all.

	*******************************************************************************/

	public LuaState registerLibrary (LuaRegistry[] functions, cstring library_name = null, int categories = -1)
	{
		foreach (LuaRegistry reg; functions)
		{
			if (reg.category == 0 || (reg.category & categories) != 0)
			{
				registerFunction (reg.name, reg.cfunction, library_name);
			}
		}

		return this;
	}

	/*******************************************************************************

	 	Registers a C function as a global function in the given Lua library.

		Params:
		cfunction = Functions to register
		library_name = Name of the library
		name = Name of the function in Lua

		Remarks:
		Together with registerMethod, replaces lua_register and luaL_register.

	*******************************************************************************/

	public LuaState registerFunction (cstring name, LuaCFunction cfunction, cstring library_name = null)
	{
		if (library_name is null)
		{
			lua_register (this.state_, toStringz (name), cast (lua_CFunction) cfunction);
		}
		else
		{
			extern (C) static luaL_reg[] reg = [ { null, null }, {null, null} ];
			reg[0].name = toStringz (name);
			reg[0].func = cast (lua_CFunction) cfunction;

			luaL_register (this.state_, toStringz (library_name), reg.ptr);
			pop ();
		}

		return this;
	}

	/*******************************************************************************

	 	Registers a C function as a method of the table ontop of the stack.

		Params:
		cfunction = Functions to register
		name = Name of the function in Lua

		Remarks:
		Together with registerFunction, replaces luaL_register.

	*******************************************************************************/

	public LuaState registerMethod (cstring name, LuaCFunction cfunction)
	{
		extern (C) static luaL_reg[] reg = [ { null, null }, {null, null} ];

		reg[0].name = toStringz (name);
		reg[0].func = cast (lua_CFunction) cfunction;

		luaL_register (this.state_, null, reg.ptr);

		return this;
	}
	
	/*******************************************************************************

	 	Wraps a D class instance, whose class type must be registered first, in
	 	a special userdata and attaches the corresponding metatable to it. Pushes
	 	the result onto the stack.

		Params:
		instance = Class instance to wrap

		Remarks:
		Together with registerFunction, replaces luaL_register.

	*******************************************************************************/

	public LuaState wrapClass (T) (T instance)
	{
		wrapClassHelper (instance, typeid (T).toString);
		return this;
	}

	/*******************************************************************************

 		Imagine you register a lot of classes.
		This helper method for wrapClass reduces the size of generated wrapClass methods.

		Params:
		instance = Class instance to wrap
		typeString = Name of the class type 

	*******************************************************************************/
	
	private void wrapClassHelper (Object instance, cstring typeString)
	{
		auto ptr = cast (Object *) newUserdata ( (Object *).sizeof);
		*ptr = instance;

		loadClassMetatable (typeString); // leaves the metatable on the stack
		setMetatable (-2); // pops table and sets it as metatable of the userdata
	}

	/*******************************************************************************

	 	Unwraps a userdata at a given index into a D class instance, whose class
	 	type must be registered first. The template parameter is the class type.

		Params:
		index = Index to unwrap.

	*******************************************************************************/

	public T unwrapClass (T) (int index)
	{
		void* userdata = checkUserdata (index, mangleClass (typeid (T).toString));

		if (userdata is null)
			throw new LuaFatalException ("Error in LuaState.unwrapClass: Cannot unwrap userdata to class " ~ typeid (T).toString ~ "! It is not registered for this LuaState!", __FILE__, __LINE__);

		T instance = * (cast (T *) userdata);

		return instance;
	}

	/*******************************************************************************

	 	Loads a class Metatable and creates it, if it does not exist.
	 	Leaves the metatable on the stack.

	*******************************************************************************/

	public LuaState loadClassMetatable (cstring class_name)
	{
		class_name = mangleClass (class_name);
		getMetatable (class_name);
    	if (isNil (-1)) // if the metatable hasn't been loaded yet, create it
    	{
    		pop (); // remove the nil
    		newMetatable (class_name); // create a new metatable t, push it and assoc. it with class_name in the registry
    		pushString ("__index"); // table index
    		pushValue (-2); // pushes the metatable
    		setTable (-3); // metatable.__index = metatable
		}

		return this;
	}

	
	/*******************************************************************************

	 	Registers a D class in Lua, creating its metatable. The template parameter
	 	must be the class.

	*******************************************************************************/

	public LuaState registerClass (T) ()
	{
		loadClassMetatable (typeid (T).toString ());
		pop ();

		return this;
	}

	/*******************************************************************************

 		Internal print function for Lua, which prints to the writer delegate
 		associated to the state.

		Params:
		lua_state = Internal Lua state pointer

	*******************************************************************************/

	private extern (C) static int print (lua_State *lua_state)
	{
		LuaState L = states[lua_state];

		int argc = L.getTop ();
		L.getGlobal ("tostring");
		for (int i = 1; i <= argc; i++)
		{
			L.pushValue (-1);
			L.pushValue (i);
			L.call (false, 1, 1);
			istring s = L.toString(-1);
			if (s is null)
			{
				return L.raiseError ("'tostring' must return a string to 'print'");
			}
			if (i > 1)
			{
				L.write ("\t");
			}
			L.write (s);
			L.pop (1);
		}
		L.write ("\n");
		return 0;
	}

	/*******************************************************************************

	 	Internal writer function, wrapping Writer delegates for the dump family.

		Params:
		lua_state = Internal Lua state pointer
		ptr = Pointer to the buffer to write
		size = Size of the buffer
		userdata = Userdata containing the delegate pointer

	*******************************************************************************/

	private extern (C) static int writer (lua_State* lua_state, void* ptr, uint size, void* userdata)
	{
		return ( * (cast (int delegate (char[] data) *) userdata )) ((cast (char*) ptr)[0 .. size]);
	}

	/*******************************************************************************

	 	Internal reader function, wrapping Reader delegates for the load family.

		Params:
		lua_state = Internal Lua state pointer
		userdata = Userdata containing the delegate pointer
		psize = Return-parameter for the read size.

	*******************************************************************************/

	private extern (C) static char* reader (lua_State* lua_state, void* userdata, size_t* psize)
	{
		char[] data = ( * (cast (char[] delegate () *) userdata )) ();

		*psize = data.length;
		return data.ptr;
	}

	/// Associative array which maps C states to D state classes
	private static LuaState[lua_State*] states;
}

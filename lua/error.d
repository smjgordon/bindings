/*******************************************************************************

	copyright:      Copyright (c) 2008 Matthias Walter. All rights reserved

    authors:        Matthias Walter, Andreas Hollandt

*******************************************************************************/

module lua.error;

private import lua.common;
private import lua.lua;
private import lua.lauxlib;
private import lua.data;
private import lua.state;
private import lua.utils : strlenz, int2string;

/*******************************************************************************

	LuaActivationRecords contain information about running functions. This
	is useful for debugging purposes.

*******************************************************************************/

class LuaActivationRecord
{
	/// Code type of activation records

	public enum CodeType : int
	{
		LUA,
		C,
		MAIN,
		TAIL
	}

	/// Name type of activation records

	enum NameType : int
	{
		GLOBAL,
		LOCAL,
		METHOD,
		FIELD,
		UPVALUE,
		UNKNOWN
	}

    /***************************************************************************

		Converts the given string into a Code type.

		Params:
		str = String representation of the Code type

    ***************************************************************************/

	private static CodeType parseCodeType (cstring str)
	{
		switch (str)
		{
			case "Lua": return CodeType.LUA;
			case "C": return CodeType.C;
			case "main": return CodeType.MAIN;
			case "tail": return CodeType.TAIL;
			default: throw new LuaFatalException ("parseCodeType: " ~ str ~ " is an invalid LuaCodeType.");
		}
	}

    /***************************************************************************

		Converts the given Code type into its string representation.

		Params:
		code_type = Code type

    ***************************************************************************/

	public static istring toString (CodeType code_type)
	{
		switch (code_type)
		{
			case CodeType.LUA: return "Lua";
			case CodeType.C: return "C";
			case CodeType.MAIN: return "main";
			case CodeType.TAIL: return "tail call";
			default: throw new LuaFatalException ("toString: " ~ int2string(cast(int)code_type) ~ " is an invalid LuaCodeType.");
		}
	}

    /***************************************************************************

		Converts the given string into a Name type.

		Params:
		str = String representation of the Name type

    ***************************************************************************/

	private static NameType parseNameType (cstring str)
	{
		switch (str)
		{
			case "global": return NameType.GLOBAL;
			case "local": return NameType.LOCAL;
			case "method": return NameType.METHOD;
			case "field": return NameType.FIELD;
			case "upvalue": return NameType.UPVALUE;
			default: return NameType.UNKNOWN;
		}
	}

    /***************************************************************************

		Converts the given Name type into its string representation.

		Params:
		name_type = Name type

    ***************************************************************************/

	public static istring toString (NameType name_type)
	{
		switch (name_type)
		{
			case NameType.GLOBAL: return "global";
			case NameType.LOCAL: return "local";
			case NameType.METHOD: return "method";
			case NameType.FIELD: return "field";
			case NameType.UPVALUE: return "upvalue";
			default: return "";
		}
	}


	/// Code type
	private CodeType code_type_;
	/// Name type
	private NameType name_type_;
	/// Name
	private mstring name_;
	/// Whether this function was loaded from a file.
	private bool is_from_file_;
	/// Source string, containing the source or filename.
	private mstring source_;
	/// Start of the definition of this function in the source.
	private uint definition_start_;
	/// End of the definition of this function in the source.
	private uint definition_end_;
	/// Current line in the source.
	private int current_line_;
	/// Number of upvalues of this function.
	private uint upvalues_;

    /***************************************************************************

		Constructs an activation record which describes one state of a
		running function.

		Params:
		L = Lua state (C)
		record = Lua debug record (C)

    ***************************************************************************/

	package this (lua_State* L, lua_Debug* record)
	{
		// 'n'
		if (lua_getinfo (L, "n", record) == 0)
			throw new LuaFatalException ("Unable to get 'name' and 'namewhat' information from activation record.");
		this.name_ = record.name[0 .. strlenz (record.name)].dup;
		this.name_type_ = parseNameType (record.namewhat[0 .. strlenz (record.namewhat)]);

		// 'S'
		if (lua_getinfo (L, "S", record) == 0)
			throw new LuaFatalException ("Unable to get 'source', 'short_src', 'linedefined', 'lastlinedefined' and 'whatname' information from activation record.");

		if (record.source[0] == '@')
		{
			this.is_from_file_ = true;
			this.source_ = record.source[1 .. strlenz (record.source)].dup;
		}
		else
		{
			this.is_from_file_ = false;
			this.source_ = record.source[0 .. strlenz (record.source)].dup;
		}

		this.definition_start_ = record.linedefined;
		this.definition_end_ = record.lastlinedefined;
		this.code_type_ = parseCodeType (record.what[0 .. strlenz (record.what)]);

		if (this.code_type_ == CodeType.C)
			this.source_ = null;

		// 'l'
		if (lua_getinfo (L, "l", record) == 0)
			throw new LuaFatalException ("Unable to get 'currentline' information from activation record.");

		this.current_line_ = record.currentline;

		// 'u'
		if (lua_getinfo (L, "u", record) == 0)
			throw new LuaFatalException ("Unable to get 'nups' information from activation record.");

		this.upvalues_ = record.nups;
	}

	/// Returns the Code type of the function.

	public CodeType codeType ()
	{
		return this.code_type_;
	}

	/// Returns the Name type of the function.

	public NameType nameType ()
	{
		return this.name_type_;
	}

	/// Returns the name of the function.

	public istring name ()
	{
		return cast(istring) this.name_;
	}

	/// Returns true, if and only if the function was defined in a file.

	public bool isFromFile ()
	{
		return this.is_from_file_;
	}

	/// Returns the source for the function or the filename, where it was defined.

	public istring source ()
	{
		return cast(istring) this.source_;
	}

	/// Returns the start of the defintion of the function.

	public uint definitionStart ()
	{
		return this.definition_start_;
	}

	/// Returns the end of the defintion of the function.

	public uint definitionEnd ()
	{
		return this.definition_end_;
	}

	/// Returns the the current line in the function.

	public int currentLine ()
	{
		return this.current_line_;
	}

	/// Returns the number of upvalues of the function.

	public uint upvalues ()
	{
		return this.upvalues_;
	}

	/// Returns of compact string representation of the information about the function.

	public istring toString ()
	{
		istring result = toString (codeType) ~ " function";

		if (this.name_ !is null)
			result ~= " " ~ name ~ ((this.nameType == NameType.UNKNOWN) ? "" : (" (" ~ toString (nameType) ~ ")"));

		if (codeType != CodeType.C)
		{
			if (isFromFile)
				result ~= " from file " ~ source;
			else
				result ~= " from string \"" ~ source ~ "\"";
			result ~= ":" ~ int2string (currentLine);
		}

		return result;
	}
}

/*******************************************************************************

	LuaCallTrace is a collection of Activation Records which together
	describe the current call stack. This is useful for debugging purposes
	to keep track of the function calls.

*******************************************************************************/

class LuaCallTrace
{
	/// List of Activation Records
	private LuaActivationRecord[] records_;

	/// Constructs a Call Trace from a given state, gathering all information.

	public this (LuaState state)
	{
		LuaActivationRecord record;
		uint level = 0;

		while ((record = state.getActivationRecord (level)) !is null)
		{
			this.records_ ~= record;
			level++;
		}
	}

	/// Returns the specified Activation Record from the Call Trace.

	public LuaActivationRecord opIndex (size_t index)
	{
		return this.records_[index];
	}

	/// Prints the Call Trace in a user-friendly way.

	public istring toString ()
	{

		istring result = "* Call Trace (last function call)\n";
		foreach (level, record; this.records_)
		{
			result ~= "*  " ~ int2string (records_.length - level) ~ ": " ~ record.toString () ~ "\n";
		}
		result ~= "* End of Call Trace (first function call)";
		return result;
	}
}

/*******************************************************************************

	LuaStackTrace is a collection of all objects which are currently on the
	stack. This is useful for debugging purposes.

*******************************************************************************/

class LuaStackTrace
{
	/// List of objects
	private LuaObject[] objects_;

	/// Constructs a Stack Trace from a given state, gathering all information.

	public this (LuaState state)
	{
		this.objects_ = new LuaObject [state.top];
		foreach (i, ref obj; this.objects_)
		{
			obj = state.getObject (i+1);
		}
	}

	/// Returns the specified object from the Stack Trace.

	public LuaObject opIndex (size_t index)
	{
		return this.objects_[index];
	}

	/// Prints the Stack Trace in a user-friendly way.

	public istring toString ()
	{
		istring result = "# Stack Trace (top of stack)\n";
		foreach_reverse (i, obj; this.objects_)
		{
			result ~= "#  " ~ int2string (i+1) ~ ": " ~ obj.toString () ~ "\n";
		}
		result ~= "# End of Stack Trace (bottom of stack)";
		return result;
	}
}

/*******************************************************************************

	Exception for fatal errors like failed memory allocation or missing
	functionality.

*******************************************************************************/

class LuaFatalException : Exception
{
	/***************************************************************************

		Constructs a fatal exception.

		Params:
		message = Error message

    ***************************************************************************/

    this (cstring message)
    {
        super (cast(istring) message);
    }

	/// ditto
	this (cstring message, cstring file, size_t line)
	{
		version(D_Version2)
			super(cast(istring) message, cast(istring) file, line);
		else
			super(this.classinfo.name ~ "@" ~ file ~ "(" ~ int2string(line) ~ "): " ~ message);
	}

	/***************************************************************************

		Constructs a fatal exception from a Lua error code.

		Params:
		error = Lua error code.

	***************************************************************************/

    this (int error)
    {
    	if (error == LUA_ERRRUN)
    		super ("Runtime error");
    	else if (error == LUA_ERRMEM)
    		super ("Memory allocation error");
    	else if (error == LUA_ERRERR)
    		super ("Error while running the error handler function");
    	else if (error == LUA_ERRFILE)
    		super ("Error opening the file");
    	else
    		super ("Unknown Lua error");
    }

	/// ditto
    this (int error, cstring file, size_t line)
    {
		version(D_Version2)
		{
			if (error == LUA_ERRRUN)
				super ("Runtime error", cast(istring) file, line);
			else if (error == LUA_ERRMEM)
				super ("Memory allocation error", cast(istring) file, line);
			else if (error == LUA_ERRERR)
				super ("Error while running the error handler function", cast(istring) file, line);
			else if (error == LUA_ERRFILE)
				super ("Error opening the file", cast(istring) file, line);
			else
				super ("Unknown Lua error", cast(istring) file, line);
		}
		else
		{
			if (error == LUA_ERRRUN)
				super (this.classinfo.name ~ "@" ~ file ~ "(" ~ int2string(line) ~ "): " ~ "Runtime error");
			else if (error == LUA_ERRMEM)
				super (this.classinfo.name ~ "@" ~ file ~ "(" ~ int2string(line) ~ "): " ~ "Memory allocation error");
			else if (error == LUA_ERRERR)
				super (this.classinfo.name ~ "@" ~ file ~ "(" ~ int2string(line) ~ "): " ~ "Error while running the error handler function");
			else if (error == LUA_ERRFILE)
				super (this.classinfo.name ~ "@" ~ file ~ "(" ~ int2string(line) ~ "): " ~ "Error opening the file");
			else
				super (this.classinfo.name ~ "@" ~ file ~ "(" ~ int2string(line) ~ "): " ~ "Unknown Lua error");
		}
    }
}


/*******************************************************************************

	Exception for I/O errors while loading Lua code from a file.

*******************************************************************************/

class LuaIOException : Exception
{
	/***************************************************************************

	Constructs an I/O exception.

    ***************************************************************************/

    public this (cstring message)
    {
    	super (cast(istring) message);
    }

	/// ditto
	this (cstring message, cstring file, size_t line)
	{
		version(D_Version2)
			super(cast(istring) message, cast(istring) file, line);
		else
			super(this.classinfo.name ~ "@" ~ file ~ "(" ~ int2string(line) ~ "): " ~ message);
	}
}

/*******************************************************************************

	Exception for errors in Lua code.

*******************************************************************************/

class LuaCodeException : Exception
{
	/***************************************************************************

	Constructs a code exception.

    ***************************************************************************/

    public this (cstring message)
    {
    	super (cast(istring) message);
    }

	/// ditto
	this (cstring message, cstring file, size_t line)
	{
		version(D_Version2)
			super(cast(istring) message, cast(istring) file, line);
		else
			super(this.classinfo.name ~ "@" ~ file ~ "(" ~ int2string(line) ~ "): " ~ message);
	}
}




// D1 phobos Exceptions are missing an "Exception next;" attribute
version (Tango)
    alias Exception ExtendedException;
else version (D_Version2)
	alias Exception ExtendedException;
else
{
    class ExtendedException : Exception
    {
		Exception next;
		istring file;
		size_t line;
		
		this (cstring message, Exception next=null)
		{
			this.next = next;
			super (message);
		}
		
		this (cstring message, cstring file, size_t line, Exception next=null)
		{
			this.next = next;
			super (message);
			this.file = file;
			this.line = line;
		}

		override istring toString()
		{
			mstring buf;

			if (this.file)
			{
			   buf ~= this.classinfo.name ~ "@" ~ this.file ~ "(" ~ int2string(this.line) ~ "): " ~ this.msg;
			}
			else
			{
			   buf ~= this.classinfo.name ~ ": " ~ this.msg;
			}
			buf ~= this.next.classinfo.name ~ this.next.toString();
			return cast(istring) buf;
		}
    }
}


/*******************************************************************************

	Exception for forwarding other Exceptions through Lua code. It contains
	information about the forwarding process as well as a reference to the
	Exception, which is forwarded.

	This is necessary, as the Lua library cannot handle exceptions. Therefore,
	the lua routines which call D code catch exceptions, save them in
	LuaForwardException.exceptions and call lua_error. If the lua code was
	called in protected mode, the error is parsed by LuaState.call which
	extracts the exception from LuaForwardException.exceptions, adds some
	forwarder information and throws it again.

	For better debugging, a Lua Call Trace and Stack Trace are added at the
	point, where the original exception was caught.

	Remember that there might be a stack of protected library calls, in which
	case each of them adds a LuaForwardException to the chain.

*******************************************************************************/

class LuaForwardException : ExtendedException
{
	/// Call Trace
	private LuaCallTrace call_trace_;

	/// Stack Trace
	private LuaStackTrace stack_trace_;

	/***************************************************************************

		Constructs a forward exception, as well as the current Call Trace and
		Stack Trace.

		Params:
		exception = exception to be forwarded
		catcher_name = name of the place, where the exception was forwarded.
		state = Lua state.

    ***************************************************************************/

    public this (LuaState state, Exception exception, cstring catcher_name)
    {
    	super (cast(istring) (catcher_name ~ " caught:\n\n" ~ this.call_trace_.toString ~ "\n\n" ~ this.stack_trace_.toString), exception);

    	this.call_trace_ = new LuaCallTrace (state);
    	this.stack_trace_ = new LuaStackTrace (state);
    }

    /***************************************************************************

		Constructs a forward exception, as well as the current Call Trace and
		Stack Trace. Also attaches file and line information.

		Params:
		exception = exception to be forwarded
		catcher_name = name of the place, where the exception was forwarded.
		file = name of the file.
		line = line in the file.
		state = Lua state.

    ***************************************************************************/

    public this (LuaState state, Exception exception, cstring catcher_name, cstring file, size_t line)
    {
    	this.call_trace_ = new LuaCallTrace (state);
    	this.stack_trace_ = new LuaStackTrace (state);

        super (cast(istring) (catcher_name ~ " caught:\n\n" ~ this.call_trace_.toString ~ "\n\n" ~ this.stack_trace_.toString), cast(istring) file, line, exception);
    }

    /***************************************************************************

		Adds forward information to the exception.

		Params:
		forwarder_name = name of the forwarder.

    ***************************************************************************/

    public void forward (cstring forwarder_name)
    {
    	this.msg = cast(istring) (forwarder_name ~ " forwarded, " ~ this.msg);
    }

    /// Returns the attached Call Trace.

    public LuaCallTrace getCallTrace ()
    {
    	return this.call_trace_;
    }

    /// Returns the attached Stack Trace.

    public LuaStackTrace getStackTrace ()
    {
    	return this.stack_trace_;
    }

    /// Associative array which maps pointers to Exceptions, to avoid collection of them during error processing.

    private static LuaForwardException[void *] exceptions;
}

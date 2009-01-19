/*******************************************************************************

	copyright:      Copyright (c) 2008 Matthias Walter. All rights reserved

    authors:        Matthias Walter, Andreas Hollandt

*******************************************************************************/

module lua.data;

private import lua.common;
private import lua.lua;
private import lua.buffer, lua.mixins, lua.error, lua.state;


version (Tango)
{
    private import tango.text.convert.Float : float2string = toString;
}
else
{
    private import std.string : float2string = toString;
}

/*******************************************************************************

	LuaObject is the base-class for all classes which represent Lua types in
	the D world. Nil, Threads, Numbers, Bool, Strings, LightUserdata, Tables and
	C functions are complete and independent of this Lua state, Userdata only
	contains the pointer and Lua functions are not supported yet.

	This is useful for stack traces (see LuaStackTrace) and to save a Lua
	value (or whole tables) in a binary format.

*******************************************************************************/

abstract class LuaObject
{
	/// Pushes this Lua Object onto the stack of the given Lua State.
	public abstract void push (LuaState state);

	/// Returns a user-friendly string representation of the Object.
	public abstract istring toString ();

	/// Size of the header (currently only the LuaType in binary form.)
	protected const byte HEADER_SIZE = LuaType.sizeof;

	/***************************************************************************

		Allocates a memory chunk with HEADER_SIZE + size bytes and fills
		the header properly.

		Params:
		size = Size for additional data.
		type = Type to write into the header.

    ***************************************************************************/

	protected byte[] writeHeader (uint size, LuaType type)
	{
		byte[] result = new byte[HEADER_SIZE + size];
		* (cast (LuaType*) &result[0]) = type;
		return result;
	}

	/// Method which returns the binary representation of the Object.
	public abstract byte[] save ();

	/// Method which fills the Object. Do not call this directly.
	public abstract uint load (byte[] data);

	/***************************************************************************

		Constructs a Lua Object from a given binary representation.

		Params:
		bytes_read = Number of bytes read.
		data = Binary data, containing all information.

    ***************************************************************************/

	public static LuaObject load (byte[] data, ref uint bytes_read)
	{
		if (data.length < HEADER_SIZE)
			throw new LuaFatalException ("Invalid stream: Could not read header.", __FILE__, __LINE__);

		LuaObject result;

		switch (* (cast (LuaType*) &data[0]))
		{
			case LuaType.NIL: result = new LuaNilObject (); break;
			case LuaType.NUMBER: result = new LuaNumberObject (); break;
			case LuaType.STRING: result = new LuaStringObject (); break;
			case LuaType.FUNCTION: result = new LuaFunctionObject (); break;
			case LuaType.USERDATA: result = new LuaUserdataObject (); break;
			case LuaType.BOOL: result = new LuaBoolObject (false); break;
			case LuaType.TABLE: result = new LuaTableObject (); break;
			default:
				throw new LuaFatalException ("Invalid stream: Wrong type code " ~ int2string (cast (int) * (cast (LuaType*) &data[0])), __FILE__, __LINE__);
		}
		bytes_read = HEADER_SIZE;
		bytes_read += result.load (data[HEADER_SIZE .. length]);

		return result;
	}
}

/*******************************************************************************

	LuaNilObject represents the Lua type Nil in the D world and can be
	saved into / loaded from a binary representation.

*******************************************************************************/

class LuaNilObject : LuaObject
{
	/// Constructs a LuaNilObject.
	
	public this ()
	{

	}
	
	/// Pushes Nil onto the stack.

	public override void push (LuaState state)
	{
		state.pushNil ();
	}
	
	/// Returns the string representation.

	public override istring toString ()
	{
		return "nil";
	}
	
	/// Saves it as binary array.

	public override byte[] save ()
	{
		return writeHeader (0, LuaType.NIL);
	}
	
	/// Fills it from a binary array.

	public override uint load (byte[] data)
	{
		return 0;
	}
}

/*******************************************************************************

	LuaThreadObject represents a Lua Thead in the D world and can be
	saved into / loaded from a binary representation.

*******************************************************************************/

class LuaThreadObject : LuaObject
{
	/// Constructs a LuaThreadObject.
	
	public this ()
	{

	}
	
	/// You cannot push a saved Thread into a LuaState!

	public override void push (LuaState state)
	{
		throw new LuaFatalException ("Error in LuaThreadObject: Cannot push threads.", __FILE__, __LINE__);
	}
	
	/// Returns the string representation.

	public override istring toString ()
	{
		return "thread";
	}

	/// Saves it as binary array.

	public override byte[] save ()
	{
		return writeHeader (0, LuaType.THREAD);
	}
	
	/// Fills it from a binary array.

	public override uint load (byte[] data)
	{
		return 0;
	}
}

/*******************************************************************************

	LuaNumberObject represents the Lua type Number in the D world and can be
	saved into / loaded from a binary representation.

*******************************************************************************/

class LuaNumberObject : LuaObject
{
	/// The numerical value
	private LuaNumber value_;
	
	/// Constructs a LuaNumberObject with a given value.

	public this (LuaNumber value = 0)
	{
		this.value_ = value;
	}
	
	/// Pushes the value onto the stack.

	public override void push (LuaState state)
	{
		state.pushNumber (this.value_);
	}
	
	/// Sets the value.
	
	public LuaNumber value (LuaNumber v)
	{
		return (this.value_ = v);
	}
	
	/// Returns the value.

	public LuaNumber value ()
	{
		return this.value_;
	}
	
	/// Returns the string representation.

	public override istring toString ()
	{
		return float2string (this.value_);
	}
	
	/// Saves it as binary array.
	
	public override byte[] save ()
	{
		byte[] result = writeHeader (double.sizeof, LuaType.NUMBER);
		*(cast (double*) &result[HEADER_SIZE]) = this.value_;
		return result;
	}

	/// Fills it from a binary array.

	public override uint load (byte[] data)
	{
		if (data.length < double.sizeof)
			throw new LuaFatalException ("Invalid stream: Could not read Number.", __FILE__, __LINE__);

		this.value_ = *(cast (double*) data.ptr);

		return double.sizeof;
	}
}

/*******************************************************************************

	LuaBoolObject represents the Lua type Bool in the D world and can be
	saved into / loaded from a binary representation.

*******************************************************************************/

class LuaBoolObject : LuaObject
{
	/// Boolean value
	private bool value_;

	/// Constructs a LuaBoolObject.
	
	public this (bool value)
	{
		this.value_ = value;
	}
	
	/// Pushes the bool value onto the Lua stack.

	public override void push (LuaState state)
	{
		state.pushBool (this.value_);
	}
	
	/// Sets the value.
	
	public bool value (bool v)
	{
		return (this.value_ = v);
	}
	
	/// Returns the value.

	public bool value ()
	{
		return this.value_;
	}
	
	/// Returns the string representation.

	public override istring toString ()
	{
		return this.value_ ? "true" : "false";
	}
	
	/// Saves it as binary array.
	
	public override byte[] save ()
	{
		byte[] result = writeHeader (bool.sizeof, LuaType.BOOL);
		*(cast (bool*) &result[HEADER_SIZE]) = this.value_;
		return result;
	}

	/// Fills it from a binary array.

	public override uint load (byte[] data)
	{
		if (data.length < bool.sizeof)
			throw new LuaFatalException ("Invalid stream: Could not read Boolean.", __FILE__, __LINE__);

		this.value_ = *(cast (bool*) data.ptr);

		return bool.sizeof;
	}
}

/*******************************************************************************

	LuaStringObject represents the Lua type String in the D world and can be
	saved into / loaded from a binary representation.

*******************************************************************************/

class LuaStringObject : LuaObject
{
	/// String value
	private mstring value_;

	/// Constructs a LuaStringObject.
	
	public this (cstring value = "")
	{
		this.value_ = value.dup;
	}
	
	/// Pushes the string onto the Lua stack.

	public override void push (LuaState state)
	{
		state.pushString (this.value_);
	}
	
	/// Sets the value.
	 
	public istring value (cstring v)
	{
		return cast(istring) (this.value_ = v.dup);
	}
	
	/// Returns the value.

	public istring value ()
	{
		return cast(istring) this.value_;
	}
	
	/// Returns the string representation.

	public override istring toString ()
	{
		return cast(istring) ("\"" ~ this.value_ ~ "\"");
	}
	
	/// Saves it as binary array.

	public override byte[] save ()
	{
		byte[] result = writeHeader (size_t.sizeof + this.value_.length, LuaType.STRING);
		*(cast (size_t*) &result[HEADER_SIZE]) = this.value_.length;
		auto p = cast (char*) &result[HEADER_SIZE + size_t.sizeof];
		p[0 .. this.value_.length] = this.value_;

		return result;
	}

	/// Fills it from a binary array.

	public override uint load (byte[] data)
	{
		if (data.length < size_t.sizeof)
			throw new LuaFatalException ("Invalid stream: Could not read String length.", __FILE__, __LINE__);

		this.value_ = new char[ *(cast (size_t*) data.ptr) ];
		if (data.length < size_t.sizeof + this.value_.length)
			throw new LuaFatalException ("Invalid stream: Could not read String.", __FILE__, __LINE__);

		auto p = cast (char*) &data[size_t.sizeof];
		this.value_[0 .. length] = p[0 .. this.value_.length];

		return size_t.sizeof + this.value_.length;
	}
}

/*******************************************************************************

	LuaUserdataObject represents the Lua types Userdata and LightUserdata
	in the D world and can be saved into / loaded from a binary representation.

*******************************************************************************/

class LuaUserdataObject : LuaObject
{
	/// Pointer to the data
	private void* value_;
	
	/// Whether it is LightUserdata
	private bool is_lightuserdata_;
	
	/// Constructs a LuaUserdataObject.

	private this ()
	{

	}
	
	/// Constructs a LuaThreadObject with a given value.

	public this (void* value, bool is_lightuserdata)
	{
		this.value_ = value;
		this.is_lightuserdata_ = is_lightuserdata;
	}
	
	/// Pushes the LightUserdata onto the stack. Throws an error if it is a plain Userdata.

	public override void push (LuaState state)
	{
		if (this.is_lightuserdata_)
			state.pushLightUserdata (this.value_);
		else
			throw new LuaFatalException ("Error in LuaUserdataObject: Cannot push userdata.", __FILE__, __LINE__);
	}
	
	/// Returns the value.

	public void* value ()
	{
		return this.value_;
	}
	
	/// Returns true, if and only if this is LightUserdata.

	public bool isLightUserdata ()
	{
		return this.is_lightuserdata_;
	}
	
	/// Returns the string representation.

	public override istring toString ()
	{
		return (this.is_lightuserdata_ ? "LightUserdata: " : "Userdata: ") ~ int2string (cast (int) this.value_);
	}
	
	/// Saves it as binary array.

	public override byte[] save ()
	{
		byte[] result = writeHeader ((void*).sizeof, LuaType.USERDATA);
		*(cast (void**) &result[HEADER_SIZE]) = this.value_;
		return result;
	}

	/// Fills it from a binary array.

	public override uint load (byte[] data)
	{
		if (data.length < (void*).sizeof)
			throw new LuaFatalException ("Invalid stream: Could not read Userdata.", __FILE__, __LINE__);

		this.value_ = *(cast (void**) data.ptr);

		return (void*).sizeof;
	}
}

/*******************************************************************************

	LuaFunctionObject represents Lua and C function in the D world and can be
	saved into / loaded from a binary representation.

*******************************************************************************/

class LuaFunctionObject : LuaObject
{
	/// C function pointer
	private LuaCFunction value_;
	
	/// Constructs a LuaFunctionObject.

	public this (LuaCFunction value = null)
	{
		this.value_ = value;
	}
	
	/// Returns the function pointer, or null if it is a Lua function.

	public LuaCFunction value ()
	{
		return this.value_;
	}
	
	/// Returns true, if and only if it is a C function.

	public bool isCFunction ()
	{
		return this.value_ !is null;
	}
	
	/// Pushes the C function onto the stack.

	public override void push (LuaState state)
	{
		state.pushCFunction (this.value_);
	}
	
	/// Returns the string representation.

	public override istring toString ()
	{
		if (this.value_ is null)
			return "Lua function";
		else
			return "C function at 0x" ~ int2string (cast (int) this.value_, 16);
	}
	
	/// Saves it as binary array.

	public override byte[] save ()
	{
		byte[] result = writeHeader (LuaCFunction.sizeof, LuaType.FUNCTION);
		*(cast (LuaCFunction*) &result[HEADER_SIZE]) = this.value_;
		return result;
	}

	/// Fills it from a binary array.

	public override uint load (byte[] data)
	{
		if (data.length < LuaCFunction.sizeof)
			throw new LuaFatalException ("Invalid stream: Could not read Function.", __FILE__, __LINE__);

		this.value_ = *(cast (LuaCFunction*) data.ptr);

		return LuaCFunction.sizeof;
	}
}

/*******************************************************************************

	LuaTableObject represents Lua Tables in the D world and can be
	saved into / loaded from a binary representation.

*******************************************************************************/

class LuaTableObject : LuaObject
{
	/// Struct containing key/value pairs.
	struct KeyValuePair
	{
		LuaObject key;
		LuaObject value;
	}
	
	/// Array of key/value pairs.
	private KeyValuePair[] data_;
	
	/// Constructs a LuaTableObject.

	private this ()
	{

	}
	
	/// Constructs a LuaTableObject from a given index, gathering the complete table.

	public this (LuaState state, int index)
	{
		state.pushNil ();
		while (state.next (index))
		{
			KeyValuePair pair;
			pair.key = state.getObject (state.top-1);
			pair.value = state.getObject (state.top);
			this.data_ ~= pair;
			state.pop ();
		}
	}

	/// Pushes onto the stack the complete table.

	public override void push (LuaState state)
	{
		state.createTable ();

		foreach (pair; this.data_)
		{
			pair.key.push (state);
			pair.value.push (state);
			state.rawSet (-3);
		}
	}

	/// Returns the string representation.

	public override istring toString ()
	{
		if (this.data_ !is null)
		{
			istring result = "{ ";
			foreach (pair; this.data_)
			{
				result ~= pair.key.toString () ~ "=" ~ pair.value.toString () ~ ", ";
			}
			return result[0 .. length-2] ~ " }";
		}
		else
			return "{}";
	}

	/// Saves it as binary array.

	public override byte[] save ()
	{
		byte[][] results = [];
		int size = 0;

		// fill keys / values
		for (int i = 0; i < this.data_.length; i++)
		{
			auto pair = this.data_[i];
			byte[] saved_key = pair.key.save ();
			byte[] saved_value = pair.value.save ();
			results ~= saved_key ~ saved_value;
			size += saved_key.length + saved_value.length;
		}

		byte[] result = writeHeader (uint.sizeof + size, LuaType.TABLE);

		*(cast (uint*) &result[HEADER_SIZE]) = this.data_.length;
		if (size > 0)
		{
			auto p = &result[HEADER_SIZE + uint.sizeof];
			foreach (byte[] r; results)
			{
				p[0 .. r.length] = r[0 .. r.length];
				p += r.length;
			}
		}

		return result;
	}

	/// Fills it from a binary array.

	public override uint load (byte[] data)
	{
		if (data.length < uint.sizeof)
			throw new LuaFatalException ("Invalid stream: Could not read Table.", __FILE__, __LINE__);

		this.data_ = new KeyValuePair [ *(cast (uint*) data.ptr) ];
		uint read = uint.sizeof;

		foreach (ref pair; this.data_)
		{
			uint rd = 0;
			pair.key = LuaObject.load (data[read .. $], rd);
			read += rd;
			pair.value = LuaObject.load (data[read .. $], rd);
			read += rd;
		}

		return read;
	}
}
/*******************************************************************************

	copyright:      Copyright (c) 2008 Matthias Walter. All rights reserved

    authors:        Matthias Walter, Andreas Hollandt

*******************************************************************************/

module lua.buffer;

private import lua.common;
private import lua.state;
private import lua.lauxlib;

/*******************************************************************************

	LuaBuffer wraps a Lua string buffer which allows building strings
	piecemeal, as in the following example:
	
	---
	// create a lua state
	auto L = new LuaState ();

	// create a buffer for this state
    auto buffer = L.createBuffer ();

    // Add char by char
    buffer.addChar ('C').addChar ('h').addChar ('a').addChar ('r');

    // Add a complete string
    buffer.addString ("String");

    // Push a number onto the stack and add its string representation
    L.pushNumber (2.1);
    buffer.addValue ();

	// Get the char-pointer of the current buffer position and manually
	// modify it. When finished, you correct the size accordingly.
    auto buf = buffer.prepare ();
    buf[0] = 'B';
    buf[1] = 'u';
    buf[2] = 'f';
    buf[3] = 'f';
    buf[4] = 'e';
    buf[5] = 'r';
    buffer.addSize (6);

    // When finished, push the result "CharString2.1Buffer" onto the stack.
    buffer.pushResult ();
	---

	During its normal operation, a string buffer uses a variable number of
	stack slots. So, while using a buffer, you cannot assume that you know
	where the top of the stack is. You can use the stack between successive
	calls to buffer	operations as long as that use is balanced; that is,
	when you call a buffer operation, the stack is at the same level it was
	immediately after the previous buffer operation. (The only exception to
	this rule is the addValue method) After calling pushResult the stack is
	back to its level when the buffer was initialized, plus the final string
	on its top.

*******************************************************************************/

class LuaBuffer
{
	/// Associated state
    private LuaState state_;

    /// Wrapped lua buffer
    private luaL_Buffer buffer_;

    /*******************************************************************************

		Constructs a buffer, attaching it to a state.
		
		Params:
		state = Lua state to attach the buffer to.
		
		Remarks:
		Replaces luaL_buffinit.
	
    *******************************************************************************/

    public this (LuaState state)
    {
    	this.state_ = state;
    	luaL_buffinit (this.state_.state, &this.buffer_);
    }

    /*******************************************************************************

		Appends a character to the buffer.
	
		Params:
		c = Character to append.
		
		Remarks:
		Replaces luaL_addchar.

    *******************************************************************************/

    public LuaBuffer addChar (char c)
    {
    	luaL_addchar (&this.buffer_, c);

    	return this;
    }

    /*******************************************************************************

		Appends a string to the buffer.

		Params:
		string = String to append.
	
		Remarks:
		Replaces luaL_addstring and luaL_addlstring.

    *******************************************************************************/

    public LuaBuffer addString (cstring string)
    {
    	luaL_addlstring (&this.buffer_, string.ptr, string.length);

    	return this;
    }

    /*******************************************************************************

		Appends a value on top of stack to the buffer and pops it.

		Remarks:
		Replaces luaL_addvalue.

    *******************************************************************************/

    public LuaBuffer addValue ()
    {
    	luaL_addvalue (&this.buffer_);

    	return this;
    }

    /*******************************************************************************
		
		Returns an address to a space of size LUAL_BUFFERSIZE where you can copy
		a string to be added to the buffer B. After copying the string into this
		space you must call addSize with the size of the string to actually add
		it to the buffer.

		Remarks:
		Replaces luaL_prepbuffer

    *******************************************************************************/

    public char* prepare ()
    {
    	return luaL_prepbuffer (&this.buffer_);
    }

    /*******************************************************************************

		Adds to the buffer a string of length size previously copied to the
		buffer area returned by prepare.

		Remarks:
		Replaces luaL_addsize

    *******************************************************************************/

    public LuaBuffer addSize (uint size)
    {
    	luaL_addsize (&this.buffer_, size);

    	return this;
    }

    /*******************************************************************************

		Finishes the use of the buffer leaving the final string on the top of
		the stack.

		Remarks:
		Replaces luaL_pushresult

    *******************************************************************************/

    public LuaState pushResult ()
    {
    	luaL_pushresult (&this.buffer_);

    	return state_;
    }
}

unittest
{

    string output = "";

    void write (cstring data)
    {
    	output ~= data;
    }

    LuaState L = new LuaState (&write);

    auto buffer = L.createBuffer ();
    buffer.addChar ('C').addChar ('h').addChar ('a').addChar ('r');
    buffer.addString ("String");
    L.pushNumber (2.1);
    buffer.addValue ();

    auto buf = buffer.prepare();
    buf[0] = 'B';
    buf[1] = 'u';
    buf[2] = 'f';
    buf[3] = 'f';
    buf[4] = 'e';
    buf[5] = 'r';
    buffer.addSize (6);

    buffer.pushResult ();
    
    assert (L.popString () == "CharString2.1Buffer");
}
/*******************************************************************************

	copyright:      Copyright (c) 2009 Andreas Hollandt. All rights reserved

    authors:        Andreas Hollandt

*******************************************************************************/

module lua.common;

// automatically link lua C library
version(Windows)pragma(lib, "lua\\lua.lib");
version(linux)	pragma(lib, "lua/lua.lib");

package
{
// define string types for compatibility with both D1 and D2
version (D_Version2)
{
	pragma(msg, "D2 detected. Taking care of constness.");

	// we need a mixin cause the code is syntactically illegal under D1
	mixin(`
	alias const(char) cchar; /// const char type
	alias invariant(char) ichar; /// invariant char type

	alias char[] mstring; /// mutable string type
	alias const(char)[] cstring; /// const string type
	alias invariant(char)[] istring; /// invariant string type

	alias wchar[] mwstring;
	alias const(wchar)[] cwstring;
	alias invariant(wchar)[] iwstring;

	alias dchar[] mdstring;
	alias const(dchar)[] cdstring;
	alias invariant(dchar)[] idstring;`);
}
else
{
	pragma(msg, "D1 detected. All strings are mutable.");
	alias char cchar;
	alias char ichar;

	alias char[] mstring;
	alias char[] cstring;
	alias char[] istring;

	alias wchar[] mwstring;
	alias wchar[] cwstring;
	alias wchar[] iwstring;

	alias dchar[] mdstring;
	alias dchar[] cdstring;
	alias dchar[] idstring;
}
}
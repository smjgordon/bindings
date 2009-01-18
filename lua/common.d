/*******************************************************************************

	copyright:      Copyright (c) 2009 Andreas Hollandt. All rights reserved

    authors:        Andreas Hollandt

*******************************************************************************/

module lua.common;

package
{
// define string types for compatibility with both D1 and D2
version (D_Version2)
{
	alias char[] mstring; /// mutable string type
	alias const(char)[] cstring; /// const string type
	alias invariant(char)[] istring; /// invariant string type

	alias wchar[] mwstring;
	alias const(wchar)[] cwstring;
	alias invariant(wchar)[] iwstring;

	alias dchar[] mdstring;
	alias const(dchar)[] cdstring;
	alias invariant(dchar)[] idstring;
}
else
{
/*
	alias char[] string;
	alias wchar[] wstring;
	alias dchar[] dstring;
*/
}
}
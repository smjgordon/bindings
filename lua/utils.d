/*******************************************************************************

	copyright:      Copyright (c) 2008 Matthias Walter. All rights reserved

    authors:        Matthias Walter, Andreas Hollandt
    
    Many functions already exist in Tango, Phobos or even both. But most of
    them are needed at compile time! E.g. Tangos text.convert.Integers
    conversion functionality is not (yet) available at compile time, so
    integer conversions are implemented here.

*******************************************************************************/

module lua.utils;
private import lua.common;
private import lua.error;

/*******************************************************************************

	Function to convert a digit to its character representation.

	Remarks:
	Can be evaluated at compile time.

*******************************************************************************/

public static char int2digit (uint d)
{
	assert (d < 16);

	if (d < 10)
		return cast (char) '0' + d;
	else
		return cast (char) 'a' + (d-10);
}

/*******************************************************************************

	Function to convert a character to a digit, representing it. Returns
	0 .. 15 for digits, -1 for a minus, -2 for a dot and -3 else.
	
	Params:
	d = the
	
	Remarks:
	Can be evaluated at compile time.

*******************************************************************************/

public static byte digit2int (char c)
{
	if (c >= '0' && c <= '9')
		return (c - '0');
	else if (c >= 'a' && c <= 'f')
		return (c - 'a' + 10);
	else if (c >= 'A' && c <= 'F')
		return (c - 'A' + 10);
	else if (c == '-')
		return -1;
	else if (c == '.')
		return -2;
	else
		return -3;
}

/*******************************************************************************

	Function template to convert an integer to a string in a number system.

	Params:
	i = Number to convert.
	radix = Base of the number system.

	Remarks:
	Can be evaluated at compile time.

*******************************************************************************/

public static istring int2string (T) (T i, int radix = 10)
{
	if (i < 0)
        return "-" ~ int2string !(ulong) (-i, radix);
    else if (i >= radix)
        return int2string !(ulong) (i / radix, radix) ~ int2digit (i % radix);
    else
        return "" ~ int2digit (i % radix);
}

unittest
{
	assert (int2string (long.min) == "-9223372036854775808");
	assert (int2string (long.max) == "9223372036854775807");
	assert (int2string (ulong.min) == "0");
	assert (int2string (ulong.max) == "18446744073709551615");
	assert (int2string (long.max, 16) == "7fffffffffffffff");
	assert (int2string (ulong.max, 16) == "ffffffffffffffff");
}

/*******************************************************************************

	Function template to parse an integer string and return the integer.
	
	Params:
	str = String, containing an integer.
	read = How many bytes have been converted, negative if overflow.
	radix = Base of the number system.

	Remarks:
	Can be evaluated at compile time.

*******************************************************************************/

public static T parseInt (T) (cstring str, out int read, uint radix = 10)
{
	read = 0;
	if (str.length == 0)
		return 0;

	ulong value = 0;
	int d = digit2int (str[0]);
	byte start = 0;

	if (d == -1)
	{
		start = 1;
		read++;
	}
	else if (d < -1 || d >= radix)
		return 0;
	
	foreach (c; str[start .. $])
	{
		d = digit2int (c);
		if (d >= 0 && d < radix)
		{
			value = radix * value + d;
			read++;
		}
		else
			break;
	}

	static if (T.min == 0)
	{
		// overflow
		if ((start == 1 && value > 0) || (value > T.max))
		{
			read = -1;
			return 0;
		}
		else
			return value;
	}
	else
	{
		if ((start == 1 && value > -cast (long) T.min) || (start == 0 && value > T.max))
		{
			read = -1;
			return 0;
		}
		else
			return cast (T) (start == 0 ? value : -value);  
	}
}

/*******************************************************************************

	Function template to convert an integer string to the integer.

	Params:
	str = String, containing an integer.
	radix = Base of the number system.

	Remarks:
	Can be evaluated at compile time.

*******************************************************************************/

public static T string2int (T = long) (cstring str, uint radix = 10)
{
	int read;
	T result = parseInt ! (T) (str, read, radix);
	if (read == str.length)
		return result;
	else if (read < 0)
		throw new ExtendedException (cast(istring) ("Parse error in '" ~ str ~ "': Integer overflow."), __FILE__, __LINE__);
	else
		throw new ExtendedException (cast(istring) ("Parse error in '" ~ str ~ "' at position " ~ int2string (read)), __FILE__, __LINE__);
}

unittest
{
	assert (string2int !(byte) ("0") == 0);
	assert (string2int !(byte) ("127") == 127);
	assert (string2int !(byte) ("-128") == -128);
	try
	{
		string2int !(byte) ("128");
		assert (false);
	}
	catch (Exception e) { }
	try
	{
		string2int !(byte) ("-129");
		assert (false);
	}
	catch (Exception e) { }
	assert (string2int ("9223372036854775807") == long.max);
	assert (string2int ("-9223372036854775808") == long.min);
	try
	{
		string2int ("-9223372036854775809");
		assert (false);
	}
	catch (Exception e) { }
	try
	{
		string2int ("9223372036854775808");
		assert (false);
	}
	catch (Exception e) { }
	assert (string2int !(ulong) ("18446744073709551615") == ulong.max);
}

/*******************************************************************************

	Function to find the first occurence of a character in a given string.

	Remarks:
	Can be evaluated at compile time.

*******************************************************************************/

public static int find (cstring str, char c)
{
    foreach (int i, char ch; str)
    {
        if (ch == c)
        	return i;
    }
    return -1;
}

/*******************************************************************************

	Function to find the last occurence of a character in a given string.

	Remarks:
	Can be evaluated at compile time.

*******************************************************************************/

public static int rfind (cstring str, char c)
{
    foreach_reverse (int i, char ch; str)
    {
        if (ch == c)
        	return i;
    }
    return -1;
}

/*******************************************************************************

	Function to create a '\0'-terminated string from a given string.

*******************************************************************************/

public static char* toStringz (cstring s)
{
    if (s.ptr)
    {
    	if (! (s.length && s[$-1] is 0))
    		s = s ~ '\0';
    }
    return cast(char*) s.ptr;
}

/*******************************************************************************

	Returns the length of a '\0'-terminated string.

*******************************************************************************/

public static size_t strlenz (cchar* s)
{
    size_t i;

    if (s)
    {
    	while (*s++)
    		i++;
    }
    return i;
}


public static cstring ltrim (cstring str, cstring chars)
{
	foreach (i, c; str)
	{
		bool match = false;
		foreach (t; chars)
		{
			if (c == t)
			{
				match = true;
				break;
			}
		}
		if (!match)
		{
			return str[i .. $];
		}
	}
	return [];
}

public static T removeFirst (T) (ref T[] array)
{
	assert (array.length > 0);

	T result = array[0];
	array = array[1 .. $];
	return result;
}

public static T[] removeFirst (T) (ref T[] array, uint amount)
{
	assert (amount <= array.length);

	T[] result = array[0 .. amount];
	array = array[amount .. $];
	return result;
}

public static T[] join (T) (T[] split, T[][] array)
{
	T[] result;
	foreach (i, a; array)
	{
		if (i > 0)
			result ~= split ~ a;
		else
			result = a;
	}
	return result;
}
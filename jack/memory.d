/*
Copyright (c) 2008 team0xf

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/


module memory;

private {
	import tango.stdc.stdlib : cMalloc = malloc, cRealloc = realloc, cFree = free;
}

public {
	import tango.stdc.string : memset;
}



uint	mallocdMemory;

version (RecordMemoryAllocations) {
	uint[char[]]	allocLengths;
	uint[char[]]	allocCounts;
}



/**
	Allocate the array using malloc
	
	Params:
	array = the array which will be resized
	numItems = number of items to be allocated in the array
	init = whether to init the allocated items to their default values or not
	
	Examples:
	int[] foo;
	foo.alloc(20);
	
	Remarks:
	The array must be null and empty for this function to succeed. The rationale behind this is that the coder should state his decision clearly. This will help and has
	already helped to spot many intricate bugs. 
*/
void alloc(T, intT)(inout T array, intT numItems, bool init = true) 
in {
	assert (array is null);
	assert (numItems >= 0);
}
out {
	assert (numItems == array.length);
}
body {
	alias typeof(T[0]) ItemT;
	array = (cast(ItemT*)cMalloc(ItemT.sizeof * numItems))[0 .. numItems];
	
	mallocdMemory += ItemT.sizeof * numItems;
	
	version (RecordMemoryAllocations) {
		allocLengths[typeid(T).toString] += numItems;
		allocCounts[typeid(T).toString] += 1;
	}
	
	static if (is(typeof(ItemT.init))) {
		if (init) {
			array[] = ItemT.init;
		}
	}
}


/**
	Clone the given array. The result is allocated using alloc() and copied piecewise from the param. Then it's returned
*/
T clone(T)(T array) {
	T res;
	res.alloc(array.length, false);
	res[] = array[];
	return res;
}


/**
	Realloc the contents of an array
	
	array = the array which will be resized
	numItems = the new size for the array
	init = whether to init the newly allocated items to their default values or not
	
	Examples:
	int[] foo;
	foo.alloc(20);
	foo.realloc(10);		// <--
*/
void realloc(T, intT)(inout T array, intT numItems, bool init = true)
in {
	assert (numItems >= 0);
}
out {
	assert (numItems == array.length);
}
body {
	version (RecordMemoryAllocations) {
		if (array is null) {
			allocCounts[typeid(T).toString] += 1;
		}
	}
	
	alias typeof(T[0]) ItemT;
	intT oldLen = array.length;
	array = (cast(ItemT*)cRealloc(array.ptr, ItemT.sizeof * numItems))[0 .. numItems];
	
	mallocdMemory += ItemT.sizeof * (numItems - oldLen);
	
	version (RecordMemoryAllocations) {
		allocLengths[typeid(T).toString] += (numItems - oldLen);
	}
	
	static if (is(typeof(ItemT.init))) {
		if (init && numItems > oldLen) {
			array[oldLen .. numItems] = ItemT.init;
		}
	}
}


/**
	Deallocate an array allocated with alloc()
*/
void free(T)(inout T array)
out {
	assert (0 == array.length);
}
body {
	if (array !is null) {
		mallocdMemory -= T[0].sizeof * array.length;
		
		version (RecordMemoryAllocations) {
			allocLengths[typeid(T).toString] -= array.length;
			allocCounts[typeid(T).toString] -= 1;
		}
	}

	cFree(array.ptr);
	array = null;
}


/**
	Append an item to an array. Optionally keep track of an external 'real length', while doing squared reallocation of the array
	
	Params:
	array = the array to append the item to
	elem = the new item to be appended
	realLength = the optional external 'real length'
	
	Remarks:
	if realLength isn't null, the array is not resized by one, but allocated in a std::vector manner. The array's length becomes it's capacity, while 'realLength'
	is the number of items in the array.
	
	Examples:
	---
	uint barLen = 0;
	int[] bar;
	append(bar, 10, &barLen);
	append(bar, 20, &barLen);
	append(bar, 30, &barLen);
	append(bar, 40, &barLen);
	assert (bar.length == 16);
	assert (barLen == 4);
	---
*/
void append(T, I)(inout T array, I elem, uint* realLength = null) {
	uint len = realLength is null ? array.length : *realLength;
	uint capacity = array.length;
	alias typeof(T[0]) ItemT;
	
	if (len >= capacity) {
		if (realLength is null) {		// just add one element to the array
			int numItems = len+1;
			array = (cast(ItemT*)cRealloc(array.ptr, ItemT.sizeof * numItems))[0 .. numItems];
		} else {								// be smarter and allocate in power-of-two increments
			const uint initialCapacity = 4;
			int numItems = capacity == 0 ? initialCapacity : capacity * 2; 
			array = (cast(ItemT*)cRealloc(array.ptr, ItemT.sizeof * numItems))[0 .. numItems];
			++*realLength;
		}
	} else if (realLength !is null) ++*realLength;
	
	array[len] = elem;
}



unittest {
	int[] foo;
	foo.alloc(10);
	assert (foo.length == 10);
	foreach (i; foo) assert (i == int.init);
	foo.realloc(20);
	assert (foo.length == 20);
	foreach (i; foo) assert (i == int.init);
	foo.realloc(10);
	assert (foo.length == 10);
	foreach (i; foo) assert (i == int.init);
	foo.free();
	
	
	uint barLen = 0;
	int[] bar;
	append(bar, 10, &barLen);
	append(bar, 20, &barLen);
	append(bar, 30, &barLen);
	append(bar, 40, &barLen);
	append(bar, 50, &barLen);
	
	assert (bar.length == 8);
	assert (barLen == 5);
	
	for (int i = 0; i < 20; ++i) {
		append(bar, i, &barLen);
	}
	
	assert (bar.length == 32);
	assert (barLen == 25);
	
	assert (bar[6 .. 10] == [1, 2, 3, 4]);
}



void preallocatedAppend(T)(ref T[] dst, ref T[] buf, T[][] src_ ...) {
	foreach (src; src_) {
		if (buf.length < src.length) {
			throw new Exception("Preallocated buffer is too small in xf.utils.Memory.append");
		} else {
			char[] slice;
			if (dst is null) {
				slice = dst = buf[0..src.length];
			} else {
				dst = dst.ptr[0..dst.length+src.length];
				slice = buf.ptr[0..src.length];
			}
			buf = buf[src.length..$];
			slice[] = src;
		}
	}
}

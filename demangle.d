// Demangles a mangled D identifier
// by James Dunne
// Jan. 5 2005

module	demangle;

import	std.ctype;
import	std.string;

// extracts a series of dot-separated identifiers:
char[] extractidentifiers(char[] id, inout int i) {
	char[]	s;
	bool first = true;

	for (;;) {
		int	num = i;

		// Parse numeric length:
		while (i < id.length) {
			if (!isdigit(id[i])) break;
			++i;
		}
		if (num == i) break;

		// Get the length as an integer:
		int	len = atoi(id[num .. i]);
		// Extract the identifier
		if (!first) s ~= ".";
		s ~= id[i .. i+len];
		i += len;

		// Dot-separate after this:
		first = false;
	}

	// Return the identifier string:
	return s;
}

// extracts a single definition (like a parameter)
char[] extracttypeinfo(char[] id, inout int i) {
	if (i >= id.length) return null;
	// Extract the type info:
	switch (id[i]) {
		// array, static array, dynamic array:
		case 'A', 'G', 'H': ++i; return extracttypeinfo(id, i) ~ "[]";
		// pointer:
		case 'P': ++i; return extracttypeinfo(id, i) ~ "*";
		// reference:
		case 'R': ++i; return extracttypeinfo(id, i) ~ "&";
		// return value:
		case 'Z': ++i; return extracttypeinfo(id, i);
		// out:
		case 'J': ++i; return "out " ~ extracttypeinfo(id, i);
		// inout:
		case 'K': ++i; return "inout " ~ extracttypeinfo(id, i);

		// enum:
		case 'E': ++i; return extractidentifiers(id, i);
		// typedef:
		case 'T': ++i; return extractidentifiers(id, i);
		// delegate:
		case 'D': ++i; return extractidentifiers(id, i);
		// class:
		case 'C': ++i; return extractidentifiers(id, i);
		// struct:
		case 'S': ++i; return extractidentifiers(id, i);
		// identifier:
		case 'I': ++i; return extractidentifiers(id, i);

		// basic types:
		case 'n': ++i; return "none";		// ever used?
		case 'v': ++i; return "void";
		case 'g': ++i; return "byte";
		case 'h': ++i; return "ubyte";
		case 's': ++i; return "short";
		case 't': ++i; return "ushort";
		case 'i': ++i; return "int";
		case 'k': ++i; return "uint";
		case 'l': ++i; return "long";
		case 'm': ++i; return "ulong";
		case 'f': ++i; return "float";
		case 'd': ++i; return "double";
		case 'e': ++i; return "real";

		// imaginary and complex:
		case 'o': ++i; return "ifloat";
		case 'p': ++i; return "idouble";
		case 'j': ++i; return "ireal";
		case 'q': ++i; return "cfloat";
		case 'r': ++i; return "cdouble";
		case 'c': ++i; return "creal";

		// other types:
		case 'b': ++i; return "bit";
		case 'a': ++i; return "char";
		case 'u': ++i; return "wchar";
		case 'w': ++i; return "dchar";

		// typeinfo, error, instance:
		case '@': ++i; return extractidentifiers(id, i);	// BUG: is this right?

		default: return "unknown";
	}
}

// Returns true if it's an identifier (should be modified to return the string)
bool demangle(char[] id) {
	char[]	name;
	int	i;

	// D linkage function:
	if (id[0] == '_') {
		if (id[1] == 'D') {
			// is it main?
			if (id[2 .. 7] == "main") {
				// aww that's easy:
				printf("int main(char[][])\n");
				return true;
			}
	
			// Parse the collection of identifiers:
			i = 2;
			name = extractidentifiers(id, i);
			// function:
			if (id[i] == 'F') {
				char[]	params;
				bool	first = true;
	
				// extract all the parameters:
				++i;
				while (i < id.length) {
					if (id[i] == 'Z') break;
					if (!first) params ~= ", ";
					params ~= extracttypeinfo(id, i);
					first = false;
				}
	
				// extract the return type:
				char[] rettype = extracttypeinfo(id, i);
	
				// print the function definition:
				printf("%.*s %.*s(%.*s)\n\n", rettype, name, params);
				return true;
			} else {
				// should always be a function with _D linkage?!?!
				printf("wtf?!\n\n");
				return false;
			}
			// Check the type:
		} else if (id[1 .. 6] == "Class") {
			i = 7;
			printf("class %.*s\n", extractidentifiers(id, i));
		} else if (id[1 .. 5] == "init") {
			i = 6;
			printf("init %.*s\n", extractidentifiers(id, i));
		} else if (id[1 .. 5] == "vtbl") {
			i = 6;
			printf("vtbl %.*s\n", extractidentifiers(id, i));
		} else if (id[1 .. 8] == "modctor") {
			i = 9;
			printf("ctor %.*s\n", extractidentifiers(id, i));
		} else if (id[1 .. 8] == "moddtor") {
			i = 9;
			printf("dtor %.*s\n", extractidentifiers(id, i));
		} else if (id[1 .. 11] == "ModuleInfo") {
			i = 12;
			printf("module %.*s\n", extractidentifiers(id, i));
		} else {
			return false;
		}
		printf("\n");
		return true;
	}

	return false;
}

// should be a unittest:
int main(char[][] args) {
	// these were taken from phobos.lib:
	demangle("_D3std6stream4File5_ctorFT3std1c7windows7windows6HANDLEE8FileModeZC3std6stream4File");
	demangle("_Class_3std6socket9UdpSocket");
	demangle("_D3std6stream4File6handleFZT3std1c7windows7windows6HANDLE");
	demangle("_D3std6stream12BufferedFile6createFAaE8FileModeZv");
	demangle("_D3std5math24polyFeAeZe");
	demangle("_D3std3uri15decodeComponentFAaZAa");
	demangle("_D3std7windows8registry17Reg_CreateKeyExA_FT3std7windows8registry4HKEYAakE6REGSAMPvJT3std7windows8registry4HKEYJkZi");
	demangle("_D3std6string5ifindFAawZi");
	demangle("_D3std6stream12EndianStream4readFJqZv");
	// these were taken from the compiled EXE of this module:
	demangle("_D8demangle18extractidentifiersFAaKiZAa");
	demangle("_D8demangle15extracttypeinfoFAaKiZAa");
	return 0;
}

//
// Demangling algorithm:
//
// 1. check the prefix of the mangled name.
//    a. if _D then D-linkage function
//    b. if __Class_ then class definition
//    c. if __init_ then init-table for class
//    d. if __vtbl_ then inherited class/interface for class
//    e. if __modctor_ then constructor for class
//    f. if __moddtor_ then destructor for class
//    g. if __ModuleInfo_ then module definition
// 2. To parse an identifier:
//    1. read digits until non-digit character
//    2. convert that collection of digits to integer
//    3. use integer as length to extract identifier
//    4. suffix identifier with .
//    5. repeat steps 1-4 until no initial digit character found.
// 3. To parse the parameter list of a function definition:
//    1. make sure function starts with '_D', has an identifier, and then an 'F'
//    2. check demangling type table function "extracttypeinfo" to appropriate action.
//    3. all lower-case letters are basic types
//    4. all upper-case letters are complex types (like arrays, structs, classes, etc)
//    5. upper-case letters are either followed by lower-case letters (basic types) or
//       identifiers.
//
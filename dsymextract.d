// Demangles a mangled D identifier and produces the result in
// inherited container classes such as DType and DSymbol.

// Ideally used to extract code-completion info from a compiled D library
// using the library's symbol table.

// by James Dunne
// Jan. 6 2005

module	dsymextract;

import	std.ctype;
import	std.string;

//version = destructors;					// include destructor code (for explicit memory management)
version = error_extrachars;				// check for extra characters after end of mangled string
version(linux) {
	version = ansi_color;				// use ANSI color strings for cheap syntax highlighting
}
//debug = destruct;						// dump destructor calls

// A D symbol (inherited usually)
class DSymbol {
	public:
		char[]	name;		// name for the symbol
		DType	type;		// type of the symbol

		this() {
			
		}

		char[] toANSIString() {
			return "\033[0;37m" ~ name;
		}

		char[] toString() {
			return name;
		}
}

// A D function definition
class DFunction : DSymbol {
	public:
		//char[]	name;		// name for the function
		//DType		type;		// return type for the function
		DType[]		params;		// parameters for the function

		this() {
		}

		version (destructors) ~this() {
			foreach (inout DType t; params)
				if (cast(DReservedType)t is null)
					delete t;
		}

		char[] toANSIString() {
			char[] s;
			bool first = true;

			if (type is null) return name;

			s = type.toANSIString() ~ " \033[0;37m" ~ name ~ "\033[0;36m" ~ "(";
			foreach (DType dt; params) {
				if (!first) s ~= "\033[0;36m" ~ ", ";
				s ~= dt.toANSIString();
				first = false;
			}
			s ~= "\033[0;36m)\033[37m";

			return s;
		}

		char[] toString() {
			char[] s;
			bool first = true;

			if (type is null) return name;

			s = type.toString() ~ " " ~ name ~ "(";
			foreach (DType dt; params) {
				if (!first) s ~= ", ";
				s ~= dt.toString();
				first = false;
			}
			s ~= ")";

			return s;
		}
}

// A D class definition:
class DClass : DSymbol {
	public:
		// Doesn't have much.
		// Should expand to contain functions and other symbols.

		this(char[] name) {
			this.name = name;
		}

		char[] toANSIString() {
			return "\033[0;37mclass " ~ name;
		}

		char[] toString() {
			return "class " ~ name;
		}
}

// A D module definition:
class DModule : DSymbol {
	public:
		// Doesn't have much.
		// Should expand to contain class definitions, functions, and other symbols.

		this(char[] name) {
			this.name = name;
		}

		char[] toANSIString() {
			return "\033[0;37mmodule " ~ name;
		}

		char[] toString() {
			return "module " ~ name;
		}
}


// A reserved type:
class DReservedType : DType {
	public:
		this() {
			
		}

		// Initialize a DType with a string representation:
		this(char[] chars) {
			asString = chars;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DReservedType.~this()\n");
		}
}

// A D type:
class DType {
	private:
		char[]	asString;		// what this type is as a string

	public:
		// Some static basic types:
		static DReservedType None;		// ever used?
		static DReservedType Void;
		static DReservedType Byte;
		static DReservedType UByte;
		static DReservedType Short;
		static DReservedType UShort;
		static DReservedType Int;
		static DReservedType UInt;
		static DReservedType Long;
		static DReservedType ULong;
		static DReservedType Float;
		static DReservedType Double;
		static DReservedType Real;

		// imaginary and complex:
		static DReservedType IFloat;
		static DReservedType IDouble;
		static DReservedType IReal;
		static DReservedType CFloat;
		static DReservedType CDouble;
		static DReservedType CReal;

		// other types:
		static DReservedType Bit;
		static DReservedType Char;
		static DReservedType WChar;
		static DReservedType DChar;

		// Initialize the basic types:
		static this() {
			// basic types:
			None = new DReservedType("none");		// ever used?
			Void = new DReservedType("void");
			Byte = new DReservedType("byte");
			UByte = new DReservedType("ubyte");
			Short = new DReservedType("short");
			UShort = new DReservedType("ushort");
			Int = new DReservedType("int");
			UInt = new DReservedType("uint");
			Long = new DReservedType("long");
			ULong = new DReservedType("ulong");
			Float = new DReservedType("float");
			Double = new DReservedType("double");
			Real = new DReservedType("real");

			// imaginary and complex:
			IFloat = new DReservedType("ifloat");
			IDouble = new DReservedType("idouble");
			IReal = new DReservedType("ireal");
			CFloat = new DReservedType("cfloat");
			CDouble = new DReservedType("cdouble");
			CReal = new DReservedType("creal");

			// other types:
			Bit = new DReservedType("bit");
			Char = new DReservedType("char");
			WChar = new DReservedType("wchar");
			DChar = new DReservedType("dchar");
		}

		version (destructors) static ~this() {
			debug (destruct) printf("static DType::~this()\n");
			// basic types:
			delete None;		// ever used?
			delete Void;
			delete Byte;
			delete UByte;
			delete Short;
			delete UShort;
			delete Int;
			delete UInt;
			delete Long;
			delete ULong;
			delete Float;
			delete Double;
			delete Real;

			// imaginary and complex:
			delete IFloat;
			delete IDouble;
			delete IReal;
			delete CFloat;
			delete CDouble;
			delete CReal;

			// other types:
			delete Bit;
			delete Char;
			delete WChar;
			delete DChar;
			debug (destruct) printf("static DType::~this() deleted\n");
		}

	public:
		// Not sure why, but the compiler complains without it:
		this() {
			
		}

		version (destructors) ~this() {
			
		}

		// Convert the type to its string representation:
		char[] toANSIString() {
			return "\033[34m" ~ asString;
		}

		char[] toString() {
			return asString;
		}
}

// This exception is thrown on parsing errors and type errors:
class DTypeException : Exception {
	public:
		this(char[] msg) {
			super("DTypeException: " ~ msg);
		}
}

// Simple D types:

// Array:
class DTypeArray : DType {
	private:
		DType	internalType;		// the type of the array

	public:
		this(DType singleType) {
			this.internalType = singleType;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DTypeArray.~this()\n");
			if (cast(DReservedType)internalType is null)
				delete internalType;
		}

		// append a [] to the end of the type:
		char[] toANSIString() {
			return internalType.toANSIString() ~ "\033[1;31m[]\033[0;37m";
		}

		char[] toString() {
			return internalType.toString() ~ "[]";
		}
}

// Static array:
class DTypeSArray : DType {
	private:
		DType	internalType;		// the type of the array

	public:
		this(DType singleType) {
			this.internalType = singleType;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DTypeSArray.~this()\n");
			if (cast(DReservedType)internalType is null)
				delete internalType;
		}

		// append a [] to the end of the type:
		char[] toANSIString() {
			return internalType.toANSIString() ~ "\033[1;31m[]\033[0;37m";
		}

		char[] toString() {
			return internalType.toString() ~ "[]";
		}
}

// Dynamic array:
class DTypeDArray : DType {
	private:
		DType	internalType;		// the type of the array

	public:
		this(DType singleType) {
			this.internalType = singleType;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DTypeDArray.~this()\n");
			if (cast(DReservedType)internalType is null)
				delete internalType;
		}

		// append a [] to the end of the type:
		char[] toANSIString() {
			return internalType.toANSIString() ~ "\033[1;31m[]\033[0;37m";
		}

		char[] toString() {
			return internalType.toString() ~ "[]";
		}
}

// Pointer:
class DTypePointer : DType {
	private:
		DType	internalType;		// the type of pointer

	public:
		this(DType singleType) {
			this.internalType = singleType;
		}

		version (destructors) ~this() {
			debug (destruct) ("DTypePointer.~this()\n");
			if (cast(DReservedType)internalType is null)
				delete internalType;
		}

		char[] toANSIString() {
			return internalType.toANSIString() ~ "\033[1;33m*\033[0;37m";
		}

		char[] toString() {
			return internalType.toString() ~ "*";
		}
}

// Reference:
class DTypeReference : DType {
	private:
		DType	internalType;		// the type of reference

	public:
		this(DType singleType) {
			this.internalType = singleType;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DTypeReference.~this()\n");
			if (cast(DReservedType)internalType is null)
				delete internalType;
		}

		char[] toANSIString() {
			return internalType.toANSIString() ~ "\033[1;33m&\033[0;37m";
		}
		
		char[] toString() {
			return internalType.toString() ~ "&";
		}
}

// out parameter:
// (in is default)
class DTypeOut : DType {
	private:
		DType	internalType;		// an out parameter

	public:
		this(DType singleType) {
			if (!(cast(DTypeInOut)singleType is null))
				throw new DTypeException("inout cannot be followed by out!");
			if (!(cast(DTypeOut)singleType is null))
				throw new DTypeException("out cannot be followed by out!");

			this.internalType = singleType;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DTypeOut.~this()\n");
			if (cast(DReservedType)internalType is null)
				delete internalType;
		}

		char[] toANSIString() {
			return "\033[34mout " ~ internalType.toANSIString();
		}

		char[] toString() {
			return "out " ~ internalType.toString();
		}
}

// inout parameter:
class DTypeInOut : DType {
	private:
		DType	internalType;		// an inout parameter

	public:
		this(DType singleType) {
			if (!(cast(DTypeInOut)singleType is null))
				throw new DTypeException("inout cannot be followed by inout!");
			if (!(cast(DTypeOut)singleType is null))
				throw new DTypeException("out cannot be followed by inout!");

			this.internalType = singleType;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DTypeInOut.~this()\n");
			if (cast(DReservedType)internalType is null)
				delete internalType;
		}

		char[] toANSIString() {
			return "\033[34minout " ~ internalType.toANSIString();
		}

		char[] toString() {
			return "inout " ~ internalType.toString();
		}
}

// enum:
class DTypeEnumeration : DType {
	private:
		char[]	identifier;			// the name of the enum type

	public:
		this(char[] ident) {
			this.identifier = ident;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DTypeEnumeration.~this()\n");
		}

		char[] toANSIString() {
			return "\033[0;37m" ~ identifier;
		}

		char[] toString() {
			return identifier;
		}
}

// typedef:
class DTypeTypedef : DType {
	private:
		char[]	identifier;			// the name of the typedef type

	public:
		this(char[] ident) {
			this.identifier = ident;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DTypeTypedef.~this()\n");
		}

		char[] toANSIString() {
			return "\033[0;37m" ~ identifier;
		}

		char[] toString() {
			return identifier;
		}
}

// delegate:
class DTypeDelegate : DType {
	private:
		char[]	identifier;			// the name of the delegate type

	public:
		this(char[] ident) {
			this.identifier = ident;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DTypeDelegate.~this()\n");
		}

		char[] toANSIString() {
			return "\033[0;37m" ~ identifier;
		}

		char[] toString() {
			return identifier;
		}
}

// class instance:
class DTypeClass : DType {
	private:
		char[]	identifier;			// the name of the class type

	public:
		this(char[] ident) {
			this.identifier = ident;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DTypeClass.~this()\n");
		}

		char[] toANSIString() {
			return "\033[0;37m" ~ identifier;
		}

		char[] toString() {
			return identifier;
		}
}

// struct instance:
class DTypeStruct : DType {
	private:
		char[]	identifier;			// the name of the struct type

	public:
		this(char[] ident) {
			this.identifier = ident;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DTypeStruct.~this()\n");
		}

		char[] toANSIString() {
			return "\033[0;37m" ~ identifier;
		}

		char[] toString() {
			return identifier;
		}
}

// identifier:
class DTypeIdentifier : DType {
	private:
		char[]	identifier;

	public:
		this(char[] ident) {
			this.identifier = ident;
		}

		version (destructors) ~this() {
			debug (destruct) printf("DTypeIdentifier.~this()\n");
		}

		char[] toANSIString() {
			return "\033[0;37m" ~ identifier;
		}

		char[] toString() {
			return identifier;
		}
}

// The extractor class:
class DSymbolExtractor {
	private:

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

				if (i+len > id.length)
					throw new DTypeException("length of identifier would exceed length of mangled string!");

				s ~= id[i .. i+len];
				i += len;

				// Dot-separate after this:
				first = false;
			}

			// Return the identifier string:
			return s;
		}

		// extracts a single definition (like a parameter)
		DType extracttypeinfo(char[] id, inout int i) {
			if (i >= id.length)
				throw new DTypeException("unexpected end of identifier!");

			// Extract the type info:
			switch (id[i]) {
				// array, static array, dynamic array:
				case 'A': ++i; return new DTypeArray(extracttypeinfo(id, i));
				case 'G': ++i; return new DTypeSArray(extracttypeinfo(id, i));
				case 'H': ++i; return new DTypeDArray(extracttypeinfo(id, i));
				// pointer:
				case 'P': ++i; return new DTypePointer(extracttypeinfo(id, i));
				// reference:
				case 'R': ++i; return new DTypeReference(extracttypeinfo(id, i));
				// out:
				case 'J': ++i; return new DTypeOut(extracttypeinfo(id, i));
				// inout:
				case 'K': ++i; return new DTypeInOut(extracttypeinfo(id, i));

				// enum:
				case 'E': ++i; return new DTypeEnumeration(extractidentifiers(id, i));
				// typedef:
				case 'T': ++i; return new DTypeTypedef(extractidentifiers(id, i));
				// delegate:
				case 'D': ++i; return new DTypeDelegate(extractidentifiers(id, i));
				// class:
				case 'C': ++i; return new DTypeClass(extractidentifiers(id, i));
				// struct:
				case 'S': ++i; return new DTypeStruct(extractidentifiers(id, i));
				// identifier:
				case 'I': ++i; return new DTypeIdentifier(extractidentifiers(id, i));

				// basic types:
				case 'n': ++i; return DType.None;		// ever used?
				case 'v': ++i; return DType.Void;
				case 'g': ++i; return DType.Byte;
				case 'h': ++i; return DType.UByte;
				case 's': ++i; return DType.Short;
				case 't': ++i; return DType.UShort;
				case 'i': ++i; return DType.Int;
				case 'k': ++i; return DType.UInt;
				case 'l': ++i; return DType.Long;
				case 'm': ++i; return DType.ULong;
				case 'f': ++i; return DType.Float;
				case 'd': ++i; return DType.Double;
				case 'e': ++i; return DType.Real;

				// imaginary and complex:
				case 'o': ++i; return DType.IFloat;
				case 'p': ++i; return DType.IDouble;
				case 'j': ++i; return DType.IReal;
				case 'q': ++i; return DType.CFloat;
				case 'r': ++i; return DType.CDouble;
				case 'c': ++i; return DType.CReal;

				// other types:
				case 'b': ++i; return DType.Bit;
				case 'a': ++i; return DType.Char;
				case 'u': ++i; return DType.WChar;
				case 'w': ++i; return DType.DChar;

				case 'Z': throw new DTypeException(format("Z (return type) cannot be used as a type at position %d!", i));

				// typeinfo, error, instance:
				case '@': ++i; return null;		// BUG: FIXME!!

				default: throw new DTypeException(format("unknown type mangle character '%s' at position %d!", id[i], i));
			}
		}

	public:
		// Constructor doesn't do anything.
		this() {
			
		}

		// Returns the symbol represented by the mangled string:
		// right now, only class declarations and function declarations.
		DSymbol demangle(char[] id) {
			char[]	name;
			int	i;

			// Remove all leading underscores except one:
			i = 0;
			while (id[i] == '_') ++i;
			if (i > 0) --i;

			id = id[i .. length];

			// D linkage function:
			if (id[0] == '_') {
				if (id[1] == 'D') {
					if (id.length <= 2)
						throw new DTypeException("mangled function identifier is too short!");

					// is it main?
					if ((id.length >= 6) && (id[2 .. 6] == "main")) {
						DFunction	dfunc = new DFunction();
						// aww that's easy:
						dfunc.name = "main";
						dfunc.type = DType.Int;
						dfunc.params.length = 1;
						dfunc.params[0] = new DTypeArray(new DTypeArray(DType.Char));
						return dfunc;
					}

					// Parse the name:
					i = 2;
					DFunction	dfunc = new DFunction();
					dfunc.name = extractidentifiers(id, i);

					// function:
					if (i >= id.length)
						throw new DTypeException(format("expected F at position %d!", i));

					if (id[i] == 'F') {
						// extract all the parameters:
						++i;
						dfunc.params.length = 0;
						while (i < id.length) {
							if (id[i] == 'Z') break;
							// Add the parameter:
							dfunc.params.length = dfunc.params.length + 1;
							dfunc.params[length - 1] = extracttypeinfo(id, i);
						}

						// extract the return type:
						if ((i >= id.length) || (id[i] != 'Z'))
							throw new DTypeException(format("Z expected at position %d!", i));

						// skip the Z cuz we know it's a return type:
						++i;
						dfunc.type = extracttypeinfo(id, i);

						version (error_extrachars) {
							// check for extra characters:
							if (i < id.length)
								throw new DTypeException(format("%d extra characters at position %d", id.length - i, i));
						}

						// Return the DFunction as a DSymbol:
						return dfunc;
					} else {
						// should always be a function if it has _D linkage!
						throw new DTypeException(format("expected F at position %d!", i));
					}
					// Check the type:
				} else if (id[1 .. 6] == "Class") {
					i = 7;
					return new DClass(extractidentifiers(id, i));
// Not sure what to do with these:
/+
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
+/
				} else if (id[1 .. 11] == "ModuleInfo") {
					i = 12;
					return new DModule(extractidentifiers(id, i));
				}
				return null;
			}

			// Got nothin' to return here:
			return null;
		}
}

// Simple test program:
int main(char[][] args) {
	static char[][]	testcases = [
		// these were taken from phobos.lib:
		"_D3std6stream4File5_ctorFT3std1c7windows7windows6HANDLEE8FileModeZC3std6stream4File",
		"__Class_3std6socket9UdpSocket",
		"_D3std6stream4File6handleFZT3std1c7windows7windows6HANDLE",
		"_D3std6stream12BufferedFile6createFAaE8FileModeZv",
		"_D3std5math24polyFeAeZe",
		"_D3std3uri15decodeComponentFAaZAa",
		"_D3std7windows8registry17Reg_CreateKeyExA_FT3std7windows8registry4HKEYAakE6REGSAMPvJT3std7windows8registry4HKEYJkZi",
		"_D3std6string5ifindFAawZi",
		"_D3std6stream12EndianStream4readFJqZv",
		// these were taken from the compiled EXE of this module:
		"_D8demangle18extractidentifiersFAaKiZAa",
		"_D8demangle15extracttypeinfoFAaKiZAa",
		"_Dmain"
	];

	// Create the symbol extractor:
	DSymbolExtractor	dse = new DSymbolExtractor();

	printf("\n");
	if (args.length <= 1) {
		// Use it on each test case:
		foreach (char[] test; testcases) {
			DSymbol dsym = dse.demangle(test);
			// Print out the demangled symbol:
			if (!(dsym is null)) {
				version (ansi_color)
					printf("%.*s\n", dsym.toANSIString());
				else
					printf("%.*s\n", dsym.toString());
				delete dsym;
			}
		}
	} else {
		// Use it on the argument:
		DSymbol	dsym = dse.demangle(args[1]);
		// Print out the demangled symbol:
		if (!(dsym is null)) {
			version (ansi_color)
				printf("%.*s\n", dsym.toANSIString());
			else
				printf("%.*s\n", dsym.toString());
			delete dsym;
		}
	}
	printf("\n");

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
//    6. function definition ends with Z followed by a type for the return type.
//

// dlexer - D language lexer
// (C) Copyright 2004-2005 James Dunne

// Please feel free to distribute this module in any form you like.  I only ask that you
// give credit where credit is due.  You may make modifications to this module.  If you do
// so, you may provide your modifications publicly, but you are not required to.

module	dlexer;

import	std.stream;
import	std.string;
import	std.ctype;

alias std.ctype.isdigit isdigit;

// Set this version identifier to enable interpretation of escaped characters within parsed strings
// If this is disabled, the strings are copied directly, escape sequences and all.

// version = interpret_slashes;

// Enumeration of D language tokens taken from DMD's lexer.h
enum : uint {
	TOKreserved,

	// Other
	TOKlparen,	TOKrparen,
	TOKlbracket,	TOKrbracket,
	TOKlcurly,	TOKrcurly,
	TOKcolon,	TOKneg,
	TOKsemicolon,	TOKdotdotdot,
	TOKeof,		TOKcast,
	TOKnull,	TOKassert,
	TOKtrue,	TOKfalse,
	TOKarray,	TOKcall,
	TOKaddress,	TOKtypedot,
	TOKtype,	TOKthrow,
	TOKnew,		TOKdelete,
	TOKstar,	TOKsymoff,
	TOKvar,		TOKdotvar,
	TOKdotti,	TOKdotexp,
	TOKdottype,	TOKslice,
	TOKarraylength,	TOKversion,
	TOKmodule,	TOKdollar,
	TOKtemplate,	TOKinstance,
	TOKdeclaration,	TOKtypeof,
	TOKpragma,	TOKdsymbol,
	TOKtypeid,	TOKuadd,

	// Operators
	TOKlt,		TOKgt,
	TOKle,		TOKge,
	TOKequal,	TOKnotequal,
	TOKidentity,	TOKnotidentity,
	TOKindex,

	// NCEG floating point compares
	// !<>=     <>    <>=    !>     !>=   !<     !<=   !<>
	TOKunord,TOKlg,TOKleg,TOKule,TOKul,TOKuge,TOKug,TOKue,

	TOKshl,		TOKshr,
	TOKshlass,	TOKshrass,
	TOKushr,	TOKushrass,
	TOKcat,		TOKcatass,	// ~ ~=
	TOKadd,		TOKmin,		TOKaddass,	TOKminass,
	TOKmul,		TOKdiv,		TOKmod,
	TOKmulass,	TOKdivass,	TOKmodass,
	TOKand,		TOKor,		TOKxor,
	TOKandass,	TOKorass,	TOKxorass,
	TOKassign,	TOKnot,		TOKtilde,
	TOKplusplus,	TOKminusminus,
	TOKdot,		TOKarrow,	TOKcomma,
	TOKquestion,	TOKandand,	TOKoror,

	// Numeric literals
	TOKint32v, TOKuns32v,
	TOKint64v, TOKuns64v,
	TOKfloat32v, TOKfloat64v, TOKfloat80v,
	TOKimaginary32v, TOKimaginary64v, TOKimaginary80v,

	// Char constants
	TOKcharv, TOKwcharv, TOKdcharv,

	// Leaf operators
	TOKidentifier,	TOKstring,
	TOKthis,	TOKsuper,

	// Basic types
	TOKvoid,
	TOKint8, TOKuns8,
	TOKint16, TOKuns16,
	TOKint32, TOKuns32,
	TOKint64, TOKuns64,
	TOKfloat32, TOKfloat64, TOKfloat80,
	TOKimaginary32, TOKimaginary64, TOKimaginary80,
	TOKcomplex32, TOKcomplex64, TOKcomplex80,
	TOKchar, TOKwchar, TOKdchar, TOKbit,

	// Aggregates
	TOKstruct, TOKclass, TOKinterface, TOKunion, TOKenum, TOKimport,
	TOKtypedef, TOKalias, TOKoverride, TOKdelegate, TOKfunction,
	TOKmixin,

	TOKalign, TOKextern, TOKprivate, TOKprotected, TOKpublic, TOKexport,
	TOKstatic, /*TOKvirtual,*/ TOKfinal, TOKconst, TOKabstract, TOKvolatile,
	TOKdebug, TOKdeprecated, TOKin, TOKout, TOKinout,
	TOKauto, TOKpackage,

	// Statements
	TOKif, TOKelse, TOKwhile, TOKfor, TOKdo, TOKswitch,
	TOKcase, TOKdefault, TOKbreak, TOKcontinue, TOKwith,
	TOKsynchronized, TOKreturn, TOKgoto, TOKtry, TOKcatch, TOKfinally,
	TOKasm, TOKforeach,

	// Contracts
	TOKbody, TOKinvariant,

	// Testing
	TOKunittest,

	TOKmax
}

// A table converting token values into string representations:
char[]	toktostr[TOKmax] = [
	TOKreserved : "reserved",

	// Other
	TOKlparen : "(",
	TOKrparen : ")",
	TOKlbracket : "[",
	TOKrbracket : "]",
	TOKlcurly : "{",
	TOKrcurly : "}",
	TOKcolon : ":",
	TOKneg : "-",
	TOKsemicolon : ";",
	TOKdotdotdot : "...",
	TOKeof : "EOF",
	TOKcast : "cast",
	TOKnull : "null",
	TOKassert : "assert",
	TOKtrue : "true",
	TOKfalse : "false",
	TOKarray : "[]",
	TOKcall : "call",
	TOKaddress : "#",
	TOKtypedot : "typedot",
	TOKtype : "type",
	TOKthrow : "throw",
	TOKnew : "new",
	TOKdelete : "delete",
	TOKstar : "*",
	TOKsymoff : "symoff",
	TOKvar : "var",
	TOKdotvar : "dotvar",
	TOKdotti : "dotti",
	TOKdotexp : "dotexp",
	TOKdottype : "dottype",
	TOKslice : "..",
	TOKarraylength : "arraylength",
	TOKversion : "version",
	TOKmodule : "module",
	TOKdollar : "$",
	TOKtemplate : "template",
	TOKinstance : "instance",
	TOKdeclaration : "declaration",
	TOKtypeof : "typeof",
	TOKpragma : "pragma",
	TOKdsymbol : "dsymbol",
	TOKtypeid : "typeid",
	TOKuadd : "uadd",

	// Operators
	TOKlt : "<",
	TOKgt : ">",
	TOKle : "<=",
	TOKge : ">=",
	TOKequal : "==",
	TOKnotequal : "!=",
	TOKidentity : "===",
	TOKnotidentity : "!==",
	TOKindex : "[]",

	// NCEG floating point compares
	// !<>=     <>    <>=    !>     !>=   !<     !<=   !<>

	// NOTE:  These could be horribly wrong
	TOKunord : "!<>=",
	TOKue : "!<>",
	TOKlg : "<>",
	TOKleg : "<>=",
	TOKule : "!>",
	TOKul : "!>=",
	TOKuge : "!<",
	TOKug : "!<=",

	TOKshl : "<<",
	TOKshr : ">>",
	TOKshlass : "<<=",
	TOKshrass : ">>=",
	TOKushr : ">>>",
	TOKushrass : ">>>=",
	TOKcat : "~",
	TOKcatass : "~=",	// ~ ~=
	TOKadd : "+",
	TOKmin : "-",
	TOKaddass : "+=",
	TOKminass : "-=",
	TOKmul : "*",
	TOKdiv : "/",
	TOKmod : "%",
	TOKmulass : "*=",
	TOKdivass : "/=",
	TOKmodass : "%=",
	TOKand : "&",
	TOKor : "|",
	TOKxor : "^",
	TOKandass : "&=",
	TOKorass : "|=",
	TOKxorass : "^=",
	TOKassign : "=",
	TOKnot : "!",
	TOKtilde : "~",
	TOKplusplus : "++",
	TOKminusminus : "--",
	TOKdot : ".",
	TOKarrow : "->",
	TOKcomma : ",",
	TOKquestion : "?",
	TOKandand : "&&",
	TOKoror : "||",

	// Numeric literals
	TOKint32v : "int32v", TOKuns32v : "uns32v",
	TOKint64v : "int64v", TOKuns64v : "uns64v",
	TOKfloat32v : "float32v", TOKfloat64v : "float64v", TOKfloat80v : "float80v",
	TOKimaginary32v : "imaginary32v", TOKimaginary64v : "imaginary64v", TOKimaginary80v : "imaginary80v",

	// Char constants
	TOKcharv : "charv", TOKwcharv : "wcharv", TOKdcharv : "dcharv",

	// Leaf operators
	TOKidentifier : "identifier",	TOKstring : "string",
	TOKthis : "this",	TOKsuper : "super",

	// Basic types
	TOKvoid : "void",
	TOKint8 : "byte", TOKuns8 : "ubyte",
	TOKint16 : "short", TOKuns16 : "ushort",
	TOKint32 : "int", TOKuns32 : "uint",
	TOKint64 : "long", TOKuns64 : "ulong",
	TOKfloat32 : "float", TOKfloat64 : "double", TOKfloat80 : "real",
	TOKimaginary32 : "ifloat", TOKimaginary64 : "idouble", TOKimaginary80 : "ireal",
	TOKcomplex32 : "cfloat", TOKcomplex64 : "cdouble", TOKcomplex80 : "creal",
	TOKchar : "char", TOKwchar : "wchar", TOKdchar : "dchar", TOKbit : "bit",

	// Aggregates
	TOKstruct : "struct", TOKclass : "class", TOKinterface : "interface", TOKunion : "union", TOKenum : "enum", TOKimport : "import",
	TOKtypedef : "typedef", TOKalias : "alias", TOKoverride : "override", TOKdelegate : "delegate", TOKfunction : "function",
	TOKmixin : "mixin",

	TOKalign : "align", TOKextern : "extern", TOKprivate : "private", TOKprotected : "protected", TOKpublic : "public", TOKexport : "export",
	TOKstatic : "static", /*TOKvirtual : "virtual",*/ TOKfinal : "final", TOKconst : "const", TOKabstract : "abstract", TOKvolatile : "volatile",
	TOKdebug : "debug", TOKdeprecated : "deprecated", TOKin : "in", TOKout : "out", TOKinout : "inout",
	TOKauto : "auto", TOKpackage : "package",

	// Statements
	TOKif : "if", TOKelse : "else", TOKwhile : "while", TOKfor : "for", TOKdo : "do", TOKswitch : "switch",
	TOKcase : "case", TOKdefault : "default", TOKbreak : "break", TOKcontinue : "continue", TOKwith : "with",
	TOKsynchronized : "synchronized", TOKreturn : "return", TOKgoto : "goto", TOKtry : "try", TOKcatch : "catch", TOKfinally : "finally",
	TOKasm : "asm", TOKforeach : "foreach",

	// Contracts
	TOKbody : "body", TOKinvariant : "invariant",

	// Testing
	TOKunittest : "unittest",
];

class Identifier {
    int		value;
    char[]	string;

    this(char[] string, int value) {
		this.value = value;
		this.string = string;
	};
};

// A language token:
struct Token {
	// The kind of token:
	uint	value;

	// The value for the token:
	union {
		// The identifier or value of the token:
		Identifier*	ident;

		char[]		ustring;

		// Integers
		int 		int32value;
		uint		uns32value;
		long		int64value;
		ulong		uns64value;

		// Floats
		real		float80value;
	};

	char[] toString() {
		return toktostr[token];
	};
}

// Exception thrown during parsing of D language:
class DLexerException : Error {
	public:
		this(DLexer dlx, char[] msg) {
			// Construct an error message with the filename and line number:
			super(dlx.filename ~ "(" ~ format("%d", dlx.line) ~ ")" ~ ": " ~ msg);
		}
}

// Check for octal digit:
int isodigit(dchar x) {
	if (!isdigit(x) || (x == '8') || (x == '9')) return 0;
	return -1;
}

// The D language lexer (tokenizer):
class DLexer {
		static uint[char[]]	keywords;
		// Initialize the keyword->tokenvalue AA:
		static this() {
			// Add all the keywords' values into the AA:
			keywords["this"] = TOKthis;
			keywords["super"] = TOKsuper;
			keywords["assert"] = TOKassert;
			keywords["null"] = TOKnull;
			keywords["true"] = TOKtrue;
			keywords["false"] = TOKfalse;
			keywords["cast"] = TOKcast;
			keywords["new"] = TOKnew;
			keywords["delete"] = TOKdelete;
			keywords["throw"] = TOKthrow;
			keywords["module"] = TOKmodule;
			keywords["pragma"] = TOKpragma;
			keywords["typeof"] = TOKtypeof;
			keywords["typeid"] = TOKtypeid;

			keywords["template"] = TOKtemplate;
			keywords["instance"] = TOKinstance;

			keywords["void"] = TOKvoid;
			keywords["byte"] = TOKint8;
			keywords["ubyte"] = TOKuns8;
			keywords["short"] = TOKint16;
			keywords["ushort"] = TOKuns16;
			keywords["int"] = TOKint32;
			keywords["uint"] = TOKuns32;
			keywords["long"] = TOKint64;
			keywords["ulong"] = TOKuns64;
			keywords["float"] = TOKfloat32;
			keywords["double"] = TOKfloat64;
			keywords["real"] = TOKfloat80;

			keywords["bit"] = TOKbit;
			keywords["char"] = TOKchar;
			keywords["wchar"] = TOKwchar;
			keywords["dchar"] = TOKdchar;

			keywords["ifloat"] = TOKimaginary32;
			keywords["idouble"] = TOKimaginary64;
			keywords["ireal"] = TOKimaginary80;

			keywords["cfloat"] = TOKcomplex32;
			keywords["cdouble"] = TOKcomplex64;
			keywords["creal"] = TOKcomplex80;

			keywords["delegate"] = TOKdelegate;
			keywords["function"] = TOKfunction;

			keywords["is"] = TOKidentity;
			keywords["if"] = TOKif;
			keywords["else"] = TOKelse;
			keywords["while"] = TOKwhile;
			keywords["for"] = TOKfor;
			keywords["do"] = TOKdo;
			keywords["switch"] = TOKswitch;
			keywords["case"] = TOKcase;
			keywords["default"] = TOKdefault;
			keywords["break"] = TOKbreak;
			keywords["continue"] = TOKcontinue;
			keywords["synchronized"] = TOKsynchronized;
			keywords["return"] = TOKreturn;
			keywords["goto"] = TOKgoto;
			keywords["try"] = TOKtry;
			keywords["catch"] = TOKcatch;
			keywords["finally"] = TOKfinally;
			keywords["with"] = TOKwith;
			keywords["asm"] = TOKasm;
			keywords["foreach"] = TOKforeach;

			keywords["struct"] = TOKstruct;
			keywords["class"] = TOKclass;
			keywords["interface"] = TOKinterface;
			keywords["union"] = TOKunion;
			keywords["enum"] = TOKenum;
			keywords["import"] = TOKimport;
			keywords["mixin"] = TOKmixin;
			keywords["static"] = TOKstatic;
			/*keywords["virtual"] = TOKvirtual;*/
			keywords["final"] = TOKfinal;
			keywords["const"] = TOKconst;
			keywords["typedef"] = TOKtypedef;
			keywords["alias"] = TOKalias;
			keywords["override"] = TOKoverride;
			keywords["abstract"] = TOKabstract;
			keywords["volatile"] = TOKvolatile;
			keywords["debug"] = TOKdebug;
			keywords["deprecated"] = TOKdeprecated;
			keywords["in"] = TOKin;
			keywords["out"] = TOKout;
			keywords["inout"] = TOKinout;
			keywords["auto"] = TOKauto;

			keywords["align"] = TOKalign;
			keywords["extern"] = TOKextern;
			keywords["private"] = TOKprivate;
			keywords["package"] = TOKpackage;
			keywords["protected"] = TOKprotected;
			keywords["public"] = TOKpublic;
			keywords["export"] = TOKexport;

			keywords["body"] = TOKbody;
			keywords["invariant"] = TOKinvariant;
			keywords["unittest"] = TOKunittest;
			keywords["version"] = TOKversion;
		}

	protected:
		Token				token;
		Identifier*[char[]]	identifiers;

	private:
		char[]	file;		// The input file
		uint	p;			// Current character

		char[]	wysiwygString(char tc) {
			char	c;
			char[]	s;
			uint	i;

			i = 0;
			++p;
			s.length = 16;
			while (p < file.length) {
				c = file[p++];
				switch (c) {
					case '\n':
						++line;
						break;

					case '\r':
						if (file[p] == '\n')
							continue;	// ignore
						c = '\n';	// treat EndOfLine as \n character
						++line;
						break;

					case 0x1A:
						error(format("unterminated string constant starting at %s", s));
						return null;

					case '"', '`':
						if (c == tc) {
							s.length = i;
							return s;
						}
						break;

					default:
						break;
				}

				if (i == s.length) s.length = s.length * 2;
				s[i++] = c;
			}
			s.length = i;
			return s;
		}

		// Test this!
		char[]	hexString() {
			char	c;
			uint	n = 0, i = 0;
			char[]	s;
			ubyte	v;

			p++;
			s.length = 16;
			while (p < file.length) {
				c = file[p++];
				switch (c) {
					case ' ', '\t', '\v', '\f':
						continue;			// skip white space

					case '\r':
						if (file[p] == '\n')
							continue;			// ignore
						// Treat isolated '\r' as if it were a '\n'
					case '\n':
						++line;
						continue;

					case 0x1A:
						error(format("unterminated string constant starting at %s", s));
						return null;

					case '"':
						if (n & 1) {
							error(format("odd number (%d) of hex characters in hex string", n));
							return null;
						}
						s.length = i;
						return s;

					default:
						if (c >= '0' && c <= '9')
							c -= '0';
						else if (c >= 'a' && c <= 'f')
							c -= 'a' - 10;
						else if (c >= 'A' && c <= 'F')
							c -= 'A' - 10;
						else
							error(format("non-hex character '%c'", c));
						if (n & 1) {
							v = (v << 4) | c;
							if (i == s.length) s.length = s.length * 2;
							s[i++] = v;
						} else
							v = c;
						++n;
						break;
				}
			}
			return null;
		}

	public:
		char[]	filename;	// Filename
		uint	line;		// Current line

		// Initialize the lexer with the full source code as a string:
		this(char[] filename, char[] src) {
			file = src;
			this.filename = filename;
			restart();
		}

		// Possible to buffer up errors until some limit n.
		void error(char[] msg) {
			throw new DLexerException(this, msg);
		}

		// This function consumes a full D language token and returns it in the structure Token:
		// null is returned if the end of the file is reached.
		uint	nextToken() {
			uint	start;

			token.ident = null;
			token.uns64value = 0;
			token.value = TOKidentifier;

			// Past the end of file? Return an EOF token:
			if (p >= file.length) {
				token.value = TOKeof;
				return token.value;
			}

			// Read up to the next white-space char:
			while (p < file.length) {
				switch (file[p]) {
					case ' ', '\n', '\r', '\v', '\t', '\f':
						if (file[p] == '\n') ++line;
						++p;
						break;

					case '.':
						++p;
						if (file[p] == '.') {
							++p;
							if (file[p] == '.') {
								++p;
								token.value = TOKdotdotdot;
							} else
								token.value = TOKslice;
						} else
							token.value = TOKdot;
						return token.value;

					case '&':
						++p;
						if (file[p] == '=') {
							++p;
							token.value = TOKandass;
						} else if (file[p] == '&') {
							++p;
							token.value = TOKandand;
						} else
							token.value = TOKand;
						return token.value;

					case '|':
						++p;
						if (file[p] == '=') {
							++p;
							token.value = TOKorass;
						} else if (file[p] == '|') {
							++p;
							token.value = TOKoror;
						} else
							token.value = TOKor;
						return token.value;

					case '-':
						++p;
						if (file[p] == '=') {
							++p;
							token.value = TOKminass;
						} else if (file[p] == '-') {
							++p;
							token.value = TOKminusminus;
						} else
							token.value = TOKmin;
						return token.value;

					case '+':
						++p;
						if (file[p] == '=') {
							++p;
							token.value = TOKaddass;
						} else if (file[p] == '+') {
							++p;
							token.value = TOKplusplus;
						} else
							token.value = TOKadd;
						return token.value;

					case '=':
						++p;
						if (file[p] == '=') {
							++p;
							if (file[p] == '=') {
								++p;
								token.value = TOKidentity;
							} else
								token.value = TOKequal;
						} else
							token.value = TOKassign;
						return token.value;

					case '<':
						++p;
						if (file[p] == '=') {
							++p;
							token.value = TOKle;			// <=
						} else if (file[p] == '<') {
							++p;
							if (file[p] == '=') {
								++p;
								token.value = TOKshlass;		// <<=
							} else
								token.value = TOKshl;		// <<
						} else if (file[p] == '>') {
							++p;
							if (file[p] == '=') {
								++p;
								token.value = TOKleg;		// <>=
							} else
								token.value = TOKlg;		// <>
						} else
							token.value = TOKlt;			// <
						return token.value;

					case '>':
						++p;
						if (file[p] == '=') {
							++p;
							token.value = TOKge;			// >=
						} else if (file[p] == '>') {
							++p;
							if (file[p] == '=') {
								++p;
								token.value = TOKshrass;		// >>=
							} else if (file[p] == '>') {
								++p;
								if (file[p] == '=') {
									++p;
									token.value = TOKushrass;	// >>>=
								} else
									token.value = TOKushr;		// >>>
							} else
								token.value = TOKshr;		// >>
						} else
							token.value = TOKgt;			// >
						return token.value;

					case '!':
						++p;
						if (file[p] == '=') {
							++p;
							if (file[p] == '=') {
								++p;
								token.value = TOKnotidentity;	// !==
							} else
								token.value = TOKnotequal;		// !=
						} else if (file[p] == '<') {
							++p;
							if (file[p] == '>') {
								++p;
								if (file[p] == '=') {
									++p;
									token.value = TOKunord; // !<>=
								} else
									token.value = TOKue;	// !<>
							} else if (file[p] == '=') {
								++p;
								token.value = TOKug;	// !<=
							} else
								token.value = TOKuge;	// !<
						} else if (file[p] == '>') {
							++p;
							if (file[p] == '=') {
								++p;
								token.value = TOKul;	// !>=
							} else
								token.value = TOKule;	// !>
						} else
							token.value = TOKnot;		// !
						return token.value;

					case '*':
						++p;
						if (file[p] == '=') {
							++p;
							token.value = TOKmulass;
						} else
							token.value = TOKmul;
						return token.value;
					case '%':
						++p;
						if (file[p] == '=') {
							++p;
							token.value = TOKmodass;
						} else
							token.value = TOKmod;
						return token.value;
					case '^':
						++p;
						if (file[p] == '=') {
							++p;
							token.value = TOKxorass;
						} else
							token.value = TOKxor;
						return token.value;
					case '~':
						++p;
						if (file[p] == '=') {
							++p;
							token.value = TOKcatass;
						} else
							token.value = TOKtilde;
						return token.value;

					case '(': ++p; token.value = TOKlparen; return token.value;
					case ')': ++p; token.value = TOKrparen; return token.value;
					case '[':
						++p;
						if (file[p] == ']') {
							++p;
							token.value = TOKarray;
						} else
							token.value = TOKlbracket;
						return token.value;
					case ']': ++p; token.value = TOKrbracket; return token.value;
					case '{': ++p; token.value = TOKlcurly; return token.value;
					case '}': ++p; token.value = TOKrcurly; return token.value;
					case ':': ++p; token.value = TOKcolon; return token.value;
					case ';': ++p; token.value = TOKsemicolon; return token.value;
					case '?': ++p; token.value = TOKquestion; return token.value;
					case ',': ++p; token.value = TOKcomma; return token.value;

					case '/':
						++p;
						switch (file[p]) {
							case '=':
								token.value = TOKdivass;
								return token.value;

							case '/':
								// single-line // comment:
								++p;
								while (p < file.length) {
									if (file[p] == '\n') {
										++line;
										++p;
										break;
									}
									++p;
								}
								break;

							case '+': {
								int nest = 0;
								// nested code comment /+:
								++p;
								while (p < file.length) {
									if (file[p] == '\n') ++line;
									
									if (file[p] == '+') {
										++p;
										if (file[p] == '/') {
											++p;
											--nest;
											if (nest < 0) break;
										}
									} else if (file[p] == '/') {
										++p;
										if (file[p] == '+') {
											++p;
											++nest;
										}
									} else ++p;
								}
								break;
							}

							case '*':
								// multi-line comment /*:
								++p;
								while (p < file.length) {
									if (file[p] == '\n') ++line;
									
									if (file[p] == '*') {
										++p;
										if (file[p] == '/') {
											++p;
											break;
										}
									} else ++p;
								}
								break;

							default:
								token.value = TOKdiv;
								return token.value;
						}
						break;

					case '\'': {
						char[]	tok;
						version (interpret_slashes) {
							// Interpret the escaped characters and insert them:
							++p;
							if (file[p] == '\\') {
								tok.length = 1;
								++p;
								switch (file[p]) {
									case 'n': tok[0] = '\n'; break;
									case 'r': tok[0] = '\r'; break;
									case 'v': tok[0] = '\v'; break;
									case 't': tok[0] = '\t'; break;
									case 'f': tok[0] = '\f'; break;
									case '\'': tok[0] = '\''; break;
									case '\"': tok[0] = '\"'; break;
									case '\\': tok[0] = '\\'; break;
									default: break;
								}
								++p;
								++p;
								token.value = TOKcharv;
								token.ustring = tok;
								return token.value;
							} else {
								tok.length = 1;
								tok[0] = file[p];
								++p;
								++p;
								token.value = TOKcharv;
								token.ustring = tok;
								return token.value;
							}
						} else {
							// Just copy over the escape strings:
							++p;
							start = p;
							while (p < file.length) {
								if (file[p] == '\\') {
									++p;
								} else if (file[p] == '\'') {
									break;
								}
								++p;
							}
							token.ustring = file[start .. p];
							token.value = TOKcharv;
							++p;
							return token.value;
						}
					}

					case '\"': {
						char[]	tok;
						version (interpret_slashes) {
							// Interpret the escaped characters and insert them:
							uint	l = 0;
							tok.length = 64;
							++p;
							while (p < file.length) {
								if (file[p] == '\\') {
									++p;
									if (p >= file.length) break;
									switch (file[p]) {
										case 'n': tok[l] = '\n'; break;
										case 'r': tok[l] = '\r'; break;
										case 't': tok[l] = '\t'; break;
										case 'v': tok[l] = '\v'; break;
										case 'f': tok[l] = '\f'; break;
										case '\'': tok[l] = '\''; break;
										case '\"': tok[l] = '\"'; break;
										case '\\': tok[l] = '\\'; break;
										default:
									}
									// Grow the token length:
									if (++l >= tok.length) tok.length = tok.length * 2;
									++p;
								} else if (file[p] == '\"') {
									break;
								} else {
									tok[l] = file[p];
									// Grow the token length:
									if (++l >= tok.length) tok.length = tok.length * 2;
									++p;
								}
							}
							token.value = TOKstring;
							tok.length = l;
							token.ustring = tok;
							++p;
							return token.value;
						} else {
							// Just copy over the escape strings:
							++p;
							start = p;
							while (p < file.length) {
								if (file[p] == '\\') {
									++p;
								} else if (file[p] == '\"') {
									break;
								}
								++p;
							}
							token.value = TOKstring;
							token.ustring = file[start .. p];
							++p;
							return token.value;
						}
					}

					case 'r':
						// WYSIWYG string?
						++p;
						if (file[p] != '\"') {
							// Nope, just an identifier:
							start = p - 1;
							goto case_ident;
						}
					case '`':
						token.value = TOKstring;
						token.ustring = wysiwygString(file[p]);
						return token.value;

					case 'x':
						// HEX string?
						++p;
						if (file[p] != '\"') {
							start = p - 1;
							goto case_ident;
						}
						token.value = TOKstring;
						token.ustring = hexString();
						return token.value;

					// Identifier start with _ or a-z,A-Z:
					case 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
						 'm', 'n', 'o', 'p', 'q',      's', 't', 'u', 'v', 'w',
						 'y', 'z':
					case 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
						 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
						 'Y', 'Z', '_':
						// Set the starting point at this character:
						start = p;
					case_ident:
						// Extract the identifier:
						while (p < file.length) {
							if (isalnum(file[p]) || (file[p] == '_'))
								++p;
							else
								break;
						}
						// Checks for the identifier in the keyword list, returns null if not there:
						char[] tok = file[start .. p];
						if (tok in keywords) {
							token.value = keywords[tok];
						} else {
							token.value = TOKidentifier;
							// Check for the identifier in the list:
							if (tok in identifiers) {
								// Use that.
								token.ident = identifiers[tok];
							} else {
								// Make a new one.
								token.ident = new Identifier(tok, 0);
								identifiers[tok] = token.ident;
							}
						}
						return token.value;

					// Numeric literal:
					case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9': {
						number();
						return token.value;
					}

					default:
						++p;
				}
			}

			return 0;
		}

		// Parse a real number:
		uint	inreal() {
			printf("inreal\n");
			return TOKfloat80v;
		}

		// Parse a number and return the associated value:
		uint	number() {
			// We use a state machine to collect numbers
			enum : uint { STATE_initial, STATE_0, STATE_decimal, STATE_octal, STATE_octale,
			STATE_hex, STATE_binary, STATE_hex0, STATE_binary0,
			STATE_hexh, STATE_error };
			uint	state;

			enum : uint {
				FLAGS_decimal  = 1,		// decimal
				FLAGS_unsigned = 2,		// u or U suffix
				FLAGS_long     = 4,		// l or L suffix
			};
			uint	flags = FLAGS_decimal;

			uint 	i;
			int 	base;
			char	c;
			char[]	s;

			uint	start;
			ulong	n;

			state = STATE_initial;
			base = 0;

			s.length = 8;

			start = p;
			i = 0;
			while (p < file.length) {
				c = file[p];
				switch (state) {
					case STATE_initial:		// opening state
						if (c == '0')
							state = STATE_0;
						else
							state = STATE_decimal;
						break;

					case STATE_0:
						flags = (flags & ~FLAGS_decimal);
						switch (c) {
							case 'X':
							case 'x':
								state = STATE_hex0;
								break;
							case '.':
								if (file[p+1] == '.')	// .. is a separate token
									goto done;
							case 'i':
							case 'f':
							case 'F':
								goto realnum;
							case 'B':
							case 'b':
								state = STATE_binary0;
								break;

							case '0': case '1': case '2': case '3':
							case '4': case '5': case '6': case '7':
								state = STATE_octal;
								break;

							case '_':
								state = STATE_octal;
								++p;
								continue;

							default:
								goto done;
						}
						break;

					case STATE_decimal:		// reading decimal number
						if (!isdigit(c)) {
							if (c == '_') {	// ignore embedded _
								++p;
								continue;
							}
							if (c == '.' && file[p+1] != '.')
								goto realnum;
							else if (c == 'i' || c == 'f' || c == 'F' ||
								 c == 'e' || c == 'E') {
						realnum:	// It's a real number. Back up and rescan as a real
								p = start;
								return inreal();
							}
							goto done;
						}
						break;

					case STATE_hex0:		// reading hex number
					case STATE_hex:
						if (!isxdigit(c)) {
							if (c == '_') {	// ignore embedded _
								++p;
								continue;
							}
							if (c == '.' && file[p+1] != '.')
								goto realnum;
							if (c == 'P' || c == 'p' || c == 'i')
								goto realnum;
							if (state == STATE_hex0)
								error(format("Hex digit expected, not '%c'", c));
							goto done;
						}
						state = STATE_hex;
						break;

					case STATE_octal:		// reading octal number
					case STATE_octale:		// reading octal number with non-octal digits
						if (!isodigit(c)) {
							if (c == '_') {	// ignore embedded _
								++p;
								continue;
							}
							if (c == '.' && file[p+1] != '.')
								goto realnum;
							if (c == 'i')
								goto realnum;
							if (isdigit(c))
								state = STATE_octale;
							else
								goto done;
						}
						break;

					case STATE_binary0:		// starting binary number
					case STATE_binary:		// reading binary number
						if (c != '0' && c != '1') {
							if (c == '_') {	// ignore embedded _
								++p;
								continue;
							}
							if (state == STATE_binary0) {
								error("binary digit expected");
								state = STATE_error;
								break;
							} else
								goto done;
						}
						state = STATE_binary;
						break;

					case STATE_error:		// for error recovery
						if (!isdigit(c))	// scan until non-digit
							goto done;
						break;

					default:
						assert(0);
				}

				if (i == s.length) s.length = s.length * 2;
				s[i++] = c;
				++p;
			}

done:
			s.length = i;
			if (state == STATE_octale)
				error("Octal digit expected");

			if ((i == 1) && (state == STATE_decimal || state == STATE_0))
				n = s[0] - '0';
			else {
				// Convert string to integer
				int	q = 0;
				int r = 10, d;

				if (s[q] == '0') {
					if (s[q+1] == 'x' || s[q+1] == 'X') {
						q += 2, r = 16;
					} else if (s[q+1] == 'b' || s[q+1] == 'B') {
						q += 2, r = 2;
					} else if (isdigit(s[q+1])) {
						q += 1, r = 8;
					}
				}

				n = 0;
				while (q < s.length) {
					if (s[q] >= '0' && s[q] <= '9')
						d = s[q] - '0';
					else if (s[q] >= 'a' && s[q] <= 'z')
						d = s[q] - 'a' + 10;
					else if (s[q] >= 'A' && s[q] <= 'Z')
						d = s[q] - 'A' + 10;
					else
						break;
					if (d >= r)
						break;
					if (n * r + d < n) {
						error("integer overflow");
						break;
					}

					n = n * r + d;
					++q;
				}
			}

			// Parse trailing 'u', 'U', 'l' or 'L' in any combination
			while (p < file.length) {
				uint	f;

				switch (file[p]) {
					case 'U':
					case 'u':
						f = FLAGS_unsigned;
						goto L1;
					case 'L':
					case 'l':
						f = FLAGS_long;
				L1:
						++p;
						if (flags & f)
							error("unrecognized token");
						flags = (flags | f);
						continue;

					default:
						break;
				}
				break;
			}

			switch (flags) {
				case 0:
					if (n & 0x8000000000000000L)
						token.value = TOKuns64v;
					else if (n & 0xFFFFFFFF00000000L)
						token.value = TOKint64v;
					else if (n & 0x80000000)
						token.value = TOKuns32v;
					else
						token.value = TOKint32v;
					break;

				case FLAGS_decimal:
					if (n & 0x8000000000000000L) {
						error("signed integer overflow");
						token.value = TOKuns64v;
					}
					else if (n & 0xFFFFFFFF80000000L)
						token.value = TOKint64v;
					else
						token.value = TOKint32v;
					break;

				case FLAGS_unsigned:
				case FLAGS_decimal | FLAGS_unsigned:
					if (n & 0xFFFFFFFF00000000L)
						token.value = TOKuns64v;
					else
						token.value = TOKuns32v;
					break;

				case FLAGS_decimal | FLAGS_long:
					if (n & 0x8000000000000000L) {
						error("signed integer overflow");
						token.value = TOKuns64v;
					} else
						token.value = TOKint64v;
					break;

				case FLAGS_long:
					if (n & 0x8000000000000000L)
						token.value = TOKuns64v;
					else
						token.value = TOKint64v;
					break;

				case FLAGS_unsigned | FLAGS_long:
				case FLAGS_decimal | FLAGS_unsigned | FLAGS_long:
					token.value = TOKuns64v;
					break;

				default:
					assert(0);
			}

			token.uns64value = n;
			return token.value;
		}

		// Only peek at the next token, don't consume it:
		uint	peekToken() {
			uint	savep = p, saveline = line;
			uint	tok = nextToken();
			p = savep;
			line = saveline;

			return tok;
		}

		// Start the parsing at the beginning of the module:
		void restart() {
			p = 0;
			line = 1;
		}
}

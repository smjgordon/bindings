// dlexer - D language lexer
// (C) Copyright 2004-2005 James Dunne

// Please feel free to distribute this module in any form you like.  I only ask that you
// give credit where credit is due.  You may make modifications to this module.  If you do
// so, you may provide your modifications publicly, but you are not required to.

module	dlexer;

import	std.stream;
import	std.string;
import	std.ctype;

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

// A language token:
struct Token {
	// The identifier or value of the token:
	char[]	ident;
	// The kind of token:
	uint	token;
}

// Exception thrown during parsing of D language:
class DLexerException : Error {
	public:
		this(DLexer dlx, char[] msg) {
			// Construct an error message with the filename and line number:
			super(dlx.filename ~ "(" ~ format("%d", dlx.line) ~ ")" ~ ": " ~ msg);
		}
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

	private:
		char[]	file;		// The input file
		uint	p;			// Current character

		// TODO:
		char[]	wysiwygString() {
			return null;
		}

		// TODO:
		char[]	hexString() {
			return null;
		}

	public:
		char[]	filename;	// Filename
		uint	line;		// Current line

		// Initialize the lexer with the full source code as a string:
		this(char[] filename, char[] src) {
			file = src;
			this.filename = filename;
			line = 1;
			p = 0;
		}

		// This function consumes a full D language token and returns it in the structure Token:
		// null is returned if the end of the file is reached.
		Token*	nextToken() {
			Token*	rettok = new Token;
			uint	start;

			rettok.ident = null;
			rettok.token = TOKidentifier;

			// Past the end of file? Return a null token:
			if (p >= file.length) return null;

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
								rettok.token = TOKdotdotdot;
							} else
								rettok.token = TOKslice;
						} else
							rettok.token = TOKdot;
						return rettok;
						break;

					case '&':
						++p;
						if (file[p] == '=') {
							++p;
							rettok.token = TOKandass;
						} else if (file[p] == '&') {
							++p;
							rettok.token = TOKandand;
						} else
							rettok.token = TOKand;
						return rettok;

					case '|':
						++p;
						if (file[p] == '=') {
							++p;
							rettok.token = TOKorass;
						} else if (file[p] == '|') {
							++p;
							rettok.token = TOKoror;
						} else
							rettok.token = TOKor;
						return rettok;

					case '-':
						++p;
						if (file[p] == '=') {
							++p;
							rettok.token = TOKminass;
						} else if (file[p] == '-') {
							++p;
							rettok.token = TOKminusminus;
						} else
							rettok.token = TOKmin;
						return rettok;

					case '+':
						++p;
						if (file[p] == '=') {
							++p;
							rettok.token = TOKaddass;
						} else if (file[p] == '+') {
							++p;
							rettok.token = TOKplusplus;
						} else
							rettok.token = TOKadd;
						return rettok;

					case '=':
						++p;
						if (file[p] == '=') {
							++p;
							if (file[p] == '=') {
								++p;
								rettok.token = TOKidentity;
							} else
								rettok.token = TOKequal;
						} else
							rettok.token = TOKassign;
						return rettok;

					case '<':
						++p;
						if (file[p] == '=') {
							++p;
							rettok.token = TOKle;			// <=
						} else if (file[p] == '<') {
							++p;
							if (file[p] == '=') {
								++p;
								rettok.token = TOKshlass;		// <<=
							} else
								rettok.token = TOKshl;		// <<
						} else if (file[p] == '>') {
							++p;
							if (file[p] == '=') {
								++p;
								rettok.token = TOKleg;		// <>=
							} else
								rettok.token = TOKlg;		// <>
						} else
							rettok.token = TOKlt;			// <
						return rettok;

					case '>':
						++p;
						if (file[p] == '=') {
							++p;
							rettok.token = TOKge;			// >=
						} else if (file[p] == '>') {
							++p;
							if (file[p] == '=') {
								++p;
								rettok.token = TOKshrass;		// >>=
							} else if (file[p] == '>') {
								++p;
								if (file[p] == '=') {
									++p;
									rettok.token = TOKushrass;	// >>>=
								} else
									rettok.token = TOKushr;		// >>>
							} else
								rettok.token = TOKshr;		// >>
						} else
							rettok.token = TOKgt;			// >
						return rettok;

					case '!':
						++p;
						if (file[p] == '=') {
							++p;
							if (file[p] == '=') {
								++p;
								rettok.token = TOKnotidentity;	// !==
							} else
								rettok.token = TOKnotequal;		// !=
						} else if (file[p] == '<') {
							++p;
							if (file[p] == '>') {
								++p;
								if (file[p] == '=') {
									++p;
									rettok.token = TOKunord; // !<>=
								} else
									rettok.token = TOKue;	// !<>
							} else if (file[p] == '=') {
								++p;
								rettok.token = TOKug;	// !<=
							} else
								rettok.token = TOKuge;	// !<
						} else if (file[p] == '>') {
							++p;
							if (file[p] == '=') {
								++p;
								rettok.token = TOKul;	// !>=
							} else
								rettok.token = TOKule;	// !>
						} else
							rettok.token = TOKnot;		// !
						return rettok;

					case '*':
						++p;
						if (file[p] == '=') {
							++p;
							rettok.token = TOKmulass;
						} else
							rettok.token = TOKmul;
						return rettok;
					case '%':
						++p;
						if (file[p] == '=') {
							++p;
							rettok.token = TOKmodass;
						} else
							rettok.token = TOKmod;
						return rettok;
					case '^':
						++p;
						if (file[p] == '=') {
							++p;
							rettok.token = TOKxorass;
						} else
							rettok.token = TOKxor;
						return rettok;
					case '~':
						++p;
						if (file[p] == '=') {
							++p;
							rettok.token = TOKcatass;
						} else
							rettok.token = TOKtilde;
						return rettok;

					case '(': ++p; rettok.token = TOKlparen; return rettok;
					case ')': ++p; rettok.token = TOKrparen; return rettok;
					case '[':
						++p;
						if (file[p] == ']') {
							++p;
							rettok.token = TOKarray;
						} else
							rettok.token = TOKlbracket;
						return rettok;
					case ']': ++p; rettok.token = TOKrbracket; return rettok;
					case '{': ++p; rettok.token = TOKlcurly; return rettok;
					case '}': ++p; rettok.token = TOKrcurly; return rettok;
					case ':': ++p; rettok.token = TOKcolon; return rettok;
					case ';': ++p; rettok.token = TOKsemicolon; return rettok;
					case '?': ++p; rettok.token = TOKquestion; return rettok;
					case ',': ++p; rettok.token = TOKcomma; return rettok;

					case '/':
						++p;
						switch (file[p]) {
							case '=':
								rettok.token = TOKdivass;
								return rettok;

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
								rettok.token = TOKdiv;
								return rettok;
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
								rettok.token = TOKcharv;
								rettok.ident = tok;
								return rettok;
							} else {
								tok.length = 1;
								tok[0] = file[p];
								++p;
								++p;
								rettok.token = TOKcharv;
								rettok.ident = tok;
								return rettok;
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
							rettok.ident = file[start .. p];
							rettok.token = TOKcharv;
							++p;
							return rettok;
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
							rettok.token = TOKstring;
							tok.length = l;
							rettok.ident = tok;
							++p;
							return rettok;
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
							rettok.token = TOKstring;
							rettok.ident = file[start .. p];
							++p;
							return rettok;
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
						rettok.token = TOKstring;
						rettok.ident = wysiwygString();
						return rettok;

					case 'h':
						// HEX string?
						++p;
						if (file[p] != '\"') {
							start = p - 1;
							goto case_ident;
						}
						rettok.token = TOKstring;
						rettok.ident = hexString();
						return rettok;

					// Identifier start with _ or a-z,A-Z:
					case 'a', 'b', 'c', 'd', 'e', 'f', 'g',      'i', 'j', 'k', 'l',
						 'm', 'n', 'o', 'p', 'q',      's', 't', 'u', 'v', 'w', 'x',
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
							rettok.token = keywords[tok];
						} else {
							rettok.token = TOKidentifier;
							rettok.ident = file[start .. p];
						}
						return rettok;

					// Numeric literal:
					case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
						// FIXME!!
						// TODO: Handle binary, hex, octal, decimal, float, etc.
						start = p;
						while (p < file.length) {
							if (!isalnum(file[p])) break;
							++p;
						}

						// Default to an int32v token for any number:
						rettok.token = TOKint32v;
						rettok.ident = file[start .. p];
						return rettok;

					default:
						++p;
				}
			}

			return null;
		}

		// Only peek at the next token, don't consume it:
		Token*	peekToken() {
			uint	savep = p, saveline = line;
			Token*	tok = nextToken();
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

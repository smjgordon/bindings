// dtags - D module parser
// (C) Copyright 2004-2005 James Dunne

// Please feel free to distribute this module in any form you like.  I only ask that you
// give credit where credit is due.  You may make modifications to this module.  If you do
// so, you may provide your modifications publicly, but you are not required to.

// TODO list:
// - correct parsing of type declarations in identifiers and functions
// - interface parsing
// - version {} blocks
// - correct extern (type) { } blocks, "extern (type):" and "extern (type) decl" work.
// - complete access modifiers on functions

module	dtags;

import	std.stream;
import	std.string;
import	std.ctype;

import	dlexer;

// public, private, etc. access:
enum accessRights : int {
	arUndefined = -1,
	arPublic,
	arPackage,
	arProtected,
	arPrivate
};

// const, final, auto, etc. modifiers:
enum accessModifier : uint {
	amConst		= 0x0001,	// unused
	amStatic	= 0x0002,	// unused
	amFinal		= 0x0004,	// unused
	amAuto		= 0x0008,	// unused
	amIn		= 0x0010,
	amOut		= 0x0020,
	amInOut		= 0x0030,
};

// A module import:
struct DImport {
	char[]			name;
	accessRights	access;		// mainly for public and private qualifiers
};

// A variable:
struct DVar {
	char[]		name;
	Token*[]	type;

	accessRights	access;
	accessModifier	modifier;	// mainly for in, out, and inout
};

// An enumeration:
struct DEnum {
	char[]		name;
	uint		type;			// type of values in enumeration (TOKint32, TOKuns32, ...)

	struct enumValue {
		char[]	name;
		union {
			int		int32value;
			uint	uns32value;
			long	int64value;
			ulong	uns64value;
		};
	};
	enumValue[]	values;
};

// A structure:
struct DStruct {
	char[]		name;

	DVar*[]		vars;
	DFunc*[]	funcs;
	DStruct*[]	structs, unions;
};

// A function:
struct DFunc {
	char[]		name;
	Token*[]	type;
	char[]		linkage;

	DVar*[]		parms, vars;
	DStruct*[]	structs, unions;
	DEnum*[]	enums;
	DFunc*[]	funcs;

	accessRights	access;
	accessModifier	modifier;
};

// An interface:
struct DInterface {
	char[]			name;
	accessRights	access;
	accessModifier	modifier;

	// Inherited interfaces:
	char[][]	iinterfaces;

	DFunc*[]	funcs;
};

// A class:
struct DClass {
	char[]			name;
	accessRights	access;
	accessModifier	modifier;

	// Inherited interfaces (and classes), can't distinguish between a class or interface here:
	char[][]	iinterfaces;

	DStruct*[]	structs, unions;
	DEnum*[]	enums;
	DFunc*[]	funcs, ctors, dtors;
	DVar*[]		vars;
};

// A module:
struct DModule {
	char[]	name;

	DImport*[]	imports;
	DClass*[]	classes, interfaces;
	DStruct*[]	structs, unions;
	DEnum*[]	enums;
	DFunc*[]	funcs;
	DVar*[]		vars;
};

class DTags : DLexer {
	private:
		accessRights	arDefault, arCurrent;
		char[]			lnkCurrent, lnkDefault;

	public:
		// The publicly available module tag structure:
		DModule*	dmodule;

		// Load up the module source code:
		this(char[] filename, char[] src) {
			// Load up the source for the lexer:
			super(filename, src);

			// Create a default module structure:
			dmodule = new DModule;
			dmodule.name = filename;

			// Set the default access rights for newly created identifiers:
			arDefault = accessRights.arPublic;
			arCurrent = accessRights.arUndefined;
			lnkDefault = "D";
			lnkCurrent = null;
		}

	private:
		// Expect a token and throw an exception if not found:
		Token*	expect(uint value, char[] msg) {
			Token*	ntok = nextToken();
			if (ntok.token != value)
			if (ntok.token != value)
				throw new DLexerException(this, "expected " ~ msg);
			return ntok;
		}

		// Expect a token and throw an exception if not found:
		Token*	expectToken(Token *tok, uint value, char[] msg) {
			if (tok.token != value)
				throw new DLexerException(this, "expected " ~ msg);
			return tok;
		}

		// Is this token a basic type?
		bool isType(uint value) {
			switch (value) {
				case TOKvoid:
				case TOKint8, TOKuns8:
				case TOKint16, TOKuns16:
				case TOKint32, TOKuns32:
				case TOKint64, TOKuns64:
				case TOKfloat32, TOKfloat64, TOKfloat80:
				case TOKimaginary32, TOKimaginary64, TOKimaginary80:
				case TOKcomplex32, TOKcomplex64, TOKcomplex80:
				case TOKchar, TOKwchar, TOKdchar, TOKbit:
					return true;
				default:
					return false;
			}
			return false;
		}

		// Get the current or default access right:
		accessRights	getAccess() {
			accessRights	ar = accessRights.arUndefined;
			if (arCurrent != accessRights.arUndefined) {
				ar = arCurrent;
				// Invalidate the current access right:
				arCurrent = accessRights.arUndefined;
			} else {
				// Use the default if no current access specified:
				ar = arDefault;
			}
			return ar;
		}
		
		// Get the current or default function linkage:
		char[]	getLinkage() {
			char[]	linkage = "D";
			if (lnkCurrent is null) {
				linkage = lnkDefault;
			} else {
				linkage = lnkCurrent;
				lnkCurrent = null;
			}
			return linkage;
		}

		// Skip over a set of nested tokens:
		void skipNest(uint l, uint r) {
			int	nest = 0;
			for (;;) {
				Token*	tok = nextToken();
				if (tok is null) break;
				if (tok.token == l) ++nest;
				if (tok.token == r) {
					--nest;
					if (nest < 0) break;
				}
			}
		}

		// Read a parameter list:
		void readParameters(inout DVar*[] parms) {
			Token*			tok;
			accessModifier	nextam;

			nextam = accessModifier.amIn;

			for (;;) {
				tok = nextToken();
				if (tok.token == TOKrparen) break;
				if (tok.token == TOKcomma) continue;

				switch (tok.token) {
					case TOKin:		nextam = accessModifier.amIn; break;
					case TOKout:	nextam = accessModifier.amOut; break;
					case TOKinout:	nextam = accessModifier.amInOut; break;

					// Check for an identifier or a reserved type:
					case TOKvoid:
					case TOKint8, TOKuns8:
					case TOKint16, TOKuns16:
					case TOKint32, TOKuns32:
					case TOKint64, TOKuns64:
					case TOKfloat32, TOKfloat64, TOKfloat80:
					case TOKimaginary32, TOKimaginary64, TOKimaginary80:
					case TOKcomplex32, TOKcomplex64, TOKcomplex80:
					case TOKchar, TOKwchar, TOKdchar, TOKbit:
					case TOKidentifier: {
						Token*	ntok;
						DVar*	var;
						char[]	ident;
						Token*[]	type;

						// Construct the type of the identifier:
						type.length = 1;
						type[0] = tok;
						while ((ntok = nextToken()).token != TOKidentifier) {
							type.length = type.length + 1;
							type[length - 1] = ntok;
						}

						// Read the identifier:
						expectToken(ntok, TOKidentifier, "identifier after type");
						ident = ntok.ident;

						// Add the parameter:
						var = new DVar;
						var.name = ident;
						var.type = type;
						var.modifier = nextam;

						parms.length = parms.length + 1;
						parms[length - 1] = var;

						nextam = accessModifier.amIn;
						break;
					}

					default:
				}
			}
		}

		// Parse an import line:
		// Starts after import token.
		DImport* parseImport() {
			DImport*	imp;
			char[]		ident;
			Token*		ntok;

			// Get the import identifier:
			while ((ntok = nextToken()).token != TOKsemicolon) {
				if (ntok.token == TOKidentifier)
					ident ~= ntok.ident;
				else if (ntok.token == TOKdot)
					ident ~= ".";
			}

			imp = new DImport;
			imp.name = ident;
			imp.access = getAccess();
			return imp;
		}

		// Parse a class definition:
		// Starts after class token.
		DClass*	parseClass() {
			DClass*		cls;
			char[]		ident;
			Token*		ntok;
			int			nest;

			// Create the DClass structure:
			cls = new DClass;
			// Grab the class identifier:
			cls.name = expect(TOKidentifier, "identifier after class").ident;
			arDefault = accessRights.arPrivate;

			// Check for an interface list:
			ntok = nextToken();
			if (ntok.token == TOKcolon) {
				for (;;) {
					ntok = expect(TOKidentifier, "identifier");

					// Add a new interface:
					cls.iinterfaces.length = cls.iinterfaces.length + 1;
					cls.iinterfaces[length - 1] = ntok.ident;

					ntok = nextToken();
					// A left-curly? Break.
					if (ntok.token == TOKlcurly) break;
					// Make sure it's a comma:
					expectToken(ntok, TOKcomma, "',' or '{' after interface");
				}
			}

			// Make sure we're at a left-curly-brace '{':
			expectToken(ntok, TOKlcurly, "'{' after interface list or class identifier");

			nest = 0;
			for (;;) {
				ntok = nextToken();

				// Nested curly braces:
				if (ntok.token == TOKlcurly) { ++nest; continue; }
				if (ntok.token == TOKrcurly) {
					--nest;
					if (nest < 0) break;
					continue;
				}

				// Peek at the next token to see if it's a colon only if we're in the immediate class scope:
				if ((nest == 0) && (peekToken().token == TOKcolon)) {
					// If so, then the current token should be an access
					// modifier.
					if (ntok.token == TOKprivate)
						arDefault = accessRights.arPrivate;
					else if (ntok.token == TOKprotected)
						arDefault = accessRights.arProtected;
					else if (ntok.token == TOKpublic)
						arDefault = accessRights.arPublic;
					else if (ntok.token == TOKpackage)
						arDefault = accessRights.arPackage;
					else
						throw new DLexerException(this, "Invalid access right modifier");
				} else {
					// Check the token:
					switch (ntok.token) {
						// Set the next used access right:
						case TOKprivate:	arCurrent = accessRights.arPrivate; break;
						case TOKprotected:	arCurrent = accessRights.arProtected; break;
						case TOKpublic:		arCurrent = accessRights.arPublic; break;
						case TOKpackage:	arCurrent = accessRights.arPackage; break;
						
						case TOKextern:
							// TODO:  Correct implementation
							printf("extern\n");
							nextToken();
							nextToken();
							nextToken();
							break;
						
						case TOKversion:
							// TODO:  Correct implementation
							break;

						// Start of a variable or function definition:
						case TOKvoid:
						case TOKint8, TOKuns8:
						case TOKint16, TOKuns16:
						case TOKint32, TOKuns32:
						case TOKint64, TOKuns64:
						case TOKfloat32, TOKfloat64, TOKfloat80:
						case TOKimaginary32, TOKimaginary64, TOKimaginary80:
						case TOKcomplex32, TOKcomplex64, TOKcomplex80:
						case TOKchar, TOKwchar, TOKdchar, TOKbit:
						case TOKidentifier: {
							Token*	tok;
							char[]	ident;
							Token*[]	type;
							accessRights	curar;

							// Construct the type of the identifier:
							type.length = 1;
							type[0] = ntok;
							for (;;) {
								tok = nextToken();
								if (tok.token == TOKidentifier) break;
								if (tok.token == TOKlparen) break;
								type.length = type.length + 1;
								type[length - 1] = tok;
							}

							if (tok.token == TOKlparen) {
								expect(TOKmul, "'*'");
								ident = expect(TOKidentifier, "identifier").ident;
								expect(TOKrparen, "')'");
							} else if (tok.token == TOKidentifier) {
								// Read the identifier:
								ident = tok.ident;
							}

							// Get the access rights for this identifier:
							curar = getAccess();

							tok = nextToken();
							if (tok.token == TOKlparen) {
								// It's a function:
								DFunc*	func = new DFunc;
								func.name = ident;
								func.type = type.dup;
								func.linkage = getLinkage();
								func.access = curar;

								// Add function to class:
								cls.funcs.length = cls.funcs.length + 1;
								cls.funcs[length - 1] = func;

								// Read the parameter list:
								readParameters(func.parms);

								// Skip the function definition:
								tok = nextToken();
								if (tok.token == TOKsemicolon) break;

								expectToken(tok, TOKlcurly, "'{'");
								skipNest(TOKlcurly, TOKrcurly);

							} else {
								// It's a variable or list thereof:

								for (;;) {
									DVar*	var = new DVar;
									var.name = ident;
									var.type = type.dup;
									var.access = curar;

									// Add variable to class:
									cls.vars.length = cls.vars.length + 1;
									cls.vars[length - 1] = var;

									// semicolon breaks the list:
									if (tok.token == TOKsemicolon) break;
									expectToken(tok, TOKcomma, "','");

									tok = nextToken();
									expectToken(tok, TOKidentifier, "identifier");
									ident = tok.ident;

									// Get next comma or semicolon:
									tok = nextToken();
								}

							}
							break;
						}

						case TOKthis: {
							DFunc*	func = new DFunc;
							Token*	ntok;

							func.access = getAccess();
							func.linkage = getLinkage();

							// Add the constructor:
							cls.ctors.length = cls.ctors.length + 1;
							cls.ctors[length - 1] = func;

							expect(TOKlparen, "'('");
							readParameters(func.parms);

							ntok = nextToken();
							if (ntok.token == TOKsemicolon) break;

							expectToken(ntok, TOKlcurly, "'{'");
							skipNest(TOKlcurly, TOKrcurly);
							break;
						}

						// Must be a destructor here:
						case TOKtilde: {
							expect(TOKthis, "'this' after '~'");

							DFunc*	func = new DFunc;
							Token*	ntok;

							// Add the destructor:
							cls.dtors.length = cls.dtors.length + 1;
							cls.dtors[length - 1] = func;

							func.linkage = getLinkage();

							expect(TOKlparen, "'('");
							readParameters(func.parms);

							ntok = nextToken();
							if (ntok.token == TOKsemicolon) break;

							expectToken(ntok, TOKlcurly, "'{'");
							skipNest(TOKlcurly, TOKrcurly);
						}

						default:
							
					}
				}
			}

			return cls;
		}

		// Parse a struct or union (same format):
		// Start after struct/union token.
		DStruct*	parseStruct() {
			Token*		tok;
			DStruct*	st = new DStruct;

			tok = nextToken();
			// Anonymous structs/unions allowed:
			st.name = null;
			if (tok.token == TOKidentifier) {
				st.name = tok.ident;
				tok = nextToken();
			}

			// We should be at a curly:
			expectToken(tok, TOKlcurly, "'{'");
			// Read in all the functions, variables, structs, and unions:
			for (;;) {
				tok = nextToken();
				if (tok.token == TOKrcurly) break;
				// Parse a module:
				switch (tok.token) {
					// Start of a variable or function definition:
					case TOKvoid:
					case TOKint8, TOKuns8:
					case TOKint16, TOKuns16:
					case TOKint32, TOKuns32:
					case TOKint64, TOKuns64:
					case TOKfloat32, TOKfloat64, TOKfloat80:
					case TOKimaginary32, TOKimaginary64, TOKimaginary80:
					case TOKcomplex32, TOKcomplex64, TOKcomplex80:
					case TOKchar, TOKwchar, TOKdchar, TOKbit:
					case TOKidentifier: {
						Token*	ntok;
						char[]	ident;
						Token*[]	type;

						// Construct the type of the identifier:
						type.length = 1;
						type[0] = tok;
						while ((ntok = nextToken()).token != TOKidentifier) {
							type.length = type.length + 1;
							type[length - 1] = ntok;
						}

						// Read the identifier:
						expectToken(ntok, TOKidentifier, "identifier after type");
						ident = ntok.ident;

						ntok = nextToken();
						if (ntok.token == TOKlparen) {
							// It's a function:
							DFunc*	func = new DFunc;
							func.name = ident;
							func.type = type.dup;
							func.linkage = getLinkage();
							func.access = accessRights.arPublic;

							// Add function to class:
							st.funcs.length = st.funcs.length + 1;
							st.funcs[length - 1] = func;

							// Read the parameter list:
							readParameters(func.parms);

							// Skip the function definition:
							ntok = nextToken();
							if (ntok.token == TOKsemicolon) break;

							expectToken(ntok, TOKlcurly, "'{'");
							skipNest(TOKlcurly, TOKrcurly);

						} else {
							// It's a variable or list thereof:

							for (;;) {
								DVar*	var = new DVar;
								var.name = ident;
								var.type = type.dup;
								var.access = accessRights.arPublic;

								// Add variable to class:
								st.vars.length = st.vars.length + 1;
								st.vars[length - 1] = var;

								// semicolon breaks the list:
								if (ntok.token == TOKsemicolon) break;
								expectToken(ntok, TOKcomma, "','");

								ntok = nextToken();
								expectToken(ntok, TOKidentifier, "identifier");
								ident = ntok.ident;

								// Get next comma or semicolon:
								ntok = nextToken();
							}

						}
						break;
					}

					case TOKstruct: {
						DStruct*	st2 = parseStruct();

						st.structs.length = st.structs.length + 1;
						st.structs[length - 1] = st2;
						break;
					}
					case TOKunion: {
						DStruct*	st2 = parseStruct();

						st.unions.length = st.unions.length + 1;
						st.unions[length - 1] = st2;
						break;
					}

					default:
				}
			}
			
			return st;
		}

		// Parse an enumeration:
		// Start after struct token.
		DEnum*	parseEnum() {
			Token*		tok;
			DEnum*		en = new DEnum;
			int			i;
			bool		negative;
			// Keep track of the enumeration value:
			union integraltype {
				int		int32value;
				uint	uns32value;
				long	int64value;
				ulong	uns64value;
			};
			integraltype	m;

			tok = nextToken();
			// Anonymous enums allowed:
			en.name = null;
			if (tok.token == TOKidentifier) {
				// enum identifier
				en.name = tok.ident;
				tok = nextToken();
				if (tok.token == TOKcolon) {
					// enum identifier : type
					tok = nextToken();
					if (isType(tok.token)) {
						en.type = tok.token;
					} else throw new DLexerException(this, "expected type after ':'");
					tok = nextToken();
				}
			} else if (tok.token == TOKcolon) {
				tok = nextToken();
				if (isType(tok.token)) {
					// enum : type
					en.type = tok.token;
					tok = nextToken();
				} else throw new DLexerException(this, "expected type after ':'");
			}

			// We should be at a curly:
			expectToken(tok, TOKlcurly, "'{'");

			i = 0;
			en.values.length = 8;
			for (;;) {
				tok = nextToken();
				if (tok.token == TOKrcurly) break;

				// Need an identifier:
				expectToken(tok, TOKidentifier, "identifier");

				DEnum.enumValue	ev;
				ev.name = tok.ident;

				// An assignment or comma
				tok = nextToken();
				if (tok.token == TOKassign) {
					negative = false;

					for (;;) {
						tok = nextToken();
						if ((tok.token == TOKcomma) || (tok.token == TOKrcurly)) break;

						if (tok.token == TOKmin) {
							// Negative number:
							negative = true;
						} else {
							// Specified enumeration value:
							switch (en.type) {
								case TOKint8, TOKint16, TOKint32:
									m.int32value = (ev.int32value = tok.int32value) + 1;
									break;
								case TOKuns8, TOKuns16, TOKuns32:
									m.uns32value = (ev.uns32value = tok.uns32value) + 1;
									break;
								case TOKint64:
									m.int64value = (ev.int64value = tok.int64value) + 1;
									break;
								case TOKuns64:
									m.uns64value = (ev.uns64value = tok.uns64value) + 1;
									break;
							}
						}
					}
					// Set negative?
					if (negative) {
						switch (en.type) {
							case TOKint8, TOKint16, TOKint32:
								m.int32value = (ev.int32value = -ev.int32value) + 1;
								break;
							case TOKint64:
								m.int64value = (ev.int64value = -ev.int64value) + 1;
								break;
						}
					}
				} else {
					// Not given a value, make it default 1 + the last value:
					switch (en.type) {
						case TOKint8, TOKint16, TOKint32:
							m.int32value = (ev.int32value = m.int32value) + 1;
							break;
						case TOKuns8, TOKuns16, TOKuns32:
							m.uns32value = (ev.uns32value = m.uns32value) + 1;
							break;
						case TOKint64:
							m.int64value = (ev.int64value = m.int64value) + 1;
							break;
						case TOKuns64:
							m.uns64value = (ev.uns64value = m.uns64value) + 1;
							break;
					}
				}

				if (i == en.values.length) en.values.length = en.values.length * 2;
				en.values[i] = ev;
				++i;

				if (tok.token == TOKrcurly) break;
				expectToken(tok, TOKcomma, "','");
			}
			en.values.length = i;

			return en;
		}

	public:
		// Parse the module:
		void go() {
			int		indent = 0;

			restart();
			for (;;) {
				Token*	tok, ntok;

				// Grab the next token from the file, a null token is the end of the file:
				tok = nextToken();
				if (tok is null) break;

				debug {
					// This dumps out the various tokens (basically reformats the source):
					if (tok.token == TOKidentifier)
						printf(`%.*s `, tok.ident);
					else if (tok.token == TOKcharv)
						printf(`'%.*s' `, tok.ident);
					else if (tok.token == TOKstring)
						printf(`"%.*s" `, tok.ident);
					// Numbers:
					else if (tok.token == TOKint32v)
						printf(`%ld `, tok.int32value);
					else if (tok.token == TOKuns32v)
						printf(`%ud `, tok.uns32value);
					else if (tok.token == TOKint64v)
						printf(`%ld `, tok.int64value);
					else if (tok.token == TOKuns64v)
						printf(`%lud `, tok.uns64value);
					// Just a regular token:
					else
						printf(`%.*s `, toktostr[tok.token]);

					ntok = peekToken();

					// Indentation:
					if (!(ntok is null))
						if (ntok.token == TOKrcurly)
							--indent;

					if (tok.token == TOKlcurly) {
						++indent;
						printf("\n");
						for (int i = 0; i < indent; ++i) printf("\t");
					} else if ((tok.token == TOKsemicolon) || (tok.token == TOKrcurly)) {
						printf("\n");
						for (int i = 0; i < indent; ++i) printf("\t");
					}

				} else {

					// Parse a module:
					switch (tok.token) {
						case TOKextern: {
							// TODO:  Correct implementation
							printf("extern\n");
							expect(TOKlparen, "'('");
							char[]	linkage = expect(TOKidentifier, "identifier").ident;
							expect(TOKrparen, "')'");
							if (peekToken().token == TOKcolon) {
								lnkDefault = linkage;
							} else if (peekToken().token == TOKlcurly) {
								
							} else {
								lnkCurrent = linkage;
							}
							break;
						}

						// Start of a variable or function definition:
						case TOKvoid:
						case TOKint8, TOKuns8:
						case TOKint16, TOKuns16:
						case TOKint32, TOKuns32:
						case TOKint64, TOKuns64:
						case TOKfloat32, TOKfloat64, TOKfloat80:
						case TOKimaginary32, TOKimaginary64, TOKimaginary80:
						case TOKcomplex32, TOKcomplex64, TOKcomplex80:
						case TOKchar, TOKwchar, TOKdchar, TOKbit:
						case TOKidentifier: {
							Token*	ntok;
							char[]	ident;
							Token*[]	type;
							accessRights	curar;

							// Construct the type of the identifier:
							type.length = 1;
							type[0] = tok;
							while ((ntok = nextToken()).token != TOKidentifier) {
								type.length = type.length + 1;
								type[length - 1] = ntok;
							}

							// Read the identifier:
							expectToken(ntok, TOKidentifier, "identifier after type");
							ident = ntok.ident;

							// Get the access rights for this identifier:
							curar = getAccess();

							ntok = nextToken();
							if (ntok.token == TOKlparen) {
								// It's a function:
								DFunc*	func = new DFunc;
								func.name = ident;
								func.type = type.dup;
								func.linkage = getLinkage();
								func.access = curar;

								// Add function to class:
								dmodule.funcs.length = dmodule.funcs.length + 1;
								dmodule.funcs[length - 1] = func;

								// Read the parameter list:
								readParameters(func.parms);

								// Skip the function definition:
								ntok = nextToken();
								if (ntok.token == TOKsemicolon) break;

								expectToken(ntok, TOKlcurly, "'{'");
								skipNest(TOKlcurly, TOKrcurly);

							} else {
								// It's a variable or list thereof:

								for (;;) {
									DVar*	var = new DVar;
									var.name = ident;
									var.type = type.dup;
									var.access = curar;

									// Add variable to class:
									dmodule.vars.length = dmodule.vars.length + 1;
									dmodule.vars[length - 1] = var;

									// semicolon breaks the list:
									if (ntok.token == TOKsemicolon) break;
									if (ntok.token == TOKassign) {
										for (;;) {
											ntok = nextToken();
											if (ntok.token == TOKlbracket)
												skipNest(TOKlbracket, TOKrbracket);
											if (ntok.token == TOKlcurly)
												skipNest(TOKlcurly, TOKrcurly);
											if (ntok.token == TOKcomma) break;
											if (ntok.token == TOKsemicolon) break;
										}
										if (ntok.token == TOKsemicolon) break;
									} else if (ntok.token != TOKcomma) {
										// Must be more type:
										for (;;) {
											ntok = nextToken();
											// TODO:  Handle adding type info.
											if (ntok.token == TOKassign) break;
											if (ntok.token == TOKcomma) break;
											if (ntok.token == TOKsemicolon) break;
										}
										if (ntok.token == TOKsemicolon) break;
										if (ntok.token == TOKassign) {
											for (;;) {
												ntok = nextToken();
												if (ntok.token == TOKlbracket)
													skipNest(TOKlbracket, TOKrbracket);
												if (ntok.token == TOKlcurly)
													skipNest(TOKlcurly, TOKrcurly);
												if (ntok.token == TOKcomma) break;
												if (ntok.token == TOKsemicolon) break;
											}
											if (ntok.token == TOKsemicolon) break;
										}
									}
									expectToken(ntok, TOKcomma, "','");

									ntok = nextToken();
									expectToken(ntok, TOKidentifier, "identifier");
									ident = ntok.ident;

									// Get next comma or semicolon:
									ntok = nextToken();
								}

							}
							break;
						}

						case TOKclass: {
							DClass*		cls = parseClass();

							// Add the class to the module:
							dmodule.classes.length = dmodule.classes.length + 1;
							dmodule.classes[length - 1] = cls;
							
							arDefault = accessRights.arPublic;
							break;
						}
						case TOKimport: {
							DImport*	imp = parseImport();

							// Add the import to the module:
							dmodule.imports.length = dmodule.imports.length + 1;
							dmodule.imports[length - 1] = imp;
							break;
						}
						case TOKmodule: {
							char[]	mod;

							// Get the module's identifier:
							while ((ntok = nextToken()).token != TOKsemicolon) {
								if (ntok.token == TOKidentifier)
									mod ~= ntok.ident;
								else if (ntok.token == TOKdot)
									mod ~= ".";
							}

							dmodule.name = mod;
							arDefault = accessRights.arPublic;
							break;
						}

						case TOKstruct: {
							DStruct*	st = parseStruct();

							dmodule.structs.length = dmodule.structs.length + 1;
							dmodule.structs[length - 1] = st;
							break;
						}
						case TOKunion: {
							DStruct*	st = parseStruct();

							dmodule.unions.length = dmodule.unions.length + 1;
							dmodule.unions[length - 1] = st;
							break;
						}
						case TOKenum: {
							DEnum*		st = parseEnum();

							dmodule.enums.length = dmodule.enums.length + 1;
							dmodule.enums[length - 1] = st;
							break;
						}
						
						case TOKalias: {
							while (nextToken().token != TOKsemicolon) { }
							break;
						}

						default:
					}
				}
			}
			return;
		}
}


// Return a string representation of the type:
char[] typeString(Token*[] type) {
	char[]	s;
	foreach (Token* tok; type) {
		if (tok.token == TOKidentifier)
			s ~= tok.ident;
		else
			s ~= toktostr[tok.token];
	}
	return s;
}

// Return a comma-separated list of parameters:
char[] parmlist(DVar*[] parms) {
	char[]	s;
	foreach (int i, DVar* parm; parms) {
		if (i > 0) s ~= ", ";
		if ((parm.modifier & accessModifier.amInOut) == accessModifier.amOut)
			s ~= "out ";
		else if ((parm.modifier & accessModifier.amInOut) == accessModifier.amInOut)
			s ~= "inout ";
		s ~= typeString(parm.type) ~ " " ~ parm.name;
	}
	return s;
}

void dumpStruct(DStruct *st, int indent, bool isunion) {
	char[]	indstr;
	for (int i = 0; i < indent; ++i) indstr ~= "\t";

	printf("%.*s", indstr);

	if (isunion)
		printf("union ");
	else
		printf("struct ");

	if (st.name is null)
		printf("{\n");
	else
		printf("%.*s {\n", st.name);

	foreach (DStruct* st2; st.structs) {
		dumpStruct(st2, indent+1, false);
	}

	foreach (DStruct* st2; st.unions) {
		dumpStruct(st2, indent+1, true);
	}

	foreach (DVar* var; st.vars) {
		printf("%.*s\t", indstr);
		printf("%.*s\t%.*s;\n", typeString(var.type), var.name);
	}

	foreach (DFunc* func; st.funcs) {
		printf("%.*s\t", indstr);
		switch (func.access) {
			case accessRights.arPublic: printf("public "); break;
			case accessRights.arPrivate: printf("private "); break;
			case accessRights.arProtected: printf("protected "); break;
			case accessRights.arPackage: printf("package "); break;
		}
		if (func.linkage != "D")
			printf("extern (%.*s) ", func.linkage);
		printf("%.*s\t%.*s(%.*s);\n", typeString(func.type), func.name, parmlist(func.parms));
	}

	printf("%.*s", indstr);
	printf("}\n\n");
}

// Simple main program:
int main(char[][] args) {
	DTags	lex;
	File	dfile;

	if (args.length <= 1) {
		printf("%.*s <file.d>\n", args[0]);
		return -1;
	}

	// Open the file:
	dfile = new File(args[1]);
	// Send in the buffer to the lexer:
	char[]	str = dfile.readString(dfile.size());

	lex = new DTags(args[1], str);
	// Close the file now:
	dfile.close();

	// Let the lexer loose:
	lex.go();

	// Report the results:

	printf("module %.*s {\n", lex.dmodule.name);

	printf("\tpublic  imports ");
	foreach (int i, DImport* im; lex.dmodule.imports) {
		if (im.access == accessRights.arPublic) {
			if (i > 0) printf(", ");
			printf("%.*s", im.name);
		}
	}
	printf(";\n");

	printf("\tprivate imports ");
	foreach (int i, DImport* im; lex.dmodule.imports) {
		if (im.access == accessRights.arPrivate) {
			if (i > 0) printf(", ");
			printf("%.*s", im.name);
		}
	}
	printf(";\n\n");

	// Enums:
	foreach (DEnum* en; lex.dmodule.enums) {
		printf("\tenum %.*s {\n", en.name);
		switch (en.type) {
			case TOKint8, TOKint16, TOKint32:
				foreach (DEnum.enumValue ev; en.values) {
					printf("\t\t%.*s = %d,\n", ev.name, ev.int32value);
				}
				break;
			case TOKuns8, TOKuns16, TOKuns32:
				foreach (DEnum.enumValue ev; en.values) {
					printf("\t\t%.*s = %u,\n", ev.name, ev.uns32value);
				}
				break;
			case TOKint64:
				foreach (DEnum.enumValue ev; en.values) {
					printf("\t\t%.*s = %ld,\n", ev.name, ev.int64value);
				}
				break;
			case TOKuns64:
				foreach (DEnum.enumValue ev; en.values) {
					printf("\t\t%.*s = %lu,\n", ev.name, ev.uns64value);
				}
				break;
		}
		printf("\t}\n\n");
	}

	// Structs:
	foreach (DStruct* st; lex.dmodule.structs) {
		dumpStruct(st, 1, false);
	}

	// Unions:
	foreach (DStruct* st; lex.dmodule.unions) {
		dumpStruct(st, 1, true);
	}

	// Variables:
	foreach (DVar* vr; lex.dmodule.vars) {
		printf("\t%.*s\t%.*s;\n", typeString(vr.type), vr.name);
	}
	if (lex.dmodule.vars.length > 0) printf("\n");

	// Classes:
	foreach (DClass* cl; lex.dmodule.classes) {
		int	j = 0;

		printf("\tclass %.*s", cl.name);
		if (cl.iinterfaces.length > 0) printf(" : ");

		foreach (char[] v; cl.iinterfaces) {
			if (j > 0) printf(", ");
			printf("%.*s", v);
			++j;
		}
		printf(" {\n");

		// Variables:
		foreach (DVar* var; cl.vars) {
			printf("\t\t");
			switch (var.access) {
				case accessRights.arPublic: printf("public "); break;
				case accessRights.arPrivate: printf("private "); break;
				case accessRights.arProtected: printf("protected "); break;
				case accessRights.arPackage: printf("package "); break;
			}
			printf("%.*s\t%.*s;\n", typeString(var.type), var.name);
		}
		if (cl.vars.length > 0) printf("\n");

		// Constructors:
		foreach (DFunc* func; cl.ctors) {
			printf("\t\t");
			switch (func.access) {
				case accessRights.arPublic: printf("public "); break;
				case accessRights.arPrivate: printf("private "); break;
				case accessRights.arProtected: printf("protected "); break;
				case accessRights.arPackage: printf("package "); break;
			}
			printf("this(%.*s);\n", parmlist(func.parms));
		}

		// Destructors:
		foreach (DFunc* func; cl.dtors) {
			printf("\t\t");
			switch (func.access) {
				case accessRights.arPublic: printf("public "); break;
				case accessRights.arPrivate: printf("private "); break;
				case accessRights.arProtected: printf("protected "); break;
				case accessRights.arPackage: printf("package "); break;
			}
			printf("~this(%.*s);\n", parmlist(func.parms));
		}

		// Functions:
		foreach (DFunc* func; cl.funcs) {
			printf("\t\t");
			switch (func.access) {
				case accessRights.arPublic: printf("public "); break;
				case accessRights.arPrivate: printf("private "); break;
				case accessRights.arProtected: printf("protected "); break;
				case accessRights.arPackage: printf("package "); break;
			}
			printf("%.*s\t%.*s(%.*s);\n", typeString(func.type), func.name, parmlist(func.parms));
		}

		printf("\t}\n\n");
	}

	// Functions:
	foreach (DFunc* func; lex.dmodule.funcs) {
		printf("\t");
		switch (func.access) {
			case accessRights.arPublic: printf("public "); break;
			case accessRights.arPrivate: printf("private "); break;
			case accessRights.arProtected: printf("protected "); break;
			case accessRights.arPackage: printf("package "); break;
		}
		printf("%.*s\t%.*s(%.*s);\n", typeString(func.type), func.name, parmlist(func.parms));
	}

	printf("}\n");

	return 0;
}
// dparse - D module parser
// (C) Copyright 2004-2005 James Dunne

// Please feel free to distribute this module in any form you like.  I only ask that you
// give credit where credit is due.  You may make modifications to this module.  If you do
// so, you may provide your modifications publicly, but you are not required to.

// A minimal parser that skips over actual code.  Only concerned with parsing for declarations.

module	dparse;

import	std.stream;
import	std.string;
import	std.ctype;

import	dlexer;
import	dtypes;

const int TRUE = 1;
const int FALSE = 0;

class DParse : DLexer {
	private:
		// Check for a certain token:
		void check(uint value) {
			if (token.value != value)
				error(format("found '%s' when expecting '%s'", token.toString(), toktostr[value]));
			nextToken();
		}

		void check(uint value, char[] string) {
			if (token.value != value)
				error(format("found '%s' when expecting '%s' following '%s'", token.toString(), toktostr[value], string));
			nextToken();
		}

		uint		linkage;

	public:
		ArrayT!(Identifier)		moduleident;

		// Load up the module source code:
		this(char[] filename, char[] src) {
			// Load up the source for the lexer:
			super(filename, src);
			linkage = LINKd;
			nextToken();			// start the scanner
		}

		Array parseModule() {
			Array	decldefs;

			// ModuleDeclation leads off
			if (token.value == TOKmodule) {
				nextToken();
				if (token.value != TOKidentifier) {
					error("Identifier expected following module");
					goto Lerr;
				} else {
					ArrayT!(Identifier) a = null;
					Identifier id;

					id = token.ident;
					while (nextToken() == TOKdot) {
						if (!a)
							a = new ArrayT!(Identifier);
						a.push(id);
						nextToken();
						if (token.value != TOKidentifier) {
							error("Identifier expected following package");
							goto Lerr;
						}
						id = token.ident;
					}

					moduleident = a;

					if (token.value != TOKsemicolon)
						error(format("';' expected following module declaration instead of %s", token.toString()));
					nextToken();
				}
			}

			decldefs = parseDeclDefs(0);
			if (token.value != TOKeof) {
				error("unrecognized declaration");
				goto Lerr;
			}
			return decldefs;

		  Lerr:
			while (token.value != TOKsemicolon && token.value != TOKeof)
				nextToken();
			nextToken();
			return new Array;
		}

		Array parseDeclDefs(int once) {
			Dsymbol s;
			Array decldefs;
			Array a;
			uint prot;
			uint stc;

			//printf("parseDeclDefs()\n");
			decldefs = new Array;
			do {
				switch (token.value) {
					case TOKenum:
						s = parseEnum();
						break;

					case TOKstruct:
						s = parseAggregate();
						break;

					case TOKunion:
						s = parseAggregate();
						break;

					case TOKclass:
						s = parseAggregate();
						break;

					case TOKinterface:
						s = parseAggregate();
						break;

					case TOKimport:
						s = parseImport(decldefs);
						break;

					case TOKtemplate:
						s = cast(Dsymbol) parseTemplateDeclaration();
						break;

					case TOKmixin:
						s = parseMixin();
						break;

					case TOKinstance:	// Deprecated
						if (isDeclaration(token, 2, TOKreserved, null)) {
							//printf("it's a declaration\n");
							goto Ldeclaration;
						} else {
							// instance foo(bar) ident;

							TemplateInstance ti;

							//printf("it's an alias\n");
							ti = parseTemplateInstance();
							s = cast(Dsymbol) ti;
							if (ti) {
								if (token.value == TOKidentifier) {
									s = new AliasDeclaration(loc, token.ident, ti);

									nextToken();
								}
							}
							if (token.value != TOKsemicolon)
								error("';' expected after template instance");
						}
						break;

					case TOKwchar: case TOKdchar:
					case TOKbit: case TOKchar:
					case TOKint8: case TOKuns8:
					case TOKint16: case TOKuns16:
					case TOKint32: case TOKuns32:
					case TOKint64: case TOKuns64:
					case TOKfloat32: case TOKfloat64: case TOKfloat80:
					case TOKimaginary32: case TOKimaginary64: case TOKimaginary80:
					case TOKcomplex32: case TOKcomplex64: case TOKcomplex80:
					case TOKvoid:

					case TOKalias:
					case TOKtypedef:
					case TOKidentifier:
					case TOKtypeof:
					case TOKdot:
					  Ldeclaration:
						a = parseDeclaration();
						decldefs.append(a);
						continue;

					case TOKthis:
						s = parseCtor();
						break;

					case TOKtilde:
						s = parseDtor();
						break;

					case TOKinvariant:
						parseInvariant();
						s = null;
						break;

					case TOKunittest:
						parseUnitTest();
						s = null;
						break;

					case TOKnew:
						s = parseNew();
						break;

					case TOKdelete:
						s = parseDelete();
						break;

					case TOKeof:
					case TOKrcurly:
						return decldefs;

					case TOKstatic:
						nextToken();
						if (token.value == TOKthis)
							s = parseStaticCtor();
						else if (token.value == TOKtilde)
							s = parseStaticDtor();
						else if (token.value == TOKassert)
							s = parseStaticAssert();
						else {
							stc = STCstatic;
							goto Lstc2;
						}
						break;

					case TOKconst:
						stc = STCconst;
						goto Lstc;
					case TOKfinal:
						stc = STCfinal;
						goto Lstc;
					case TOKauto:
						stc = STCauto;
						goto Lstc;
					case TOKoverride:
						stc = STCoverride;
						goto Lstc;
					case TOKabstract:
						stc = STCabstract;
						goto Lstc;
					case TOKsynchronized:
						stc = STCsynchronized;
						goto Lstc;
					case TOKdeprecated:
						stc = STCdeprecated;
						goto Lstc;

					  Lstc:
						nextToken();
					  Lstc2:
						switch (token.value) {
							case TOKconst:
								stc |= STCconst;
								goto Lstc;
							case TOKfinal:
								stc |= STCfinal;
								goto Lstc;
							case TOKauto:
								stc |= STCauto;
								goto Lstc;
							case TOKoverride:
								stc |= STCoverride;
								goto Lstc;
							case TOKabstract:
								stc |= STCabstract;
								goto Lstc;
							case TOKsynchronized:
								stc |= STCsynchronized;
								goto Lstc;
							case TOKdeprecated:
								stc |= STCdeprecated;
								goto Lstc;
						}
						a = parseBlock();
						s = new StorageClassDeclaration(stc, a);
						break;

					case TOKprivate:
						prot = PROTprivate;
						goto Lprot;
					case TOKpackage:
						prot = PROTpackage;
						goto Lprot;
					case TOKprotected:
						prot = PROTprotected;
						goto Lprot;
					case TOKpublic:
						prot = PROTpublic;
						goto Lprot;
					case TOKexport:
						prot = PROTexport;
						goto Lprot;

					  Lprot:
						nextToken();
						a = parseBlock();
						s = new ProtDeclaration(prot, a);
						break;

					case TOKalign:
						{
							uint n;

							s = null;
							nextToken();
							if (token.value == TOKlparen) {
								nextToken();
								if (token.value == TOKint32v)
									n = cast(uint)token.uns64value;
								else {
									error("integer expected, not %s", token.toString());
									n = 1;
								}
								nextToken();
								check(TOKrparen);
							} else
								n = 4;	//global.structalign;	// default

							a = parseBlock();
							s = new AlignDeclaration(n, a);
							break;
						}

					case TOKpragma:
						{
							Identifier ident;
							Array args = null;

							nextToken();
							check(TOKlparen);
							if (token.value != TOKidentifier) {
								error("pragma(identifier expected");
								goto Lerror;
							}
							ident = token.ident;
							nextToken();
							if (token.value == TOKcomma)
								args = parseArguments();	// pragma(identifier, args...)
							else
								check(TOKrparen);	// pragma(identifier)

							if (token.value == TOKsemicolon)
								a = null;
							else
								a = parseBlock();
							/+s = new PragmaDeclaration(ident, args, a);+/
							s = null;
							break;
						}

					case TOKextern:
						{
							uint link = LINKdefault;
							uint linksave;

							s = null;
							nextToken();
							if (token.value == TOKlparen) {
								nextToken();
								if (token.value == TOKidentifier) {
									Identifier id = token.ident;

									nextToken();
									if (id == Id.Windows)
										link = LINKwindows;
									else if (id == Id.Pascal)
										link = LINKpascal;
									else if (id == Id.D)
										link = LINKd;
									else if (id == Id.C) {
										link = LINKc;
										if (token.value == TOKplusplus) {
											link = LINKcpp;
											nextToken();
										}
									} else {
										error("valid linkage identifiers are D, C, C++, Pascal, Windows");
										link = LINKd;
										break;
									}
								} else {
									link = LINKd;	// default
								}
								check(TOKrparen);
							} else {
								stc = STCextern;
								goto Lstc2;
							}
							linksave = linkage;
							linkage = link;
							a = parseBlock();
							linkage = linksave;
							s = new LinkDeclaration(link, a);
							break;
						}

					case TOKdebug:
						{
							DebugCondition condition;
							Array aelse;

							nextToken();
							if (token.value == TOKassign) {
								nextToken();
								if (token.value == TOKidentifier)
									s = new DebugSymbol(token.ident);
								else if (token.value == TOKint32v)
									s = new DebugSymbol(cast(uint)token.uns64value);
								else {
									error("identifier or integer expected, not %s", token.toString());
									s = null;
								}
								nextToken();
								if (token.value != TOKsemicolon)
									error("semicolon expected");
								nextToken();
								break;
							}

							if (token.value == TOKlparen) {
								nextToken();
								condition = parseDebugCondition();
								check(TOKrparen);
							} else
								condition = new DebugCondition(1, null);
							a = parseBlock();
							aelse = null;
							if (token.value == TOKelse) {
								nextToken();
								aelse = parseBlock();
							}
							s = new DebugDeclaration(condition, a, aelse);
							break;
						}

					case TOKversion:
						{
							VersionCondition condition;
							Array aelse;

							nextToken();
							if (token.value == TOKassign) {
								nextToken();
								if (token.value == TOKidentifier)
									s = new VersionSymbol(token.ident);
								else if (token.value == TOKint32v)
									s = new VersionSymbol(cast(uint)token.uns64value);
								else {
									error("identifier or integer expected, not %s", token.toString());
									s = null;
								}
								nextToken();
								if (token.value != TOKsemicolon)
									error("semicolon expected");
								nextToken();
								break;
							}

							if (token.value == TOKlparen) {
								nextToken();
								condition = parseVersionCondition();
								check(TOKrparen);
							} else {
								error("(condition) expected following version");
								condition = null;
							}
							a = parseBlock();
							aelse = null;
							if (token.value == TOKelse) {
								nextToken();
								aelse = parseBlock();
							}
							s = new VersionDeclaration(condition, a, aelse);
							break;
						}

					case TOKsemicolon:	// empty declaration
						nextToken();
						continue;

					default:
						error("Declaration expected, not '%s'\n", token.toString());
					  Lerror:
						while (token.value != TOKsemicolon && token.value != TOKeof)
							nextToken();
						nextToken();
						s = null;
						continue;
				}
				if (s)
					decldefs.push(s);
			} while (!once);
			return decldefs;
		}

		/********************************************
		 * Parse declarations after an align, protection, or extern decl.
		 */

		Array parseBlock() {
			Array a = null;
			Dsymbol s;

			//printf("parseBlock()\n");
			switch (token.value) {
				case TOKsemicolon:
					error("declaration expected following attribute, not ';'");
					nextToken();
					break;

				case TOKlcurly:
					nextToken();
					a = parseDeclDefs(0);
					if (token.value != TOKrcurly) {	/* { */
						error("matching '}' expected, not %s", token.toString());
					} else
						nextToken();
					break;

				case TOKcolon:
					nextToken();
					a = null;
/+		#else
					a = parseDeclDefs(0);	// grab declarations up to closing curly bracket
		#endif+/
					break;

				default:
					a = parseDeclDefs(1);
					break;
			}
			return a;
		}

		/**********************************
		 * Parse a static assertion.
		 */

		StaticAssert parseStaticAssert() {
			Loc loc = this.loc;
			Expression exp;

			//printf("parseStaticAssert()\n");
			nextToken();
			check(TOKlparen);
			exp = parseExpression();
			check(TOKrparen);
			check(TOKsemicolon);
			return new StaticAssert(loc, exp);
		}

		/**************************************
		 * Parse a debug conditional
		 */

		DebugCondition parseDebugCondition() {
			uint level = 1;
			Identifier id = null;

			if (token.value == TOKidentifier)
				id = token.ident;
			else if (token.value == TOKint32v)
				level = cast(uint)token.uns64value;
			else
				error("identifier or integer expected, not %s", token.toString());
			nextToken();

			return new DebugCondition(level, id);
		}

		/**************************************
		 * Parse a version conditional
		 */

		VersionCondition parseVersionCondition() {
			uint level = 1;
			Identifier id = null;

			if (token.value == TOKidentifier)
				id = token.ident;
			else if (token.value == TOKint32v)
				level = cast(uint)token.uns64value;
			else
				error("identifier or integer expected, not %s", token.toString());
			nextToken();

			return new VersionCondition(level, id);
		}

		/*****************************************
		 * Parse a constructor definition:
		 *	this(arguments) { body }
		 * Current token is 'this'.
		 */

		CtorDeclaration parseCtor() {
			CtorDeclaration f;
			Array arguments;
			int varargs;
			Loc loc = this.loc;

			nextToken();
			arguments = parseParameters(varargs);
			f = new CtorDeclaration(loc, 0, arguments, varargs);
			parseContracts(f);
			return f;
		}

		/*****************************************
		 * Parse a destructor definition:
		 *	~this() { body }
		 * Current token is '~'.
		 */

		DtorDeclaration parseDtor() {
			DtorDeclaration f;
			Loc loc = this.loc;

			nextToken();
			check(TOKthis);
			check(TOKlparen);
			check(TOKrparen);

			f = new DtorDeclaration(loc, 0);
			parseContracts(f);
			return f;
		}

		/*****************************************
		 * Parse a static constructor definition:
		 *	static this() { body }
		 * Current token is 'this'.
		 */

		StaticCtorDeclaration parseStaticCtor() {
			StaticCtorDeclaration f;
			Loc loc = this.loc;

			nextToken();
			check(TOKlparen);
			check(TOKrparen);

			f = new StaticCtorDeclaration(loc, 0);
			parseContracts(f);
			return f;
		}

		/*****************************************
		 * Parse a static destructor definition:
		 *	static ~this() { body }
		 * Current token is '~'.
		 */

		StaticDtorDeclaration parseStaticDtor() {
			StaticDtorDeclaration f;
			Loc loc = this.loc;

			nextToken();
			check(TOKthis);
			check(TOKlparen);
			check(TOKrparen);

			f = new StaticDtorDeclaration(loc, 0);
			parseContracts(f);
			return f;
		}

		/*****************************************
		 * Parse an invariant definition:
		 *	invariant { body }
		 * Current token is 'invariant'.
		 */

		InvariantDeclaration parseInvariant() {
			InvariantDeclaration f;
			Loc loc = this.loc;

			nextToken();
			//check(TOKlparen);     // don't require ()
			//check(TOKrparen);

			f = new InvariantDeclaration(loc, 0);
			f.fbody = parseStatement(PScurly);
			return f;
		}

		/*****************************************
		 * Parse a unittest definition:
		 *	unittest { body }
		 * Current token is 'unittest'.
		 */

		UnitTestDeclaration parseUnitTest() {
			UnitTestDeclaration f;
			Statement sbody;
			Loc loc = this.loc;

			nextToken();

			sbody = parseStatement(PScurly);

			f = new UnitTestDeclaration(loc, this.loc);
			f.fbody = sbody;
			return f;
		}
		
		/*****************************************
		 * Parse a new definition:
		 *	new(arguments) { body }
		 * Current token is 'new'.
		 */
		
		NewDeclaration parseNew() {
			NewDeclaration f;
			Array arguments;
			int varargs;
			Loc loc = this.loc;
		
			nextToken();
			arguments = parseParameters(varargs);
			f = new NewDeclaration(loc, 0, arguments, varargs);
			parseContracts(f);
			return f;
		}
		
		/*****************************************
		 * Parse a delete definition:
		 *	delete(arguments) { body }
		 * Current token is 'delete'.
		 */
		
		DeleteDeclaration parseDelete() {
			DeleteDeclaration f;
			Array arguments;
			int varargs;
			Loc loc = this.loc;
		
			nextToken();
			arguments = parseParameters(varargs);
			if (varargs)
				error("... not allowed in delete function parameter list");
			f = new DeleteDeclaration(loc, 0, arguments);
			parseContracts(f);
			return f;
		}

		/**********************************************
		 * Parse parameter list.
		 */

		Array parseParameters(out int pvarargs) {
			Array arguments = new Array;
			int varargs = 0;
			int hasdefault = 0;

			check(TOKlparen);
			while (1) {
				Type tb;
				Identifier ai;
				Type at;
				Argument a;
				uint inoutt;
				Expression ae;

				ai = null;
				inoutt = In;				// parameter is "in" by default
				switch (token.value) {
					case TOKrparen:
						break;

					case TOKdotdotdot:
						varargs = 1;
						nextToken();
						break;

					case TOKin:
						inoutt = In;
						nextToken();
						goto L1;

					case TOKout:
						inoutt = Out;
						nextToken();
						goto L1;

					case TOKinout:
						inoutt = InOut;
						nextToken();
						goto L1;

					default:
					  L1:
						tb = parseBasicType();
						at = parseDeclarator(tb, &ai);
						if (token.value == TOKassign)	// = defaultArg
						{
							nextToken();
							ae = parseAssignExp();
							hasdefault = 1;
						} else {
							if (hasdefault)
								error("default argument expected for parameter '%s'", ai.toString());
							ae = null;
						}
						a = new Argument(inoutt, at, ai, ae);
						arguments.push(a);
						if (token.value == TOKcomma) {
							nextToken();
							continue;
						}
						break;
				}
				break;
			}
			check(TOKrparen);
			pvarargs = varargs;
			return arguments;
		}

		/*************************************
		 */

		EnumDeclaration parseEnum() {
			EnumDeclaration e;
			Identifier id;
			Type t;

			//printf("parseEnum()\n");
			nextToken();
			if (token.value == TOKidentifier) {
				id = token.ident;
				nextToken();
			} else
				id = null;

			if (token.value == TOKcolon) {
				nextToken();
				t = parseBasicType();
			} else
				t = null;

			e = new EnumDeclaration(id, t);
			if (token.value == TOKsemicolon && id)
				nextToken();
			else if (token.value == TOKlcurly) {
				//printf("enum definition\n");
				e.members = new ArrayT!(EnumMember);
				nextToken();
				while (token.value != TOKrcurly) {
					if (token.value == TOKidentifier) {
						EnumMember em;
						Expression value;
						Identifier ident;

						ident = token.ident;
						value = null;
						nextToken();
						if (token.value == TOKassign) {
							nextToken();
							value = parseAssignExp();
						}
						em = new EnumMember(loc, ident, value);
						e.members.push(em);
						if (token.value == TOKrcurly) { }
						else
							check(TOKcomma);
					} else {
						error("enum member expected");
						nextToken();
					}
				}
				nextToken();
			} else
				error("enum declaration is invalid");

			return e;
		}

		Dsymbol parseAggregate() {
			AggregateDeclaration a = null;
			int anon = 0;
			uint tok;
			Identifier id;
			Array tpl = null;

			//printf("parseAggregate()\n");
			tok = token.value;
			nextToken();
			if (token.value != TOKidentifier) {
				id = null;
			} else {
				id = token.ident;
				nextToken();

				if (token.value == TOKlparen) {	// Class template declaration.

					// Gather template parameter list
					tpl = parseTemplateParameterList();
				}
			}

			switch (tok) {
				case TOKclass:
				case TOKinterface:
					{
						Array baseclasses = null;
						BaseClass b;

						if (!id)
							error("anonymous classes not allowed");

						// Collect base class(es)
						b = null;
						if (token.value == TOKcolon) {
							uint protection = PROTpublic;

							baseclasses = new Array;
							while (1) {
								nextToken();
								switch (token.value) {
									case TOKidentifier:
									case TOKinstance:
										break;
									case TOKprivate:
										protection = PROTprivate;
										continue;
									case TOKpackage:
										protection = PROTpackage;
										continue;
									case TOKprotected:
										protection = PROTprotected;
										continue;
									case TOKpublic:
										protection = PROTpublic;
										continue;
									default:
										error("base classes expected following ':'");
										return null;
								}
								b = new BaseClass(parseBasicType(), protection);
								baseclasses.push(b);
								if (token.value != TOKcomma)
									break;
								protection = PROTpublic;
							}
							if (token.value != TOKlcurly)
								error("members expected");
						}

						if (tok == TOKclass)
							a = new ClassDeclaration(loc, id, baseclasses);
						else
							a = new InterfaceDeclaration(loc, id, baseclasses);
						break;
					}

				case TOKstruct:
					if (id)
						a = new StructDeclaration(loc, id);
					else
						anon = 1;
					break;

				case TOKunion:
					if (id)
						a = new UnionDeclaration(loc, id);
					else
						anon = 2;
					break;

				default:
					assert(0);
					break;
			}

			if (a && token.value == TOKsemicolon) {
				nextToken();
			} else if (token.value == TOKlcurly) {
				//printf("aggregate definition\n");
				nextToken();
				Array decl = parseDeclDefs(0);

				if (token.value != TOKrcurly)
					error("struct member expected");
				nextToken();
				if (anon) {
					/* Anonymous structs/unions are more like attributes.
					 */
					return new AnonDeclaration(anon - 1, decl);
				} else
					a.members = decl;
			} else {
				error("{ } expected following aggregate declaration");
				a = new StructDeclaration(loc, null);
			}

			if (tpl) {
				Array decldefs;
				TemplateDeclaration tempdecl;

				// Wrap a template around the aggregate declaration
				decldefs = new Array;
				decldefs.push(a);
				tempdecl = new TemplateDeclaration(loc, id, tpl, decldefs);
				return tempdecl;
			}

			return a;
		}

		/**************************************
		 * Parse a TemplateDeclaration.
		 */

		TemplateDeclaration parseTemplateDeclaration() {
			TemplateDeclaration tempdecl;
			Identifier id;
			Array tpl;
			Array decldefs;
			Loc loc = this.loc;

			nextToken();
			if (token.value != TOKidentifier) {
				error("TemplateIdentifier expected following template");
				goto Lerr;
			}
			id = token.ident;
			nextToken();
			tpl = parseTemplateParameterList();
			if (!tpl)
				goto Lerr;

			if (token.value != TOKlcurly) {
				error("members of template declaration expected");
				goto Lerr;
			} else {
				nextToken();
				decldefs = parseDeclDefs(0);
				if (token.value != TOKrcurly) {
					error("template member expected");
					goto Lerr;
				}
				nextToken();
			}

			tempdecl = new TemplateDeclaration(loc, id, tpl, decldefs);
			return tempdecl;

		  Lerr:
			return null;
		}

		/******************************************
		 * Parse template parameter list.
		 */

		Array parseTemplateParameterList() {
			Array tpl;

			if (token.value != TOKlparen) {
				error("parenthesized TemplateParameterList expected following TemplateIdentifier");
				goto Lerr;
			}
			tpl = new Array;
			nextToken();

			// Get TemplateParameterList
			if (token.value != TOKrparen) {
				while (1) {
					TemplateParameter tp;
					Identifier tp_ident;
					Type tp_spectype;
					Type tp_valtype;
					Type tp_defaulttype;
					Expression tp_specvalue;
					Expression tp_defaultvalue;
					Token t;

					// Get TemplateParameter

					// First, look ahead to see if it is a TypeParameter or a ValueParameter
					t = peek(token);
					if (token.value == TOKalias) {	// AliasParameter
						nextToken();
						if (token.value != TOKidentifier) {
							error("Identifier expected for template parameter");
							goto Lerr;
						}
						tp_ident = token.ident;
						nextToken();
						if (token.value == TOKassign)	// : Type
						{
							nextToken();
							tp_defaulttype = parseBasicType();
							tp_defaulttype = parseDeclarator(tp_defaulttype, null);
						}
						tp = new TemplateAliasParameter(loc, tp_ident, tp_defaulttype);
					} else if (t.value == TOKcolon || t.value == TOKassign || t.value == TOKcomma || t.value == TOKrparen) {	// TypeParameter
						if (token.value != TOKidentifier) {
							error("Identifier expected for template parameter");
							goto Lerr;
						}
						tp_ident = token.ident;
						nextToken();
						if (token.value == TOKcolon)	// : Type
						{
							nextToken();
							tp_spectype = parseBasicType();
							tp_spectype = parseDeclarator(tp_spectype, null);
						}
						if (token.value == TOKassign)	// : Type
						{
							nextToken();
							tp_defaulttype = parseBasicType();
							tp_defaulttype = parseDeclarator(tp_defaulttype, null);
						}
						tp = new TemplateTypeParameter(loc, tp_ident, tp_spectype, tp_defaulttype);
					} else {			// ValueParameter
						tp_valtype = parseBasicType();
						tp_valtype = parseDeclarator(tp_valtype, &tp_ident);
						if (!tp_ident) {
							error("no identifier for template value parameter");
							goto Lerr;
						}
						if (token.value == TOKcolon)	// : CondExpression
						{
							nextToken();
							tp_specvalue = parseCondExp();
						}
						if (token.value == TOKassign)	// = CondExpression
						{
							nextToken();
							tp_defaultvalue = parseCondExp();
						}
						tp = new TemplateValueParameter(loc, tp_ident, tp_valtype, tp_specvalue, tp_defaultvalue);
					}
					tpl.push(tp);
					if (token.value != TOKcomma)
						break;
					nextToken();
				}
			}
			check(TOKrparen);
			return tpl;

		  Lerr:
			return null;
		}

		/**************************************
		 * Parse a TemplateInstance.
		 */

		TemplateInstance parseTemplateInstance() {
			TemplateInstance tempinst;
			Identifier id;

			//printf("parseTemplateInstance()\n");
			nextToken();
			if (token.value == TOKdot) {
				id = Id.empty;
			} else if (token.value == TOKidentifier) {
				id = token.ident;
				nextToken();
			} else {
				error("TemplateIdentifier expected following instance");
				goto Lerr;
			}
			tempinst = new TemplateInstance(loc, id);
			while (token.value == TOKdot) {
				nextToken();
				if (token.value == TOKidentifier)
					tempinst.addIdent(token.ident);
				else {
					error("identifier expected following '.' instead of '%s'", token.toString());
					goto Lerr;
				}
				nextToken();
			}
			/+tempinst.tiargs = +/parseTemplateArgumentList();

			//if (!global.params.useDeprecated)
			//	error("instance is deprecated, use %s", tempinst.toString());
			return tempinst;

		  Lerr:
			return null;
		}

		/******************************************
		 * Parse template mixin.
		 *	mixin Foo;
		 *	mixin Foo!(args);
		 *	mixin a.b.c!(args).Foo!(args);
		 *	mixin Foo!(args) identifier;
		 */

		TemplateMixin parseMixin() {
			TemplateMixin tm;
			Identifier id;
			TypeTypeof tqual;
			Array tiargs;
			ArrayT!(Identifier) idents;

			//printf("parseMixin()\n");
			nextToken();

			tqual = null;
			if (token.value == TOKdot) {
				id = Id.empty;
			} else {
				if (token.value == TOKtypeof) {
					Expression exp;

					nextToken();
					check(TOKlparen);
					exp = parseExpression();
					check(TOKrparen);
					tqual = new TypeTypeof(loc, exp);
					check(TOKdot);
				}
				if (token.value != TOKidentifier) {
					error("identifier expected, not %s", token.toString());
					goto Lerr;
				}
				id = token.ident;
			}

			idents = new ArrayT!(Identifier);
			while (1) {
				nextToken();
				tiargs = null;
				if (token.value == TOKnot) {
					nextToken();
					/+tiargs = +/parseTemplateArgumentList();
				}

				if (token.value != TOKdot)
					break;

				if (tiargs) {
					TemplateInstance tempinst = new TemplateInstance(loc, id);
		
					tempinst.tiargs = tiargs;
					id = cast(Identifier) tempinst;
					tiargs = null;
				}
				idents.push(id);

				nextToken();
				if (token.value != TOKidentifier) {
					error("identifier expected following '.' instead of '%s'", token.toString());
					break;
				}
				id = token.ident;
			}
			idents.push(id);

			if (token.value == TOKidentifier) {
				id = token.ident;
				nextToken();
			} else
				id = null;

			tm = new TemplateMixin(loc, id, tqual, idents, tiargs);
			if (token.value != TOKsemicolon)
				error("';' expected after mixin");
			nextToken();

			return tm;

		  Lerr:
			return null;
		}

		/******************************************
		 * Parse template argument list.
		 * Input:
		 * 	current token is opening '('
		 * Output:
		 *	current token is one after closing ')'
		 */

		void parseTemplateArgumentList() {
			/+ArrayT!(Object) tiargs = new Array;+/

			if (token.value != TOKlparen) {
				error("!(TemplateArgumentList) expected following TemplateIdentifier");
				return/+ tiargs+/;
			}
			nextToken();

			// Get TemplateArgumentList
			if (token.value != TOKrparen) {
				while (1) {
					// See if it is an Expression or a Type
					/+if (isDeclaration(&token, 0, TOKreserved, null)) {	// Type
						Type ta;

						// Get TemplateArgument
						ta = parseBasicType();
						ta = parseDeclarator(ta, null);
						tiargs.push(ta);
					} else {			// Expression
						Expression ea;

						ea = parseAssignExp();
						tiargs.push(ea);
					}+/
					if (token.value != TOKcomma)
						break;
					nextToken();
				}
			}
			check(TOKrparen, "template argument list");
			return/+ tiargs+/;
		}

		Import parseImport(Array decldefs) {
			Import s;
			Identifier id;
			ArrayT!(Identifier) a;
			Loc loc;

			//printf("parseImport()\n");
			do {
				nextToken();
				if (token.value != TOKidentifier) {
					error("Identifier expected following import");
					break;
				}

				loc = this.loc;
				a = null;
				id = token.ident;
				while (nextToken() == TOKdot) {
					if (!a)
						a = new ArrayT!(Identifier);
					a.push(id);
					nextToken();
					if (token.value != TOKidentifier) {
						error("Identifier expected following package");
						break;
					}
					id = token.ident;
				}

				s = new Import(loc, a, token.ident);
				decldefs.push(s);
			} while (token.value == TOKcomma);

			if (token.value == TOKsemicolon)
				nextToken();
			else {
				error("';' expected");
				nextToken();
			}

			return null;
		}

		Type parseBasicType() {
			Type t;
			Identifier id;
			TypeQualified tid;
			TemplateInstance tempinst;

			//printf("parseBasicType()\n");
			switch (token.value) {
				case TOKvoid:	 t = Type.tvoid;  goto LabelX;
				case TOKint8:	 t = Type.tint8;  goto LabelX;
				case TOKuns8:	 t = Type.tuns8;  goto LabelX;
				case TOKint16:	 t = Type.tint16; goto LabelX;
				case TOKuns16:	 t = Type.tuns16; goto LabelX;
				case TOKint32:	 t = Type.tint32; goto LabelX;
				case TOKuns32:	 t = Type.tuns32; goto LabelX;
				case TOKint64:	 t = Type.tint64; goto LabelX;
				case TOKuns64:	 t = Type.tuns64; goto LabelX;
				case TOKfloat32: t = Type.tfloat32; goto LabelX;
				case TOKfloat64: t = Type.tfloat64; goto LabelX;
				case TOKfloat80: t = Type.tfloat80; goto LabelX;
				case TOKimaginary32: t = Type.timaginary32; goto LabelX;
				case TOKimaginary64: t = Type.timaginary64; goto LabelX;
				case TOKimaginary80: t = Type.timaginary80; goto LabelX;
				case TOKcomplex32: t = Type.tcomplex32; goto LabelX;
				case TOKcomplex64: t = Type.tcomplex64; goto LabelX;
				case TOKcomplex80: t = Type.tcomplex80; goto LabelX;
				case TOKbit:	 t = Type.tbit;     goto LabelX;
				case TOKchar:	 t = Type.tchar;    goto LabelX;
				case TOKwchar:	 t = Type.twchar; goto LabelX;
				case TOKdchar:	 t = Type.tdchar; goto LabelX;
				LabelX:
					nextToken();
					break;

				case TOKidentifier:
					id = token.ident;
					nextToken();
					if (token.value == TOKnot) {
						nextToken();
						tempinst = new TemplateInstance(loc, id);
						/+tempinst.tiargs = +/parseTemplateArgumentList();
						tid = new TypeInstance(loc, tempinst);
						goto Lident2;
					}
				  Lident:
					tid = new TypeIdentifier(loc, id);
				  Lident2:
					while (token.value == TOKdot) {
						nextToken();
						if (token.value != TOKidentifier) {
							error("identifier expected following '.' instead of '%s'", token.toString());
							break;
						}
						id = token.ident;
						nextToken();
						if (token.value == TOKnot) {
							nextToken();
							tempinst = new TemplateInstance(loc, id);
							/+tempinst.tiargs = +/parseTemplateArgumentList();
							/+tid.addIdent(cast(Identifier) tempinst);+/
						} else
							/+tid.addIdent(id);+/ { }
					}
					t = tid;
					break;

				case TOKdot:
					id = Id.empty;
					goto Lident;

				case TOKinstance:
					{					// Deprecated
						tempinst = parseTemplateInstance();
						if (!tempinst)	// if error
						{
							t = Type.tvoid;
							break;
						}

						tid = new TypeInstance(loc, tempinst);
						goto Lident2;
					}

				case TOKtypeof:
					{
						Expression exp;

						nextToken();
						check(TOKlparen);
						exp = parseExpression();
						check(TOKrparen);
						tid = new TypeTypeof(loc, exp);
						goto Lident2;
					}

				default:
					error("basic type expected, not %s", token.toString());
					t = Type.tint32;
					break;
			}
			return t;
		}

		Type parseBasicType2(Type t) {
			Expression e;
			Type ts;
			Type ta;

			//printf("parseBasicType2()\n");
			while (1) {
				switch (token.value) {
					case TOKmul:
						t = new TypePointer(t);
						nextToken();
						continue;

					case TOKlbracket:
						// Handle []. Make sure things like
						//     int[3][1] a;
						// is (array[1] of array[3] of int)
						nextToken();
						if (token.value == TOKrbracket) {
							t = new TypeDArray(t);	// []
							nextToken();
						} else if (isDeclaration(token, 0, TOKrbracket, null)) {	// It's an associative array declaration
							Type index;

							//printf("it's an associative array\n");
							index = parseBasicType();
							index = parseDeclarator(index, null);	// [ type ]
							t = new TypeAArray(t, index);
							check(TOKrbracket);
						} else {
							//printf("it's [expression]\n");
							e = parseExpression();	// [ expression ]
							t = new TypeSArray(t, e);
							check(TOKrbracket);
						}
						continue;

					case TOKdelegate:
					case TOKfunction:
						{				// Handle delegate declaration:
							//  t delegate(parameter list)
							//  t function(parameter list)
							Array arguments;
							int varargs;
							uint  save = token.value;

							nextToken();
							arguments = parseParameters(varargs);
							t = new TypeFunction(arguments, t, varargs, linkage);
							if (save == TOKdelegate)
								t = new TypeDelegate(t);
							else
								t = new TypePointer(t);	// pointer to function
							continue;
						}

					default:
						ts = t;
						break;
				}
				break;
			}
			return ts;
		}

		Type parseDeclarator(Type t, Identifier *pident) {
			Expression e;
			Type ts;
			Type ta;
			Type *pt;

			//printf("parseDeclarator(t = %p)\n", t);
			while (1) {
				switch (token.value) {
					case TOKmul:
						t = new TypePointer(t);
						nextToken();
						continue;

					case TOKlbracket:
						// Handle []. Make sure things like
						//     int[3][1] a;
						// is (array[1] of array[3] of int)
						nextToken();
						if (token.value == TOKrbracket) {
							t = new TypeDArray(t);	// []
							nextToken();
						} else if (isDeclaration(token, 0, TOKrbracket, null)) {	// It's an associative array declaration
							Type index;

							//printf("it's an associative array\n");
							index = parseBasicType();
							index = parseDeclarator(index, null);	// [ type ]
							t = new TypeAArray(t, index);
							check(TOKrbracket);
						} else {
							//printf("it's [expression]\n");
							e = parseExpression();	// [ expression ]
							t = new TypeSArray(t, e);
							check(TOKrbracket);
						}
						continue;

					case TOKidentifier:
						if (pident)
							*pident = token.ident;
						else
							error("unexpected identifer '%s' in declarator", token.ident.toString());
						ts = t;
						nextToken();
						break;

					case TOKlparen:
						nextToken();
						ts = parseDeclarator(t, pident);
						check(TOKrparen);
						break;

					case TOKdelegate:
					case TOKfunction:
						{				// Handle delegate declaration:
							//  t delegate(parameter list)
							//  t function(parameter list)
							Array arguments;
							int varargs;
							uint save = token.value;

							nextToken();
							arguments = parseParameters(varargs);
							t = new TypeFunction(arguments, t, varargs, linkage);
							if (save == TOKdelegate)
								t = new TypeDelegate(t);
							else
								t = new TypePointer(t);	// pointer to function
							continue;
						}
					default:
						ts = t;
						break;
				}
				break;
			}

			while (1) {
				switch (token.value) {
					case TOKlbracket:
						// This is the old C-style post [] syntax.
						// Should we disallow it?
						nextToken();
						if (token.value == TOKrbracket) {
							ta = new TypeDArray(t);	// []
							nextToken();
						} else if (isDeclaration(token, 0, TOKrbracket, null)) {	// It's an associative array declaration
							Type index;

							//printf("it's an associative array\n");
							index = parseBasicType();
							index = parseDeclarator(index, null);	// [ type ]
							check(TOKrbracket);
							ta = new TypeAArray(t, index);
						} else {
							//printf("it's [expression]\n");
							e = parseExpression();	// [ expression ]
							ta = new TypeSArray(t, e);
							check(TOKrbracket);
						}
						for (pt = &ts; *pt != t; pt = &((*pt).next)) {}
						*pt = ta;
						continue;
					case TOKlparen:
						{
							Array arguments;
							int varargs;

							arguments = parseParameters(varargs);
							ta = new TypeFunction(arguments, t, varargs, linkage);
							for (pt = &ts; *pt != t; pt = &((*pt).next)) {}
							*pt = ta;
							continue;
						}
				}
				break;
			}

			return ts;
		}
		
		/**********************************
		 * Return array of Declaration *'s.
		 */
		
		Array parseDeclaration() {
			uint storage_class;
			uint sc;
			Type ts;
			Type t;
			Type tfirst;
			Identifier ident;
			Array a;
			uint tok;

			//printf("parseDeclaration()\n");
			switch (token.value) {
				case TOKtypedef:
				case TOKalias:
					tok = token.value;
					nextToken();
					break;

				default:
					tok = TOKreserved;
					break;
			}

			storage_class = STCundefined;
			while (1) {
				switch (token.value) {
					case TOKconst:
						sc = STCconst;
						goto L1;
					case TOKstatic:
						sc = STCstatic;
						goto L1;
					case TOKfinal:
						sc = STCfinal;
						goto L1;
					case TOKauto:
						sc = STCauto;
						goto L1;
					case TOKoverride:
						sc = STCoverride;
						goto L1;
					case TOKabstract:
						sc = STCabstract;
						goto L1;
					case TOKsynchronized:
						sc = STCsynchronized;
						goto L1;
					case TOKdeprecated:
						sc = STCdeprecated;
						goto L1;
					  L1:
						if (storage_class & sc)
							error("redundant storage class '%s'", token.toString());
						storage_class = (storage_class | sc);
						nextToken();
						continue;
				}
				break;
			}

			a = new Array;
			ts = parseBasicType();
			ts = parseBasicType2(ts);
			tfirst = null;

			while (1) {
				Loc loc = this.loc;

				ident = null;
				t = parseDeclarator(ts, &ident);
				assert(t);
				if (!tfirst)
					tfirst = t;
				else if (t != tfirst)
					error("multiple declarations must have the same type, not %s and %s", tfirst.toString(), t.toString());
				if (!ident)
					error("no identifier for declarator");

				if (tok == TOKtypedef || tok == TOKalias) {
					Declaration v;
					Initializer init;

					init = null;
					if (token.value == TOKassign) {
						nextToken();
						init = parseInitializer();
					}
					if (tok == TOKtypedef)
						v = new TypedefDeclaration(ident, t, init);
					else {
						if (init)
							error("alias cannot have initializer");
						v = new AliasDeclaration(loc, ident, t);
					}
					v.storage_class = storage_class;
					a.push(v);
					switch (token.value) {
						case TOKsemicolon:
							nextToken();
							break;

						case TOKcomma:
							nextToken();
							continue;

						default:
							error("semicolon expected to close %s declaration", Token.toChars(tok));
							break;
					}
				} else if (t.ty == Tfunction) {
					FuncDeclaration f;

					f = new FuncDeclaration(loc, 0, ident, storage_class, t);
					a.push(f);
					parseContracts(f);
				} else {
					VarDeclaration v;
					Initializer init;

					init = null;
					if (token.value == TOKassign) {
						nextToken();
						init = parseInitializer();
					}
					v = new VarDeclaration(loc, t, ident, init);
					v.storage_class = storage_class;
					a.push(v);
					switch (token.value) {
						case TOKsemicolon:
							nextToken();
							break;

						case TOKcomma:
							nextToken();
							continue;

						default:
							error("semicolon expected, not '%s'", token.toString());
							break;
					}
				}
				break;
			}
			return a;
		}

		/*****************************************
		 * Parse contracts following function declaration.
		 */

		void parseContracts(FuncDeclaration f) {
			Type tb;
			uint linksave = linkage;

			// The following is irrelevant, as it is overridden by sc.linkage in
			// TypeFunction.semantic
			linkage = LINKd;			// nested functions have D linkage
		  L1:
			switch (token.value) {
				case TOKlcurly:
					if (f.frequire || f.fensure)
						error("missing body { ... } after in or out");
					f.fbody = parseStatement(PSsemi);
					/+f.endloc = endloc;+/
					break;
		
				case TOKbody:
					nextToken();
					f.fbody = parseStatement(PScurly);
					/+f.endloc = endloc;+/
					break;
		
				case TOKsemicolon:
					if (f.frequire || f.fensure)
						error("missing body { ... } after in or out");
					nextToken();
					break;
		
				case TOKin:
					nextToken();
					if (f.frequire)
						error("redundant 'in' statement");
					f.frequire = parseStatement(PScurly | PSscope);
					goto L1;
		
				case TOKout:
					// parse: out (identifier) { statement }
					nextToken();
					if (token.value != TOKlcurly) {
						check(TOKlparen);
						if (token.value != TOKidentifier)
							error("(identifier) following 'out' expected, not %s", token.toString());
						f.outId = token.ident;
						nextToken();
						check(TOKrparen);
					}
					if (f.fensure)
						error("redundant 'out' statement");
					f.fensure = parseStatement(PScurly | PSscope);
					goto L1;
		
				default:
					error("semicolon expected following function declaration");
					break;
			}
			linkage = linksave;
		}
		
		/*****************************************
		 */
		
		Initializer parseInitializer() {
			StructInitializer ist;
			ArrayInitializer ia;
			ExpInitializer ie;
			Expression e;
			Identifier id;
			Initializer value;
			int comma;
			Loc loc = this.loc;
			Token t;
		
			switch (token.value) {
				case TOKlcurly:
					ist = new StructInitializer(loc);
					nextToken();
					comma = 0;
					while (1) {
						switch (token.value) {
							case TOKidentifier:
								if (comma == 1)
									error("comma expected separating field initializers");
								t = peek(token);
								if (t.value == TOKcolon) {
									id = token.ident;
									nextToken();
									nextToken();	// skip over ':'
								} else {
									id = null;
								}
								value = parseInitializer();
								ist.addInit(id, value);
								comma = 1;
								continue;
		
							case TOKcomma:
								nextToken();
								comma = 2;
								continue;
		
							case TOKrcurly:	// allow trailing comma's
								nextToken();
								break;
		
							default:
								value = parseInitializer();
								ist.addInit(null, value);
								comma = 1;
								continue;
								//error("found '%s' instead of field initializer", token.toString());
								//break;
						}
						break;
					}
					return ist;
		
				case TOKlbracket:
					ia = new ArrayInitializer(loc);
					nextToken();
					comma = 0;
					while (1) {
						switch (token.value) {
							default:
								if (comma == 1) {
									error("comma expected separating array initializers, not %s", token.toString());
									nextToken();
									break;
								}
								e = parseAssignExp();
								if (!e)
									break;
								if (token.value == TOKcolon) {
									nextToken();
									value = parseInitializer();
								} else {
									value = new ExpInitializer(e.loc, e);
									e = null;
								}
								ia.addInit(e, value);
								comma = 1;
								continue;
		
							case TOKlcurly:
							case TOKlbracket:
								if (comma == 1)
									error("comma expected separating array initializers, not %s", token.toString());
								value = parseInitializer();
								ia.addInit(null, value);
								comma = 1;
								continue;
		
							case TOKcomma:
								nextToken();
								comma = 2;
								continue;
		
							case TOKrbracket:	// allow trailing comma's
								nextToken();
								break;
		
							case TOKeof:
								error("found '%s' instead of array initializer", token.toString());
								break;
						}
						break;
					}
					return ia;

				default:
					e = parseAssignExp();
					ie = new ExpInitializer(loc, e);
					return ie;
			}
		}


		/*****************************************
		 * Input:
		 *	flags	PSxxxx
		 */

		Statement parseStatement(int flags)
		{
			Statement s;
			Token t;
			Loc loc = this.loc;

			//printf("parseStatement()\n");
		
			if (flags & PScurly && token.value != TOKlcurly)
				error("statement expected to be { }, not %s", token.toString());
		
			switch (token.value) {
				case TOKidentifier:
					// Need to look ahead to see if it is a declaration, label, or expression
					t = peek(token);
					if (t.value == TOKcolon) {	// It's a label
						Identifier ident;
		
						ident = token.ident;
						nextToken();
						nextToken();
						/+s = +/parseStatement(PSsemi);
						/+s = new LabelStatement(loc, ident, s);+/
						s = null;
						break;
					}
					// fallthrough to TOKdot
				case TOKdot:
				case TOKtypeof:
					if (isDeclaration(token, 2, TOKreserved, null))
						goto Ldeclaration;
					else
						goto Lexp;
					break;
		
				case TOKassert:
				case TOKthis:
				case TOKsuper:
				case TOKint32v:
				case TOKuns32v:
				case TOKint64v:
				case TOKuns64v:
				case TOKfloat32v:
				case TOKfloat64v:
				case TOKfloat80v:
				case TOKimaginary32v:
				case TOKimaginary64v:
				case TOKimaginary80v:
				case TOKcharv:
				case TOKwcharv:
				case TOKdcharv:
				case TOKnull:
				case TOKtrue:
				case TOKfalse:
				case TOKstring:
				case TOKlparen:
				case TOKcast:
				case TOKmul:
				case TOKmin:
				case TOKadd:
				case TOKplusplus:
				case TOKminusminus:
				case TOKnew:
				case TOKdelete:
				case TOKdelegate:
				case TOKfunction:
				case TOKtypeid:
				  Lexp:
					{
						Expression exp;
		
						exp = parseExpression();
						check(TOKsemicolon, "statement");
						/+s = new ExpStatement(loc, exp);+/
						break;
					}
		
				case TOKinstance:		// Deprecated
					/* Three cases:
					 *  1) Declaration
					 *  2) Template Instance Alias
					 *  3) Expression
					 */
					if (isDeclaration(token, 2, TOKreserved, null)) {
						//printf("it's a declaration\n");
						goto Ldeclaration;
					} else {
						if (isTemplateInstance(token, &t) && t.value == TOKidentifier) {	// case 2
							TemplateInstance ti;
							AliasDeclaration a;
		
							ti = parseTemplateInstance();
							assert(ti);
							assert(token.value == TOKidentifier);
		
							a = new AliasDeclaration(loc, token.ident, ti);
							s = new DeclarationStatement(loc, a);
							nextToken();
							if (token.value != TOKsemicolon)
								error("';' expected after template instance, not %s", token.toString());
						} else
							goto Lexp;	// case 3
					}
					break;
		
				case TOKstatic:
					{					// Look ahead to see if it's static assert()
						Token t;
		
						t = peek(token);
						if (t.value == TOKassert) {
							nextToken();
							/+s = new StaticAssertStatement(parseStaticAssert());+/
							s = null;
							break;
						}
						goto Ldeclaration;
					}
		
				case TOKwchar: case TOKdchar:
				case TOKbit: case TOKchar:
				case TOKint8: case TOKuns8:
				case TOKint16: case TOKuns16:
				case TOKint32: case TOKuns32:
				case TOKint64: case TOKuns64:
				case TOKfloat32: case TOKfloat64: case TOKfloat80:
				case TOKimaginary32: case TOKimaginary64: case TOKimaginary80:
				case TOKcomplex32: case TOKcomplex64: case TOKcomplex80:
				case TOKvoid:

				case TOKtypedef:
				case TOKalias:
				case TOKconst:
				case TOKauto:
		//  case TOKtypeof:
				  Ldeclaration:
					{
						Array a;

						a = parseDeclaration();
						if (a.dim > 1) {
							ArrayT!(Statement) as = new ArrayT!(Statement)();

							as.reserve(a.dim);
							for (int i = 0; i < a.dim; i++) {
								Dsymbol d = cast(Dsymbol) a.data[i];

								s = new DeclarationStatement(loc, d);
								as.push(s);
							}
							s = new CompoundStatement(loc, as);
						} else if (a.dim == 1) {
							Dsymbol d = cast(Dsymbol) a.data[0];

							s = new DeclarationStatement(loc, d);
						} else
							assert(0);
						break;
					}

				case TOKstruct:
				case TOKunion:
				case TOKclass:
				case TOKinterface:
					{
						Dsymbol d;

						d = parseAggregate();
						s = new DeclarationStatement(loc, d);
						break;
					}

				case TOKenum:
					{
						Dsymbol d;
		
						d = parseEnum();
						s = new DeclarationStatement(loc, d);
						break;
					}

				case TOKmixin:
					{
						Dsymbol d;
		
						d = parseMixin();
						s = new DeclarationStatement(loc, d);
						break;
					}

				case TOKlcurly:
					{
						nextToken();
						while (token.value != TOKrcurly) {
							parseStatement(PSsemi | PScurlyscope);
						}
						nextToken();
						break;
					}

				case TOKwhile:
					{
						nextToken();
						check(TOKlparen);
						parseExpression();
						check(TOKrparen);
						parseStatement(PSscope);
						s = null;
						break;
					}

				case TOKsemicolon:
					if (!(flags & PSsemi))
						error("use '{ }' for an empty statement, not a ';'");
					nextToken();
					s = new ExpStatement(loc, null);
					break;

				case TOKdo:
					{
						nextToken();
						parseStatement(PSscope);
						check(TOKwhile);
						check(TOKlparen);
						parseExpression();
						check(TOKrparen);
						s = null;
						break;
					}

				case TOKfor:
					{
						nextToken();
						check(TOKlparen);
						if (token.value == TOKsemicolon) {
							nextToken();
						} else {
							parseStatement(0);
						}
						if (token.value == TOKsemicolon) {
							nextToken();
						} else {
							parseExpression();
							check(TOKsemicolon, "for condition");
						}
						if (token.value == TOKrparen) {
							nextToken();
						} else {
							parseExpression();
							check(TOKrparen);
						}
						parseStatement(0);
						s = null;
						break;
					}

				case TOKforeach:
					{
						nextToken();
						check(TOKlparen);
		
						while (1) {
							Type tb;
							Identifier ai = null;
							Type at;
							uint inoutt;
							Argument a;
		
							inoutt = In;
							if (token.value == TOKinout) {
								inoutt = InOut;
								nextToken();
							}
							tb = parseBasicType();
							at = parseDeclarator(tb, &ai);
							if (!ai)
								error("no identifier for declarator");
							if (token.value == TOKcomma) {
								nextToken();
								continue;
							}
							break;
						}
						check(TOKsemicolon);
		
						parseExpression();
						check(TOKrparen);
						parseStatement(0);
						s = null;
						break;
					}
		
				case TOKif:
					{
						nextToken();
						check(TOKlparen);
						parseExpression();
						check(TOKrparen);
						parseStatement(PSscope);
						if (token.value == TOKelse) {
							nextToken();
							parseStatement(PSscope);
						}
						s = null;
						break;
					}
		
				case TOKdebug:
					{
						nextToken();
						if (token.value == TOKlparen) {
							nextToken();
							parseDebugCondition();
							check(TOKrparen);
						}
						parseStatement(PSsemi);
						if (token.value == TOKelse) {
							nextToken();
							parseStatement(PSsemi);
						}
						s = null;
						break;
					}
		
				case TOKversion:
					{
/+						Condition condition;
						Statement ifbody;
						Statement elsebody;
+/	
						nextToken();
						if (token.value == TOKlparen) {
							nextToken();
							/+condition = +/parseVersionCondition();
							check(TOKrparen);
						} else {
							error("(condition) expected after version");
							/+condition = null;+/
						}
						/+ifbody = +/parseStatement(PSsemi);
						if (token.value == TOKelse) {
							nextToken();
							/+elsebody = +/parseStatement(PSsemi);
						}/+ else
							elsebody = null;+/
						/+s = new ConditionalStatement(loc, condition, ifbody, elsebody);+/
						s = null;
						break;
					}
		
				case TOKpragma:
					{
						nextToken();
						check(TOKlparen);
						if (token.value != TOKidentifier) {
							error("pragma(identifier expected");
							goto Lerror;
						}
						nextToken();
						if (token.value == TOKcomma)
							parseArguments();	// pragma(identifier, args...);
						else
							check(TOKrparen);	// pragma(identifier);
						parseStatement(PSsemi);
						s = null;
						break;
					}
		
				case TOKswitch:
					{
		
						nextToken();
						check(TOKlparen);
						parseExpression();
						check(TOKrparen);
						parseStatement(PSscope);
						s = null;
						break;
					}
		
				case TOKcase:
					{
						Expression exp;
						Array statements;
		
						while (1) {
							nextToken();
							exp = parseAssignExp();
							if (token.value != TOKcomma)
								break;
						}
						check(TOKcolon);
		
						while (token.value != TOKcase && token.value != TOKdefault && token.value != TOKrcurly) {
							parseStatement(PSsemi | PScurlyscope);
						}
						s = null;
						break;
					}
		
				case TOKdefault:
					{
						Array statements;
		
						nextToken();
						check(TOKcolon);
		
						while (token.value != TOKcase && token.value != TOKdefault && token.value != TOKrcurly) {
							parseStatement(PSsemi | PScurlyscope);
						}
						s = null;
						break;
					}
		
				case TOKreturn:
					{
						Expression exp;
		
						nextToken();
						if (token.value == TOKsemicolon)
							exp = null;
						else
							exp = parseExpression();
						check(TOKsemicolon, "return statement");
						s = null;
						break;
					}
		
				case TOKbreak:
					{
						Identifier ident;
		
						nextToken();
						if (token.value == TOKidentifier) {
							ident = token.ident;
							nextToken();
						} else
							ident = null;
						check(TOKsemicolon, "break statement");
						s = null;
						break;
					}
		
				case TOKcontinue:
					{
						Identifier ident;
		
						nextToken();
						if (token.value == TOKidentifier) {
							ident = token.ident;
							nextToken();
						} else
							ident = null;
						check(TOKsemicolon, "continue statement");
						s = null;
						break;
					}
		
				case TOKgoto:
					{
						Identifier ident;
		
						nextToken();
						if (token.value == TOKdefault) {
							nextToken();
							s = null;
						} else if (token.value == TOKcase) {
							Expression *exp = null;
		
							nextToken();
							if (token.value != TOKsemicolon)
								parseExpression();
							s = null;
						} else {
							if (token.value != TOKidentifier) {
								error("Identifier expected following goto");
							} else {
								nextToken();
							}
							s = null;
						}
						check(TOKsemicolon, "goto statement");
						break;
					}
		
				case TOKsynchronized:
					{
						Expression exp;
						Statement sbody;
		
						nextToken();
						if (token.value == TOKlparen) {
							nextToken();
							parseExpression();
							check(TOKrparen);
						} else
							exp = null;
						parseStatement(PSscope);
						s = null;
						break;
					}
		
				case TOKwith:
					{
						nextToken();
						check(TOKlparen);
						parseExpression();
						check(TOKrparen);
						parseStatement(PSscope);
						s = null;
						break;
					}
		
				case TOKtry:
					{
		
						nextToken();
						parseStatement(PSscope);
						while (token.value == TOKcatch) {
							Statement handler;
							Type t;
							Identifier id;
		
							nextToken();
							if (token.value == TOKlcurly) {
								t = null;
								id = null;
							} else {
								check(TOKlparen);
								t = parseBasicType();
								id = null;
								t = parseDeclarator(t, &id);
								check(TOKrparen);
							}
							parseStatement(0);
						}
		
						if (token.value == TOKfinally) {
							nextToken();
							parseStatement(0);
						}
						break;
					}
		
				case TOKthrow:
					{
						nextToken();
						parseExpression();
						check(TOKsemicolon, "throw statement");
						s = null;
						break;
					}

				case TOKvolatile:
					nextToken();
					parseStatement(PSsemi | PSscope);
					s = null;
					break;

				case TOKasm:
					{
						// Parse the asm block into a sequence of AsmStatements,
						// each AsmStatement is one instruction.
						// Separate out labels.
						// Defer parsing of AsmStatements until semantic processing.

						nextToken();
						check(TOKlcurly);
						while (1) {
							switch (token.value) {
								case TOKidentifier:
									// Look ahead to see if it is a label
									t = peek(token);
									if (t.value == TOKcolon) {	// It's a label
										nextToken();
										nextToken();
										continue;
									}
									goto Ldefault;

								case TOKrcurly:
									break;

								case TOKsemicolon:
									s = null;
									nextToken();
									continue;

								case TOKeof:
									error("matching '}' expected, not end of file");
									break;

								default:
								  Ldefault:
									nextToken();
									continue;
							}
							break;
						}
						s = null;
						nextToken();
						break;
					}

				default:
					error("found '%s' instead of statement", token.toString());
				  Lerror:
					while (token.value != TOKsemicolon && token.value != TOKeof)
						nextToken();
					nextToken();
					s = null;
					break;
			}

			return s;
		}

		/************************************
		 * Determine if the scanner is sitting on the start of a declaration.
		 * Input:
		 *	needId	0	no identifier
		 *		1	identifier optional
		 *		2	must have identifier
		 */

		bool isDeclaration(Token t, int needId, uint endtok, Token *pt) {
			bool haveId = 0;

			if (!isBasicType(&t))
				return false;
			if (!isDeclarator(&t, haveId, endtok))
				return false;
			if ( needId == 1 ||
			(needId == 0 && !haveId) ||
			(needId == 2 &&  haveId))
			{	if (pt)
					*pt = t;
				return true;
			}
			else
				return false;
		}

		int isBasicType(Token *pt)
		{
			// This code parallels parseBasicType()
			Token t = *pt;
			Token t2;
			int parens;

			switch (t.value) {
				case TOKwchar: case TOKdchar:
				case TOKbit: case TOKchar:
				case TOKint8: case TOKuns8:
				case TOKint16: case TOKuns16:
				case TOKint32: case TOKuns32:
				case TOKint64: case TOKuns64:
				case TOKfloat32: case TOKfloat64: case TOKfloat80:
				case TOKimaginary32: case TOKimaginary64: case TOKimaginary80:
				case TOKcomplex32: case TOKcomplex64: case TOKcomplex80:
				case TOKvoid:
				t = peek(t);
				break;

			case TOKidentifier:
				t = peek(t);
				if (t.value == TOKnot)
				{
					goto L4;
				}
				goto L3;
				while (1)
				{
			L2:
				t = peek(t);
			L3:
				if (t.value == TOKdot)
				{
			Ldot:
					t = peek(t);
					if (t.value != TOKidentifier)
						goto Lfalse;
					t = peek(t);
					if (t.value != TOKnot)
						goto L3;
			L4:
					t = peek(t);
					if (t.value != TOKlparen)
						goto Lfalse;
					if (!skipParens(t, &t))
						goto Lfalse;
				}
				else
					break;
				}
				break;

			case TOKdot:
				goto Ldot;

			case TOKinstance:	// Deprecated
				// Handle cases like:
				//	instance Foo(int).bar x;
				// But remember that:
				//	instance Foo(int) x;
				// is not a type, but is an AliasDeclaration declaration.
				if (!isTemplateInstance(t, &t))
					goto Lfalse;		// invalid syntax for template instance
				if (t.value == TOKdot)
					goto Ldot;
				goto Lfalse;

			case TOKtypeof:
				/* typeof(exp).identifier...
				 */
				t = peek(t);
				if (t.value != TOKlparen)
					goto Lfalse;
				if (!skipParens(t, &t))
					goto Lfalse;
				goto L2;

			default:
				goto Lfalse;
			}
			*pt = t;
			return TRUE;

		Lfalse:
			return FALSE;
		}

		int isDeclarator(Token *pt, out bool haveId, uint endtok)
		{   // This code parallels parseDeclarator()
			Token t = *pt;
			int parens;

			if (t.value == TOKassign)
				return FALSE;

			while (1) {
				parens = FALSE;
				switch (t.value)
				{
					case TOKmul:
					case TOKand:
						t = peek(t);
						continue;
			
					case TOKlbracket:
						t = peek(t);
						if (t.value == TOKrbracket)
						{
							t = peek(t);
						}
						else if (isDeclaration(t, 0, TOKrbracket, &t))
						{   // It's an associative array declaration
							t = peek(t);
						}
						else
						{
							// [ expression ]
							if (!isExpression(&t))
								return FALSE;
							if (t.value != TOKrbracket)
								return FALSE;
							t = peek(t);
						}
						continue;
			
					case TOKidentifier:
						haveId = true;
						t = peek(t);
						break;

					case TOKlparen:
						t = peek(t);

						if (t.value == TOKrparen)
							return FALSE;		// () is not a declarator

						/* Regard ( identifier ) as not a declarator
						* BUG: what about ( *identifier ) in
						*	f(*p)(x);
						* where f is a class instance with overloaded () ?
						* Should we just disallow C-style function pointer declarations?
						*/
						if (t.value == TOKidentifier)
						{   Token t2 = peek(t);
							if (t2.value == TOKrparen)
								return FALSE;
						}


						if (!isDeclarator(&t, haveId, TOKrparen))
							return FALSE;
						t = peek(t);
						parens = TRUE;
						break;

					case TOKdelegate:
					case TOKfunction:
						t = peek(t);
						if (!isParameters(&t))
							return FALSE;
						continue;
				}
				break;
			}

			while (1) {
				switch (t.value)
				{
	//		#if CARRAYDECL
					case TOKlbracket:
						parens = FALSE;
						t = peek(t);
						if (t.value == TOKrbracket)
						{
							t = peek(t);
						}
						else if (isDeclaration(t, 0, TOKrbracket, &t))
						{   // It's an associative array declaration
							t = peek(t);
						}
						else
						{
							// [ expression ]
							if (!isExpression(&t))
								return FALSE;
							if (t.value != TOKrbracket)
								return FALSE;
							t = peek(t);
						}
						continue;
	//		#endif
			
					case TOKlparen:
						parens = FALSE;
						if (!isParameters(&t))
							return FALSE;
						continue;
			
					// Valid tokens that follow a declaration
					case TOKrparen:
					case TOKrbracket:
					case TOKassign:
					case TOKcomma:
					case TOKsemicolon:
					case TOKlcurly:
						// The !parens is to disallow unnecessary parentheses
						if (!parens && (endtok == TOKreserved || endtok == t.value))
						{   *pt = t;
							return TRUE;
						}
						return FALSE;
			
					default:
						return FALSE;
				}
			}
		}
		
		
		int isParameters(Token *pt)
		{   // This code parallels parseParameters()
			Token t = *pt;
			bool tmp;
		
			if (t.value != TOKlparen)
			return FALSE;
			t = peek(t);
			while (1)
			{
			switch (t.value)
			{
				case TOKrparen:
				break;
		
				case TOKdotdotdot:
				t = peek(t);
				break;
		
				case TOKin:
				case TOKout:
				case TOKinout:
				t = peek(t);
				default:
				if (!isBasicType(&t))
					return FALSE;
				tmp = FALSE;
				if (!isDeclarator(&t, tmp, TOKreserved))
					return FALSE;
				if (t.value == TOKcomma)
				{   t = peek(t);
					continue;
				}
				break;
			}
			break;
			}
			if (t.value != TOKrparen)
			return FALSE;
			t = peek(t);
			*pt = t;
			return TRUE;
		}
		
		int isExpression(Token *pt)
		{
			// This is supposed to determine if something is an expression.
			// What it actually does is scan until a closing right bracket
			// is found.
		
			Token t = *pt;
			int nest = 0;
		
			for (;; t = peek(t))
			{
			switch (t.value)
			{
				case TOKlbracket:
				nest++;
				continue;
		
				case TOKrbracket:
				if (--nest >= 0)
					continue;
				break;
		
				case TOKeof:
				return FALSE;
		
				default:
				continue;
			}
			break;
			}
		
			*pt = t;
			return TRUE;
		}
		
		/**********************************************
		 * Skip over
		 *	instance foo.bar(parameters...)
		 * Output:
		 *	if (pt), *pt is set to the token following the closing )
		 * Returns:
		 *	1	it's valid instance syntax
		 *	0	invalid instance syntax
		 */
		
		int isTemplateInstance(Token t, Token *pt)
		{
			t = peek(t);
			if (t.value != TOKdot)
			{
			if (t.value != TOKidentifier)
				goto Lfalse;
			t = peek(t);
			}
			while (t.value == TOKdot)
			{
			t = peek(t);
			if (t.value != TOKidentifier)
				goto Lfalse;
			t = peek(t);
			}
			if (t.value != TOKlparen)
			goto Lfalse;
		
			// Skip over the template arguments
			while (1)
			{
			while (1)
			{
				t = peek(t);
				switch (t.value)
				{
				case TOKlparen:
					if (!skipParens(t, &t))
					goto Lfalse;
					continue;
				case TOKrparen:
					break;
				case TOKcomma:
					break;
				case TOKeof:
				case TOKsemicolon:
					goto Lfalse;
				default:
					continue;
				}
				break;
			}
		
			if (t.value != TOKcomma)
				break;
			}
			if (t.value != TOKrparen)
			goto Lfalse;
			t = peek(t);
			if (pt)
			*pt = t;
			return 1;
		
		Lfalse:
			return 0;
		}
		
		/*******************************************
		 * Skip parens, brackets.
		 * Input:
		 *	t is on opening (
		 * Output:
		 *	*pt is set to closing token, which is ')' on success
		 * Returns:
		 *	!=0	successful
		 *	0	some parsing error
		 */
		
		int skipParens(Token t, Token *pt)
		{
			int parens = 0;
		
			while (1)
			{
			switch (t.value)
			{
				case TOKlparen:
				parens++;
				break;
		
				case TOKrparen:
				parens--;
				if (parens < 0)
					goto Lfalse;
				if (parens == 0)
					goto Ldone;
				break;
		
				case TOKeof:
				case TOKsemicolon:
				goto Lfalse;
		
				 default:
				break;
			}
			t = peek(t);
			}
		
		  Ldone:
			if (*pt)
			*pt = t;
			return 1;
		
		  Lfalse:
			return 0;
		}
		
		/********************************* Expression Parser ***************************/
		
		Expression parsePrimaryExp() {
			Expression e;
			Type t;
			Identifier id;
			Loc loc = this.loc;
		
			switch (token.value) {
				case TOKidentifier:
					id = token.ident;
					nextToken();
					if (token.value == TOKnot) {
						// identifier!(template-argument-list)
						TemplateInstance tempinst;
			
						tempinst = new TemplateInstance(loc, id);
						nextToken();
						tempinst.tiargs = parseTemplateArgumentList();
						e = new ScopeExp(loc, tempinst);
					} else
						e = new IdentifierExp(loc, id);
					break;
			
				case TOKdot:
					// Signal global scope '.' operator with "" identifier
					e = new IdentifierExp(loc, Id.empty);
					break;
			
				case TOKthis:
					e = new ThisExp(loc);
					nextToken();
					break;
			
				case TOKsuper:
					e = new SuperExp(loc);
					nextToken();
					break;
			
				case TOKint32v:
					e = new IntegerExp(loc, token.int32value, Type.tint32);
					nextToken();
					break;
			
				case TOKuns32v:
					e = new IntegerExp(loc, token.uns32value, Type.tuns32);
					nextToken();
					break;
			
				case TOKint64v:
					e = new IntegerExp(loc, token.int64value, Type.tint64);
					nextToken();
					break;
			
				case TOKuns64v:
					e = new IntegerExp(loc, token.uns64value, Type.tuns64);
					nextToken();
					break;
			
				case TOKfloat32v:
					e = new RealExp(loc, token.float80value, Type.tfloat32);
					nextToken();
					break;
			
				case TOKfloat64v:
					e = new RealExp(loc, token.float80value, Type.tfloat64);
					nextToken();
					break;
			
				case TOKfloat80v:
					e = new RealExp(loc, token.float80value, Type.tfloat80);
					nextToken();
					break;
			
				case TOKimaginary32v:
					e = new ImaginaryExp(loc, token.float80value, Type.timaginary32);
					nextToken();
					break;
			
				case TOKimaginary64v:
					e = new ImaginaryExp(loc, token.float80value, Type.timaginary64);
					nextToken();
					break;
			
				case TOKimaginary80v:
					e = new ImaginaryExp(loc, token.float80value, Type.timaginary80);
					nextToken();
					break;
			
				case TOKnull:
					e = new NullExp(loc);
					nextToken();
					break;
			
				case TOKtrue:
					e = new IntegerExp(loc, 1, Type.tbit);
					nextToken();
					break;
			
				case TOKfalse:
					e = new IntegerExp(loc, 0, Type.tbit);
					nextToken();
					break;
			
				case TOKcharv:
					e = new IntegerExp(loc, token.uns32value, Type.tchar);
					nextToken();
					break;
			
				case TOKwcharv:
					e = new IntegerExp(loc, token.uns32value, Type.twchar);
					nextToken();
					break;
			
				case TOKdcharv:
					e = new IntegerExp(loc, token.uns32value, Type.tdchar);
					nextToken();
					break;
			
				case TOKstring:
				{   char[]	s;
	
					// cat adjacent strings
					s = token.ustring;
					while (1) {
						nextToken();
						if (token.value == TOKstring) {
							s ~= token.ustring;
						} else
							break;
					}
					e = new StringExp(loc, s, len);
					break;
				}
			
					case TOKvoid:	 t = Type.tvoid;  goto LabelX;
					case TOKint8:	 t = Type.tint8;  goto LabelX;
					case TOKuns8:	 t = Type.tuns8;  goto LabelX;
					case TOKint16:	 t = Type.tint16; goto LabelX;
					case TOKuns16:	 t = Type.tuns16; goto LabelX;
					case TOKint32:	 t = Type.tint32; goto LabelX;
					case TOKuns32:	 t = Type.tuns32; goto LabelX;
					case TOKint64:	 t = Type.tint64; goto LabelX;
					case TOKuns64:	 t = Type.tuns64; goto LabelX;
					case TOKfloat32: t = Type.tfloat32; goto LabelX;
					case TOKfloat64: t = Type.tfloat64; goto LabelX;
					case TOKfloat80: t = Type.tfloat80; goto LabelX;
					case TOKimaginary32: t = Type.timaginary32; goto LabelX;
					case TOKimaginary64: t = Type.timaginary64; goto LabelX;
					case TOKimaginary80: t = Type.timaginary80; goto LabelX;
					case TOKcomplex32: t = Type.tcomplex32; goto LabelX;
					case TOKcomplex64: t = Type.tcomplex64; goto LabelX;
					case TOKcomplex80: t = Type.tcomplex80; goto LabelX;
					case TOKbit:	 t = Type.tbit;     goto LabelX;
					case TOKchar:	 t = Type.tchar;    goto LabelX;
					case TOKwchar:	 t = Type.twchar; goto LabelX;
					case TOKdchar:	 t = Type.tdchar; goto LabelX;
					LabelX:
						nextToken();
				L1:
					check(TOKdot, t.toString());
					if (token.value != TOKidentifier)
					{   error("found '%s' when expecting identifier following '%s.'", token.toString(), t.toString());
					goto Lerr;
					}
					e = new TypeDotIdExp(loc, t, token.ident);
					nextToken();
					break;
			
				case TOKtypeof:
				{   Expression exp;
			
					nextToken();
					check(TOKlparen);
					exp = parseExpression();
					check(TOKrparen);
					t = new TypeTypeof(loc, exp);
					goto L1;
				}
			
				case TOKtypeid:
				{   Type t;
			
					nextToken();
					check(TOKlparen, "typeid");
					t = parseBasicType();
					t = parseDeclarator(t,NULL);	// ( type )
					check(TOKrparen);
					e = new TypeidExp(loc, t);
					break;
				}
			
				case TOKassert:
					nextToken();
					check(TOKlparen, "assert");
					e = parseAssignExp();
					check(TOKrparen);
					e = new AssertExp(loc, e);
					break;
			
				case TOKinstance:	// Deprecated
				{   TemplateInstance tempinst;
			
					tempinst = parseTemplateInstance();
					if (!tempinst)
					return NULL;
					e = new ScopeExp(loc, tempinst);
					break;
				}
			
				case TOKfunction:
				case TOKdelegate:
				{
					/* function type(parameters) { body }
					 * delegate type(parameters) { body }
					 */
					Array arguments;
					int varargs;
					FuncLiteralDeclaration fd;
					Type t;
					uint save = token.value;
			
					nextToken();
					if (token.value == TOKlcurly)
					{	// default to void()
						t = Type.tvoid;
						varargs = 0;
						arguments = new Array();
					} else {
						if (token.value == TOKlparen)
							t = Type.tvoid;		// default to void return type
						else {
							t = parseBasicType();
							t = parseBasicType2(t);	// function return type
						}
						arguments = parseParameters(&varargs);
					}
					t = new TypeFunction(arguments, t, varargs, linkage);
					fd = new FuncLiteralDeclaration(loc, 0, t, save, NULL);
					parseContracts(fd);
					e = new FuncExp(loc, fd);
					break;
			}
		
			default:
				error("expression expected, not '%s'", token.toString());
			Lerr:
				// Anything for e, as long as it's not NULL
				e = new IntegerExp(loc, 0, Type.tint32);
				nextToken();
				break;
			}
			return parsePostExp(e);
		}
		
		Expression parsePostExp(Expression e)
		{
			Loc loc;
		
			while (1) {
				loc = this.loc;
				switch (token.value) {
					case TOKdot:
						nextToken();
						if (token.value == TOKidentifier)
						{   Identifier id = token.ident;
				
							nextToken();
							if (token.value == TOKnot)
							{   // identifier!(template-argument-list)
							TemplateInstance tempinst;
				
							tempinst = new TemplateInstance(loc, id);
							nextToken();
							tempinst.tiargs = parseTemplateArgumentList();
							e = new DotTemplateInstanceExp(loc, e, tempinst);
							}
							else
							e = new DotIdExp(loc, e, id);
							continue;
						}
						else
							error("identifier expected following '.', not '%s'", token.toString());
						break;
	
					case TOKplusplus:
						e = new PostIncExp(loc, e);
						break;
			
					case TOKminusminus:
						e = new PostDecExp(loc, e);
						break;
			
					case TOKlparen:
						e = new CallExp(loc, e, parseArguments());
						continue;
			
					case TOKlbracket:
					{	// array dereferences:
					//	array[index]
					//	array[]
					//	array[lwr .. upr]
					Expression index;
					Expression upr;
			
					nextToken();
					if (token.value == TOKrbracket)
					{   // array[]
						e = new SliceExp(loc, e, NULL, NULL);
						nextToken();
					}
					else
					{
						index = parseAssignExp();
						if (token.value == TOKslice)
						{	// array[lwr .. upr]
						nextToken();
						upr = parseAssignExp();
						e = new SliceExp(loc, e, index, upr);
						}
						else
						{	// array[index, i2, i3, i4, ...]
						Array arguments = new Array();
						arguments.push(index);
						if (token.value == TOKcomma)
						{
							nextToken();
							while (1)
							{   Expression arg;
			
							arg = parseAssignExp();
							arguments.push(arg);
							if (token.value == TOKrbracket)
								break;
							check(TOKcomma);
							}
						}
						e = new ArrayExp(loc, e, arguments);
						}
						check(TOKrbracket);
					}
					continue;
					}
			
					default:
					return e;
				}
				nextToken();
			}
		}
		
		Expression parseUnaryExp()
		{   Expression e;
			Loc loc = this.loc;
		
			switch (token.value)
			{
			case TOKand:
				nextToken();
				e = parseUnaryExp();
				e = new AddrExp(loc, e);
				break;
		
			case TOKplusplus:
				nextToken();
				e = parseUnaryExp();
				e = new AddAssignExp(loc, e, new IntegerExp(loc, 1, Type.tint32));
				break;
		
			case TOKminusminus:
				nextToken();
				e = parseUnaryExp();
				e = new MinAssignExp(loc, e, new IntegerExp(loc, 1, Type.tint32));
				break;
		
			case TOKmul:
				nextToken();
				e = parseUnaryExp();
				e = new PtrExp(loc, e);
				break;
		
			case TOKmin:
				nextToken();
				e = parseUnaryExp();
				e = new NegExp(loc, e);
				break;
		
			case TOKadd:
				nextToken();
				e = parseUnaryExp();
				e = new UAddExp(loc, e);
				break;

			case TOKnot:
				nextToken();
				e = parseUnaryExp();
				e = new NotExp(loc, e);
				break;

			case TOKtilde:
				nextToken();
				e = parseUnaryExp();
				e = new ComExp(loc, e);
				break;

			case TOKdelete:
				nextToken();
				e = parseUnaryExp();
				e = new DeleteExp(loc, e);
				break;

			case TOKnew:
			{   Type t;
				Array newargs;
				Array arguments = NULL;
		
				nextToken();
				newargs = NULL;
				if (token.value == TOKlparen) {
					newargs = parseArguments();
				}
		
//		#if LTORARRAYDECL
				t = parseBasicType();
				t = parseBasicType2(t);
				if (t.ty == Taarray)
				{
				Type index = (cast(TypeAArray)t).index;
		
				if (index.ty == Tident)
				{
					TypeIdentifier ti = cast(TypeIdentifier)index;
					int i;
					Expression e;
					Identifier id = ti.ident;
		
					e = new IdentifierExp(loc, id);
					for (i = 0; i < ti.idents.dim; i++)
					{
					id = cast(Identifier)ti.idents.data[i];
					e = new DotIdExp(loc, e, id);
					}
		
					arguments = new Array();
					arguments.push(e);
					t = new TypeDArray(t.next);
				}
				else
				{
					error("need size of rightmost array, not type %s", index.toString());
					return new NullExp(loc);
				}
				}
				else if (t.ty == Tsarray)
				{
				TypeSArray tsa = cast(TypeSArray)t;
				Expression e = tsa.dim;
		
				arguments = new Array();
				arguments.push(e);
				t = new TypeDArray(t.next);
				}
				else if (token.value == TOKlparen)
				{
				arguments = parseArguments();
				}
/+		#else
				t = parseBasicType();
				while (token.value == TOKmul)
				{	t = new TypePointer(t);
				nextToken();
				}
				if (token.value == TOKlbracket)
				{
				Expression *e;
		
				nextToken();
				e = parseAssignExp();
				arguments = new Array();
				arguments.push(e);
				check(TOKrbracket);
				t = parseDeclarator(t, NULL);
				t = new TypeDArray(t);
				}
				else if (token.value == TOKlparen)
				arguments = parseArguments();
		#endif
+/
				e = new NewExp(loc, newargs, t, arguments);
				break;
			}
//		#if DCASTSYNTAX
			case TOKcast:				// cast(type) expression
			{   Type *t;
		
				nextToken();
				check(TOKlparen);
				t = parseBasicType();
				t = parseDeclarator(t,NULL);	// ( type )
				check(TOKrparen);
		
				// if .identifier
				if (token.value == TOKdot)
				{
				nextToken();
				if (token.value != TOKidentifier)
				{   error("Identifier expected following cast(type).");
					return NULL;
				}
				// cast(type).ident
				e = new TypeDotIdExp(loc, t, token.ident);
				nextToken();
				}
				else
				{
				e = parseUnaryExp();
				e = new CastExp(loc, e, t);
				}
		
				break;
			}
//		#endif
			case TOKlparen:
			{   Token *tk;
		
				nextToken();
/+		#if CCASTSYNTAX
				// If cast
				if (isDeclaration(&token, 0, TOKrparen, &tk))
				{
				tk = peek(tk);		// skip over right parenthesis
				switch (tk.value)
				{
					case TOKdot:
					case TOKplusplus:
					case TOKminusminus:
					case TOKnot:
					case TOKtilde:
					case TOKdelete:
					case TOKnew:
					case TOKlparen:
					case TOKidentifier:
					case TOKthis:
					case TOKsuper:
					case TOKint32v:
					case TOKuns32v:
					case TOKint64v:
					case TOKuns64v:
					case TOKfloat32v:
					case TOKfloat64v:
					case TOKfloat80v:
					case TOKimaginary32v:
					case TOKimaginary64v:
					case TOKimaginary80v:
					case TOKnull:
					case TOKtrue:
					case TOKfalse:
					case TOKcharv:
					case TOKwcharv:
					case TOKdcharv:
					case TOKstring:
					case TOKand:
					case TOKmul:
					case TOKmin:
					case TOKadd:
					case TOKfunction:
					case TOKdelegate:
					case TOKtypeof:
					CASE_BASIC_TYPES:		// (type)int.size
					{	// (type) una_exp
					Type *t;
		
					t = parseBasicType();
					t = parseDeclarator(t,NULL);
					check(TOKrparen);
		
					// if .identifier
					if (token.value == TOKdot)
					{
						nextToken();
						if (token.value != TOKidentifier)
						{   error("Identifier expected following (type).");
						return NULL;
						}
						e = new TypeDotIdExp(loc, t, token.ident);
						nextToken();
					}
					else
					{
						e = parseUnaryExp();
						e = new CastExp(loc, e, t);
						if (!global.params.useDeprecated)
						error("C style cast deprecated, use %s", e.toChars());
					}
					return e;
					}
				}
				}
		#endif
+/
				// ( expression )
				e = parseExpression();
				check(TOKrparen);
				e = parsePostExp(e);
				break;
			}
			default:
				e = parsePrimaryExp();
				break;
			}
			assert(e);
			return e;
		}
		
		Expression parseMulExp()
		{   Expression e;
			Expression e2;
			Loc loc = this.loc;
		
			e = parseUnaryExp();
			while (1)
			{
			switch (token.value)
			{
				case TOKmul: nextToken(); e2 = parseUnaryExp(); e = new MulExp(loc,e,e2); continue;
				case TOKdiv:   nextToken(); e2 = parseUnaryExp(); e = new DivExp(loc,e,e2); continue;
				case TOKmod:  nextToken(); e2 = parseUnaryExp(); e = new ModExp(loc,e,e2); continue;
		
				default:
				break;
			}
			break;
			}
			return e;
		}
		
		Expression parseAddExp()
		{   Expression e;
			Expression e2;
			Loc loc = this.loc;
		
			e = parseMulExp();
			while (1)
			{
			switch (token.value)
			{
				case TOKadd:    nextToken(); e2 = parseMulExp(); e = new AddExp(loc,e,e2); continue;
				case TOKmin:    nextToken(); e2 = parseMulExp(); e = new MinExp(loc,e,e2); continue;
				case TOKtilde:  nextToken(); e2 = parseMulExp(); e = new CatExp(loc,e,e2); continue;
		
				default:
				break;
			}
			break;
			}
			return e;
		}
		
		Expression parseShiftExp()
		{   Expression e;
			Expression e2;
			Loc loc = this.loc;
		
			e = parseAddExp();
			while (1)
			{
			switch (token.value)
			{
				case TOKshl:  nextToken(); e2 = parseAddExp(); e = new ShlExp(loc,e,e2);  continue;
				case TOKshr:  nextToken(); e2 = parseAddExp(); e = new ShrExp(loc,e,e2);  continue;
				case TOKushr: nextToken(); e2 = parseAddExp(); e = new UshrExp(loc,e,e2); continue;
		
				default:
				break;
			}
			break;
			}
			return e;
		}
		
		Expression parseRelExp()
		{   Expression e;
			Expression e2;
			uint op;
			Loc loc = this.loc;
		
			e = parseShiftExp();
			while (1) {
				switch (token.value) {
					case TOKlt:
					case TOKle:
					case TOKgt:
					case TOKge:
					case TOKunord:
					case TOKlg:
					case TOKleg:
					case TOKule:
					case TOKul:
					case TOKuge:
					case TOKug:
					case TOKue:
						op = token.value;
						nextToken();
						e2 = parseShiftExp();
						e = new CmpExp(op, loc, e, e2);
						continue;
			
					case TOKin:
						nextToken();
						e2 = parseShiftExp();
						e = new InExp(loc, e, e2);
						continue;
			
					default:
						break;
				}
				break;
			}
			return e;
		}
		
		Expression parseEqualExp()
		{   Expression e;
			Expression e2;
			Loc loc = this.loc;
		
			e = parseRelExp();
			while (1) {
				uint value = token.value;
			
				switch (value)
				{
					case TOKequal:
					case TOKnotequal:
						nextToken();
						e2 = parseRelExp();
						e = new EqualExp(value, loc, e, e2);
						continue;
			
					case TOKidentity:
					case TOKnotidentity:
						nextToken();
						e2 = parseRelExp();
						e = new IdentityExp(value, loc, e, e2);
						continue;
			
					default:
						break;
				}
				break;
			}
			return e;
		}
		
		Expression parseAndExp()
		{   Expression e;
			Expression e2;
			Loc loc = this.loc;
		
			e = parseEqualExp();
			while (token.value == TOKand) {
				nextToken();
				e2 = parseEqualExp();
				e = new AndExp(loc,e,e2);
				loc = this.loc;
			}
			return e;
		}
		
		Expression parseXorExp()
		{   Expression e;
			Expression e2;
			Loc loc = this.loc;
		
			e = parseAndExp();
			while (token.value == TOKxor) {
				nextToken();
				e2 = parseAndExp();
				e = new XorExp(loc, e, e2);
			}
			return e;
		}
		
		Expression parseOrExp()
		{   Expression e;
			Expression e2;
			Loc loc = this.loc;
		
			e = parseXorExp();
			while (token.value == TOKor) {
				nextToken();
				e2 = parseXorExp();
				e = new OrExp(loc, e, e2);
			}
			return e;
		}
		
		Expression parseAndAndExp()
		{   Expression e;
			Expression e2;
			Loc loc = this.loc;
		
			e = parseOrExp();
			while (token.value == TOKandand) {
				nextToken();
				e2 = parseOrExp();
				e = new AndAndExp(loc, e, e2);
			}
			return e;
		}
		
		Expression parseOrOrExp()
		{   Expression e;
			Expression e2;
			Loc loc = this.loc;
		
			e = parseAndAndExp();
			while (token.value == TOKoror) {
				nextToken();
				e2 = parseAndAndExp();
				e = new OrOrExp(loc, e, e2);
			}
			return e;
		}
		
		Expression parseCondExp()
		{   Expression e;
			Expression e1;
			Expression e2;
			Loc loc = this.loc;
		
			e = parseOrOrExp();
			if (token.value == TOKquestion) {
				nextToken();
				e1 = parseExpression();
				check(TOKcolon);
				e2 = parseCondExp();
				e = new CondExp(loc, e, e1, e2);
			}
			return e;
		}
		
		Expression parseAssignExp()
		{   Expression e;
			Expression e2;
			Loc loc;
		
			e = parseCondExp();
			while (1) {
				loc = this.loc;
				switch (token.value) {
					case TOKassign: nextToken(); e2 = parseAssignExp(); e = new AssignExp(loc, e, e2); continue;
					case TOKaddass: nextToken(); e2 = parseAssignExp(); e = new AddAssignExp(loc, e, e2); continue;
					case TOKminass: nextToken(); e2 = parseAssignExp(); e = new MinAssignExp(loc, e, e2); continue;
					case TOKmulass: nextToken(); e2 = parseAssignExp(); e = new MulAssignExp(loc, e, e2); continue;
					case TOKdivass: nextToken(); e2 = parseAssignExp(); e = new DivAssignExp(loc, e, e2); continue;
					case TOKmodass: nextToken(); e2 = parseAssignExp(); e = new ModAssignExp(loc, e, e2); continue;
					case TOKandass: nextToken(); e2 = parseAssignExp(); e = new AndAssignExp(loc, e, e2); continue;
					case TOKorass: nextToken(); e2 = parseAssignExp(); e = new OrAssignExp(loc, e, e2); continue;
					case TOKxorass: nextToken(); e2 = parseAssignExp(); e = new XorAssignExp(loc, e, e2); continue;
					case TOKshlass: nextToken(); e2 = parseAssignExp(); e = new ShlAssignExp(loc, e, e2); continue;
					case TOKshrass: nextToken(); e2 = parseAssignExp(); e = new ShrAssignExp(loc, e, e2); continue;
					case TOKushrass: nextToken(); e2 = parseAssignExp(); e = new UshrAssignExp(loc, e, e2); continue;
					case TOKcatass: nextToken(); e2 = parseAssignExp(); e = new CatAssignExp(loc, e, e2); continue;
					default:
					break;
				}
				break;
			}
			return e;
		}
		
		Expression parseExpression()
		{   Expression e;
			Expression e2;
			Loc loc = this.loc;
		
			//printf("parseExpression()\n");
			e = parseAssignExp();
			while (token.value == TOKcomma) {
				nextToken();
				e2 = parseAssignExp();
				e = new CommaExp(loc, e, e2);
				loc = this.loc;
			}
			return e;
		}
		
		
		/*************************
		 * Collect argument list.
		 * Assume current token is '('.
		 */
		
		Array parseArguments()
		{   // function call
			Array arguments;
			Expression arg;
		
			arguments = new Array();
			//if (token.value == TOKlparen)
			{
				nextToken();
				if (token.value != TOKrparen) {
					while (1) {
						arg = parseAssignExp();
						arguments.push(arg);
						if (token.value == TOKrparen)
							break;
						check(TOKcomma);
					}
				}
				check(TOKrparen);
			}
			return arguments;
		}
		
}

// Simple main program:
int main(char[][] args) {
	DParse	p;
	File	dfile;

	if (args.length <= 1) {
		printf("%.*s <file.d>\n", args[0]);
		return -1;
	}

	// Open the file:
	dfile = new File(args[1]);
	// Send in the buffer to the lexer:
	char[]	str = dfile.readString(dfile.size());

	p = new DParse(args[1], str);
	// Close the file now:
	dfile.close();

	// Let the lexer loose:
	p.parseModule();

	return 0;
}
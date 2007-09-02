/***********************************************************************\
*                               dfilter.d                               *
*                                                                       *
*                    D code filter for Doxygen 1.4.2                    *
*                                                                       *
*     Portions written by Hauke Duden, Stewart Gordon, James Dunne,     *
*                 probably various anonymous authors....                *
\***********************************************************************/
import std.file, std.ctype, std.string, std.c.stdio, std.stdio, std.cstream;

char[] data;    // Program code
char* current;  // Current point
char* previous; // Previous filter point
char* end;      // End of the data
char* ptoken;   // Start of this token

// Read in a token
char[] token() {
restart:
	ptoken = current;

	if (current >= end)
		return null;

	if (isalpha(*current) || *current == '_') {
		for (current++; current < end; current++)
			if (!isalnum(*current) && *current != '_')
				break;

		return ptoken[0 .. cast(int) (current - ptoken)];
	}

	if (*current == ' ' || *current == '\r' || *current == '\n'
		  || *current == '\t') {
		current++;
		goto restart;
	}

	if (*current == '"') {
		for (current++; current < end; current++)
			if (*current == '\\') {
				current++;
			} else if (*current == '"') {
				current++;
				break;
			}
		goto restart;
	}

	if (*current == '\'') {
		for (current++; current < end; current++)
			if (*current == '\\') {
				current++;
			} else if (*current == '\'') {
				current++;
				break;
			}
		goto restart;
	}

	if (current < end - 1) {
		if (current[0..2] == "//") {
			for (current += 2; ; current++)
				if (current >= end || *current == '\n') {
					current++;
					goto restart;
				}
		}

		if (current[0..2] == "/*") {
			for (current += 2; ; current++)
				if (current >= end - 1
					  || (current[0..2] == "*/")) {
					current += 2;
					goto restart;
				}
		}

		if (current[0..2] == "/+") {
			char* commentStart = current;
			int depth = 1;

			for (current += 2; ; current++) {
				if (current >= end - 1) {
					throw new Error("Unterminated /+...+/ comment");
				} else if (current[0..2] == "/+") {
					current++;
					depth++;
				} else if (current[0..2] == "+/") {
					current++;
					depth--;
					if (!depth) {
						/*	remove comment
						 *	can be kept once Doxygen understands them
						 */
						commentStart[0..end-current]
						  = current[0..end-current].dup;
						end -= current - commentStart;
						current = commentStart;
						current[0] = ' ';
						goto restart;
					}
				}
			}
		}
	}

	current++;
	return ptoken[0..1];
}

// Print all text to this point, and set previous to the current point
void flush(char* p) {
	std.c.stdio.fwrite(previous, cast(int) (p - previous), 1, stdout);
	previous = current;
}

// Print all text to a set point, which becomes the new previous point
void flushTo(char* p) {
	std.c.stdio.fwrite(previous, cast(int) (p - previous), 1, stdout);
	previous = p;
}

// Consume a "{ ... }" or "(xxx) { ... }" block
void skipBlock(char* p) {
	char* o = previous;

	flush(p);

	int depth = 0;
	char[] t = token();

	if (t == "(") {
		while (1) {
			t = token();
			if (t == ")" || t == null)
				break;
		}
		t = token();
	}

	if (t != "{") {
		previous = p;
		flush(current);
		return;
	}

	while (1) {
		if (t == null)
			break;
		if (t == "{")
			depth++;
		if (t == "}") {
			depth--;
			if (depth == 0)
				break;
		}

		t = token();
	}

	previous = current;
}


int main(char[][] args) {
	if (args.length == 1) {
		writefln("Dfilter for Doxygen 1.4.2
%s FILENAME

Preprocesses the file in preparation for Doxygen.", args[0]);
		return 1;
	}

	try {
		debug (filename) derr.writefln("Filtering file %s", args[1]);
		data = cast(char[]) read(args[1]);

		// translate line breaks (to make output more readable for debugging)
		data = replace(data, "\r\n", "\n");
		data = replace(data, "\r", "\n");

		current = previous = data.ptr;
		end = previous + data.length;

		char[] t;
		bool elseif, readingContent;

		while ((t = token()) != null) {
			debug {
				derr.writefln("Token '%s', block level %d",
				  t, attrStack.length);
				derr.writefln("Pending write: '%s'",
				  previous[0..current - previous]);
				debug (step) {
					getch();
				}
			}

			// remove private blocks if they are on the module level
			if (attrStack.length == 0 && t == "private") {
				debug {
					fputs("entered remove module-level private block\n", stderr);
				}
				flushTo(ptoken);

				// FIXME: this doesn't work for constructs of the form
				// private:
				// public XXX;
				// <more private data>

				bool endReached = false;
				bool breakAfterDecl = true;
				uint tokenCount = 0;
				int blockLevel = 0;

				while (!endReached) {
					t = token();
					if (t == null)
						return 0;

					debug derr.writefln("Private token '%s', block level %d",
					  t, blockLevel);

					tokenCount++;

					switch (t) {
						case ":":
							if (tokenCount == 1)
								/*	do not break after next declaration;
								 *	instead we search for the next public
								 *	statement
								 */
								breakAfterDecl = false;
							break;
						case ";":
							if (blockLevel == 0 && breakAfterDecl)
								endReached = true;
							break;
						case "{":
							blockLevel++;
							break;
						case "}":
							blockLevel--;
							if (blockLevel == 0 && breakAfterDecl)
								endReached = true;
							break;
						case "public":
							if (blockLevel == 0) {
								writef("%s", t);
								endReached = true;
							}
							break;
						default:
							break;
					}
				}

				previous=current;
				debug {
					fputs("exited remove module-level private block\n", stderr);
				}
			}
			else switch (t) {
				// remove these keywords
				case "body":
					flush(ptoken);
					previous = current;
					break;

				// remove these blocks
				case "unittest":
				case "invariant":
				case "in":
				case "out":
					skipBlock(ptoken);
					break;

				// record attributes to support attr: or attr { ... } syntax
				case "export":
					currentAttr.protect = PROT.EXPORT;
					break;
				case "public":
					currentAttr.protect = PROT.PUBLIC;
					break;
				case "protected":
					currentAttr.protect = PROT.PROTECTED;
					break;
				case "package":
					currentAttr.protect = PROT.PACKAGE;
					break;
				case "private":
					currentAttr.protect = PROT.PRIVATE;
					break;
				case "deprecated":
					currentAttr.attr = ATTR.DEPRECATED;
					break;
				case "static":
					currentAttr.attr = ATTR.STATIC;
					break;
				case "abstract":
					currentAttr.attr = ATTR.ABSTRACT;
					break;
				case "final":
					currentAttr.attr = ATTR.FINAL;
					break;
				case "override":
					currentAttr.attr = ATTR.OVERRIDE;
					break;
				case "const":
					currentAttr.attr = ATTR.CONST;
					break;
				case "auto":
					currentAttr.attr = ATTR.AUTO;
					break;
				case "synchronized":
					currentAttr.attr = ATTR.SYNCHRONIZED;
					break;

				case ":":
					if (!readingContent) {
						currentBlockAttr = currentAttr;
						previous = current;
					}
					break;

				case ";":
					if (readingContent) {
						flush(current);
						currentAttr = currentBlockAttr;
						readingContent = false;
					}
					break;

				case "{":
					if (readingContent) {
						// is function/structure body
						flush(current);
						pushContentBlock();
						readingContent = false;
					} else {
						// is attribute block
						pushAttrBlock();
						flush(ptoken);
					}
					break;

				case "}":
					if (currentAttr.isContentBlock) {
						flush(current);
					} else {
						flush(ptoken);
					}
					currentAttr = currentBlockAttr
					  = attrStack[attrStack.length-1];
					attrStack.length = attrStack.length - 1;
					readingContent = false;
					break;

				// Change "version (...) { }" into "#ifdef ... and #endif"
				case "version": {
					char *o = previous;
					flush(ptoken);

					char[][] ver;
					int depth = 0;

					t = token();

					ver.length = 0;
					if (t == "(") {
						while (1) {
							t = token();
							if (t == ")" || t == null)
								break;
							ver.length = ver.length + 1;
							ver[length - 1] = t;
						}
						t = token();
					}

					if (elseif) {
						writefln("\n#elif VERSION_%s",
						  std.string.toupper(join(ver, "")));
					} else {
						writefln("\n#ifdef VERSION_%s",
						  std.string.toupper(join(ver, "")));
					}
					elseif = false;

					if (t == "{") {
						char *savec = current;
						while (1) {
							if (t == null)
								break;
							if (t == "{")
								depth++;
							if (t == "}") {
								depth--;
								if (depth == 0) {
									// We found the last '}', now remove it!
									*(current-1) = 0x01;
									current = savec;
									break;
								}
							}

							t = token();
						}

						previous = current;
					} else {
						previous = ptoken;

						// Parse until the next semicolon:
						while (1) {
							if (t == null)
								break;
							if (t == ";")
								break;
							t = token();
						}
						flush(current);
						writefln("\n#endif");
						previous = current;
					}
					break;
				}

				// marked end of version block
				case "\x01":
					flush(ptoken);

					if ((t = token()) != "else") {
						writefln("\n#endif");
						current = ptoken;
						break;
					}

					if ((t = token()) != "version") {
						elseif = false;
						writefln("\n#else");
						char *savec = current;
						int depth = 0;

						while (1) {
							if (t == null)
								break;
							if (t == "{")
								depth++;
							if (t == "}") {
								depth--;
								if (depth == 0) {
									// We found the last '}', now mark it!
									*(current-1) = 0x01;
									break;
								}
							}

							t = token();
						}
						ptoken = savec;
					} else {
						elseif = true;
					}
					previous = current = ptoken;
					break;

				// Remove "extern (...)" and "align (...)"
				case "extern":
				case "align":
				case "pragma":
					flush(ptoken);
					if ((t = token()) != "(") {
						current = ptoken;
						break;
					}

					while ((t = token()) != null)
						if (t == ")")
							break;
					previous = current;
					break;

				// "alias" into "typedef"
				case "alias":
					flush(ptoken);
					writef("%s typedef", currentAttr.toString);
					readingContent = true;
					previous = current;
					break;

				// "template name (x)" into "template namespace name <x>"
				case "template":
					flush(current);

					readingContent = true;
					writef("%s class", currentAttr.toString);

					while ((t = token()) != null)
						if (t == "(") {
							flush(ptoken);
							writef("<");
							previous = current;
						} else if (t == ")") {
							flush(ptoken);
							writef(">");
							previous = current;
							break;
						}

					while ((t = token()) != null)
						if (t == "{") {
							pushContentBlock();
							readingContent = false;
							flush(current);
							break;
						} else if (t == ";")
							break;
					break;

				/* "delegate (...) name" into "(*name) (...)". */
				case "function":
				case "delegate":
					flush(ptoken);
					previous = current;

					readingContent = true;
					writef("%s ", currentAttr.toString);

					while ((t = token()) != "(") {}

					// reach end of function signature
					uint bracketLevel = 1;
					while (bracketLevel != 0) {
						switch (t = token()) {
							case "(":
								bracketLevel++;
								break;
							case ")":
								bracketLevel--;
								break;
							default:
						}
					}
					t = token();
					if (t == "{") {
						/*	is function/delegate literal - don't need to
						 *	preserve so just do this
						 */
						writef("delegate {");
						pushContentBlock();
					} else {
						while (t == "[") {
							uint arrayLevel = 1;
							while (arrayLevel != 0) {
								switch (t = token()) {
									case "[":
										arrayLevel++;
										break;
									case "]":
										arrayLevel--;
										break;
									default:
								}
							}
							t = token();
						}
						writef("(*%s)", t);
					}

					flush(ptoken);
					previous = current;
					break;

				default:
					if (!readingContent) {
						readingContent = true;
						flushTo(ptoken);
						writef("%s ", currentAttr.toString);
					}
			}
		}
		flush(current);
		return 0;
	} catch (Object o) {
		derr.writefln("Error: %s", o.toString());
		return 1;
	}
}


enum PROT { NONE, PRIVATE, PACKAGE, PROTECTED, PUBLIC, EXPORT }
enum ATTR { DEPRECATED, STATIC, ABSTRACT, FINAL, OVERRIDE, CONST, AUTO,
  SYNCHRONIZED }

const char[][PROT.max + 1] PROT_WORD = [
	PROT.NONE:		"",
	PROT.PRIVATE:	"private",
	PROT.PACKAGE:	"package private",
		// because Doxygen doesn't recgonise "package"
	PROT.PROTECTED:	"protected",
	PROT.PUBLIC:	"public",
	PROT.EXPORT:	"export"
];

const char[][ATTR.max + 1] ATTR_WORD = [
	ATTR.DEPRECATED:	"deprecated",
	ATTR.STATIC:		"static",
	ATTR.ABSTRACT:		"abstract",
	ATTR.FINAL:			"final",
	ATTR.OVERRIDE:		"override",
	ATTR.CONST:			"const",
	ATTR.AUTO:			"auto",
	ATTR.SYNCHRONIZED:	"synchronized"
];

struct Attributes {
	PROT _protect = PROT.NONE;
	bool[ATTR.max + 1] _attr;
	bool isContentBlock = false;

	char[] toString() {
		char[] s = PROT_WORD[_protect];

		foreach (uint i, bool b; _attr) {
			if (b) s ~= " " ~ ATTR_WORD[i];
		}

		return s;
	}

	void protect(PROT p) {
		_protect = p;
		flush(ptoken);
	}

	void attr(ATTR a) {
		_attr[a] = true;
		flush(ptoken);
	}
}

Attributes currentAttr, currentBlockAttr;
Attributes[] attrStack;

void pushContentBlock() {
	attrStack ~= currentBlockAttr;
	currentAttr = Attributes.init;
	currentAttr.isContentBlock = true;
	currentBlockAttr = currentAttr;
}

void pushAttrBlock() {
	attrStack ~= currentBlockAttr;
	currentAttr.isContentBlock = false;
	currentBlockAttr = currentAttr;
}

// dfilter.d - modifications by James Dunne
// original author unknown/forgotten by me (feel free to give credit)

// These modifications allow version (identifier) { } else { } blocks
// to be replaced with corresponding C preprocessor #ifdef blocks which
// doxygen recognizes and interprets.  The identifiers are translated into
// all uppercase with a VERSION_ prefix.  An example should illustrate:

// version (server) {
//   code1
// } else version (client) {
//   code2
// } else {
//   code3
// }

// becomes:

// #ifdef VERSION_SERVER
//   code1
// #elif VERSION_CLIENT
//   code2
// #else
//   code3
// #endif

// Modifications have also been made to support D interfaces conversion
// into C++ classes.

import std.file, std.ctype, std.c.stdio, std.string;

char [] data; /* Data. */
char *c; /* Current point. */
char *s; /* Previous filter point. */
char *e; /* End of the data. */
char *p; /* Start of this token. */

/* Read in a token. */
char [] token ()
{
restart:
	p = c;

	if (c >= e)
		return null;

	if (isalpha (*c) || *c == '_')
	{
		for (c ++; c < e; c ++)
			if (!isalnum (*c) && *c != '_')
				break;

		return p [0 .. cast(int)(c - p)];
	}

	if (*c == ' ' || *c == '\r' || *c == '\n' || *c == '\t')
	{
		c ++;
		goto restart;
	}

	if (*c == '"')
	{
		for (c ++; c < e; c ++)
			if (*c == '\\')
				c ++;
			else if (*c == '"')
			{
				c ++;
				break;
			}
		goto restart;
	}

	if (*c == '\'')
	{
		for (c ++; c < e; c ++)
			if (*c == '\'')
			{
				c ++;
				break;
			}
		goto restart;
	}

	if (c < e - 1)
	{
		if (*c == '/' && c [1] == '/')
		{
			for (c += 2; ; c ++)
				if (c >= e || *c == '\n')
				{
					c ++;
					goto restart;
				}
		}
		
		if (*c == '/' && c [1] == '*')
		{
			for (c += 2; ; c ++)
				if (c >= e - 1 || (*c == '*' && c [1] == '/'))
				{
					c += 2;
					goto restart;
				}
		}

		if (*c == '/' && c [1] == '+')
		{
			int depth = 1;

			for (c += 2; ; c ++)
				if (c >= e - 1)
					goto restart;
				else if (*c == '/' && c [1] == '+')
				{
					c += 2;
					depth ++;
				}
				else if (*c == '+' && c [1] == '/')
				{
					c += 2;
					depth --;
					if (!depth)
						goto restart;
				}
		}
	}

	c ++;
	return p [0 .. 1];
}

/* Print all text to this point and set s to the current point. */
void flush (char *p)
{
	fwrite (s, cast(int)(p - s), 1, stdout);
	s = c;
}

/* Consume a "{ ... }" or "(xxx) { ... }" block. */
void skipBlock (char *p)
{
	char *o = s;

	flush (p);

	int depth = 0;
	char [] t = token ();

	if (t == "(")
	{
		while (1)
		{
			t = token ();
			if (t == ")" || t == null)
				break;
		} 
		t = token ();
	}

	if (t != "{")
	{
		s = p;
		flush (c);
		return;
	}

	while (1)
	{
		if (t == null)
			break;
		if (t == "{")
			depth ++;
		if (t == "}")
		{
			depth --;
			if (depth == 0)
				break;
		}

		t = token ();
	}

	s = c;
}

int main (char [] [] args)
{
	if (args.length == 1)
	{
		printf ("%.*s FILENAME\n\nPreprocesses the file in preparation for Doxygen.\n", args [0]);
		return 1;
	}
	
	data = cast(char []) read (args [1]);
	c = s = data;
	e = s + data.length;

	char [] t;
	char [] [] protectRecord;
	char [] protect = "public";
	char [] [] brackets;
	char [] nextOpenBracket;
	char [] nextSemiColon;
	bit insideBrackets, elseif;
	
	while (1)
	{
		t = token ();
		if (t == null)
		{
			flush (c);
			return 0;
		}

		switch (t)
		{
			/* Remove these keywords. */
			case "body":
				flush (p);
				s = c;
				break;

			/* Remove these blocks. */
			case "unittest":
			case "invariant":
			case "in":
			case "out":
				skipBlock (p);
				break;

			/* Remove "keyword:" but only if it is followed with a colon. */
			case "override":
			case "abstract":
			case "final":
				flush (p);
				if ((t = token ()) == ":")
					s = c;
				break;

			case ";":
				flush (c);
				printf ("%.*s", nextSemiColon);
				nextSemiColon = null;
				break;

			/* "keyword" without "keyword:" into "keyword: ... { ... } antikeyword:" */
			case "public":
			case "private":
			case "protected":
				flush (p);
				if (token () == ":")
				{
					printf ("%.*s", t);
					protect = t;
					break;
				}

				if (t != protect)
				{
					printf ("%.*s: ", t);
					s = p;
					nextOpenBracket = protect ~ ":";
					nextSemiColon = protect ~ ":";
				}
				break;
			
			/* Modify into "package". */
			/*Not necessary anymore
				case "module":
				flush (p);
				printf ("package ", nextSemiColon);
				s = c;
				break;*/
			
			/* Modify into import X.Y.*. */
			/* Not necessary anymore
			case "import":
				flush (p);
				printf ("import ", nextSemiColon);

				while ((t = token ()) != null)
				{
					if (t == ";")
					{
						printf (";");
						break;
					}
					else
						printf ("%.*s", t);
				}
				s = c;
				break;*/

			/* Change "version (...) { }" into "#ifdef ... and #endif" */
			case "version": {
					char *o = s;
					flush (p);

					char [] [] ver;

					int depth = 0;
					char [] t = token ();

					ver.length = 0;
					if (t == "(")
					{
						while (1)
						{
							t = token ();
							if (t == ")" || t == null)
								break;
							ver.length = ver.length + 1;
							ver[length - 1] = t;
						}
						t = token ();
					}

					if (elseif) {
						printf ("\n#elif VERSION_%.*s\n", std.string.toupper(join(ver, "")));
					} else {
						printf ("\n#ifdef VERSION_%.*s\n", std.string.toupper(join(ver, "")));
					}
					elseif = false;

					if (t == "{") {
						char *savec = c;
						while (1)
						{
							if (t == null)
								break;
							if (t == "{")
								depth ++;
							if (t == "}")
							{
								depth --;
								if (depth == 0) {
									// We found the last '}', now remove it!
									*(c-1) = 0x01;
									c = savec;
									break;
								}
							}

							t = token ();
						}

						s = c;
					} else {
						s = p;

						// Parse until the next semicolon:
						while (1) {
							if (t == null)
								break;
							if (t == ";")
								break;
							t = token();
						}
						flush (c);
						printf("\n#endif\n");
						s = c;
					}
					break;
				}

			case "\x01":
				flush(p);

				if ((t = token ()) != "else") {
					printf("\n#endif\n");
					c = p;
					break;
				}

				if ((t = token()) != "version") {
					elseif = false;
					printf("\n#else\n");
					char *savec = c;
					int depth = 0;

					while (1) {
						if (t == null)
							break;
						if (t == "{")
							depth ++;
						if (t == "}")
						{
							depth --;
							if (depth == 0) {
								// We found the last '}', now mark it!
								*(c-1) = 0x01;
								break;
							}
						}

						t = token ();
					}
					p = savec;
				} else {
					elseif = true;
				}
				s = c = p;
				break;

			/* Remove "extern (...)". */
			case "extern":
				flush (p);
				if ((t = token ()) != "(")
				{
					c = p;
					break;
				}

				while ((t = token ()) != null)
					if (t == ")")
						break;
				s = c;
				break;

			/* "alias" into "typedef". */
			case "alias":
				flush (p);
				printf ("typedef");
				s = c;
				break;

			/* "instance" into "typedef". */
			case "instance":
				flush (p);
				printf ("typedef");
				s = c;

				while ((t = token ()) != null)
					if (t == "(")
					{
						flush (p);
						printf ("<");
						s = c;
					}
					else if (t == ")")
					{
						flush (p);
						printf (">");
						s = c;
						break;
					}

				break;

			case "{":
				brackets ~= nextOpenBracket;
				nextOpenBracket = null;
				break;

			/* "}" into "};" */
			case "}":
				if (protectRecord.length)
				{
					protect = protectRecord [protectRecord.length - 1];
					protectRecord.length = protectRecord.length - 1;
				}

				flush (c);
				printf (";");
				if (brackets.length && brackets [brackets.length - 1])
				{
					printf (" %.*s", brackets [brackets.length - 1]);
					brackets = brackets [0 .. brackets.length - 1];
				}
				break;

			/* "class ... {" into "class ... { public:". */
			/*
			Not necessary anymore
			case "class":
			*/
			case "interface":
			{
				bit colon = false;

				flush (p);

				printf ("class");

				protectRecord ~= protect;
				protect = "public";

				while ((t = token ()) != null)
				{
				restart:
					if (t == ":" && !colon)
					{
						colon = true;
						t = token ();
						if (t != "public" && t != "private" && t != "protected")
						{
							flush (p);
							s = p;
							printf ("public ");
							goto restart;
						}
					}
					else if (t == ";")
						break;
					else if (t == "{")
					{
						flush (c);		
						printf (" public:");
						break;
					}
				}
				break;
			}

			/* "template name (x)" into "template namespace name <x>". */
			case "template": 
				protectRecord ~= protect;
				protect = "public";

				flush (c);
				printf (" class");
				while ((t = token ()) != null)
					if (t == "(")
					{
						flush (p);
						printf ("<");
						s = c;
					}
					else if (t == ")")
					{
						flush (p);
						printf (">");
						s = c;
						break;
					}

				while ((t = token ()) != null)
					if (t == "{")
					{
						flush (c);
						printf (" public:");
						break;
					}
					else if (t == ";")
						break;
				break;

			/* "delegate (...) name" into "(*name) (...)". */
			case "delegate":
				flush (p);
				s = c;
				while ((t = token ()) != null)
					if (t == ")")
					{
						t = token ();
						printf ("(*%.*s)", t);
						flush (p);
						s = c;
						break;
					}
				break;

			default:
				break;
		}
	}
}

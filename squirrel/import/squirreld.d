module squirreld;

private {
	import squirrel, sqstdlib;
	import std.c.stdarg, std.c.stdio;
}

class Squirrel {
	public HSQUIRRELVM vm;

	this() {
		vm = sq_open(1024);
		sq_pushroottable(vm);
		sqstd_seterrorhandlers(vm);
	}

	extern(C) static void printfunc(HSQUIRRELVM v, SQChar *s, ...) {
		va_list arglist;
		va_start(arglist, s);
		vprintf(cast(char *)s, arglist);
		va_end(arglist);
	}

	void setdefaultprintfunc() {
		setprintfunc(&Squirrel.printfunc);
	}

	extern(C) void setprintfunc(SQPRINTFUNCTION func) { sq_setprintfunc(vm, func); }
	extern(C) void vmcall(SQRESULT (*func)(HSQUIRRELVM)) { func(vm); }
	extern(C) void vmcall(void (*func)(HSQUIRRELVM)) { func(vm); }
	//extern(C) void register(void (*func)(HSQUIRRELVM)) { func(vm); }

	bool executeFile(char[] file) {
		sq_pushroottable(vm);
		if (SQ_FAILED(sqstd_dofile(vm, _SC(file), SQFalse, SQTrue))) {
			throw(new Exception(std.string.format("Can't execute file '%s'", file)));
		}
		return true;
	}

	bool execute(char[] data) {
		sq_pushroottable(vm);
		if (SQ_FAILED(sq_compilebuffer(vm, data.ptr, data.length, "buffer", true))) {
			throw(new Exception("Can't compile buffer"));
		}

		sq_push(vm, -2);
		if(SQ_SUCCEEDED(sq_call(vm, 1, SQTrue, SQTrue))) {
			sq_remove(vm, -2);
			return true;
		}
		sq_pop(vm, 1);

		return false;
	}

	SQRESULT call(char[] func, ...) {
		SQInteger top = sq_gettop(vm);
		sq_pushroottable(vm);

		sq_pushstring(vm, func, -1);
		if (SQ_FAILED(sq_get(vm, -2))) {
			sq_settop(vm, top);
			throw(new Exception(std.string.format("Function %s doesn't exists", func)));
		}

		sq_pushroottable(vm);

		va_list arglist = _argptr;

		TypeInfo primitiveTypeInfo(char m) {
			switch (m) {
				case 'v': return typeid(void);
				case 'b': return typeid(bit);
				case 'x': return typeid(bool);
				case 'g': return typeid(byte);
				case 'h': return typeid(ubyte);
				case 's': return typeid(short);
				case 't': return typeid(ushort);
				case 'i': return typeid(int);
				case 'k': return typeid(uint);
				case 'l': return typeid(long);
				case 'm': return typeid(ulong);
				case 'f': return typeid(float);
				case 'd': return typeid(double);
				case 'e': return typeid(real);
				case 'o': return typeid(ifloat);
				case 'p': return typeid(idouble);
				case 'j': return typeid(ireal);
				case 'q': return typeid(cfloat);
				case 'r': return typeid(cdouble);
				case 'c': return typeid(creal);
				case 'a': return typeid(char);
				case 'u': return typeid(wchar);
				case 'w': return typeid(dchar);
				default: return null;
			}
		}

		void pushTypeInfo(TypeInfo a, inout va_list arglist) {
			switch (a.classinfo.name[9]) {
				case 'b': // Tbit
					sq_pushbool(vm, va_arg!(bit)(arglist));
				break;
				case 'x': // Tbool
					sq_pushbool(vm, va_arg!(bool)(arglist));
				break;
				case 'd': // Tdouble
					sq_pushfloat(vm, va_arg!(double)(arglist));
				break;
				case 'f': // Tfloat
					sq_pushfloat(vm, va_arg!(float)(arglist));
				break;
				case 'h': // Tubyte
				case 'g': // Tbyte
					sq_pushinteger(vm, va_arg!(byte)(arglist));
				break;
				case 't': // Tushort
				case 's': // Tshort
					sq_pushinteger(vm, va_arg!(short)(arglist));
				break;
				case 'l': // Tlong
				case 'm': // Tulong
					sq_pushinteger(vm, va_arg!(long)(arglist));
				break;
				case 'e': // Treal
					sq_pushfloat(vm, va_arg!(real)(arglist));
				break;
				case 'o': // Tifloat
					sq_pushfloat(vm, cast(float)va_arg!(ifloat)(arglist));
				break;
				case 'p': // Tidouble
					sq_pushfloat(vm, cast(float)va_arg!(idouble)(arglist));
				break;
				case 'j': // Tireal
					sq_pushfloat(vm, cast(float)va_arg!(ireal)(arglist));
				break;
				case 'q': // Tcfloat
					sq_pushfloat(vm, cast(float)va_arg!(cfloat)(arglist));
				break;
				case 'r': // Tcdouble
					sq_pushfloat(vm, cast(float)va_arg!(cdouble)(arglist));
				break;
				case 'c': // Tcreal
					sq_pushfloat(vm, cast(float)va_arg!(creal)(arglist));
				break;
				case 'a': // Tchar
					sq_pushinteger(vm, va_arg!(char)(arglist));
				break;
				case 'u': // Twchar
					sq_pushinteger(vm, va_arg!(wchar)(arglist));
				break;
				case 'w': // Tdchar
					sq_pushinteger(vm, va_arg!(dchar)(arglist));
				break;
				case 'A': // Tarray
					if (a.classinfo.name.length == 14 && a.classinfo.name[9..14] == "Array")  {
						void[] va = va_arg!(void[])(arglist);
						void *p = va.ptr;
						int len = va.length;

						sq_newarray(vm, 0);

						size_t tsize = a.tsize();
						while (len--) {
							void *cp = p;
							pushTypeInfo((cast(TypeInfo_Array)a).next, cp);
							sq_arrayappend(vm, -2);

							p += tsize;
						}

						break;
					}

					if (a.classinfo.name.length >= 10) {
						switch (a.classinfo.name[10]) {
							case 'a':
								char[] s =  va_arg!(char[])(arglist);
								sq_pushstring(vm, s, s.length);
							break;
							case 'u':
								wchar[] s = va_arg!(wchar[])(arglist);
								sq_pushstring(vm, cast(char *)s, s.length);
							break;
							case 'w':
								dchar[] s = va_arg!(dchar[])(arglist);
								sq_pushstring(vm, cast(char *)s, s.length);
							break;
							default:
								void[] va = va_arg!(void[])(arglist);
								void *p = va.ptr;
								int len = va.length;

								sq_newarray(vm, 0);

								while (len--) {
									pushTypeInfo(primitiveTypeInfo(a.classinfo.name[10]), p);
									sq_arrayappend(vm, -2);
								}
							break;
						}
					}
				break;
				case 'G': // Tsarray
				case 'H': // Taarray
				case 'P': // Tpointer
				case 'F': // Tfunction
				case 'I': // Tident
				case 'C': // Tclass
				case 'S': // Tstruct
				case 'E': // Tenum
				case 'T': // Ttypedef
				case 'D': // Tdelegate
					sq_pushuserpointer(vm, cast(SQUserPointer *)va_arg!(int)(arglist));
				break;
				case 'k': // Tuint
				case 'i': // Tint
				default:
					sq_pushinteger(vm, va_arg!(int)(arglist));
					//_argptr
				break;
			}
		}

		foreach (TypeInfo a; _arguments) pushTypeInfo(a, arglist);

		sq_call(vm, _arguments.length + 1, SQFalse, SQTrue);

		sq_settop(vm, top);

		return true;
	}

	~this() {
		sq_close(vm);
	}
}

module	dtypes;

private import dlexer;

enum {
    STCundefined    = 0,
    STCstatic	    = 1,
    STCextern	    = 2,
    STCconst	    = 4,
    STCfinal	    = 8,
    STCabstract     = 0x10,
    STCparameter    = 0x20,
    STCfield	    = 0x40,
    STCoverride	    = 0x80,
    STCauto         = 0x100,
    STCsynchronized = 0x200,
    STCdeprecated   = 0x400,
    STCin           = 0x800,		// in parameter
    STCout          = 0x1000,		// out parameter
    STCforeach      = 0x2000,		// variable for foreach loop
    STCcomdat       = 0x4000,		// should go into COMDAT record
};

enum {
    PROTundefined,
    PROTnone,		// no access
    PROTprivate,
    PROTpackage,
    PROTprotected,
    PROTpublic,
    PROTexport,
};

enum {
	LINKdefault,
	LINKwindows,
	LINKpascal,
	LINKd,
	LINKc,
	LINKcpp
};

enum {
    Tarray,			// dynamic array
    Tsarray,		// static array
    Taarray,		// associative array
    Tpointer,
    Treference,
    Tfunction,
    Tident,
    Tclass,
    Tstruct,
    Tenum,
    Ttypedef,
    Tdelegate,

    Tnone,
    Tvoid,
    Tint8,
    Tuns8,
    Tint16,
    Tuns16,
    Tint32,
    Tuns32,
    Tint64,
    Tuns64,
    Tfloat32,
    Tfloat64,
    Tfloat80,

    Timaginary32,
    Timaginary64,
    Timaginary80,

    Tcomplex32,
    Tcomplex64,
    Tcomplex80,

    Tbit,
    Tchar,
    Twchar,
    Tdchar,

    Terror,
    Tinstance,
    Ttypeof,
    TMAX
};

enum {
    PSsemi = 1,     // empty ';' statements are allowed
    PSscope = 2,    // start a new scope
    PScurly = 4,    // { } statement is required
    PScurlyscope = 8,   // { } starts a new scope
};

enum {
	In,
	Out,
	InOut
};

// A dynamically growing array with some stack properties:
class ArrayT(mytype) {
	mytype[]	data;
	int			count;

	this() {
		count = 0;
		data.length = 0;
	}

	int dim() {
		return data.length;
	}

	void dim(int i) {
		data.length = i;
	}

	void reserve(int i) {
		if (data.length - count < i)
			data.length = count + i;
	}

	mytype pop() {
		return data[--count];
	}

	void push(mytype s) {
		reserve(1);
		data[count++] = s;
	}

	void append(ArrayT a) {
		data.length = count;
		data ~= a.data;
		count = data.length;
	}
}

class Id {
	static Identifier	Windows;
	static Identifier	Pascal;
	static Identifier	D;
	static Identifier	C;
	static Identifier	empty;
	static this() {
		Windows = new Identifier("Windows", 0);
		Pascal = new Identifier("Pascal", 0);
		D = new Identifier("D", 0);
		C = new Identifier("C", 0);
		empty = new Identifier("", 0);
	}
}

class Dsymbol {
	public:
		Identifier		id;
		Loc				loc;
		
		this(Loc loc, Identifier id) {
			this.loc = loc;
			this.id = id;
		}
}

alias ArrayT!(Dsymbol) Array;

class Type {
	static Type	tvoid;
	static Type tint8;
	static Type tuns8;
	static Type tint16;
	static Type tuns16;
	static Type tint32;
	static Type tuns32;
	static Type tint64;
	static Type tuns64;
	static Type tfloat32;
	static Type tfloat64;
	static Type tfloat80;
	static Type timaginary32;
	static Type timaginary64;
	static Type timaginary80;
	static Type tcomplex32;
	static Type tcomplex64;
	static Type tcomplex80;
	static Type tbit;
	static Type tchar;
	static Type twchar;
	static Type tdchar;

	Type	next;
	uint	ty;
}

class TypeQualified : Type {
	
}

class TypeTypeof : TypeQualified {
	public:
		this(Loc loc, Expression e) {
			super(loc, null);
		}
}

class TypePointer : TypeQualified {
	public:
		this(Type y) {
			
		}
}

class TypeInstance : TypeQualified {
	public:
		this(Loc loc, TemplateInstance ti) {
		}
}

class TypeIdentifier : TypeQualified {
	public:
		this(Loc loc, Identifier id) {
			
		}
}

class TypeDArray : TypeQualified {
	public:
		this(Type t) {
			
		}
}

class TypeAArray : TypeQualified {
	public:
		this(Type t, Type it) {
			
		}
}

class TypeSArray : TypeQualified {
	public:
		this(Type t, Expression e) {
			
		}
}

class TypeFunction : TypeQualified {
	public:
		this(Array a, Type t, int b, uint c) {
		
		}
}

class TypeDelegate : TypeQualified {
	public:
		this(Type t) {
		
		}
}

class Declaration : Dsymbol {
	public:
		uint	storage_class;

		this(Loc loc, Identifier id) {
			super(loc, id);
		}
}

class TypedefDeclaration : Declaration {
	public:
		this(Identifier id, Type t, Initializer iz) {

		}
}

class AggregateDeclaration : Declaration {
	public:
		Array	members;

		this(Loc loc, Identifier id) {
			super(loc, id);
			this.members = new Array();
		}
}

class StructDeclaration : AggregateDeclaration {
	public:
		this(Loc loc, Identifier id) {
			super(loc, id);
		}
}

class UnionDeclaration : AggregateDeclaration {
	public:
		this(Loc loc, Identifier id) {
			super(loc, id);
		}
}

class InterfaceDeclaration : AggregateDeclaration {
	public:
		this(Loc loc, Identifier id) {
			super(loc, id);
		}

		this(Loc loc, Identifier id, Array a) {
			super(loc, id);
		}
}

class ClassDeclaration : AggregateDeclaration {
	public:
		this(Loc loc, Identifier id) {
			super(loc, id);
		}

		this(Loc loc, Identifier id, Array a) {
			super(loc, id);
		}
}

class AnonDeclaration : AggregateDeclaration {
	public:
		this(Loc loc, Identifier id) {
			super(loc, id);
		}

		this(int i, Array a) {
			
		}
}

class FuncDeclaration : Declaration {
	public:
		Statement	fbody, frequire, fensure;
		Loc			endloc;
		Identifier	outId;

		this(Loc loc, int a, Identifier id, uint b, Type t) {
			super(loc, id);
		}
}

class CtorDeclaration : FuncDeclaration {
	public:
		this(Loc loc, int a, Array b, int c) {
			super(loc, null);
		}
}

class StaticCtorDeclaration : FuncDeclaration {
	public:
		this(Loc loc, int a, Array b, int c) {
			super(loc, null);
		}

		this(Loc loc, int level) {
		
		}
}

class DtorDeclaration : FuncDeclaration {
	public:
		this(Loc loc, Identifier id) {
			super(loc, id);
		}

		this(Loc loc, int level) {
		
		}
}

class StaticDtorDeclaration : FuncDeclaration {
	public:
		this(Loc loc, Identifier id) {
			super(loc, id);
		}
		
		this(Loc loc, int level) {
		
		}
}

class NewDeclaration : FuncDeclaration {
	public:
		this(Loc loc, Identifier id) {
			super(loc, id);
		}

		this(Loc loc, int a, Array b, int c) {
			super(loc, null);
		}
}

class DeleteDeclaration : FuncDeclaration {
	public:
		this(Loc loc, Identifier id) {
			super(loc, id);
		}

		this(Loc loc, int a, Array b) {
			super(loc, null);
		}
}

class BaseClass : Dsymbol {
	public:
		this(Type t, uint v) {

		}
}

class EnumMember : Dsymbol {
	public:
		this(Loc loc, Identifier id, Expression e) {
			super(loc, id);
		}
}

class EnumDeclaration : Declaration {
	public:
		ArrayT!(EnumMember)	members;

		this(Identifier id, Type t) {
			super(null, id);
		}
}

class TemplateParameter : Dsymbol {
	public:
		this(Loc loc, Identifier id, Type t) {
			super(loc, id);
		}
}

class TemplateAliasParameter : TemplateParameter {
	public:
		this(Loc loc, Identifier id, Type t) {
			super(loc, id, t);
		}
}

class TemplateTypeParameter : TemplateParameter {
	public:
		this(Loc loc, Identifier id, Type t, Type t2) {
			super(loc, id, t);
		}
}

class TemplateValueParameter : TemplateParameter {
	public:
		this(Loc loc, Identifier id, Type t, Expression e, Expression e2) {
			super(loc, id, t);
		}
}

class TemplateDeclaration : Declaration {
	public:
		this(Loc loc, Identifier id, Array a, Array b) {
			super(loc, id);
		}
}

class DebugSymbol : Dsymbol {
	public:
		uint	level;

		this(Identifier id) {
			super(null, id);
		}

		this(uint level) {
			this.level = level;
		}
}

class VersionSymbol : Dsymbol {
	public:
		uint	level;

		this(Identifier id) {
			super(null, id);
		}

		this(uint level) {
			this.level = level;
		}
}

class Import : Dsymbol {
	public:
		ArrayT!(Identifier)	imp;

		this(Loc loc, ArrayT!(Identifier) a, Identifier id) {
			super(loc, id);
			imp = a;
		}
}

class Initializer {
	public:
		this(Loc loc, Loc endloc) {
			
		}
}

class StructInitializer : Initializer {
	public:
		ArrayT!(Identifier)		field;
		ArrayT!(Initializer)	value;
		AggregateDeclaration	ad;
		
		this(Loc loc) {
			super(loc, null);
		}

		void addInit(Identifier field, Initializer value) {
			this.field.push(field);
			this.value.push(value);
		}
}

class ArrayInitializer : Initializer {
	public:
		ArrayT!(Expression)		index;
		ArrayT!(Initializer)	value;
		uint					dim;
		Type					type;
		
		this(Loc loc) {
			super(loc, null);
		}

		void addInit(Expression e, Initializer iz) {
			index.push(e);
			value.push(iz);
		}
}

class ExpInitializer : Initializer {
	public:
		Expression		exp;

		this(Loc loc, Expression e) {
			super(loc, null);
			exp = e;
		}
}


class VarDeclaration : Declaration {
	public:
		this(Loc loc, Type t, Identifier id, Initializer iz) {
			super(loc, id);
		}
}

class Statement {
	public:
		Loc		loc;

		this(Loc loc) {
			this.loc = loc;
		}
}

class ExpStatement : Statement {
	public:
		Expression	exp;

		this(Loc loc, Expression e) {
			super(loc);
			exp = e;
		}
}

class DeclarationStatement : ExpStatement {
	public:
		this(Loc loc, Dsymbol id) {
			super(loc);
		}
		this(Loc loc, Expression e) {
			super(loc, e);
		}
}

class CompoundStatement : Statement {
	public:
		ArrayT!(Statement)	statements;

		this(Loc loc, ArrayT!(Statement) s) {
			super(loc);
			statements = s;
		}
		this(Loc loc, Statement s1, Statement s2) {
			super(loc);
			statements = new ArrayT!(Statement);
			statements.push(s1);
			statements.push(s2);
		}
}

class Expression : Dsymbol {
	public:
		this(Loc loc, Identifier id) {
			super(loc, id);
		}
}

class StaticAssert : Dsymbol {
	public:
		this(Loc loc, Expression e) {
			super(loc, null);
		}
}

class UnitTestDeclaration : FuncDeclaration {
	public:
		this(Loc loc, Loc endloc) {
			super(loc, null);
		}
}

class TemplateMixin : Dsymbol {
	public:
		this(Loc loc, Identifier id, TypeTypeof t, ArrayT!(Identifier) a, Array b) {
			super(loc, id);
		}
}

class TemplateInstance : Dsymbol {
	public:
		Array	tiargs;

		this(Loc loc, Identifier id) {
			super(loc, id);
		}

		void addIdent(Identifier id) {
		
		}
}

class AliasDeclaration : Declaration {
	public:
		TemplateInstance	ti;

		this(Loc loc, Identifier id, TemplateInstance ti) {
			super(loc, id);
			this.ti = ti;
		}

		this(Loc loc, Identifier id, Type t) {
			super(loc, id);
		}
}

class InvariantDeclaration : FuncDeclaration {
	public:
		this(Loc loc, Identifier id) {
			super(loc, id);
		}
		
		this(Loc loc, int level) {
		
		}
}

class StorageClassDeclaration : Declaration {
	public:
		this(uint stc, Array a) {
			
		}
}

class ProtDeclaration : Declaration {
	public:
		this(uint prot, Array a) {
			
		}
}

class AlignDeclaration : Declaration {
	public:
		this(uint prot, Array a) {
			
		}
}

class PragmaDeclaration : Declaration {
	public:
		this(Identifier id, Array a, Array b) {
			
		}
}

class LinkDeclaration : Declaration {
	public:
		this(uint link, Array a) {
			
		}
}

// Conditions:

class DebugCondition : Dsymbol {
	public:
		uint	level;

		this(uint level, Identifier id) {
			super(null, id);
			this.level = level;
		}
}

class VersionCondition : Dsymbol {
	public:
		uint	level;

		this(uint level, Identifier id) {
			super(null, id);
			this.level = level;
		}
}

class DebugDeclaration : Declaration {
	public:
		this(DebugCondition dc, Array a, Array b) {
			
		}
}

class VersionDeclaration : Declaration {
	public:
		this(VersionCondition dc, Array a, Array b) {
			
		}
}

class Argument : Dsymbol {
	public:
		this(uint inoutt, Type a, Identifier id, Expression e) {
		}
}

class ScopeExp : Expression {
	public:
		this(Loc l, TemplateInstance ti) {
			super(loc, null);
		}
}
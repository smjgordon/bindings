module gmpp;
private import gmp;
private import std.string;
private import std.stdio;
/*object oriented interface to gmp*/
const BITS_PER_DIGIT = 3.32192809488736234787;
uint precision =  - 1;
class mpf
{
  mpf_t v;
  this()
  {
    initialise();
  }
  void initialise()
  {
    if (precision ==  - 1)
      mpf_init(&v);
    else
      mpf_init2(&v, precision);
  } 
  ~this()
  {
    mpf_clear(&v);
  } 
  this(uint val)
  {
    initialise();
    mpf_set_ui(&v, val);
  }
  this(int val)
  {
    initialise();
    mpf_set_si(&v, val);
  }
  this(double val)
  {
    initialise();
    mpf_set_d(&v, val);
  }
  
  
  template anop(alias f)  
  {
  	mpf anop()
  	{
     mpf n = new mpf();
     f (&n.v, &v);
     return n;
    }
  } 
  
  mpf opNeg()
  {
    mpf n = new mpf();
    mpf_neg (&n.v, &v);
    return n;
  } 
  
  mpf anopmpf(alias f)(mpf b)
  {
    mpf n = new mpf();
    f (&n.v, &v, &b.v);
    return n;
  } 
  mpf anopui(alias f)(uint val)
  {
    mpf n = new mpf();
    f (&n.v, &v, val);
    return n;
  } 
  alias anopmpf!(mpf_add) opAdd;
  alias anopui!(mpf_add_ui) opAdd;
  alias anopmpf!(mpf_sub) opSub;
  alias anopui!(mpf_sub_ui) opSub;
  alias anopmpf!(mpf_mul) opMul;
  alias anopmpf!(mpf_div) opDiv;
  alias anopui!(mpf_div_ui) opDiv;
  alias anopui!(mpf_mul_2exp) mul_2exp; 
  alias anopui!(mpf_div_2exp) div_2exp; 
  
  alias anop!(mpf_floor) floor;
  alias anop!(mpf_ceil) ceil;
  alias anop!(mpf_trunc) trunc;
  alias anop!(mpf_abs) abs;
  alias anop!(mpf_sqrt) sqrt;
 
  mpf opSub_r(uint val)
  {
    mpf n = new mpf();
    mpf_ui_sub (&n.v, val, &v);
    return n;
  } 
  
  mpf opMul(uint val)
  {
    mpf n = new mpf();
    mpf_mul_ui (&n.v, &v, val);
    return n;
  } 
  mpf opMul(int val)
  {
  //	writefln("here");
    mpf n = new mpf();
    if (val >= 0)
      mpf_mul_ui (&n.v, &v, val);
    else
    {
      mpf_mul_ui (&n.v, &v, - 1 * val);
      return n.opNeg();
    } 
    return n;
  } 
  
  mpf opDiv_r(uint val)
  {
    mpf n = new mpf();
    mpf_ui_div (&n.v, val, &v);
    return n;
  }
  
  char[] toString()
  {
    mp_exp_t expptr;
    uint prec = mpf_get_prec(&v);
    char[] curres = new char[cast(uint)(cast(float)prec / BITS_PER_DIGIT + 2.)];
    mpf_get_str (curres.ptr, &expptr, 10, 0, &v);
    
    char[] exp = std.string.toString(expptr - 1);
    if (exp[0] == '-') 
    { 
      if (curres[0] != '-')
        return curres[0]~"."~std.string.toString(curres[1..$].ptr)~"e"~exp;
      else
        return curres[0..2]~"."~std.string.toString(curres[2..$].ptr)~"e"~exp~"e";
    }
    else
    {
      if (curres[0] != '-')
        return curres[0]~"."~std.string.toString(curres[1..$].ptr)~"e+"~exp;
      else
        return curres[0..2]~"."~std.string.toString(curres[2..$].ptr)~"e+"~exp; 
    }
  } 
  
  
  uint precisionbits()
  {
    return mpf_get_prec(&v);
  } 
  void precisionbits(uint prec)
  {
    mpf_set_prec(&v, prec);
  } 
  uint precisiondigits()
  {
    return cast(uint)(cast(float)mpf_get_prec(&v) / BITS_PER_DIGIT + 0.9999999);
  } 
  void precisiondigits(uint digits)
  {
    mpf_set_prec(&v, cast(uint)(cast(float)digits * BITS_PER_DIGIT));
  } 
// Function: void mpf_set_z (mpf_t rop, mpz_t op)
// Function: void mpf_set_q (mpf_t rop, mpq_t op)		
  
} 


mpf sqrt_ui(uint a)
{
  mpf n = new mpf();
  mpf_sqrt_ui (&n.v, a);
  return n;
} 

mpf mpf_call(alias f)(mpf a)
{
  mpf n = new mpf();
  f (&n.v, &a.v);
  return n;
} 
alias mpf_call!(mpf_sqrt) sqrt;
alias mpf_call!(mpf_abs) abs;
alias mpf_call!(mpf_ceil) ceil;
alias mpf_call!(mpf_floor) floor;
alias mpf_call!(mpf_trunc) trunc;



version(test)
void main()
{
  writefln("unittest");
  mpf a = new mpf(2);
  writefln("a:", a);
  a = a * 2;
  writefln("2*a:", a);
  a = a / 2;
  writefln("2*a/2:", a);
  a = a + 3;
  writefln("a+3:", a);
  a = a * new mpf(4.1);
  writefln("a*4.1:", a);
  a = a - 8;
  writefln("a-8:", a);
  a = a * - 1; 
  writefln("a*-1:", a);
  a = - a; 
  writefln("-a:", a);
  a = 2 / a;
  writefln("2/a:", a);
  a = new mpf(2);
  writefln("sqrt(a):", sqrt(a));
  writefln("abs(-a)):", abs( - a));
  writefln("floor sqrt(a):", floor(sqrt(a)));
  writefln("ceil sqrt(a):", ceil(sqrt(a)));
  writefln("trunc sqrt(a):", trunc(sqrt(a)));
  precision = 400; // for new numbers and for temporal results
  writefln("precision=400 trunc sqrt(a):", trunc(sqrt(a)));
  a.precisionbits = 100;
  a = a + 1 / 3;
  writefln("a:", a," ", a.precisionbits," ", a.precisiondigits);
  a.precisionbits = 250;
  writefln("a:", a," ", a.precisionbits," ", a.precisiondigits);
  a.precisionbits = 300;
  writefln("a:", a," ", a.precisionbits," ", a.precisiondigits);
  a = new mpf(10000);
  writefln("a:", a," ", a.precisionbits," ", a.precisiondigits);
  writefln("floor.trunc.ceil.abs.sqrt a:", a.floor.trunc.ceil.abs.sqrt);
} 




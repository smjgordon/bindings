module gmp;
import std.c.stdlib;
import std.c.stdio;
extern (C)
{
const int __gmp_0 = 0;
int __gmp_junk;
/*void *_alloca(size_t size)
{
// return std.c.stdlib.alloca(size);
	char* v= cast(char*)std.c.stdlib.malloc(size);
	for (int i=0;i<size;i++)
	{
	 v[i]=cast(char)0;
	}
	return v;
//	return cast(char*)new void[size];
}*/
enum gmp_randalg_t:int
{
  GMP_RAND_ALG_DEFAULT = 0,
  GMP_RAND_ALG_LC = GMP_RAND_ALG_DEFAULT /* Linear congruential.  */
} ;
 extern  int __gmp_bits_per_limb;
alias __gmp_bits_per_limb mp_bits_per_limb;

 extern int __gmp_errno;
alias __gmp_errno gmp_errno;
 extern  char *  __gmp_version;

alias __gmp_version gmp_version;

const __GMP_BITS_PER_MP_LIMB=32;
const __GMP_HAVE_HOST_CPU_FAMILY_power=0;
const __GMP_HAVE_HOST_CPU_FAMILY_powerpc=0;
const GMP_LIMB_BITS=32;
const GMP_NAIL_BITS=0;
const GMP_NUMB_BITS=(GMP_LIMB_BITS - GMP_NAIL_BITS);
const GMP_NUMB_MASK=((~ cast(mp_limb_t)( 0)) >> GMP_NAIL_BITS);
const GMP_NUMB_MAX=GMP_NUMB_MASK;
const GMP_NAIL_MASK=(~ GMP_NUMB_MASK);
alias uint mp_limb_t;
alias int mp_limb_signed_t;
struct  __mpz_struct{
  int _mp_alloc;		/* Number of *limbs* allocated and pointed
				   to by the _mp_d field.  */
  int _mp_size;			/* abs(_mp_size) is the number of limbs the
				   last field points to.  If _mp_size is
				   negative this is a negative number.  */
  mp_limb_t *_mp_d;		/* Pointer to the limbs.  */
}
alias __mpz_struct MP_INT;
alias __mpz_struct mpz_t[1];
alias mp_limb_t * mp_ptr;
alias mp_limb_t * mp_srcptr;
const __GMP_MP_SIZE_T_INT=0;
alias int mp_size_t;
alias int mp_exp_t;
struct  __mpq_struct{
  __mpz_struct _mp_num;
  __mpz_struct _mp_den;
}
alias __mpq_struct MP_RAT;
alias __mpq_struct mpq_t[1];
struct  __mpf_struct{
  int _mp_prec;			/* Max precision, in number of `mp_limb_t's.
				   Set by mpf_init and modified by
				   mpf_set_prec.  The area pointed to by the
				   _mp_d field contains `prec' + 1 limbs.  */
  int _mp_size;			/* abs(_mp_size) is the number of limbs the
				   last field points to.  If _mp_size is
				   negative this is a negative number.  */
  mp_exp_t _mp_exp;		/* Exponent, in the base of `mp_limb_t'.  */
  mp_limb_t *_mp_d;		/* Pointer to the limbs.  */
}
alias __mpf_struct MP_FLOAT;
alias __mpf_struct mpf_t;
struct  __gmp_randstate_struct{
  mpz_t _mp_seed;	  /* _mp_d member points to state of the generator. */
  gmp_randalg_t _mp_alg;  /* Currently unused. */
  union _mp_algdata {
    void *_mp_lc;         /* Pointer to function pointers structure.  */
  };
}
alias __gmp_randstate_struct gmp_randstate_t[1];
alias __mpz_struct *mpz_srcptr;
alias __mpz_struct *mpz_ptr;
alias __mpf_struct *mpf_srcptr;
alias __mpf_struct *mpf_ptr;
alias __mpq_struct *mpq_srcptr;
alias __mpq_struct *mpq_ptr;
const __GMP_UINT_MAX=(~ cast(uint) 0);
const __GMP_ULONG_MAX=(~ cast(uint) 0);
const __GMP_USHRT_MAX=(cast(ushort) ~0);
/**************** Random number routines.  ****************/

/* obsolete */
alias __gmp_randinit gmp_randinit;
 void __gmp_randinit (gmp_randstate_t, gmp_randalg_t, ...);

alias __gmp_randinit_default gmp_randinit_default;
 void __gmp_randinit_default (gmp_randstate_t);

alias __gmp_randinit_lc_2exp gmp_randinit_lc_2exp;
 void __gmp_randinit_lc_2exp (gmp_randstate_t,
                                   mpz_srcptr, uint,
				   uint);

alias __gmp_randinit_lc_2exp_size gmp_randinit_lc_2exp_size;
 int __gmp_randinit_lc_2exp_size (gmp_randstate_t, uint);

alias __gmp_randinit_mt gmp_randinit_mt;
 void __gmp_randinit_mt (gmp_randstate_t);

alias __gmp_randinit_set gmp_randinit_set;
void __gmp_randinit_set (gmp_randstate_t,  __gmp_randstate_struct *);

alias __gmp_randseed gmp_randseed;
 void __gmp_randseed (gmp_randstate_t, mpz_srcptr);

alias __gmp_randseed_ui gmp_randseed_ui;
 void __gmp_randseed_ui (gmp_randstate_t, uint);

alias __gmp_randclear gmp_randclear;
 void __gmp_randclear (gmp_randstate_t);

alias __gmp_urandomb_ui gmp_urandomb_ui;
uint __gmp_urandomb_ui (gmp_randstate_t, uint);

alias __gmp_urandomm_ui gmp_urandomm_ui;
uint __gmp_urandomm_ui (gmp_randstate_t, uint);


/**************** Formatted output routines.  ****************/

alias __gmp_asprintf gmp_asprintf;
 int __gmp_asprintf (char **,  char *, ...);

alias __gmp_fprintf gmp_fprintf;

 int __gmp_fprintf (FILE *,  char *, ...);


alias __gmp_printf gmp_printf;
 int __gmp_printf ( char *, ...);

alias __gmp_snprintf gmp_snprintf;
 int __gmp_snprintf (char *, size_t,  char *, ...);

alias __gmp_sprintf gmp_sprintf;
 int __gmp_sprintf (char *,  char *, ...);

/**************** Formatted input routines.  ****************/

alias __gmp_fscanf gmp_fscanf;

 int __gmp_fscanf (FILE *,  char *, ...);


alias __gmp_scanf gmp_scanf;
 int __gmp_scanf ( char *, ...);

alias __gmp_sscanf gmp_sscanf;
 int __gmp_sscanf ( char *,  char *, ...);

/**************** Integer (i.e. Z) routines.  ****************/

 void *_mpz_realloc (mpz_ptr, mp_size_t);

alias __gmpz_abs mpz_abs;

 void __gmpz_abs (mpz_ptr, mpz_srcptr);


alias __gmpz_add mpz_add;
 void __gmpz_add (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_add_ui mpz_add_ui;
 void __gmpz_add_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_addmul mpz_addmul;
 void __gmpz_addmul (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_addmul_ui mpz_addmul_ui;
 void __gmpz_addmul_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_and mpz_and;
 void __gmpz_and (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_array_init mpz_array_init;
 void __gmpz_array_init (mpz_ptr, mp_size_t, mp_size_t);

alias __gmpz_bin_ui mpz_bin_ui;
 void __gmpz_bin_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_bin_uiui mpz_bin_uiui;
 void __gmpz_bin_uiui (mpz_ptr, uint, uint);

alias __gmpz_cdiv_q mpz_cdiv_q;
 void __gmpz_cdiv_q (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_cdiv_q_2exp mpz_cdiv_q_2exp;
 void __gmpz_cdiv_q_2exp (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_cdiv_q_ui mpz_cdiv_q_ui;
 uint __gmpz_cdiv_q_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_cdiv_qr mpz_cdiv_qr;
 void __gmpz_cdiv_qr (mpz_ptr, mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_cdiv_qr_ui mpz_cdiv_qr_ui;
 uint __gmpz_cdiv_qr_ui (mpz_ptr, mpz_ptr, mpz_srcptr, uint);

alias __gmpz_cdiv_r mpz_cdiv_r;
 void __gmpz_cdiv_r (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_cdiv_r_2exp mpz_cdiv_r_2exp;
 void __gmpz_cdiv_r_2exp (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_cdiv_r_ui mpz_cdiv_r_ui;
 uint __gmpz_cdiv_r_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_cdiv_ui mpz_cdiv_ui;
 uint __gmpz_cdiv_ui (mpz_srcptr, uint);

alias __gmpz_clear mpz_clear;
 void __gmpz_clear (mpz_ptr);

alias __gmpz_clrbit mpz_clrbit;
 void __gmpz_clrbit (mpz_ptr, uint);

alias __gmpz_cmp mpz_cmp;
 int __gmpz_cmp (mpz_srcptr, mpz_srcptr);

alias __gmpz_cmp_d mpz_cmp_d;
 int __gmpz_cmp_d (mpz_srcptr, double);

alias __gmpz_cmp_si _mpz_cmp_si;
 int __gmpz_cmp_si (mpz_srcptr, int);

alias __gmpz_cmp_ui _mpz_cmp_ui;
 int __gmpz_cmp_ui (mpz_srcptr, uint);

alias __gmpz_cmpabs mpz_cmpabs;
 int __gmpz_cmpabs (mpz_srcptr, mpz_srcptr);

alias __gmpz_cmpabs_d mpz_cmpabs_d;
 int __gmpz_cmpabs_d (mpz_srcptr, double);

alias __gmpz_cmpabs_ui mpz_cmpabs_ui;
 int __gmpz_cmpabs_ui (mpz_srcptr, uint);

alias __gmpz_com mpz_com;
 void __gmpz_com (mpz_ptr, mpz_srcptr);

alias __gmpz_combit mpz_combit;
 void __gmpz_combit (mpz_ptr, uint);

alias __gmpz_congruent_p mpz_congruent_p;
 int __gmpz_congruent_p (mpz_srcptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_congruent_2exp_p mpz_congruent_2exp_p;
 int __gmpz_congruent_2exp_p (mpz_srcptr, mpz_srcptr, uint);

alias __gmpz_congruent_ui_p mpz_congruent_ui_p;
 int __gmpz_congruent_ui_p (mpz_srcptr, uint, uint);

alias __gmpz_divexact mpz_divexact;
 void __gmpz_divexact (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_divexact_ui mpz_divexact_ui;
 void __gmpz_divexact_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_divisible_p mpz_divisible_p;
 int __gmpz_divisible_p (mpz_srcptr, mpz_srcptr);

alias __gmpz_divisible_ui_p mpz_divisible_ui_p;
 int __gmpz_divisible_ui_p (mpz_srcptr, uint);

alias __gmpz_divisible_2exp_p mpz_divisible_2exp_p;
 int __gmpz_divisible_2exp_p (mpz_srcptr, uint);

alias __gmpz_dump mpz_dump;
 void __gmpz_dump (mpz_srcptr);

alias __gmpz_export mpz_export;
 void *__gmpz_export (void *, size_t *, int, size_t, int, size_t, mpz_srcptr);

alias __gmpz_fac_ui mpz_fac_ui;
 void __gmpz_fac_ui (mpz_ptr, uint);

alias __gmpz_fdiv_q mpz_fdiv_q;
 void __gmpz_fdiv_q (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_fdiv_q_2exp mpz_fdiv_q_2exp;
 void __gmpz_fdiv_q_2exp (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_fdiv_q_ui mpz_fdiv_q_ui;
 uint __gmpz_fdiv_q_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_fdiv_qr mpz_fdiv_qr;
 void __gmpz_fdiv_qr (mpz_ptr, mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_fdiv_qr_ui mpz_fdiv_qr_ui;
 uint __gmpz_fdiv_qr_ui (mpz_ptr, mpz_ptr, mpz_srcptr, uint);

alias __gmpz_fdiv_r mpz_fdiv_r;
 void __gmpz_fdiv_r (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_fdiv_r_2exp mpz_fdiv_r_2exp;
 void __gmpz_fdiv_r_2exp (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_fdiv_r_ui mpz_fdiv_r_ui;
 uint __gmpz_fdiv_r_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_fdiv_ui mpz_fdiv_ui;
 uint __gmpz_fdiv_ui (mpz_srcptr, uint);

alias __gmpz_fib_ui mpz_fib_ui;
 void __gmpz_fib_ui (mpz_ptr, uint);

alias __gmpz_fib2_ui mpz_fib2_ui;
 void __gmpz_fib2_ui (mpz_ptr, mpz_ptr, uint);

alias __gmpz_fits_sint_p mpz_fits_sint_p;
 int __gmpz_fits_sint_p (mpz_srcptr);

alias __gmpz_fits_slong_p mpz_fits_slong_p;
 int __gmpz_fits_slong_p (mpz_srcptr);

alias __gmpz_fits_sshort_p mpz_fits_sshort_p;
 int __gmpz_fits_sshort_p (mpz_srcptr);

alias __gmpz_fits_uint_p mpz_fits_uint_p;

 int __gmpz_fits_uint_p (mpz_srcptr);


alias __gmpz_fits_ulong_p mpz_fits_ulong_p;

 int __gmpz_fits_ulong_p (mpz_srcptr);


alias __gmpz_fits_ushort_p mpz_fits_ushort_p;

 int __gmpz_fits_ushort_p (mpz_srcptr);


alias __gmpz_gcd mpz_gcd;
 void __gmpz_gcd (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_gcd_ui mpz_gcd_ui;
 uint __gmpz_gcd_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_gcdext mpz_gcdext;
 void __gmpz_gcdext (mpz_ptr, mpz_ptr, mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_get_d mpz_get_d;
 double __gmpz_get_d (mpz_srcptr);

alias __gmpz_get_d_2exp mpz_get_d_2exp;
 double __gmpz_get_d_2exp (int *, mpz_srcptr);

alias __gmpz_get_si mpz_get_si;
 /* signed */ int __gmpz_get_si (mpz_srcptr);

alias __gmpz_get_str mpz_get_str;
 char *__gmpz_get_str (char *, int, mpz_srcptr);

alias __gmpz_get_ui mpz_get_ui;

 uint __gmpz_get_ui (mpz_srcptr);


alias __gmpz_getlimbn mpz_getlimbn;

 mp_limb_t __gmpz_getlimbn (mpz_srcptr, mp_size_t);


alias __gmpz_hamdist mpz_hamdist;
 uint __gmpz_hamdist (mpz_srcptr, mpz_srcptr);

alias __gmpz_import mpz_import;
 void __gmpz_import (mpz_ptr, size_t, int, size_t, int, size_t,  void *);

alias __gmpz_init mpz_init;
 void __gmpz_init (mpz_ptr);

alias __gmpz_init2 mpz_init2;
 void __gmpz_init2 (mpz_ptr, uint);

alias __gmpz_init_set mpz_init_set;
 void __gmpz_init_set (mpz_ptr, mpz_srcptr);

alias __gmpz_init_set_d mpz_init_set_d;
 void __gmpz_init_set_d (mpz_ptr, double);

alias __gmpz_init_set_si mpz_init_set_si;
 void __gmpz_init_set_si (mpz_ptr, int);

alias __gmpz_init_set_str mpz_init_set_str;
 int __gmpz_init_set_str (mpz_ptr,  char *, int);

alias __gmpz_init_set_ui mpz_init_set_ui;
 void __gmpz_init_set_ui (mpz_ptr, uint);

alias __gmpz_inp_raw mpz_inp_raw;

 size_t __gmpz_inp_raw (mpz_ptr, FILE *);


alias __gmpz_inp_str mpz_inp_str;

 size_t __gmpz_inp_str (mpz_ptr, FILE *, int);


alias __gmpz_invert mpz_invert;
 int __gmpz_invert (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_ior mpz_ior;
 void __gmpz_ior (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_jacobi mpz_jacobi;
 int __gmpz_jacobi (mpz_srcptr, mpz_srcptr);

alias mpz_jacobi mpz_kronecker;

alias __gmpz_kronecker_si mpz_kronecker_si;
 int __gmpz_kronecker_si (mpz_srcptr, long);

alias __gmpz_kronecker_ui mpz_kronecker_ui;
 int __gmpz_kronecker_ui (mpz_srcptr, uint);

alias __gmpz_si_kronecker mpz_si_kronecker;
 int __gmpz_si_kronecker (long, mpz_srcptr);

alias __gmpz_ui_kronecker mpz_ui_kronecker;
 int __gmpz_ui_kronecker (uint, mpz_srcptr);

alias __gmpz_lcm mpz_lcm;
 void __gmpz_lcm (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_lcm_ui mpz_lcm_ui;
 void __gmpz_lcm_ui (mpz_ptr, mpz_srcptr, uint);

alias mpz_jacobi mpz_legendre;

alias __gmpz_lucnum_ui mpz_lucnum_ui;
 void __gmpz_lucnum_ui (mpz_ptr, uint);

alias __gmpz_lucnum2_ui mpz_lucnum2_ui;
 void __gmpz_lucnum2_ui (mpz_ptr, mpz_ptr, uint);

alias __gmpz_millerrabin mpz_millerrabin;
 int __gmpz_millerrabin (mpz_srcptr, int);

alias __gmpz_mod mpz_mod;
 void __gmpz_mod (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias mpz_fdiv_r_ui mpz_mod_ui;

alias __gmpz_mul mpz_mul;
 void __gmpz_mul (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_mul_2exp mpz_mul_2exp;
 void __gmpz_mul_2exp (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_mul_si mpz_mul_si;
 void __gmpz_mul_si (mpz_ptr, mpz_srcptr, int);

alias __gmpz_mul_ui mpz_mul_ui;
 void __gmpz_mul_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_neg mpz_neg;

 void __gmpz_neg (mpz_ptr, mpz_srcptr);


alias __gmpz_nextprime mpz_nextprime;
 void __gmpz_nextprime (mpz_ptr, mpz_srcptr);

alias __gmpz_out_raw mpz_out_raw;

 size_t __gmpz_out_raw (FILE *, mpz_srcptr);


alias __gmpz_out_str mpz_out_str;

 size_t __gmpz_out_str (FILE *, int, mpz_srcptr);


alias __gmpz_perfect_power_p mpz_perfect_power_p;
 int __gmpz_perfect_power_p (mpz_srcptr);

alias __gmpz_perfect_square_p mpz_perfect_square_p;

 int __gmpz_perfect_square_p (mpz_srcptr);


alias __gmpz_popcount mpz_popcount;

 uint __gmpz_popcount (mpz_srcptr);


alias __gmpz_pow_ui mpz_pow_ui;
 void __gmpz_pow_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_powm mpz_powm;
 void __gmpz_powm (mpz_ptr, mpz_srcptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_powm_ui mpz_powm_ui;
 void __gmpz_powm_ui (mpz_ptr, mpz_srcptr, uint, mpz_srcptr);

alias __gmpz_probab_prime_p mpz_probab_prime_p;
 int __gmpz_probab_prime_p (mpz_srcptr, int);

alias __gmpz_random mpz_random;
 void __gmpz_random (mpz_ptr, mp_size_t);

alias __gmpz_random2 mpz_random2;
 void __gmpz_random2 (mpz_ptr, mp_size_t);

alias __gmpz_realloc2 mpz_realloc2;
 void __gmpz_realloc2 (mpz_ptr, uint);

alias __gmpz_remove mpz_remove;
 uint __gmpz_remove (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_root mpz_root;
 int __gmpz_root (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_rootrem mpz_rootrem;
 void __gmpz_rootrem (mpz_ptr,mpz_ptr, mpz_srcptr, uint);

alias __gmpz_rrandomb mpz_rrandomb;
 void __gmpz_rrandomb (mpz_ptr, gmp_randstate_t, uint);

alias __gmpz_scan0 mpz_scan0;
 uint __gmpz_scan0 (mpz_srcptr, uint);

alias __gmpz_scan1 mpz_scan1;
 uint __gmpz_scan1 (mpz_srcptr, uint);

alias __gmpz_set mpz_set;
 void __gmpz_set (mpz_ptr, mpz_srcptr);

alias __gmpz_set_d mpz_set_d;
 void __gmpz_set_d (mpz_ptr, double);

alias __gmpz_set_f mpz_set_f;
 void __gmpz_set_f (mpz_ptr, mpf_srcptr);

alias __gmpz_set_q mpz_set_q;

 void __gmpz_set_q (mpz_ptr, mpq_srcptr);


alias __gmpz_set_si mpz_set_si;
 void __gmpz_set_si (mpz_ptr, int);

alias __gmpz_set_str mpz_set_str;
 int __gmpz_set_str (mpz_ptr,  char *, int);

alias __gmpz_set_ui mpz_set_ui;
 void __gmpz_set_ui (mpz_ptr, uint);

alias __gmpz_setbit mpz_setbit;
 void __gmpz_setbit (mpz_ptr, uint);

alias __gmpz_size mpz_size;

 size_t __gmpz_size (mpz_srcptr);


alias __gmpz_sizeinbase mpz_sizeinbase;
 size_t __gmpz_sizeinbase (mpz_srcptr, int);

alias __gmpz_sqrt mpz_sqrt;
 void __gmpz_sqrt (mpz_ptr, mpz_srcptr);

alias __gmpz_sqrtrem mpz_sqrtrem;
 void __gmpz_sqrtrem (mpz_ptr, mpz_ptr, mpz_srcptr);

alias __gmpz_sub mpz_sub;
 void __gmpz_sub (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_sub_ui mpz_sub_ui;
 void __gmpz_sub_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_ui_sub mpz_ui_sub;
 void __gmpz_ui_sub (mpz_ptr, uint, mpz_srcptr);

alias __gmpz_submul mpz_submul;
 void __gmpz_submul (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_submul_ui mpz_submul_ui;
 void __gmpz_submul_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_swap mpz_swap;
 void __gmpz_swap (mpz_ptr, mpz_ptr);

alias __gmpz_tdiv_ui mpz_tdiv_ui;
 uint __gmpz_tdiv_ui (mpz_srcptr, uint);

alias __gmpz_tdiv_q mpz_tdiv_q;
 void __gmpz_tdiv_q (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_tdiv_q_2exp mpz_tdiv_q_2exp;
 void __gmpz_tdiv_q_2exp (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_tdiv_q_ui mpz_tdiv_q_ui;
 uint __gmpz_tdiv_q_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_tdiv_qr mpz_tdiv_qr;
 void __gmpz_tdiv_qr (mpz_ptr, mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_tdiv_qr_ui mpz_tdiv_qr_ui;
 uint __gmpz_tdiv_qr_ui (mpz_ptr, mpz_ptr, mpz_srcptr, uint);

alias __gmpz_tdiv_r mpz_tdiv_r;
 void __gmpz_tdiv_r (mpz_ptr, mpz_srcptr, mpz_srcptr);

alias __gmpz_tdiv_r_2exp mpz_tdiv_r_2exp;
 void __gmpz_tdiv_r_2exp (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_tdiv_r_ui mpz_tdiv_r_ui;
 uint __gmpz_tdiv_r_ui (mpz_ptr, mpz_srcptr, uint);

alias __gmpz_tstbit mpz_tstbit;
 int __gmpz_tstbit (mpz_srcptr, uint);

alias __gmpz_ui_pow_ui mpz_ui_pow_ui;
 void __gmpz_ui_pow_ui (mpz_ptr, uint, uint);

alias __gmpz_urandomb mpz_urandomb;
 void __gmpz_urandomb (mpz_ptr, gmp_randstate_t, uint);

alias __gmpz_urandomm mpz_urandomm;
 void __gmpz_urandomm (mpz_ptr, gmp_randstate_t, mpz_srcptr);

alias __gmpz_xor mpz_xor;
alias __gmpz_xor mpz_eor;
 void __gmpz_xor (mpz_ptr, mpz_srcptr, mpz_srcptr);


/**************** Rational (i.e. Q) routines.  ****************/

alias __gmpq_abs mpq_abs;

 void __gmpq_abs (mpq_ptr, mpq_srcptr);


alias __gmpq_add mpq_add;
 void __gmpq_add (mpq_ptr, mpq_srcptr, mpq_srcptr);

alias __gmpq_canonicalize mpq_canonicalize;
 void __gmpq_canonicalize (mpq_ptr);

alias __gmpq_clear mpq_clear;
 void __gmpq_clear (mpq_ptr);

alias __gmpq_cmp mpq_cmp;
 int __gmpq_cmp (mpq_srcptr, mpq_srcptr);

alias __gmpq_cmp_si _mpq_cmp_si;
 int __gmpq_cmp_si (mpq_srcptr, long, uint);

alias __gmpq_cmp_ui _mpq_cmp_ui;
 int __gmpq_cmp_ui (mpq_srcptr, uint, uint);

alias __gmpq_div mpq_div;
 void __gmpq_div (mpq_ptr, mpq_srcptr, mpq_srcptr);

alias __gmpq_div_2exp mpq_div_2exp;
 void __gmpq_div_2exp (mpq_ptr, mpq_srcptr, uint);

alias __gmpq_equal mpq_equal;
 int __gmpq_equal (mpq_srcptr, mpq_srcptr);

alias __gmpq_get_num mpq_get_num;
 void __gmpq_get_num (mpz_ptr, mpq_srcptr);

alias __gmpq_get_den mpq_get_den;
 void __gmpq_get_den (mpz_ptr, mpq_srcptr);

alias __gmpq_get_d mpq_get_d;
 double __gmpq_get_d (mpq_srcptr);

alias __gmpq_get_str mpq_get_str;
 char *__gmpq_get_str (char *, int, mpq_srcptr);

alias __gmpq_init mpq_init;
 void __gmpq_init (mpq_ptr);

alias __gmpq_inp_str mpq_inp_str;

 size_t __gmpq_inp_str (mpq_ptr, FILE *, int);


alias __gmpq_inv mpq_inv;
 void __gmpq_inv (mpq_ptr, mpq_srcptr);

alias __gmpq_mul mpq_mul;
 void __gmpq_mul (mpq_ptr, mpq_srcptr, mpq_srcptr);

alias __gmpq_mul_2exp mpq_mul_2exp;
 void __gmpq_mul_2exp (mpq_ptr, mpq_srcptr, uint);

alias __gmpq_neg mpq_neg;

 void __gmpq_neg (mpq_ptr, mpq_srcptr);


alias __gmpq_out_str mpq_out_str;

 size_t __gmpq_out_str (FILE *, int, mpq_srcptr);


alias __gmpq_set mpq_set;
 void __gmpq_set (mpq_ptr, mpq_srcptr);

alias __gmpq_set_d mpq_set_d;
 void __gmpq_set_d (mpq_ptr, double);

alias __gmpq_set_den mpq_set_den;
 void __gmpq_set_den (mpq_ptr, mpz_srcptr);

alias __gmpq_set_f mpq_set_f;
 void __gmpq_set_f (mpq_ptr, mpf_srcptr);

alias __gmpq_set_num mpq_set_num;
 void __gmpq_set_num (mpq_ptr, mpz_srcptr);

alias __gmpq_set_si mpq_set_si;
 void __gmpq_set_si (mpq_ptr, int, uint);

alias __gmpq_set_str mpq_set_str;
 int __gmpq_set_str (mpq_ptr,  char *, int);

alias __gmpq_set_ui mpq_set_ui;
 void __gmpq_set_ui (mpq_ptr, uint, uint);

alias __gmpq_set_z mpq_set_z;
 void __gmpq_set_z (mpq_ptr, mpz_srcptr);

alias __gmpq_sub mpq_sub;
 void __gmpq_sub (mpq_ptr, mpq_srcptr, mpq_srcptr);

alias __gmpq_swap mpq_swap;
 void __gmpq_swap (mpq_ptr, mpq_ptr);


/**************** Float (i.e. F) routines.  ****************/

alias __gmpf_abs mpf_abs;
 void __gmpf_abs (mpf_ptr, mpf_srcptr);

alias __gmpf_add mpf_add;
 void __gmpf_add (mpf_ptr, mpf_srcptr, mpf_srcptr);

alias __gmpf_add_ui mpf_add_ui;
 void __gmpf_add_ui (mpf_ptr, mpf_srcptr, uint);
alias __gmpf_ceil mpf_ceil;
 void __gmpf_ceil (mpf_ptr, mpf_srcptr);

alias __gmpf_clear mpf_clear;
 void __gmpf_clear (mpf_ptr);

alias __gmpf_cmp mpf_cmp;
 int __gmpf_cmp (mpf_srcptr, mpf_srcptr);

alias __gmpf_cmp_d mpf_cmp_d;
 int __gmpf_cmp_d (mpf_srcptr, double);

alias __gmpf_cmp_si mpf_cmp_si;
 int __gmpf_cmp_si (mpf_srcptr, int);

alias __gmpf_cmp_ui mpf_cmp_ui;
 int __gmpf_cmp_ui (mpf_srcptr, uint);

alias __gmpf_div mpf_div;
 void __gmpf_div (mpf_ptr, mpf_srcptr, mpf_srcptr);

alias __gmpf_div_2exp mpf_div_2exp;
 void __gmpf_div_2exp (mpf_ptr, mpf_srcptr, uint);

alias __gmpf_div_ui mpf_div_ui;
 void __gmpf_div_ui (mpf_ptr, mpf_srcptr, uint);

alias __gmpf_dump mpf_dump;
 void __gmpf_dump (mpf_srcptr);

alias __gmpf_eq mpf_eq;
 int __gmpf_eq (mpf_srcptr, mpf_srcptr, uint);

alias __gmpf_fits_sint_p mpf_fits_sint_p;
 int __gmpf_fits_sint_p (mpf_srcptr);

alias __gmpf_fits_slong_p mpf_fits_slong_p;
 int __gmpf_fits_slong_p (mpf_srcptr);

alias __gmpf_fits_sshort_p mpf_fits_sshort_p;
 int __gmpf_fits_sshort_p (mpf_srcptr);

alias __gmpf_fits_uint_p mpf_fits_uint_p;
 int __gmpf_fits_uint_p (mpf_srcptr);

alias __gmpf_fits_ulong_p mpf_fits_ulong_p;
 int __gmpf_fits_ulong_p (mpf_srcptr);

alias __gmpf_fits_ushort_p mpf_fits_ushort_p;
 int __gmpf_fits_ushort_p (mpf_srcptr);

alias __gmpf_floor mpf_floor;
 void __gmpf_floor (mpf_ptr, mpf_srcptr);

alias __gmpf_get_d mpf_get_d;
 double __gmpf_get_d (mpf_srcptr);

alias __gmpf_get_d_2exp mpf_get_d_2exp;
 double __gmpf_get_d_2exp (int *, mpf_srcptr);

alias __gmpf_get_default_prec mpf_get_default_prec;
 uint __gmpf_get_default_prec ();

alias __gmpf_get_prec mpf_get_prec;
 uint __gmpf_get_prec (mpf_srcptr);

alias __gmpf_get_si mpf_get_si;
 long __gmpf_get_si (mpf_srcptr);

alias __gmpf_get_str mpf_get_str;
 char *__gmpf_get_str (char *, mp_exp_t *, int, size_t, mpf_srcptr);

alias __gmpf_get_ui mpf_get_ui;
 uint __gmpf_get_ui (mpf_srcptr);

alias __gmpf_init mpf_init;
 void __gmpf_init (mpf_ptr);

alias __gmpf_init2 mpf_init2;
 void __gmpf_init2 (mpf_ptr, uint);

alias __gmpf_init_set mpf_init_set;
 void __gmpf_init_set (mpf_ptr, mpf_srcptr);

alias __gmpf_init_set_d mpf_init_set_d;
 void __gmpf_init_set_d (mpf_ptr, double);

alias __gmpf_init_set_si mpf_init_set_si;
 void __gmpf_init_set_si (mpf_ptr, int);

alias __gmpf_init_set_str mpf_init_set_str;
 int __gmpf_init_set_str (mpf_ptr,  char *, int);

alias __gmpf_init_set_ui mpf_init_set_ui;
 void __gmpf_init_set_ui (mpf_ptr, uint);

alias __gmpf_inp_str mpf_inp_str;

 size_t __gmpf_inp_str (mpf_ptr, FILE *, int);


alias __gmpf_integer_p mpf_integer_p;
 int __gmpf_integer_p (mpf_srcptr);

alias __gmpf_mul mpf_mul;
 void __gmpf_mul (mpf_ptr, mpf_srcptr, mpf_srcptr);

alias __gmpf_mul_2exp mpf_mul_2exp;
 void __gmpf_mul_2exp (mpf_ptr, mpf_srcptr, uint);

alias __gmpf_mul_ui mpf_mul_ui;
 void __gmpf_mul_ui (mpf_ptr, mpf_srcptr, uint);

alias __gmpf_neg mpf_neg;
 void __gmpf_neg (mpf_ptr, mpf_srcptr);

alias __gmpf_out_str mpf_out_str;

 size_t __gmpf_out_str (FILE *, int, size_t, mpf_srcptr);


alias __gmpf_pow_ui mpf_pow_ui;
 void __gmpf_pow_ui (mpf_ptr, mpf_srcptr, uint);

alias __gmpf_random2 mpf_random2;
 void __gmpf_random2 (mpf_ptr, mp_size_t, mp_exp_t);

alias __gmpf_reldiff mpf_reldiff;
 void __gmpf_reldiff (mpf_ptr, mpf_srcptr, mpf_srcptr);

alias __gmpf_set mpf_set;
 void __gmpf_set (mpf_ptr, mpf_srcptr);

alias __gmpf_set_d mpf_set_d;
 void __gmpf_set_d (mpf_ptr, double);

alias __gmpf_set_default_prec mpf_set_default_prec;
 void __gmpf_set_default_prec (uint);

alias __gmpf_set_prec mpf_set_prec;
 void __gmpf_set_prec (mpf_ptr, uint);

alias __gmpf_set_prec_raw mpf_set_prec_raw;
 void __gmpf_set_prec_raw (mpf_ptr, uint);

alias __gmpf_set_q mpf_set_q;
 void __gmpf_set_q (mpf_ptr, mpq_srcptr);

alias __gmpf_set_si mpf_set_si;
 void __gmpf_set_si (mpf_ptr, int);

alias __gmpf_set_str mpf_set_str;
 int __gmpf_set_str (mpf_ptr,  char *, int);

alias __gmpf_set_ui mpf_set_ui;
 void __gmpf_set_ui (mpf_ptr, uint);

alias __gmpf_set_z mpf_set_z;
 void __gmpf_set_z (mpf_ptr, mpz_srcptr);

alias __gmpf_size mpf_size;
 size_t __gmpf_size (mpf_srcptr);

alias __gmpf_sqrt mpf_sqrt;
 void __gmpf_sqrt (mpf_ptr, mpf_srcptr);

alias __gmpf_sqrt_ui mpf_sqrt_ui;
 void __gmpf_sqrt_ui (mpf_ptr, uint);

alias __gmpf_sub mpf_sub;
 void __gmpf_sub (mpf_ptr, mpf_srcptr, mpf_srcptr);

alias __gmpf_sub_ui mpf_sub_ui;
 void __gmpf_sub_ui (mpf_ptr, mpf_srcptr, uint);

alias __gmpf_swap mpf_swap;
 void __gmpf_swap (mpf_ptr, mpf_ptr);

alias __gmpf_trunc mpf_trunc;
 void __gmpf_trunc (mpf_ptr, mpf_srcptr);

alias __gmpf_ui_div mpf_ui_div;
 void __gmpf_ui_div (mpf_ptr, uint, mpf_srcptr);

alias __gmpf_ui_sub mpf_ui_sub;
 void __gmpf_ui_sub (mpf_ptr, uint, mpf_srcptr);

alias __gmpf_urandomb mpf_urandomb;
 void __gmpf_urandomb (mpf_t, gmp_randstate_t, uint);


}

/* Converted to D from gsl_sf_gamma.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_gamma;
/* specfunc/gsl_sf_gamma.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Gerard Jungman
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

/* Author:  G. Jungman */

public import gsl.gsl_sf_result;

/* Log[Gamma(x)], x not a negative integer
 * Uses real Lanczos method.
 * Returns the real part of Log[Gamma[x]] when x < 0,
 * i.e. Log[|Gamma[x]|].
 *
 * exceptions: GSL_EDOM, GSL_EROUND
 */

extern (C):
int  gsl_sf_lngamma_e(double x, gsl_sf_result *result);

double  gsl_sf_lngamma(double x);

/* Log[Gamma(x)], x not a negative integer
 * Uses real Lanczos method. Determines
 * the sign of Gamma[x] as well as Log[|Gamma[x]|] for x < 0.
 * So Gamma[x] = sgn * Exp[result_lg].
 *
 * exceptions: GSL_EDOM, GSL_EROUND
 */

int  gsl_sf_lngamma_sgn_e(double x, gsl_sf_result *result_lg, double *sgn);

/* Gamma(x), x not a negative integer
 * Uses real Lanczos method.
 *
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EROUND
 */

int  gsl_sf_gamma_e(double x, gsl_sf_result *result);

double  gsl_sf_gamma(double x);

/* Regulated Gamma Function, x > 0
 * Gamma^*(x) = Gamma(x)/(Sqrt[2Pi] x^(x-1/2) exp(-x))
 *            = (1 + 1/(12x) + ...),  x->Inf
 * A useful suggestion of Temme.
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_gammastar_e(double x, gsl_sf_result *result);

double  gsl_sf_gammastar(double x);

/* 1/Gamma(x)
 * Uses real Lanczos method.
 *
 * exceptions: GSL_EUNDRFLW, GSL_EROUND
 */

int  gsl_sf_gammainv_e(double x, gsl_sf_result *result);

double  gsl_sf_gammainv(double x);

/* Log[Gamma(z)] for z complex, z not a negative integer
 * Uses complex Lanczos method. Note that the phase part (arg)
 * is not well-determined when |z| is very large, due
 * to inevitable roundoff in restricting to (-Pi,Pi].
 * This will raise the GSL_ELOSS exception when it occurs.
 * The absolute value part (lnr), however, never suffers.
 *
 * Calculates:
 *   lnr = log|Gamma(z)|
 *   arg = arg(Gamma(z))  in (-Pi, Pi]
 *
 * exceptions: GSL_EDOM, GSL_ELOSS
 */

int  gsl_sf_lngamma_complex_e(double zr, double zi, gsl_sf_result *lnr, gsl_sf_result *arg);

/* x^n / n!
 *
 * x >= 0.0, n >= 0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_taylorcoeff_e(int n, double x, gsl_sf_result *result);

double  gsl_sf_taylorcoeff(int n, double x);

/* n!
 *
 * exceptions: GSL_EDOM, GSL_OVRFLW
 */

int  gsl_sf_fact_e(uint n, gsl_sf_result *result);

double  gsl_sf_fact(uint n);

/* n!! = n(n-2)(n-4) ... 
 *
 * exceptions: GSL_EDOM, GSL_OVRFLW
 */

int  gsl_sf_doublefact_e(uint n, gsl_sf_result *result);

double  gsl_sf_doublefact(uint n);

/* log(n!) 
 * Faster than ln(Gamma(n+1)) for n < 170; defers for larger n.
 *
 * exceptions: none
 */

int  gsl_sf_lnfact_e(uint n, gsl_sf_result *result);

double  gsl_sf_lnfact(uint n);

/* log(n!!) 
 *
 * exceptions: none
 */

int  gsl_sf_lndoublefact_e(uint n, gsl_sf_result *result);

double  gsl_sf_lndoublefact(uint n);

/* log(n choose m)
 *
 * exceptions: GSL_EDOM 
 */

int  gsl_sf_lnchoose_e(uint n, uint m, gsl_sf_result *result);

double  gsl_sf_lnchoose(uint n, uint m);

/* n choose m
 *
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_choose_e(uint n, uint m, gsl_sf_result *result);

double  gsl_sf_choose(uint n, uint m);

/* Logarithm of Pochhammer (Apell) symbol
 *   log( (a)_x )
 *   where (a)_x := Gamma[a + x]/Gamma[a]
 *
 * a > 0, a+x > 0
 *
 * exceptions:  GSL_EDOM
 */

int  gsl_sf_lnpoch_e(double a, double x, gsl_sf_result *result);

double  gsl_sf_lnpoch(double a, double x);

/* Logarithm of Pochhammer (Apell) symbol, with sign information.
 *   result = log( |(a)_x| )
 *   sgn    = sgn( (a)_x )
 *   where (a)_x := Gamma[a + x]/Gamma[a]
 *
 * a != neg integer, a+x != neg integer
 *
 * exceptions:  GSL_EDOM
 */

int  gsl_sf_lnpoch_sgn_e(double a, double x, gsl_sf_result *result, double *sgn);

/* Pochhammer (Apell) symbol
 *   (a)_x := Gamma[a + x]/Gamma[x]
 *
 * a != neg integer, a+x != neg integer
 *
 * exceptions:  GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_poch_e(double a, double x, gsl_sf_result *result);

double  gsl_sf_poch(double a, double x);

/* Relative Pochhammer (Apell) symbol
 *   ((a,x) - 1)/x
 *   where (a,x) = (a)_x := Gamma[a + x]/Gamma[a]
 *
 * exceptions:  GSL_EDOM
 */

int  gsl_sf_pochrel_e(double a, double x, gsl_sf_result *result);

double  gsl_sf_pochrel(double a, double x);

/* Normalized Incomplete Gamma Function
 *
 * Q(a,x) = 1/Gamma(a) Integral[ t^(a-1) e^(-t), {t,x,Infinity} ]
 *
 * a >= 0, x >= 0
 *   Q(a,0) := 1
 *   Q(0,x) := 0, x != 0
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_gamma_inc_Q_e(double a, double x, gsl_sf_result *result);

double  gsl_sf_gamma_inc_Q(double a, double x);

/* Complementary Normalized Incomplete Gamma Function
 *
 * P(a,x) = 1/Gamma(a) Integral[ t^(a-1) e^(-t), {t,0,x} ]
 *
 * a > 0, x >= 0
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_gamma_inc_P_e(double a, double x, gsl_sf_result *result);

double  gsl_sf_gamma_inc_P(double a, double x);

/* Non-normalized Incomplete Gamma Function
 *
 * Gamma(a,x) := Integral[ t^(a-1) e^(-t), {t,x,Infinity} ]
 *
 * x >= 0.0
 *   Gamma(a, 0) := Gamma(a)
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_gamma_inc_e(double a, double x, gsl_sf_result *result);

double  gsl_sf_gamma_inc(double a, double x);

/* Logarithm of Beta Function
 * Log[B(a,b)]
 *
 * a > 0, b > 0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_lnbeta_e(double a, double b, gsl_sf_result *result);

double  gsl_sf_lnbeta(double a, double b);

/* Beta Function
 * B(a,b)
 *
 * a > 0, b > 0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_beta_e(double a, double b, gsl_sf_result *result);

double  gsl_sf_beta(double a, double b);

/* Normalized Incomplete Beta Function
 * B_x(a,b)/B(a,b)
 *
 * a > 0, b > 0, 0 <= x <= 1
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_beta_inc_e(double a, double b, double x, gsl_sf_result *result);

double  gsl_sf_beta_inc(double a, double b, double x);

/* The maximum x such that gamma(x) is not
 * considered an overflow.
 */

const GSL_SF_GAMMA_XMAX = 171.0;
/* The maximum n such that gsl_sf_fact(n) does not give an overflow. */

const GSL_SF_FACT_NMAX = 170;
/* The maximum n such that gsl_sf_doublefact(n) does not give an overflow. */

const GSL_SF_DOUBLEFACT_NMAX = 297;


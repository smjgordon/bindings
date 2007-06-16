/* Converted to D from gsl_sf_bessel.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_bessel;
/* specfunc/gsl_sf_bessel.h
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

import tango.stdc.stdlib;

public import gsl.gsl_mode;

public import gsl.gsl_precision;

public import gsl.gsl_sf_result;

/* Regular Bessel Function J_0(x)
 *
 * exceptions: none
 */

extern (C):
int  gsl_sf_bessel_J0_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_J0(double x);

/* Regular Bessel Function J_1(x)
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_J1_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_J1(double x);

/* Regular Bessel Function J_n(x)
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_Jn_e(int n, double x, gsl_sf_result *result);

double  gsl_sf_bessel_Jn(int n, double x);

/* Regular Bessel Function J_n(x),  nmin <= n <= nmax
 *
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_Jn_array(int nmin, int nmax, double x, double *result_array);

/* Irregular Bessel function Y_0(x)
 *
 * x > 0.0
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_Y0_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_Y0(double x);

/* Irregular Bessel function Y_1(x)
 *
 * x > 0.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_Y1_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_Y1(double x);

/* Irregular Bessel function Y_n(x)
 *
 * x > 0.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_Yn_e(int n, double x, gsl_sf_result *result);

double  gsl_sf_bessel_Yn(int n, double x);

/* Irregular Bessel function Y_n(x), nmin <= n <= nmax
 *
 * x > 0.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_Yn_array(int nmin, int nmax, double x, double *result_array);

/* Regular modified Bessel function I_0(x)
 *
 * exceptions: GSL_EOVRFLW
 */

int  gsl_sf_bessel_I0_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_I0(double x);

/* Regular modified Bessel function I_1(x)
 *
 * exceptions: GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_I1_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_I1(double x);

/* Regular modified Bessel function I_n(x)
 *
 * exceptions: GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_In_e(int n, double x, gsl_sf_result *result);

double  gsl_sf_bessel_In(int n, double x);

/* Regular modified Bessel function  I_n(x) for n=nmin,...,nmax
 *
 * nmin >=0, nmax >= nmin
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_In_array(int nmin, int nmax, double x, double *result_array);

/* Scaled regular modified Bessel function
 *  exp(-|x|) I_0(x)
 *
 * exceptions: none
 */

int  gsl_sf_bessel_I0_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_I0_scaled(double x);

/* Scaled regular modified Bessel function
 *  exp(-|x|) I_1(x)
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_I1_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_I1_scaled(double x);

/* Scaled regular modified Bessel function
 *  exp(-|x|) I_n(x)
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_In_scaled_e(int n, double x, gsl_sf_result *result);

double  gsl_sf_bessel_In_scaled(int n, double x);

/* Scaled regular modified Bessel function
 *  exp(-|x|) I_n(x)  for n=nmin,...,nmax
 *
 * nmin >=0, nmax >= nmin
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_In_scaled_array(int nmin, int nmax, double x, double *result_array);

/* Irregular modified Bessel function K_0(x)
 *
 * x > 0.0
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_K0_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_K0(double x);

/* Irregular modified Bessel function K_1(x)
 *
 * x > 0.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_K1_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_K1(double x);

/* Irregular modified Bessel function K_n(x)
 *
 * x > 0.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_Kn_e(int n, double x, gsl_sf_result *result);

double  gsl_sf_bessel_Kn(int n, double x);

/* Irregular modified Bessel function  K_n(x)  for n=nmin,...,nmax
 *
 * x > 0.0, nmin >=0, nmax >= nmin
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_Kn_array(int nmin, int nmax, double x, double *result_array);

/* Scaled irregular modified Bessel function
 *  exp(x) K_0(x)
 *
 * x > 0.0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_bessel_K0_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_K0_scaled(double x);

/* Scaled irregular modified Bessel function
 *  exp(x) K_1(x)
 *
 * x > 0.0
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_K1_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_K1_scaled(double x);

/* Scaled irregular modified Bessel function
 *  exp(x) K_n(x)
 *
 * x > 0.0
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_Kn_scaled_e(int n, double x, gsl_sf_result *result);

double  gsl_sf_bessel_Kn_scaled(int n, double x);

/* Scaled irregular modified Bessel function  exp(x) K_n(x)  for n=nmin,...,nmax
 *
 * x > 0.0, nmin >=0, nmax >= nmin
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_Kn_scaled_array(int nmin, int nmax, double x, double *result_array);

/* Regular spherical Bessel function j_0(x) = sin(x)/x
 *
 * exceptions: none
 */

int  gsl_sf_bessel_j0_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_j0(double x);

/* Regular spherical Bessel function j_1(x) = (sin(x)/x - cos(x))/x
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_j1_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_j1(double x);

/* Regular spherical Bessel function j_2(x) = ((3/x^2 - 1)sin(x) - 3cos(x)/x)/x
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_j2_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_j2(double x);

/* Regular spherical Bessel function j_l(x)
 *
 * l >= 0, x >= 0.0
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_jl_e(int l, double x, gsl_sf_result *result);

double  gsl_sf_bessel_jl(int l, double x);

/* Regular spherical Bessel function j_l(x) for l=0,1,...,lmax
 *
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_jl_array(int lmax, double x, double *result_array);

/* Regular spherical Bessel function j_l(x) for l=0,1,...,lmax
 * Uses Steed's method.
 *
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_jl_steed_array(int lmax, double x, double *jl_x_array);

/* Irregular spherical Bessel function y_0(x)
 *
 * exceptions: none
 */

int  gsl_sf_bessel_y0_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_y0(double x);

/* Irregular spherical Bessel function y_1(x)
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_y1_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_y1(double x);

/* Irregular spherical Bessel function y_2(x)
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_y2_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_y2(double x);

/* Irregular spherical Bessel function y_l(x)
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_yl_e(int l, double x, gsl_sf_result *result);

double  gsl_sf_bessel_yl(int l, double x);

/* Irregular spherical Bessel function y_l(x) for l=0,1,...,lmax
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_yl_array(int lmax, double x, double *result_array);

/* Regular scaled modified spherical Bessel function
 *
 * Exp[-|x|] i_0(x)
 *
 * exceptions: none
 */

int  gsl_sf_bessel_i0_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_i0_scaled(double x);

/* Regular scaled modified spherical Bessel function
 *
 * Exp[-|x|] i_1(x)
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_i1_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_i1_scaled(double x);

/* Regular scaled modified spherical Bessel function
 *
 * Exp[-|x|] i_2(x)
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_i2_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_i2_scaled(double x);

/* Regular scaled modified spherical Bessel functions
 *
 * Exp[-|x|] i_l(x)
 *
 * i_l(x) = Sqrt[Pi/(2x)] BesselI[l+1/2,x]
 *
 * l >= 0
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_il_scaled_e(int l, double x, gsl_sf_result *result);

double  gsl_sf_bessel_il_scaled(int l, double x);

/* Regular scaled modified spherical Bessel functions
 *
 * Exp[-|x|] i_l(x)
 * for l=0,1,...,lmax
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_bessel_il_scaled_array(int lmax, double x, double *result_array);

/* Irregular scaled modified spherical Bessel function
 * Exp[x] k_0(x)
 *
 * x > 0.0
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_k0_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_k0_scaled(double x);

/* Irregular modified spherical Bessel function
 * Exp[x] k_1(x)
 *
 * x > 0.0
 * exceptions: GSL_EDOM, GSL_EUNDRFLW, GSL_EOVRFLW
 */

int  gsl_sf_bessel_k1_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_k1_scaled(double x);

/* Irregular modified spherical Bessel function
 * Exp[x] k_2(x)
 *
 * x > 0.0
 * exceptions: GSL_EDOM, GSL_EUNDRFLW, GSL_EOVRFLW
 */

int  gsl_sf_bessel_k2_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_bessel_k2_scaled(double x);

/* Irregular modified spherical Bessel function
 * Exp[x] k_l[x]
 *
 * k_l(x) = Sqrt[Pi/(2x)] BesselK[l+1/2,x]
 *
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_kl_scaled_e(int l, double x, gsl_sf_result *result);

double  gsl_sf_bessel_kl_scaled(int l, double x);

/* Irregular scaled modified spherical Bessel function
 * Exp[x] k_l(x)
 *
 * for l=0,1,...,lmax
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_kl_scaled_array(int lmax, double x, double *result_array);

/* Regular cylindrical Bessel function J_nu(x)
 *
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_Jnu_e(double nu, double x, gsl_sf_result *result);

double  gsl_sf_bessel_Jnu(double nu, double x);

/* Irregular cylindrical Bessel function Y_nu(x)
 *
 * exceptions:  
 */

int  gsl_sf_bessel_Ynu_e(double nu, double x, gsl_sf_result *result);

double  gsl_sf_bessel_Ynu(double nu, double x);

/* Regular cylindrical Bessel function J_nu(x)
 * evaluated at a series of x values. The array
 * contains the x values. They are assumed to be
 * strictly ordered and positive. The array is
 * over-written with the values of J_nu(x_i).
 *
 * exceptions: GSL_EDOM, GSL_EINVAL
 */

int  gsl_sf_bessel_sequence_Jnu_e(double nu, gsl_mode_t mode, size_t size, double *v);

/* Scaled modified cylindrical Bessel functions
 *
 * Exp[-|x|] BesselI[nu, x]
 * x >= 0, nu >= 0
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_bessel_Inu_scaled_e(double nu, double x, gsl_sf_result *result);

double  gsl_sf_bessel_Inu_scaled(double nu, double x);

/* Modified cylindrical Bessel functions
 *
 * BesselI[nu, x]
 * x >= 0, nu >= 0
 *
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_bessel_Inu_e(double nu, double x, gsl_sf_result *result);

double  gsl_sf_bessel_Inu(double nu, double x);

/* Scaled modified cylindrical Bessel functions
 *
 * Exp[+|x|] BesselK[nu, x]
 * x > 0, nu >= 0
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_bessel_Knu_scaled_e(double nu, double x, gsl_sf_result *result);

double  gsl_sf_bessel_Knu_scaled(double nu, double x);

/* Modified cylindrical Bessel functions
 *
 * BesselK[nu, x]
 * x > 0, nu >= 0
 *
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_bessel_Knu_e(double nu, double x, gsl_sf_result *result);

double  gsl_sf_bessel_Knu(double nu, double x);

/* Logarithm of modified cylindrical Bessel functions.
 *
 * Log[BesselK[nu, x]]
 * x > 0, nu >= 0
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_bessel_lnKnu_e(double nu, double x, gsl_sf_result *result);

double  gsl_sf_bessel_lnKnu(double nu, double x);

/* s'th positive zero of the Bessel function J_0(x).
 *
 * exceptions: 
 */

int  gsl_sf_bessel_zero_J0_e(uint s, gsl_sf_result *result);

double  gsl_sf_bessel_zero_J0(uint s);

/* s'th positive zero of the Bessel function J_1(x).
 *
 * exceptions: 
 */

int  gsl_sf_bessel_zero_J1_e(uint s, gsl_sf_result *result);

double  gsl_sf_bessel_zero_J1(uint s);

/* s'th positive zero of the Bessel function J_nu(x).
 *
 * exceptions: 
 */

int  gsl_sf_bessel_zero_Jnu_e(double nu, uint s, gsl_sf_result *result);

double  gsl_sf_bessel_zero_Jnu(double nu, uint s);


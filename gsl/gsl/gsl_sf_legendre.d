/* Converted to D from gsl_sf_legendre.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_legendre;
/* specfunc/gsl_sf_legendre.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2004 Gerard Jungman
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

/* P_l(x)   l >= 0; |x| <= 1
 *
 * exceptions: GSL_EDOM
 */

extern (C):
int  gsl_sf_legendre_Pl_e(int l, double x, gsl_sf_result *result);

double  gsl_sf_legendre_Pl(int l, double x);

/* P_l(x) for l=0,...,lmax; |x| <= 1
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_legendre_Pl_array(int lmax, double x, double *result_array);

/* P_l(x) and P_l'(x) for l=0,...,lmax; |x| <= 1
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_legendre_Pl_deriv_array(int lmax, double x, double *result_array, double *result_deriv_array);

/* P_l(x), l=1,2,3
 *
 * exceptions: none
 */

int  gsl_sf_legendre_P1_e(double x, gsl_sf_result *result);

int  gsl_sf_legendre_P2_e(double x, gsl_sf_result *result);

int  gsl_sf_legendre_P3_e(double x, gsl_sf_result *result);

double  gsl_sf_legendre_P1(double x);

double  gsl_sf_legendre_P2(double x);

double  gsl_sf_legendre_P3(double x);

/* Q_0(x), x > -1, x != 1
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_legendre_Q0_e(double x, gsl_sf_result *result);

double  gsl_sf_legendre_Q0(double x);

/* Q_1(x), x > -1, x != 1
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_legendre_Q1_e(double x, gsl_sf_result *result);

double  gsl_sf_legendre_Q1(double x);

/* Q_l(x), x > -1, x != 1, l >= 0
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_legendre_Ql_e(int l, double x, gsl_sf_result *result);

double  gsl_sf_legendre_Ql(int l, double x);

/* P_l^m(x)  m >= 0; l >= m; |x| <= 1.0
 *
 * Note that this function grows combinatorially with l.
 * Therefore we can easily generate an overflow for l larger
 * than about 150.
 *
 * There is no trouble for small m, but when m and l are both large,
 * then there will be trouble. Rather than allow overflows, these
 * functions refuse to calculate when they can sense that l and m are
 * too big.
 *
 * If you really want to calculate a spherical harmonic, then DO NOT
 * use this. Instead use legendre_sphPlm() below, which  uses a similar
 * recursion, but with the normalized functions.
 *
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_legendre_Plm_e(int l, int m, double x, gsl_sf_result *result);

double  gsl_sf_legendre_Plm(int l, int m, double x);

/* P_l^m(x)  m >= 0; l >= m; |x| <= 1.0
 * l=|m|,...,lmax
 *
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_legendre_Plm_array(int lmax, int m, double x, double *result_array);

/* P_l^m(x)  and d(P_l^m(x))/dx;  m >= 0; lmax >= m; |x| <= 1.0
 * l=|m|,...,lmax
 *
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_legendre_Plm_deriv_array(int lmax, int m, double x, double *result_array, double *result_deriv_array);

/* P_l^m(x), normalized properly for use in spherical harmonics
 * m >= 0; l >= m; |x| <= 1.0
 *
 * There is no overflow problem, as there is for the
 * standard normalization of P_l^m(x).
 *
 * Specifically, it returns:
 *
 *        sqrt((2l+1)/(4pi)) sqrt((l-m)!/(l+m)!) P_l^m(x)
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_legendre_sphPlm_e(int l, int m, double x, gsl_sf_result *result);

double  gsl_sf_legendre_sphPlm(int l, int m, double x);

/* sphPlm(l,m,x) values
 * m >= 0; l >= m; |x| <= 1.0
 * l=|m|,...,lmax
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_legendre_sphPlm_array(int lmax, int m, double x, double *result_array);

/* sphPlm(l,m,x) and d(sphPlm(l,m,x))/dx values
 * m >= 0; l >= m; |x| <= 1.0
 * l=|m|,...,lmax
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_legendre_sphPlm_deriv_array(int lmax, int m, double x, double *result_array, double *result_deriv_array);

/* size of result_array[] needed for the array versions of Plm
 * (lmax - m + 1)
 */

int  gsl_sf_legendre_array_size(int lmax, int m);

/* Irregular Spherical Conical Function
 * P^{1/2}_{-1/2 + I lambda}(x)
 *
 * x > -1.0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_conicalP_half_e(double lambda, double x, gsl_sf_result *result);

double  gsl_sf_conicalP_half(double lambda, double x);

/* Regular Spherical Conical Function
 * P^{-1/2}_{-1/2 + I lambda}(x)
 *
 * x > -1.0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_conicalP_mhalf_e(double lambda, double x, gsl_sf_result *result);

double  gsl_sf_conicalP_mhalf(double lambda, double x);

/* Conical Function
 * P^{0}_{-1/2 + I lambda}(x)
 *
 * x > -1.0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_conicalP_0_e(double lambda, double x, gsl_sf_result *result);

double  gsl_sf_conicalP_0(double lambda, double x);

/* Conical Function
 * P^{1}_{-1/2 + I lambda}(x)
 *
 * x > -1.0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_conicalP_1_e(double lambda, double x, gsl_sf_result *result);

double  gsl_sf_conicalP_1(double lambda, double x);

/* Regular Spherical Conical Function
 * P^{-1/2-l}_{-1/2 + I lambda}(x)
 *
 * x > -1.0, l >= -1
 * exceptions: GSL_EDOM
 */

int  gsl_sf_conicalP_sph_reg_e(int l, double lambda, double x, gsl_sf_result *result);

double  gsl_sf_conicalP_sph_reg(int l, double lambda, double x);

/* Regular Cylindrical Conical Function
 * P^{-m}_{-1/2 + I lambda}(x)
 *
 * x > -1.0, m >= -1
 * exceptions: GSL_EDOM
 */

int  gsl_sf_conicalP_cyl_reg_e(int m, double lambda, double x, gsl_sf_result *result);

double  gsl_sf_conicalP_cyl_reg(int m, double lambda, double x);

/* The following spherical functions are specializations
 * of Legendre functions which give the regular eigenfunctions
 * of the Laplacian on a 3-dimensional hyperbolic space.
 * Of particular interest is the flat limit, which is
 * Flat-Lim := {lambda->Inf, eta->0, lambda*eta fixed}.
 */
  
/* Zeroth radial eigenfunction of the Laplacian on the
 * 3-dimensional hyperbolic space.
 *
 * legendre_H3d_0(lambda,eta) := sin(lambda*eta)/(lambda*sinh(eta))
 * 
 * Normalization:
 * Flat-Lim legendre_H3d_0(lambda,eta) = j_0(lambda*eta)
 *
 * eta >= 0.0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_legendre_H3d_0_e(double lambda, double eta, gsl_sf_result *result);

double  gsl_sf_legendre_H3d_0(double lambda, double eta);

/* First radial eigenfunction of the Laplacian on the
 * 3-dimensional hyperbolic space.
 *
 * legendre_H3d_1(lambda,eta) :=
 *    1/sqrt(lambda^2 + 1) sin(lam eta)/(lam sinh(eta))
 *    (coth(eta) - lambda cot(lambda*eta))
 * 
 * Normalization:
 * Flat-Lim legendre_H3d_1(lambda,eta) = j_1(lambda*eta)
 *
 * eta >= 0.0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_legendre_H3d_1_e(double lambda, double eta, gsl_sf_result *result);

double  gsl_sf_legendre_H3d_1(double lambda, double eta);

/* l'th radial eigenfunction of the Laplacian on the
 * 3-dimensional hyperbolic space.
 *
 * Normalization:
 * Flat-Lim legendre_H3d_l(l,lambda,eta) = j_l(lambda*eta)
 *
 * eta >= 0.0, l >= 0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_legendre_H3d_e(int l, double lambda, double eta, gsl_sf_result *result);

double  gsl_sf_legendre_H3d(int l, double lambda, double eta);

/* Array of H3d(ell),  0 <= ell <= lmax
 */

int  gsl_sf_legendre_H3d_array(int lmax, double lambda, double eta, double *result_array);


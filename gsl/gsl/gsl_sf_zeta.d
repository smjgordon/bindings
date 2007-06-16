/* Converted to D from gsl_sf_zeta.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_zeta;
/* specfunc/gsl_sf_zeta.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004 Gerard Jungman
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

/* Riemann Zeta Function
 * zeta(n) = Sum[ k^(-n), {k,1,Infinity} ]
 *
 * n=integer, n != 1
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

extern (C):
int  gsl_sf_zeta_int_e(int n, gsl_sf_result *result);

double  gsl_sf_zeta_int(int n);

/* Riemann Zeta Function
 * zeta(x) = Sum[ k^(-s), {k,1,Infinity} ], s != 1.0
 *
 * s != 1.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_zeta_e(double s, gsl_sf_result *result);

double  gsl_sf_zeta(double s);

/* Riemann Zeta Function minus 1
 *   useful for evaluating the fractional part
 *   of Riemann zeta for large argument
 *
 * s != 1.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_zetam1_e(double s, gsl_sf_result *result);

double  gsl_sf_zetam1(double s);

/* Riemann Zeta Function minus 1 for integer arg
 *   useful for evaluating the fractional part
 *   of Riemann zeta for large argument
 *
 * s != 1.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_zetam1_int_e(int s, gsl_sf_result *result);

double  gsl_sf_zetam1_int(int s);

/* Hurwitz Zeta Function
 * zeta(s,q) = Sum[ (k+q)^(-s), {k,0,Infinity} ]
 *
 * s > 1.0, q > 0.0
 * exceptions: GSL_EDOM, GSL_EUNDRFLW, GSL_EOVRFLW
 */

int  gsl_sf_hzeta_e(double s, double q, gsl_sf_result *result);

double  gsl_sf_hzeta(double s, double q);

/* Eta Function
 * eta(n) = (1-2^(1-n)) zeta(n)
 *
 * exceptions: GSL_EUNDRFLW, GSL_EOVRFLW
 */

int  gsl_sf_eta_int_e(int n, gsl_sf_result *result);

double  gsl_sf_eta_int(int n);

/* Eta Function
 * eta(s) = (1-2^(1-s)) zeta(s)
 *
 * exceptions: GSL_EUNDRFLW, GSL_EOVRFLW
 */

int  gsl_sf_eta_e(double s, gsl_sf_result *result);

double  gsl_sf_eta(double s);


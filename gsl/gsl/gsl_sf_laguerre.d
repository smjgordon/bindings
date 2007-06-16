/* Converted to D from gsl_sf_laguerre.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_laguerre;
/* specfunc/gsl_sf_laguerre.h
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

/* L^a_n(x) = (a+1)_n / n! 1F1(-n,a+1,x) */

/* Evaluate generalized Laguerre polynomials
 * using explicit representations.
 *
 * exceptions: none
 */

extern (C):
int  gsl_sf_laguerre_1_e(double a, double x, gsl_sf_result *result);

int  gsl_sf_laguerre_2_e(double a, double x, gsl_sf_result *result);

int  gsl_sf_laguerre_3_e(double a, double x, gsl_sf_result *result);

double  gsl_sf_laguerre_1(double a, double x);

double  gsl_sf_laguerre_2(double a, double x);

double  gsl_sf_laguerre_3(double a, double x);

/* Evaluate generalized Laguerre polynomials.
 *
 * a > -1.0
 * n >= 0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_laguerre_n_e(int n, double a, double x, gsl_sf_result *result);

double  gsl_sf_laguerre_n(int n, double a, double x);


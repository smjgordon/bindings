/* Converted to D from gsl_sf_psi.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_psi;
/* specfunc/gsl_sf_psi.h
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

/* Poly-Gamma Functions
 *
 * psi(m,x) := (d/dx)^m psi(0,x) = (d/dx)^{m+1} log(gamma(x))
 */

/* Di-Gamma Function  psi(n) = psi(0,n)
 *
 * n > 0
 * exceptions: GSL_EDOM
 */

extern (C):
int  gsl_sf_psi_int_e(int n, gsl_sf_result *result);

double  gsl_sf_psi_int(int n);

/* Di-Gamma Function psi(x) = psi(0, x)
 *
 * x != 0.0, -1.0, -2.0, ...
 * exceptions: GSL_EDOM, GSL_ELOSS
 */

int  gsl_sf_psi_e(double x, gsl_sf_result *result);

double  gsl_sf_psi(double x);

/* Di-Gamma Function Re[psi(1 + I y)]
 *
 * exceptions: none
 */

int  gsl_sf_psi_1piy_e(double y, gsl_sf_result *result);

double  gsl_sf_psi_1piy(double y);

/* Tri-Gamma Function psi^(1)(n)
 *
 * n > 0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_psi_1_int_e(int n, gsl_sf_result *result);

double  gsl_sf_psi_1_int(int n);

/* Tri-Gamma Function psi^(1)(x)
 *
 * x != 0.0, -1.0, -2.0, ...
 * exceptions: GSL_EDOM, GSL_ELOSS
 */

int  gsl_sf_psi_1_e(double x, gsl_sf_result *result);

double  gsl_sf_psi_1(double x);

/* Poly-Gamma Function psi^(n)(x)
 *
 * n >= 0, x > 0.0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_psi_n_e(int n, double x, gsl_sf_result *result);

double  gsl_sf_psi_n(int n, double x);


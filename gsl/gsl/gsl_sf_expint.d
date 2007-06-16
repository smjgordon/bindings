/* Converted to D from gsl_sf_expint.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_expint;
/* specfunc/gsl_sf_expint.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002 Gerard Jungman
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

/* Author: G. Jungman */

public import gsl.gsl_sf_result;

/* E_1(x) := Re[ Integrate[ Exp[-xt]/t, {t,1,Infinity}] ]
 *
 * x != 0.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

extern (C):
int  gsl_sf_expint_E1_e(double x, gsl_sf_result *result);

double  gsl_sf_expint_E1(double x);

/* E_2(x) := Re[ Integrate[ Exp[-xt]/t^2, {t,1,Infinity}] ]
 *
 * x != 0.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_expint_E2_e(double x, gsl_sf_result *result);

double  gsl_sf_expint_E2(double x);

/* E_1_scaled(x) := exp(x) E_1(x)
 *
 * x != 0.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_expint_E1_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_expint_E1_scaled(double x);

/* E_2_scaled(x) := exp(x) E_2(x)
 *
 * x != 0.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_expint_E2_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_expint_E2_scaled(double x);

/* Ei(x) := - PV Integrate[ Exp[-t]/t, {t,-x,Infinity}]
 *       :=   PV Integrate[ Exp[t]/t, {t,-Infinity,x}]
 *
 * x != 0.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_expint_Ei_e(double x, gsl_sf_result *result);

double  gsl_sf_expint_Ei(double x);

/* Ei_scaled(x) := exp(-x) Ei(x)
 *
 * x != 0.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_expint_Ei_scaled_e(double x, gsl_sf_result *result);

double  gsl_sf_expint_Ei_scaled(double x);

/* Shi(x) := Integrate[ Sinh[t]/t, {t,0,x}]
 *
 * exceptions: GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_Shi_e(double x, gsl_sf_result *result);

double  gsl_sf_Shi(double x);

/* Chi(x) := Re[ M_EULER + log(x) + Integrate[(Cosh[t]-1)/t, {t,0,x}] ]
 *
 * x != 0.0
 * exceptions: GSL_EDOM, GSL_EOVRFLW, GSL_EUNDRFLW
 */

int  gsl_sf_Chi_e(double x, gsl_sf_result *result);

double  gsl_sf_Chi(double x);

/* Ei_3(x) := Integral[ Exp[-t^3], {t,0,x}]
 *
 * x >= 0.0
 * exceptions: GSL_EDOM
 */

int  gsl_sf_expint_3_e(double x, gsl_sf_result *result);

double  gsl_sf_expint_3(double x);

/* Si(x) := Integrate[ Sin[t]/t, {t,0,x}]
 *
 * exceptions: none
 */

int  gsl_sf_Si_e(double x, gsl_sf_result *result);

double  gsl_sf_Si(double x);

/* Ci(x) := -Integrate[ Cos[t]/t, {t,x,Infinity}]
 *
 * x > 0.0
 * exceptions: GSL_EDOM 
 */

int  gsl_sf_Ci_e(double x, gsl_sf_result *result);

double  gsl_sf_Ci(double x);

/* AtanInt(x) := Integral[ Arctan[t]/t, {t,0,x}]
 *
 *
 * exceptions:
 */

int  gsl_sf_atanint_e(double x, gsl_sf_result *result);

double  gsl_sf_atanint(double x);


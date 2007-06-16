/* Converted to D from gsl_sf_fermi_dirac.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_fermi_dirac;
/* specfunc/gsl_sf_fermi_dirac.h
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

/* Complete Fermi-Dirac Integrals:
 *
 *  F_j(x)   := 1/Gamma[j+1] Integral[ t^j /(Exp[t-x] + 1), {t,0,Infinity}]
 *
 *
 * Incomplete Fermi-Dirac Integrals:
 *
 *  F_j(x,b) := 1/Gamma[j+1] Integral[ t^j /(Exp[t-x] + 1), {t,b,Infinity}]
 */

/* Complete integral F_{-1}(x) = e^x / (1 + e^x)
 *
 * exceptions: GSL_EUNDRFLW
 */

extern (C):
int  gsl_sf_fermi_dirac_m1_e(double x, gsl_sf_result *result);

double  gsl_sf_fermi_dirac_m1(double x);

/* Complete integral F_0(x) = ln(1 + e^x)
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_fermi_dirac_0_e(double x, gsl_sf_result *result);

double  gsl_sf_fermi_dirac_0(double x);

/* Complete integral F_1(x)
 *
 * exceptions: GSL_EUNDRFLW, GSL_EOVRFLW
 */

int  gsl_sf_fermi_dirac_1_e(double x, gsl_sf_result *result);

double  gsl_sf_fermi_dirac_1(double x);

/* Complete integral F_2(x)
 *
 * exceptions: GSL_EUNDRFLW, GSL_EOVRFLW
 */

int  gsl_sf_fermi_dirac_2_e(double x, gsl_sf_result *result);

double  gsl_sf_fermi_dirac_2(double x);

/* Complete integral F_j(x)
 * for integer j
 *
 * exceptions: GSL_EUNDRFLW, GSL_EOVRFLW
 */

int  gsl_sf_fermi_dirac_int_e(int j, double x, gsl_sf_result *result);

double  gsl_sf_fermi_dirac_int(int j, double x);

/* Complete integral F_{-1/2}(x)
 *
 * exceptions: GSL_EUNDRFLW, GSL_EOVRFLW
 */

int  gsl_sf_fermi_dirac_mhalf_e(double x, gsl_sf_result *result);

double  gsl_sf_fermi_dirac_mhalf(double x);

/* Complete integral F_{1/2}(x)
 *
 * exceptions: GSL_EUNDRFLW, GSL_EOVRFLW
 */

int  gsl_sf_fermi_dirac_half_e(double x, gsl_sf_result *result);

double  gsl_sf_fermi_dirac_half(double x);

/* Complete integral F_{3/2}(x)
 *
 * exceptions: GSL_EUNDRFLW, GSL_EOVRFLW
 */

int  gsl_sf_fermi_dirac_3half_e(double x, gsl_sf_result *result);

double  gsl_sf_fermi_dirac_3half(double x);

/* Incomplete integral F_0(x,b) = ln(1 + e^(b-x)) - (b-x)
 *
 * exceptions: GSL_EUNDRFLW, GSL_EDOM
 */

int  gsl_sf_fermi_dirac_inc_0_e(double x, double b, gsl_sf_result *result);

double  gsl_sf_fermi_dirac_inc_0(double x, double b);


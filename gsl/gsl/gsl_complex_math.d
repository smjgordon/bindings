/* Converted to D from gsl_complex_math.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_complex_math;
/* complex/gsl_complex_math.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004 Jorma Olavi Tähtinen, Brian Gough
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

public import gsl.gsl_complex;

/* Complex numbers */

extern (C):
gsl_complex  gsl_complex_rect(double x, double y);

gsl_complex  gsl_complex_polar(double r, double theta);

/* Properties of complex numbers */

double  gsl_complex_arg(gsl_complex z);

double  gsl_complex_abs(gsl_complex z);

double  gsl_complex_abs2(gsl_complex z);

double  gsl_complex_logabs(gsl_complex z);

/* Complex arithmetic operators */

gsl_complex  gsl_complex_add(gsl_complex a, gsl_complex b);

gsl_complex  gsl_complex_sub(gsl_complex a, gsl_complex b);

gsl_complex  gsl_complex_mul(gsl_complex a, gsl_complex b);

gsl_complex  gsl_complex_div(gsl_complex a, gsl_complex b);
                                                           

gsl_complex  gsl_complex_add_real(gsl_complex a, double x);

gsl_complex  gsl_complex_sub_real(gsl_complex a, double x);

gsl_complex  gsl_complex_mul_real(gsl_complex a, double x);

gsl_complex  gsl_complex_div_real(gsl_complex a, double x);

gsl_complex  gsl_complex_add_imag(gsl_complex a, double y);

gsl_complex  gsl_complex_sub_imag(gsl_complex a, double y);

gsl_complex  gsl_complex_mul_imag(gsl_complex a, double y);

gsl_complex  gsl_complex_div_imag(gsl_complex a, double y);

gsl_complex  gsl_complex_conjugate(gsl_complex z);

gsl_complex  gsl_complex_inverse(gsl_complex a);

gsl_complex  gsl_complex_negative(gsl_complex a);

/* Elementary Complex Functions */

gsl_complex  gsl_complex_sqrt(gsl_complex z);

gsl_complex  gsl_complex_sqrt_real(double x);

gsl_complex  gsl_complex_pow(gsl_complex a, gsl_complex b);

gsl_complex  gsl_complex_pow_real(gsl_complex a, double b);

gsl_complex  gsl_complex_exp(gsl_complex a);

gsl_complex  gsl_complex_log(gsl_complex a);

gsl_complex  gsl_complex_log10(gsl_complex a);

gsl_complex  gsl_complex_log_b(gsl_complex a, gsl_complex b);

/* Complex Trigonometric Functions */

gsl_complex  gsl_complex_sin(gsl_complex a);

gsl_complex  gsl_complex_cos(gsl_complex a);

gsl_complex  gsl_complex_sec(gsl_complex a);

gsl_complex  gsl_complex_csc(gsl_complex a);

gsl_complex  gsl_complex_tan(gsl_complex a);

gsl_complex  gsl_complex_cot(gsl_complex a);

/* Inverse Complex Trigonometric Functions */

gsl_complex  gsl_complex_arcsin(gsl_complex a);

gsl_complex  gsl_complex_arcsin_real(double a);

gsl_complex  gsl_complex_arccos(gsl_complex a);

gsl_complex  gsl_complex_arccos_real(double a);

gsl_complex  gsl_complex_arcsec(gsl_complex a);

gsl_complex  gsl_complex_arcsec_real(double a);

gsl_complex  gsl_complex_arccsc(gsl_complex a);

gsl_complex  gsl_complex_arccsc_real(double a);

gsl_complex  gsl_complex_arctan(gsl_complex a);

gsl_complex  gsl_complex_arccot(gsl_complex a);

/* Complex Hyperbolic Functions */

gsl_complex  gsl_complex_sinh(gsl_complex a);

gsl_complex  gsl_complex_cosh(gsl_complex a);

gsl_complex  gsl_complex_sech(gsl_complex a);

gsl_complex  gsl_complex_csch(gsl_complex a);

gsl_complex  gsl_complex_tanh(gsl_complex a);

gsl_complex  gsl_complex_coth(gsl_complex a);

/* Inverse Complex Hyperbolic Functions */

gsl_complex  gsl_complex_arcsinh(gsl_complex a);

gsl_complex  gsl_complex_arccosh(gsl_complex a);

gsl_complex  gsl_complex_arccosh_real(double a);

gsl_complex  gsl_complex_arcsech(gsl_complex a);

gsl_complex  gsl_complex_arccsch(gsl_complex a);

gsl_complex  gsl_complex_arctanh(gsl_complex a);

gsl_complex  gsl_complex_arctanh_real(double a);

gsl_complex  gsl_complex_arccoth(gsl_complex a);


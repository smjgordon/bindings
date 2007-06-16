/* Converted to D from gsl_sys.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sys;
/* sys/gsl_sys.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Gerard Jungman, Brian Gough
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

extern (C):
double  gsl_log1p(double x);

double  gsl_expm1(double x);

double  gsl_hypot(double x, double y);

double  gsl_acosh(double x);

double  gsl_asinh(double x);

double  gsl_atanh(double x);

int  gsl_isnan(double x);

int  gsl_isinf(double x);

int  gsl_finite(double x);

double  gsl_nan();

double  gsl_posinf();

double  gsl_neginf();

double  gsl_fdiv(double x, double y);

double  gsl_coerce_double(double x);

float  gsl_coerce_float(float x);

real  gsl_coerce_long_double(real x);

double  gsl_ldexp(double x, int e);

double  gsl_frexp(double x, int *e);

int  gsl_fcmp(double x1, double x2, double epsilon);


/* Converted to D from gsl_complex.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_complex;
/* complex/gsl_complex.h
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

/* two consecutive built-in types as a complex number */

extern (C):
alias double *gsl_complex_packed;

alias float *gsl_complex_packed_float;

alias real *gsl_complex_packed_long_double;

alias double *gsl_const_complex_packed;

alias float *gsl_const_complex_packed_float;

alias real *gsl_const_complex_packed_long_double;

/* 2N consecutive built-in types as N complex numbers */

alias double *gsl_complex_packed_array;

alias float *gsl_complex_packed_array_float;

alias real *gsl_complex_packed_array_long_double;

alias double *gsl_const_complex_packed_array;

alias float *gsl_const_complex_packed_array_float;

alias real *gsl_const_complex_packed_array_long_double;

/* Yes... this seems weird. Trust us. The point is just that
   sometimes you want to make it obvious that something is
   an output value. The fact that it lacks a 'const' may not
   be enough of a clue for people in some contexts.
 */

alias double *gsl_complex_packed_ptr;

alias float *gsl_complex_packed_float_ptr;

alias real *gsl_complex_packed_long_double_ptr;

alias double *gsl_const_complex_packed_ptr;

alias float *gsl_const_complex_packed_float_ptr;

alias real *gsl_const_complex_packed_long_double_ptr;

struct gsl_complex_long_double
{
    real [2]dat;
};

struct gsl_complex
{
    double [2]dat;
};

struct gsl_complex_float
{
    float [2]dat;
};


/* Converted to D from gsl_math.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_math;
/* gsl_math.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004 Gerard Jungman, Brian Gough
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

import tango.stdc.math;

public import gsl.gsl_sys;

public import gsl.gsl_machine;

public import gsl.gsl_precision;

public import gsl.gsl_nan;

public import gsl.gsl_pow_int;

const M_SQRT3 = 1.73205080756887729352744634151;

const M_SQRTPI = 1.77245385090551602729816748334;

const M_LNPI = 1.14472988584940017414342735135;

const M_EULER = 0.57721566490153286060651209008;

/* other needlessly compulsive abstractions */

/* Return nonzero if x is a real number, i.e. non NaN or infinite. */

/* Define MAX and MIN macros/functions if they don't exist. */

/* plain old macros for general use */

/* function versions of the above, in case they are needed */

extern (C):
double  gsl_max(double a, double b);

double  gsl_min(double a, double b);

/* inline-friendly strongly typed versions */

/* Definition of an arbitrary function with parameters */

struct gsl_function_struct
{
    //double  function(double x, void *params) function;
    double function(double x, void *params) func;
    void *params;
}

alias gsl_function_struct gsl_function;

/* Definition of an arbitrary function returning two values, r1, r2 */

struct gsl_function_fdf_struct
{
    double  function(double x, void *params)f;
    double  function(double x, void *params)df;
    void  function(double x, void *params, double *f, double *df)fdf;
    void *params;
}

alias gsl_function_fdf_struct gsl_function_fdf;

/* Definition of an arbitrary vector-valued function with parameters */

struct gsl_function_vec_struct
{
    //int  function(double x, double *y, void *params)function;
    int  function(double x, double *y, void *params)func;
    void *params;
}

alias gsl_function_vec_struct gsl_function_vec;


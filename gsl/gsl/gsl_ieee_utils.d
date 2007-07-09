/* Converted to D from gsl_ieee_utils.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_ieee_utils;
/* ieee-utils/gsl_ieee_utils.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Brian Gough
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

import tango.stdc.stdio;

enum
{
    GSL_IEEE_TYPE_NAN = 1,
    GSL_IEEE_TYPE_INF,
    GSL_IEEE_TYPE_NORMAL,
    GSL_IEEE_TYPE_DENORMAL,
    GSL_IEEE_TYPE_ZERO,
}

extern (C):
struct gsl_ieee_float_rep
{
    int sign;
    char [24]mantissa;
    int exponent;
    int type;
};

struct gsl_ieee_double_rep
{
    int sign;
    char [53]mantissa;
    int exponent;
    int type;
};

void  gsl_ieee_printf_float(float *x);

void  gsl_ieee_printf_double(double *x);

void  gsl_ieee_fprintf_float(FILE *stream, float *x);

void  gsl_ieee_fprintf_double(FILE *stream, double *x);

void  gsl_ieee_float_to_rep(float *x, gsl_ieee_float_rep *r);

void  gsl_ieee_double_to_rep(double *x, gsl_ieee_double_rep *r);

enum
{
    GSL_IEEE_SINGLE_PRECISION = 1,
    GSL_IEEE_DOUBLE_PRECISION,
    GSL_IEEE_EXTENDED_PRECISION,
}

enum
{
    GSL_IEEE_ROUND_TO_NEAREST = 1,
    GSL_IEEE_ROUND_DOWN,
    GSL_IEEE_ROUND_UP,
    GSL_IEEE_ROUND_TO_ZERO,
}

enum
{
    GSL_IEEE_MASK_INVALID = 1,
    GSL_IEEE_MASK_DENORMALIZED,
    GSL_IEEE_MASK_DIVISION_BY_ZERO = 4,
    GSL_IEEE_MASK_OVERFLOW = 8,
    GSL_IEEE_MASK_UNDERFLOW = 16,
    GSL_IEEE_MASK_ALL = 31,
    GSL_IEEE_TRAP_INEXACT,
}

void  gsl_ieee_env_setup();

int  gsl_ieee_read_mode_string(char *description, int *precision, int *rounding, int *exception_mask);

int  gsl_ieee_set_mode(int precision, int rounding, int exception_mask);


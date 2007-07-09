/* Converted to D from C:\Dokumente und Einstellungen\iwi-media\Desktop\dm851c\dm\bin\gsl\gsl_min.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_min;
/* min/gsl_min.h
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

import tango.stdc.stdlib;

public import gsl.gsl_types;

public import gsl.gsl_math;

extern (C):
struct gsl_min_fminimizer_type
{
    char *name;
    size_t size;
    int  function(void *state, gsl_function *f, double x_minimum, double f_minimum, double x_lower, double f_lower, double x_upper, double f_upper)set;
    int  function(void *state, gsl_function *f, double *x_minimum, double *f_minimum, double *x_lower, double *f_lower, double *x_upper, double *f_upper)iterate;
};

struct gsl_min_fminimizer
{
    gsl_min_fminimizer_type *type;
    gsl_function *func;
    double x_minimum;
    double x_lower;
    double x_upper;
    double f_minimum;
    double f_lower;
    double f_upper;
    void *state;
};

gsl_min_fminimizer * gsl_min_fminimizer_alloc(gsl_min_fminimizer_type *T);

void  gsl_min_fminimizer_free(gsl_min_fminimizer *s);

int  gsl_min_fminimizer_set(gsl_min_fminimizer *s, gsl_function *f, double x_minimum, double x_lower, double x_upper);

int  gsl_min_fminimizer_set_with_values(gsl_min_fminimizer *s, gsl_function *f, double x_minimum, double f_minimum, double x_lower, double f_lower, double x_upper, double f_upper);

int  gsl_min_fminimizer_iterate(gsl_min_fminimizer *s);

char * gsl_min_fminimizer_name(gsl_min_fminimizer *s);

double  gsl_min_fminimizer_x_minimum(gsl_min_fminimizer *s);

double  gsl_min_fminimizer_x_lower(gsl_min_fminimizer *s);

double  gsl_min_fminimizer_x_upper(gsl_min_fminimizer *s);

double  gsl_min_fminimizer_f_minimum(gsl_min_fminimizer *s);

double  gsl_min_fminimizer_f_lower(gsl_min_fminimizer *s);

double  gsl_min_fminimizer_f_upper(gsl_min_fminimizer *s);

/* Deprecated, use x_minimum instead */

double  gsl_min_fminimizer_minimum(gsl_min_fminimizer *s);

int  gsl_min_test_interval(double x_lower, double x_upper, double epsabs, double epsrel);

extern gsl_min_fminimizer_type *gsl_min_fminimizer_goldensection;

extern gsl_min_fminimizer_type *gsl_min_fminimizer_brent;

alias int  function(gsl_function *f, double *x_minimum, double *f_minimum, double *x_lower, double *f_lower, double *x_upper, double *f_upper, size_t eval_max)gsl_min_bracketing_function;

int  gsl_min_find_bracket(gsl_function *f, double *x_minimum, double *f_minimum, double *x_lower, double *f_lower, double *x_upper, double *f_upper, size_t eval_max);


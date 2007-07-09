/* Converted to D from gsl_roots.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_roots;
/* roots/gsl_roots.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Reid Priedhorsky, Brian Gough
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
struct gsl_root_fsolver_type
{
    char *name;
    size_t size;
    int  function(void *state, gsl_function *f, double *root, double x_lower, double x_upper)set;
    int  function(void *state, gsl_function *f, double *root, double *x_lower, double *x_upper)iterate;
};

struct gsl_root_fsolver
{
    gsl_root_fsolver_type *type;
    gsl_function *func;
    double root;
    double x_lower;
    double x_upper;
    void *state;
};

struct gsl_root_fdfsolver_type
{
    char *name;
    size_t size;
    int  function(void *state, gsl_function_fdf *f, double *root)set;
    int  function(void *state, gsl_function_fdf *f, double *root)iterate;
};

struct gsl_root_fdfsolver
{
    gsl_root_fdfsolver_type *type;
    gsl_function_fdf *fdf;
    double root;
    void *state;
};

gsl_root_fsolver * gsl_root_fsolver_alloc(gsl_root_fsolver_type *T);

void  gsl_root_fsolver_free(gsl_root_fsolver *s);

int  gsl_root_fsolver_set(gsl_root_fsolver *s, gsl_function *f, double x_lower, double x_upper);

int  gsl_root_fsolver_iterate(gsl_root_fsolver *s);

char * gsl_root_fsolver_name(gsl_root_fsolver *s);

double  gsl_root_fsolver_root(gsl_root_fsolver *s);

double  gsl_root_fsolver_x_lower(gsl_root_fsolver *s);

double  gsl_root_fsolver_x_upper(gsl_root_fsolver *s);

gsl_root_fdfsolver * gsl_root_fdfsolver_alloc(gsl_root_fdfsolver_type *T);

int  gsl_root_fdfsolver_set(gsl_root_fdfsolver *s, gsl_function_fdf *fdf, double root);

int  gsl_root_fdfsolver_iterate(gsl_root_fdfsolver *s);

void  gsl_root_fdfsolver_free(gsl_root_fdfsolver *s);

char * gsl_root_fdfsolver_name(gsl_root_fdfsolver *s);

double  gsl_root_fdfsolver_root(gsl_root_fdfsolver *s);

int  gsl_root_test_interval(double x_lower, double x_upper, double epsabs, double epsrel);

int  gsl_root_test_residual(double f, double epsabs);

int  gsl_root_test_delta(double x1, double x0, double epsabs, double epsrel);

extern gsl_root_fsolver_type *gsl_root_fsolver_bisection;

extern gsl_root_fsolver_type *gsl_root_fsolver_brent;

extern gsl_root_fsolver_type *gsl_root_fsolver_falsepos;

extern gsl_root_fdfsolver_type *gsl_root_fdfsolver_newton;

extern gsl_root_fdfsolver_type *gsl_root_fdfsolver_secant;

extern gsl_root_fdfsolver_type *gsl_root_fdfsolver_steffenson;


/* Converted to D from gsl_multimin.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_multimin;
/* multimin/gsl_multimin.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Fabrice Rossi
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

/* Modified by Tuomo Keskitalo to include fminimizer and 
   Nelder Mead related lines */

import tango.stdc.stdlib;

public import gsl.gsl_types;

public import gsl.gsl_math;

public import gsl.gsl_vector;

public import gsl.gsl_matrix;

public import gsl.gsl_min;

/* Definition of an arbitrary real-valued function with gsl_vector input and */
/* parameters */

extern (C):
struct gsl_multimin_function_struct
{
    double  function(gsl_vector *x, void *params)f;
    size_t n;
    void *params;
}
alias gsl_multimin_function_struct gsl_multimin_function;

/* Definition of an arbitrary differentiable real-valued function */
/* with gsl_vector input and parameters */

struct gsl_multimin_function_fdf_struct
{
    double  function(gsl_vector *x, void *params)f;
    void  function(gsl_vector *x, void *params, gsl_vector *df)df;
    void  function(gsl_vector *x, void *params, double *f, gsl_vector *df)fdf;
    size_t n;
    void *params;
}
alias gsl_multimin_function_fdf_struct gsl_multimin_function_fdf;

int  gsl_multimin_diff(gsl_multimin_function *f, gsl_vector *x, gsl_vector *g);

/* minimization of non-differentiable functions */

struct gsl_multimin_fminimizer_type
{
    char *name;
    size_t size;
    int  function(void *state, size_t n)alloc;
    int  function(void *state, gsl_multimin_function *f, gsl_vector *x, double *size, gsl_vector *step_size)set;
    int  function(void *state, gsl_multimin_function *f, gsl_vector *x, double *size, double *fval)iterate;
    void  function(void *state)free;
};

  /* multi dimensional part */

  

struct gsl_multimin_fminimizer
{
    gsl_multimin_fminimizer_type *type;
    gsl_multimin_function *f;
    double fval;
    gsl_vector *x;
    double size;
    void *state;
};

gsl_multimin_fminimizer * gsl_multimin_fminimizer_alloc(gsl_multimin_fminimizer_type *T, size_t n);

int  gsl_multimin_fminimizer_set(gsl_multimin_fminimizer *s, gsl_multimin_function *f, gsl_vector *x, gsl_vector *step_size);

void  gsl_multimin_fminimizer_free(gsl_multimin_fminimizer *s);

char * gsl_multimin_fminimizer_name(gsl_multimin_fminimizer *s);

int  gsl_multimin_fminimizer_iterate(gsl_multimin_fminimizer *s);

gsl_vector * gsl_multimin_fminimizer_x(gsl_multimin_fminimizer *s);

double  gsl_multimin_fminimizer_minimum(gsl_multimin_fminimizer *s);

double  gsl_multimin_fminimizer_size(gsl_multimin_fminimizer *s);

/* Convergence test functions */

int  gsl_multimin_test_gradient(gsl_vector *g, double epsabs);

int  gsl_multimin_test_size(double size, double epsabs);

/* minimisation of differentiable functions */

struct gsl_multimin_fdfminimizer_type
{
    char *name;
    size_t size;
    int  function(void *state, size_t n)alloc;
    int  function(void *state, gsl_multimin_function_fdf *fdf, gsl_vector *x, double *f, gsl_vector *gradient, double step_size, double tol)set;
    int  function(void *state, gsl_multimin_function_fdf *fdf, gsl_vector *x, double *f, gsl_vector *gradient, gsl_vector *dx)iterate;
    int  function(void *state)restart;
    void  function(void *state)free;
};

  /* multi dimensional part */

struct gsl_multimin_fdfminimizer
{
    gsl_multimin_fdfminimizer_type *type;
    gsl_multimin_function_fdf *fdf;
    double f;
    gsl_vector *x;
    gsl_vector *gradient;
    gsl_vector *dx;
    void *state;
};

gsl_multimin_fdfminimizer * gsl_multimin_fdfminimizer_alloc(gsl_multimin_fdfminimizer_type *T, size_t n);

int  gsl_multimin_fdfminimizer_set(gsl_multimin_fdfminimizer *s, gsl_multimin_function_fdf *fdf, gsl_vector *x, double step_size, double tol);

void  gsl_multimin_fdfminimizer_free(gsl_multimin_fdfminimizer *s);

char * gsl_multimin_fdfminimizer_name(gsl_multimin_fdfminimizer *s);

int  gsl_multimin_fdfminimizer_iterate(gsl_multimin_fdfminimizer *s);

int  gsl_multimin_fdfminimizer_restart(gsl_multimin_fdfminimizer *s);

gsl_vector * gsl_multimin_fdfminimizer_x(gsl_multimin_fdfminimizer *s);

gsl_vector * gsl_multimin_fdfminimizer_dx(gsl_multimin_fdfminimizer *s);

gsl_vector * gsl_multimin_fdfminimizer_gradient(gsl_multimin_fdfminimizer *s);

double  gsl_multimin_fdfminimizer_minimum(gsl_multimin_fdfminimizer *s);

extern gsl_multimin_fdfminimizer_type *gsl_multimin_fdfminimizer_steepest_descent;

extern gsl_multimin_fdfminimizer_type *gsl_multimin_fdfminimizer_conjugate_pr;

extern gsl_multimin_fdfminimizer_type *gsl_multimin_fdfminimizer_conjugate_fr;

extern gsl_multimin_fdfminimizer_type *gsl_multimin_fdfminimizer_vector_bfgs;

extern gsl_multimin_fminimizer_type *gsl_multimin_fminimizer_nmsimplex;


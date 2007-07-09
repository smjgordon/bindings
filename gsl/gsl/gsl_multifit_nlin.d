/* Converted to D from gsl_multifit_nlin.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_multifit_nlin;
/* multifit_nlin/gsl_multifit_nlin.h
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

public import gsl.gsl_vector;

public import gsl.gsl_matrix;

extern (C):
int  gsl_multifit_gradient(gsl_matrix *J, gsl_vector *f, gsl_vector *g);

int  gsl_multifit_covar(gsl_matrix *J, double epsrel, gsl_matrix *covar);

/* Definition of vector-valued functions with parameters based on gsl_vector */

struct gsl_multifit_function_struct
{
    int  function(gsl_vector *x, void *params, gsl_vector *f)f;
    size_t n;
    size_t p;
    void *params;
}
alias gsl_multifit_function_struct gsl_multifit_function;

struct gsl_multifit_fsolver_type
{
    char *name;
    size_t size;
    int  function(void *state, size_t n, size_t p)alloc;
    int  function(void *state, gsl_multifit_function *func, gsl_vector *x, gsl_vector *f, gsl_vector *dx)set;
    int  function(void *state, gsl_multifit_function *func, gsl_vector *x, gsl_vector *f, gsl_vector *dx)iterate;
    void  function(void *state)free;
};

struct gsl_multifit_fsolver
{
    gsl_multifit_fsolver_type *type;
    gsl_multifit_function *func;
    gsl_vector *x;
    gsl_vector *f;
    gsl_vector *dx;
    void *state;
};

gsl_multifit_fsolver * gsl_multifit_fsolver_alloc(gsl_multifit_fsolver_type *T, size_t n, size_t p);

void  gsl_multifit_fsolver_free(gsl_multifit_fsolver *s);

int  gsl_multifit_fsolver_set(gsl_multifit_fsolver *s, gsl_multifit_function *f, gsl_vector *x);

int  gsl_multifit_fsolver_iterate(gsl_multifit_fsolver *s);

char * gsl_multifit_fsolver_name(gsl_multifit_fsolver *s);

gsl_vector * gsl_multifit_fsolver_position(gsl_multifit_fsolver *s);

/* Definition of vector-valued functions and gradient with parameters
   based on gsl_vector */

struct gsl_multifit_function_fdf_struct
{
    int  function(gsl_vector *x, void *params, gsl_vector *f)f;
    int  function(gsl_vector *x, void *params, gsl_matrix *df)df;
    int  function(gsl_vector *x, void *params, gsl_vector *f, gsl_matrix *df)fdf;
    size_t n;
    size_t p;
    void *params;
}
alias gsl_multifit_function_fdf_struct gsl_multifit_function_fdf;

struct gsl_multifit_fdfsolver_type
{
    char *name;
    size_t size;
    int  function(void *state, size_t n, size_t p)alloc;
    int  function(void *state, gsl_multifit_function_fdf *fdf, gsl_vector *x, gsl_vector *f, gsl_matrix *J, gsl_vector *dx)set;
    int  function(void *state, gsl_multifit_function_fdf *fdf, gsl_vector *x, gsl_vector *f, gsl_matrix *J, gsl_vector *dx)iterate;
    void  function(void *state)free;
};

struct gsl_multifit_fdfsolver
{
    gsl_multifit_fdfsolver_type *type;
    gsl_multifit_function_fdf *fdf;
    gsl_vector *x;
    gsl_vector *f;
    gsl_matrix *J;
    gsl_vector *dx;
    void *state;
};

gsl_multifit_fdfsolver * gsl_multifit_fdfsolver_alloc(gsl_multifit_fdfsolver_type *T, size_t n, size_t p);

int  gsl_multifit_fdfsolver_set(gsl_multifit_fdfsolver *s, gsl_multifit_function_fdf *fdf, gsl_vector *x);

int  gsl_multifit_fdfsolver_iterate(gsl_multifit_fdfsolver *s);

void  gsl_multifit_fdfsolver_free(gsl_multifit_fdfsolver *s);

char * gsl_multifit_fdfsolver_name(gsl_multifit_fdfsolver *s);

gsl_vector * gsl_multifit_fdfsolver_position(gsl_multifit_fdfsolver *s);

int  gsl_multifit_test_delta(gsl_vector *dx, gsl_vector *x, double epsabs, double epsrel);

int  gsl_multifit_test_gradient(gsl_vector *g, double epsabs);

/* extern const gsl_multifit_fsolver_type * gsl_multifit_fsolver_gradient; */

extern gsl_multifit_fdfsolver_type *gsl_multifit_fdfsolver_lmder;

extern gsl_multifit_fdfsolver_type *gsl_multifit_fdfsolver_lmsder;


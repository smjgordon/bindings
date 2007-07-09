/* Converted to D from gsl_multiroots.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_multiroots;
/* multiroots/gsl_multiroots.h
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

/* Definition of vector-valued functions with parameters based on gsl_vector */

struct gsl_multiroot_function_struct
{
    int  function(gsl_vector *x, void *params, gsl_vector *f)f;
    size_t n;
    void *params;
}

extern (C):
alias gsl_multiroot_function_struct gsl_multiroot_function;

int  gsl_multiroot_fdjacobian(gsl_multiroot_function *F, gsl_vector *x, gsl_vector *f, double epsrel, gsl_matrix *jacobian);

struct gsl_multiroot_fsolver_type
{
    char *name;
    size_t size;
    int  function(void *state, size_t n)alloc;
    int  function(void *state, gsl_multiroot_function *func, gsl_vector *x, gsl_vector *f, gsl_vector *dx)set;
    int  function(void *state, gsl_multiroot_function *func, gsl_vector *x, gsl_vector *f, gsl_vector *dx)iterate;
    void  function(void *state)free;
};

struct gsl_multiroot_fsolver
{
    gsl_multiroot_fsolver_type *type;
    gsl_multiroot_function *func;
    gsl_vector *x;
    gsl_vector *f;
    gsl_vector *dx;
    void *state;
};

gsl_multiroot_fsolver * gsl_multiroot_fsolver_alloc(gsl_multiroot_fsolver_type *T, size_t n);

void  gsl_multiroot_fsolver_free(gsl_multiroot_fsolver *s);

int  gsl_multiroot_fsolver_set(gsl_multiroot_fsolver *s, gsl_multiroot_function *f, gsl_vector *x);

int  gsl_multiroot_fsolver_iterate(gsl_multiroot_fsolver *s);

char * gsl_multiroot_fsolver_name(gsl_multiroot_fsolver *s);

gsl_vector * gsl_multiroot_fsolver_root(gsl_multiroot_fsolver *s);

gsl_vector * gsl_multiroot_fsolver_dx(gsl_multiroot_fsolver *s);

gsl_vector * gsl_multiroot_fsolver_f(gsl_multiroot_fsolver *s);

/* Definition of vector-valued functions and gradient with parameters
   based on gsl_vector */

struct gsl_multiroot_function_fdf_struct
{
    int  function(gsl_vector *x, void *params, gsl_vector *f)f;
    int  function(gsl_vector *x, void *params, gsl_matrix *df)df;
    int  function(gsl_vector *x, void *params, gsl_vector *f, gsl_matrix *df)fdf;
    size_t n;
    void *params;
}

alias gsl_multiroot_function_fdf_struct gsl_multiroot_function_fdf;

struct gsl_multiroot_fdfsolver_type
{
    char *name;
    size_t size;
    int  function(void *state, size_t n)alloc;
    int  function(void *state, gsl_multiroot_function_fdf *fdf, gsl_vector *x, gsl_vector *f, gsl_matrix *J, gsl_vector *dx)set;
    int  function(void *state, gsl_multiroot_function_fdf *fdf, gsl_vector *x, gsl_vector *f, gsl_matrix *J, gsl_vector *dx)iterate;
    void  function(void *state)free;
};

struct gsl_multiroot_fdfsolver
{
    gsl_multiroot_fdfsolver_type *type;
    gsl_multiroot_function_fdf *fdf;
    gsl_vector *x;
    gsl_vector *f;
    gsl_matrix *J;
    gsl_vector *dx;
    void *state;
};

gsl_multiroot_fdfsolver * gsl_multiroot_fdfsolver_alloc(gsl_multiroot_fdfsolver_type *T, size_t n);

int  gsl_multiroot_fdfsolver_set(gsl_multiroot_fdfsolver *s, gsl_multiroot_function_fdf *fdf, gsl_vector *x);

int  gsl_multiroot_fdfsolver_iterate(gsl_multiroot_fdfsolver *s);

void  gsl_multiroot_fdfsolver_free(gsl_multiroot_fdfsolver *s);

char * gsl_multiroot_fdfsolver_name(gsl_multiroot_fdfsolver *s);

gsl_vector * gsl_multiroot_fdfsolver_root(gsl_multiroot_fdfsolver *s);

gsl_vector * gsl_multiroot_fdfsolver_dx(gsl_multiroot_fdfsolver *s);

gsl_vector * gsl_multiroot_fdfsolver_f(gsl_multiroot_fdfsolver *s);

int  gsl_multiroot_test_delta(gsl_vector *dx, gsl_vector *x, double epsabs, double epsrel);

int  gsl_multiroot_test_residual(gsl_vector *f, double epsabs);

extern gsl_multiroot_fsolver_type *gsl_multiroot_fsolver_dnewton;

extern gsl_multiroot_fsolver_type *gsl_multiroot_fsolver_broyden;

extern gsl_multiroot_fsolver_type *gsl_multiroot_fsolver_hybrid;

extern gsl_multiroot_fsolver_type *gsl_multiroot_fsolver_hybrids;

extern gsl_multiroot_fdfsolver_type *gsl_multiroot_fdfsolver_newton;

extern gsl_multiroot_fdfsolver_type *gsl_multiroot_fdfsolver_gnewton;

extern gsl_multiroot_fdfsolver_type *gsl_multiroot_fdfsolver_hybridj;

extern gsl_multiroot_fdfsolver_type *gsl_multiroot_fdfsolver_hybridsj;


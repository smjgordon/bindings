/* Converted to D from gsl_interp.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_interp;
/* interpolation/gsl_interp.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004 Gerard Jungman
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

/* Author:  G. Jungman
 */

import tango.stdc.stdlib;

public import gsl.gsl_types;

/* evaluation accelerator */

extern (C):
struct gsl_interp_accel
{
    size_t cache;
    size_t miss_count;
    size_t hit_count;
};

/* interpolation object type */

struct gsl_interp_type
{
    char *name;
    uint min_size;
    void * function(size_t size)alloc;
    int  function(void *, double *xa, double *ya, size_t size)init;
    int  function(void *, double *xa, double *ya, size_t size, double x, gsl_interp_accel *, double *y)eval;
    int  function(void *, double *xa, double *ya, size_t size, double x, gsl_interp_accel *, double *y_p)eval_deriv;
    int  function(void *, double *xa, double *ya, size_t size, double x, gsl_interp_accel *, double *y_pp)eval_deriv2;
    int  function(void *, double *xa, double *ya, size_t size, gsl_interp_accel *, double a, double b, double *result)eval_integ;
    void  function(void *)free;
};

/* general interpolation object */

struct gsl_interp
{
    gsl_interp_type *type;
    double xmin;
    double xmax;
    size_t size;
    void *state;
};

/* available types */

extern gsl_interp_type *gsl_interp_linear;

extern gsl_interp_type *gsl_interp_polynomial;

extern gsl_interp_type *gsl_interp_cspline;

extern gsl_interp_type *gsl_interp_cspline_periodic;

extern gsl_interp_type *gsl_interp_akima;

extern gsl_interp_type *gsl_interp_akima_periodic;

gsl_interp_accel * gsl_interp_accel_alloc();

size_t  gsl_interp_accel_find(gsl_interp_accel *a, double *x_array, size_t size, double x);

int  gsl_interp_accel_reset(gsl_interp_accel *a);

void  gsl_interp_accel_free(gsl_interp_accel *a);

gsl_interp * gsl_interp_alloc(gsl_interp_type *T, size_t n);
     

int  gsl_interp_init(gsl_interp *obj, double *xa, double *ya, size_t size);

char * gsl_interp_name(gsl_interp *interp);

uint  gsl_interp_min_size(gsl_interp *interp);

int  gsl_interp_eval_e(gsl_interp *obj, double *xa, double *ya, double x, gsl_interp_accel *a, double *y);

double  gsl_interp_eval(gsl_interp *obj, double *xa, double *ya, double x, gsl_interp_accel *a);

int  gsl_interp_eval_deriv_e(gsl_interp *obj, double *xa, double *ya, double x, gsl_interp_accel *a, double *d);

double  gsl_interp_eval_deriv(gsl_interp *obj, double *xa, double *ya, double x, gsl_interp_accel *a);

int  gsl_interp_eval_deriv2_e(gsl_interp *obj, double *xa, double *ya, double x, gsl_interp_accel *a, double *d2);

double  gsl_interp_eval_deriv2(gsl_interp *obj, double *xa, double *ya, double x, gsl_interp_accel *a);

int  gsl_interp_eval_integ_e(gsl_interp *obj, double *xa, double *ya, double a, double b, gsl_interp_accel *acc, double *result);

double  gsl_interp_eval_integ(gsl_interp *obj, double *xa, double *ya, double a, double b, gsl_interp_accel *acc);

void  gsl_interp_free(gsl_interp *interp);

size_t  gsl_interp_bsearch(double *x_array, double x, size_t index_lo, size_t index_hi);


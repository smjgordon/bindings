/* Converted to D from gsl_spline.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_spline;
/* interpolation/gsl_spline.h
 * 
 * Copyright (C) 2001 Brian Gough
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

public import gsl.gsl_interp;

/* general interpolation object */

extern (C):
struct gsl_spline
{
    gsl_interp *interp;
    double *x;
    double *y;
    size_t size;
};

gsl_spline * gsl_spline_alloc(gsl_interp_type *T, size_t size);

int  gsl_spline_init(gsl_spline *spline, double *xa, double *ya, size_t size);

char * gsl_spline_name(gsl_spline *spline);

uint  gsl_spline_min_size(gsl_spline *spline);

int  gsl_spline_eval_e(gsl_spline *spline, double x, gsl_interp_accel *a, double *y);

double  gsl_spline_eval(gsl_spline *spline, double x, gsl_interp_accel *a);

int  gsl_spline_eval_deriv_e(gsl_spline *spline, double x, gsl_interp_accel *a, double *y);

double  gsl_spline_eval_deriv(gsl_spline *spline, double x, gsl_interp_accel *a);

int  gsl_spline_eval_deriv2_e(gsl_spline *spline, double x, gsl_interp_accel *a, double *y);

double  gsl_spline_eval_deriv2(gsl_spline *spline, double x, gsl_interp_accel *a);

int  gsl_spline_eval_integ_e(gsl_spline *spline, double a, double b, gsl_interp_accel *acc, double *y);

double  gsl_spline_eval_integ(gsl_spline *spline, double a, double b, gsl_interp_accel *acc);

void  gsl_spline_free(gsl_spline *spline);


/* Converted to D from gsl_fit.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_fit;
/* fit/gsl_fit.h
 * 
 * Copyright (C) 2000 Brian Gough
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

public import gsl.gsl_math;

extern (C):
int  gsl_fit_linear(double *x, size_t xstride, double *y, size_t ystride, size_t n, double *c0, double *c1, double *cov00, double *cov01, double *cov11, double *sumsq);

int  gsl_fit_wlinear(double *x, size_t xstride, double *w, size_t wstride, double *y, size_t ystride, size_t n, double *c0, double *c1, double *cov00, double *cov01, double *cov11, double *chisq);

int  gsl_fit_linear_est(double x, double c0, double c1, double c00, double c01, double c11, double *y, double *y_err);

int  gsl_fit_mul(double *x, size_t xstride, double *y, size_t ystride, size_t n, double *c1, double *cov11, double *sumsq);

int  gsl_fit_wmul(double *x, size_t xstride, double *w, size_t wstride, double *y, size_t ystride, size_t n, double *c1, double *cov11, double *sumsq);

int  gsl_fit_mul_est(double x, double c1, double c11, double *y, double *y_err);


/* Converted to D from gsl_multifit.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_multifit;
/* multifit/gsl_multifit.h
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

public import gsl.gsl_vector;

public import gsl.gsl_matrix;

extern (C):
struct gsl_multifit_linear_workspace
{
    size_t n;
    size_t p;
    gsl_matrix *A;
    gsl_matrix *Q;
    gsl_matrix *QSI;
    gsl_vector *S;
    gsl_vector *t;
    gsl_vector *xt;
    gsl_vector *D;
};

gsl_multifit_linear_workspace * gsl_multifit_linear_alloc(size_t n, size_t p);

void  gsl_multifit_linear_free(gsl_multifit_linear_workspace *work);

int  gsl_multifit_linear(gsl_matrix *X, gsl_vector *y, gsl_vector *c, gsl_matrix *cov, double *chisq, gsl_multifit_linear_workspace *work);

int  gsl_multifit_linear_svd(gsl_matrix *X, gsl_vector *y, double tol, size_t *rank, gsl_vector *c, gsl_matrix *cov, double *chisq, gsl_multifit_linear_workspace *work);

int  gsl_multifit_wlinear(gsl_matrix *X, gsl_vector *w, gsl_vector *y, gsl_vector *c, gsl_matrix *cov, double *chisq, gsl_multifit_linear_workspace *work);

int  gsl_multifit_wlinear_svd(gsl_matrix *X, gsl_vector *w, gsl_vector *y, double tol, size_t *rank, gsl_vector *c, gsl_matrix *cov, double *chisq, gsl_multifit_linear_workspace *work);

int  gsl_multifit_linear_est(gsl_vector *x, gsl_vector *c, gsl_matrix *cov, double *y, double *y_err);


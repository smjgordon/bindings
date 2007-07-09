/* Converted to D from gsl_poly.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_poly;
/* poly/gsl_poly.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004 Brian Gough
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

public import gsl.gsl_complex;

/* Evaluate polynomial
 *
 * c[0] + c[1] x + c[2] x^2 + ... + c[len-1] x^(len-1)
 *
 * exceptions: none
 */

extern (C):
double  gsl_poly_eval(double *c, int len, double x);

/* Work with divided-difference polynomials, Abramowitz & Stegun 25.2.26 */

int  gsl_poly_dd_init(double *dd, double *x, double *y, size_t size);

double  gsl_poly_dd_eval(double *dd, double *xa, size_t size, double x);

int  gsl_poly_dd_taylor(double *c, double xp, double *dd, double *x, size_t size, double *w);

/* Solve for real or complex roots of the standard quadratic equation,
 * returning the number of real roots.
 *
 * Roots are returned ordered.
 */

int  gsl_poly_solve_quadratic(double a, double b, double c, double *x0, double *x1);

int  gsl_poly_complex_solve_quadratic(double a, double b, double c, gsl_complex *z0, gsl_complex *z1);

/* Solve for real roots of the cubic equation
 * x^3 + a x^2 + b x + c = 0, returning the
 * number of real roots.
 *
 * Roots are returned ordered.
 */

int  gsl_poly_solve_cubic(double a, double b, double c, double *x0, double *x1, double *x2);

int  gsl_poly_complex_solve_cubic(double a, double b, double c, gsl_complex *z0, gsl_complex *z1, gsl_complex *z2);

/* Solve for the complex roots of a general real polynomial */

struct gsl_poly_complex_workspace
{
    size_t nc;
    double *matrix;
};

gsl_poly_complex_workspace * gsl_poly_complex_workspace_alloc(size_t n);

void  gsl_poly_complex_workspace_free(gsl_poly_complex_workspace *w);

int  gsl_poly_complex_solve(double *a, size_t n, gsl_poly_complex_workspace *w, gsl_complex_packed_ptr z);


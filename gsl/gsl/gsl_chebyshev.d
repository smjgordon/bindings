/* Converted to D from gsl_chebyshev.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_chebyshev;
/* cheb/gsl_chebyshev.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Gerard Jungman
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

public import gsl.gsl_math;

public import gsl.gsl_mode;

/* data for a Chebyshev series over a given interval */

  /* The following exists (mostly) for the benefit
   * of the implementation. It is an effective single
   * precision order, for use in single precision
   * evaluation. Users can use it if they like, but
   * only they know how to calculate it, since it is
   * specific to the approximated function. By default,
   * order_sp = order.
   * It is used explicitly only by the gsl_cheb_eval_mode
   * functions, which are not meant for casual use.
   */

  /* Additional elements not used by specfunc */

struct gsl_cheb_series_struct
{
    double *c;
    size_t order;
    double a;
    double b;
    size_t order_sp;
    double *f;
}

extern (C):
alias gsl_cheb_series_struct gsl_cheb_series;

/* Calculate a Chebyshev series of specified order over
 * a specified interval, for a given function.
 * Return 0 on failure.
 */

gsl_cheb_series * gsl_cheb_alloc(int size_t,...);

/* Free a Chebyshev series previously calculated with gsl_cheb_alloc().
 */

void  gsl_cheb_free(gsl_cheb_series *cs);

/* Calculate a Chebyshev series using the storage provided.
 * Uses the interval (a,b) and the order with which it
 * was initially created.
 *
 */

int  gsl_cheb_init(gsl_cheb_series *cs, gsl_function *func, double a, double b);

/* Evaluate a Chebyshev series at a given point.
 * No errors can occur for a struct obtained from gsl_cheb_new().
 */

double  gsl_cheb_eval(gsl_cheb_series *cs, double x);

int  gsl_cheb_eval_err(gsl_cheb_series *cs, double x, double *result, double *abserr);

/* Evaluate a Chebyshev series at a given point, to (at most) the given order.
 * No errors can occur for a struct obtained from gsl_cheb_new().
 */

double  gsl_cheb_eval_n(gsl_cheb_series *cs, int size_t,...);


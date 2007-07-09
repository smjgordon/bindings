/* Converted to D from gsl_monte_plain.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_monte_plain;
/* monte/gsl_monte_plain.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Michael Booth
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

/* Plain Monte-Carlo. */

/* Author: MJB */

import tango.stdc.stdio;

public import gsl.gsl_monte;

public import gsl.gsl_rng;

extern (C):
struct gsl_monte_plain_state
{
    size_t dim;
    double *x;
};

int  gsl_monte_plain_integrate(gsl_monte_function *f, double *xl, double *xu, size_t dim, size_t calls, gsl_rng *r, gsl_monte_plain_state *state, double *result, double *abserr);

gsl_monte_plain_state * gsl_monte_plain_alloc(size_t dim);

int  gsl_monte_plain_init(gsl_monte_plain_state *state);

void  gsl_monte_plain_free(gsl_monte_plain_state *state);


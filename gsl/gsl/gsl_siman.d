/* Converted to D from gsl_siman.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_siman;
/* siman/gsl_siman.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Mark Galassi
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

public import gsl.gsl_rng;

/* types for the function pointers passed to gsl_siman_solve */

extern (C):
alias double  function(void *xp)gsl_siman_Efunc_t;

alias void  function(gsl_rng *r, void *xp, double step_size)gsl_siman_step_t;

alias double  function(void *xp, void *yp)gsl_siman_metric_t;

alias void  function(void *xp)gsl_siman_print_t;

alias void  function(void *source, void *dest)gsl_siman_copy_t;

alias void * function(void *xp)gsl_siman_copy_construct_t;

alias void  function(void *xp)gsl_siman_destroy_t;

/* this structure contains all the information needed to structure the
   search, beyond the energy function, the step function and the
   initial guess. */

  /* the following parameters are for the Boltzmann distribution */

struct gsl_siman_params_t
{
    int n_tries;
    int iters_fixed_T;
    double step_size;
    double k;
    double t_initial;
    double mu_t;
    double t_min;
};

/* prototype for the workhorse function */

void  gsl_siman_solve(gsl_rng *r, void *x0_p, gsl_siman_Efunc_t Ef, gsl_siman_step_t take_step, gsl_siman_metric_t distance, gsl_siman_print_t print_position, gsl_siman_copy_t copyfunc, gsl_siman_copy_construct_t copy_constructor, gsl_siman_destroy_t destructor, size_t element_size, gsl_siman_params_t params);

void  gsl_siman_solve_many(gsl_rng *r, void *x0_p, gsl_siman_Efunc_t Ef, gsl_siman_step_t take_step, gsl_siman_metric_t distance, gsl_siman_print_t print_position, size_t element_size, gsl_siman_params_t params);


/* Converted to D from gsl_sf_result.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_result;
/* specfunc/gsl_sf_result.h
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

/* Author:  G. Jungman */

struct gsl_sf_result_struct
{
    double val;
    double err;
}

extern (C):
alias gsl_sf_result_struct gsl_sf_result;

struct gsl_sf_result_e10_struct
{
    double val;
    double err;
    int e10;
}

alias gsl_sf_result_e10_struct gsl_sf_result_e10;

int  gsl_sf_result_smash_e(gsl_sf_result_e10 *re, gsl_sf_result *r);


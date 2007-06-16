/* Converted to D from gsl_deriv.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_deriv;
/* deriv/gsl_deriv.h
 * 
 * Copyright (C) 2000 David Morrison
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

extern (C):
int  gsl_deriv_central(gsl_function *f, double x, double h, double *result, double *abserr);

int  gsl_deriv_backward(gsl_function *f, double x, double h, double *result, double *abserr);

int  gsl_deriv_forward(gsl_function *f, double x, double h, double *result, double *abserr);


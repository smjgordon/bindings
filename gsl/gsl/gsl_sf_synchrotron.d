/* Converted to D from gsl_sf_synchrotron.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_synchrotron;
/* specfunc/gsl_sf_synchrotron.h
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

public import gsl.gsl_sf_result;

/* First synchrotron function:
 *   synchrotron_1(x) = x Integral[ K_{5/3}(t), {t, x, Infinity}]
 *
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

extern (C):
int  gsl_sf_synchrotron_1_e(double x, gsl_sf_result *result);

double  gsl_sf_synchrotron_1(double x);

/* Second synchroton function:
 *   synchrotron_2(x) = x * K_{2/3}(x)
 *
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_synchrotron_2_e(double x, gsl_sf_result *result);

double  gsl_sf_synchrotron_2(double x);


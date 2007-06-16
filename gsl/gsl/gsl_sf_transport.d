/* Converted to D from gsl_sf_transport.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_transport;
/* specfunc/gsl_sf_transport.h
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

/* Transport function:
 *   J(n,x) := Integral[ t^n e^t /(e^t - 1)^2, {t,0,x}]
 */

/* J(2,x)
 *
 * exceptions: GSL_EDOM
 */

extern (C):
int  gsl_sf_transport_2_e(double x, gsl_sf_result *result);

double  gsl_sf_transport_2(double x);

/* J(3,x)
 *
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_transport_3_e(double x, gsl_sf_result *result);

double  gsl_sf_transport_3(double x);

/* J(4,x)
 *
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_transport_4_e(double x, gsl_sf_result *result);

double  gsl_sf_transport_4(double x);

/* J(5,x)
 *
 * exceptions: GSL_EDOM, GSL_EUNDRFLW
 */

int  gsl_sf_transport_5_e(double x, gsl_sf_result *result);

double  gsl_sf_transport_5(double x);


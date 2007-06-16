/* Converted to D from gsl_sf_trig.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_trig;
/* specfunc/gsl_sf_trig.h
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

/* Sin(x) with GSL semantics. This is actually important
 * because we want to control the error estimate, and trying
 * to guess the error for the standard library implementation
 * every time it is used would be a little goofy.
 */

extern (C):
int  gsl_sf_sin_e(double x, gsl_sf_result *result);

double  gsl_sf_sin(double x);

/* Cos(x) with GSL semantics.
 */

int  gsl_sf_cos_e(double x, gsl_sf_result *result);

double  gsl_sf_cos(double x);

/* Hypot(x,y) with GSL semantics.
 */

int  gsl_sf_hypot_e(double x, double y, gsl_sf_result *result);

double  gsl_sf_hypot(double x, double y);

/* Sin(z) for complex z
 *
 * exceptions: GSL_EOVRFLW
 */

int  gsl_sf_complex_sin_e(double zr, double zi, gsl_sf_result *szr, gsl_sf_result *szi);

/* Cos(z) for complex z
 *
 * exceptions: GSL_EOVRFLW
 */

int  gsl_sf_complex_cos_e(double zr, double zi, gsl_sf_result *czr, gsl_sf_result *czi);

/* Log(Sin(z)) for complex z
 *
 * exceptions: GSL_EDOM, GSL_ELOSS
 */

int  gsl_sf_complex_logsin_e(double zr, double zi, gsl_sf_result *lszr, gsl_sf_result *lszi);

/* Sinc(x) = sin(pi x) / (pi x)
 *
 * exceptions: none
 */

int  gsl_sf_sinc_e(double x, gsl_sf_result *result);

double  gsl_sf_sinc(double x);

/* Log(Sinh(x)), x > 0
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_lnsinh_e(double x, gsl_sf_result *result);

double  gsl_sf_lnsinh(double x);

/* Log(Cosh(x))
 *
 * exceptions: none
 */

int  gsl_sf_lncosh_e(double x, gsl_sf_result *result);

double  gsl_sf_lncosh(double x);

/* Convert polar to rectlinear coordinates.
 *
 * exceptions: GSL_ELOSS
 */

int  gsl_sf_polar_to_rect(double r, double theta, gsl_sf_result *x, gsl_sf_result *y);

/* Convert rectilinear to polar coordinates.
 * return argument in range [-pi, pi]
 *
 * exceptions: GSL_EDOM
 */

int  gsl_sf_rect_to_polar(double x, double y, gsl_sf_result *r, gsl_sf_result *theta);

/* Sin(x) for quantity with an associated error.
 */

int  gsl_sf_sin_err_e(double x, double dx, gsl_sf_result *result);

/* Cos(x) for quantity with an associated error.
 */

int  gsl_sf_cos_err_e(double x, double dx, gsl_sf_result *result);

/* Force an angle to lie in the range (-pi,pi].
 *
 * exceptions: GSL_ELOSS
 */

int  gsl_sf_angle_restrict_symm_e(double *theta);

double  gsl_sf_angle_restrict_symm(double theta);

/* Force an angle to lie in the range [0, 2pi)
 *
 * exceptions: GSL_ELOSS
 */

int  gsl_sf_angle_restrict_pos_e(double *theta);

double  gsl_sf_angle_restrict_pos(double theta);

int  gsl_sf_angle_restrict_symm_err_e(double theta, gsl_sf_result *result);

int  gsl_sf_angle_restrict_pos_err_e(double theta, gsl_sf_result *result);


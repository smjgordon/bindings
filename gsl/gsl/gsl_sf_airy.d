/* Converted to D from gsl_sf_airy.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_airy;
/* specfunc/gsl_sf_airy.h
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

public import gsl.gsl_mode;

public import gsl.gsl_sf_result;

/* Airy function Ai(x)
 *
 * exceptions: GSL_EUNDRFLW
 */

extern (C):
int  gsl_sf_airy_Ai_e(double x, gsl_mode_t mode, gsl_sf_result *result);

double  gsl_sf_airy_Ai(double x, gsl_mode_t mode);

/* Airy function Bi(x)
 *
 * exceptions: GSL_EOVRFLW
 */

int  gsl_sf_airy_Bi_e(double x, gsl_mode_t mode, gsl_sf_result *result);

double  gsl_sf_airy_Bi(double x, gsl_mode_t mode);

/* scaled Ai(x):
 *                     Ai(x)   x < 0
 *   exp(+2/3 x^{3/2}) Ai(x)   x > 0
 *
 * exceptions: none
 */

int  gsl_sf_airy_Ai_scaled_e(double x, gsl_mode_t mode, gsl_sf_result *result);

double  gsl_sf_airy_Ai_scaled(double x, gsl_mode_t mode);

/* scaled Bi(x):
 *                     Bi(x)   x < 0
 *   exp(-2/3 x^{3/2}) Bi(x)   x > 0
 *
 * exceptions: none
 */

int  gsl_sf_airy_Bi_scaled_e(double x, gsl_mode_t mode, gsl_sf_result *result);

double  gsl_sf_airy_Bi_scaled(double x, gsl_mode_t mode);

/* derivative Ai'(x)
 *
 * exceptions: GSL_EUNDRFLW
 */

int  gsl_sf_airy_Ai_deriv_e(double x, gsl_mode_t mode, gsl_sf_result *result);

double  gsl_sf_airy_Ai_deriv(double x, gsl_mode_t mode);

/* derivative Bi'(x)
 *
 * exceptions: GSL_EOVRFLW
 */

int  gsl_sf_airy_Bi_deriv_e(double x, gsl_mode_t mode, gsl_sf_result *result);

double  gsl_sf_airy_Bi_deriv(double x, gsl_mode_t mode);

/* scaled derivative Ai'(x):
 *                     Ai'(x)   x < 0
 *   exp(+2/3 x^{3/2}) Ai'(x)   x > 0
 *
 * exceptions: none
 */

int  gsl_sf_airy_Ai_deriv_scaled_e(double x, gsl_mode_t mode, gsl_sf_result *result);

double  gsl_sf_airy_Ai_deriv_scaled(double x, gsl_mode_t mode);

/* scaled derivative:
 *                     Bi'(x)   x < 0
 *   exp(-2/3 x^{3/2}) Bi'(x)   x > 0
 *
 * exceptions: none
 */

int  gsl_sf_airy_Bi_deriv_scaled_e(double x, gsl_mode_t mode, gsl_sf_result *result);

double  gsl_sf_airy_Bi_deriv_scaled(double x, gsl_mode_t mode);

/* Zeros of Ai(x)
 */

int  gsl_sf_airy_zero_Ai_e(uint s, gsl_sf_result *result);

double  gsl_sf_airy_zero_Ai(uint s);

/* Zeros of Bi(x)
 */

int  gsl_sf_airy_zero_Bi_e(uint s, gsl_sf_result *result);

double  gsl_sf_airy_zero_Bi(uint s);

/* Zeros of Ai'(x)
 */

int  gsl_sf_airy_zero_Ai_deriv_e(uint s, gsl_sf_result *result);

double  gsl_sf_airy_zero_Ai_deriv(uint s);

/* Zeros of Bi'(x)
 */

int  gsl_sf_airy_zero_Bi_deriv_e(uint s, gsl_sf_result *result);

double  gsl_sf_airy_zero_Bi_deriv(uint s);


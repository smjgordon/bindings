/* Converted to D from gsl_sf_coupling.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_coupling;
/* specfunc/gsl_sf_coupling.h
 * 
 * Copyright (C) 1996,1997,1998,1999,2000,2001,2002 Gerard Jungman
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

/* 3j Symbols:  / ja jb jc  *              \ ma mb mc /
 *
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

extern (C):
int  gsl_sf_coupling_3j_e(int two_ja, int two_jb, int two_jc, int two_ma, int two_mb, int two_mc, gsl_sf_result *result);

double  gsl_sf_coupling_3j(int two_ja, int two_jb, int two_jc, int two_ma, int two_mb, int two_mc);

/* 6j Symbols:  / ja jb jc  *              \ jd je jf /
 *
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_coupling_6j_e(int two_ja, int two_jb, int two_jc, int two_jd, int two_je, int two_jf, gsl_sf_result *result);

double  gsl_sf_coupling_6j(int two_ja, int two_jb, int two_jc, int two_jd, int two_je, int two_jf);

/* Racah W coefficients:
 *
 *   W(a b c d; e f) = (-1)^{a+b+c+d} / a b e  *                                    \ d c f /
 *
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_coupling_RacahW_e(int two_ja, int two_jb, int two_jc, int two_jd, int two_je, int two_jf, gsl_sf_result *result);

double  gsl_sf_coupling_RacahW(int two_ja, int two_jb, int two_jc, int two_jd, int two_je, int two_jf);

/* 9j Symbols:  / ja jb jc  *              | jd je jf |
 *              \ jg jh ji /
 *
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_coupling_9j_e(int two_ja, int two_jb, int two_jc, int two_jd, int two_je, int two_jf, int two_jg, int two_jh, int two_ji, gsl_sf_result *result);

double  gsl_sf_coupling_9j(int two_ja, int two_jb, int two_jc, int two_jd, int two_je, int two_jf, int two_jg, int two_jh, int two_ji);

/* INCORRECT version of 6j Symbols:
 * This function actually calculates
 *              / ja jb je  *              \ jd jc jf /
 * It represents the original implementation,
 * which had the above permutation of the
 * arguments. This was wrong and confusing,
 * and I had to fix it. Sorry for the trouble.
 * [GJ] Tue Nov 26 12:53:39 MST 2002
 *
 * exceptions: GSL_EDOM, GSL_EOVRFLW
 */

int  gsl_sf_coupling_6j_INCORRECT_e(int two_ja, int two_jb, int two_jc, int two_jd, int two_je, int two_jf, gsl_sf_result *result);

double  gsl_sf_coupling_6j_INCORRECT(int two_ja, int two_jb, int two_jc, int two_jd, int two_je, int two_jf);


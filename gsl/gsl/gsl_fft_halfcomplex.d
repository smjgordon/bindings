/* Converted to D from gsl_fft_halfcomplex.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_fft_halfcomplex;
/* fft/gsl_fft_halfcomplex.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Brian Gough
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

import tango.stdc.stddef;

public import gsl.gsl_math;

public import gsl.gsl_complex;

public import gsl.gsl_fft;

public import gsl.gsl_fft_real;

extern (C):
int  gsl_fft_halfcomplex_radix2_backward(double *data, size_t stride, size_t n);

int  gsl_fft_halfcomplex_radix2_inverse(double *data, size_t stride, size_t n);

int  gsl_fft_halfcomplex_radix2_transform(double *data, size_t stride, size_t n);

struct gsl_fft_halfcomplex_wavetable
{
    size_t n;
    size_t nf;
    size_t [64]factor;
    gsl_complex *[64]twiddle;
    gsl_complex *trig;
};

gsl_fft_halfcomplex_wavetable * gsl_fft_halfcomplex_wavetable_alloc(size_t n);

void  gsl_fft_halfcomplex_wavetable_free(gsl_fft_halfcomplex_wavetable *wavetable);

int  gsl_fft_halfcomplex_backward(double *data, size_t stride, size_t n, gsl_fft_halfcomplex_wavetable *wavetable, gsl_fft_real_workspace *work);

int  gsl_fft_halfcomplex_inverse(double *data, size_t stride, size_t n, gsl_fft_halfcomplex_wavetable *wavetable, gsl_fft_real_workspace *work);

int  gsl_fft_halfcomplex_transform(double *data, size_t stride, size_t n, gsl_fft_halfcomplex_wavetable *wavetable, gsl_fft_real_workspace *work);

int  gsl_fft_halfcomplex_unpack(double *halfcomplex_coefficient, double *complex_coefficient, size_t stride, size_t n);

int  gsl_fft_halfcomplex_radix2_unpack(double *halfcomplex_coefficient, double *complex_coefficient, size_t stride, size_t n);


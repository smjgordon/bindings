/* Converted to D from gsl_fft_complex.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_fft_complex;
/* fft/gsl_fft_complex.h
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

/*  Power of 2 routines  */

extern (C):
int  gsl_fft_complex_radix2_forward(gsl_complex_packed_array data, size_t stride, size_t n);

int  gsl_fft_complex_radix2_backward(gsl_complex_packed_array data, size_t stride, size_t n);

int  gsl_fft_complex_radix2_inverse(gsl_complex_packed_array data, size_t stride, size_t n);

int  gsl_fft_complex_radix2_transform(gsl_complex_packed_array data, size_t stride, size_t n, gsl_fft_direction sign);

int  gsl_fft_complex_radix2_dif_forward(gsl_complex_packed_array data, size_t stride, size_t n);

int  gsl_fft_complex_radix2_dif_backward(gsl_complex_packed_array data, size_t stride, size_t n);

int  gsl_fft_complex_radix2_dif_inverse(gsl_complex_packed_array data, size_t stride, size_t n);

int  gsl_fft_complex_radix2_dif_transform(gsl_complex_packed_array data, size_t stride, size_t n, gsl_fft_direction sign);

/*  Mixed Radix general-N routines  */

struct gsl_fft_complex_wavetable
{
    size_t n;
    size_t nf;
    size_t [64]factor;
    gsl_complex *[64]twiddle;
    gsl_complex *trig;
};

struct gsl_fft_complex_workspace
{
    size_t n;
    double *scratch;
};

gsl_fft_complex_wavetable * gsl_fft_complex_wavetable_alloc(size_t n);

void  gsl_fft_complex_wavetable_free(gsl_fft_complex_wavetable *wavetable);

gsl_fft_complex_workspace * gsl_fft_complex_workspace_alloc(size_t n);

void  gsl_fft_complex_workspace_free(gsl_fft_complex_workspace *workspace);

int  gsl_fft_complex_memcpy(gsl_fft_complex_wavetable *dest, gsl_fft_complex_wavetable *src);

int  gsl_fft_complex_forward(gsl_complex_packed_array data, size_t stride, size_t n, gsl_fft_complex_wavetable *wavetable, gsl_fft_complex_workspace *work);

int  gsl_fft_complex_backward(gsl_complex_packed_array data, size_t stride, size_t n, gsl_fft_complex_wavetable *wavetable, gsl_fft_complex_workspace *work);

int  gsl_fft_complex_inverse(gsl_complex_packed_array data, size_t stride, size_t n, gsl_fft_complex_wavetable *wavetable, gsl_fft_complex_workspace *work);

int  gsl_fft_complex_transform(gsl_complex_packed_array data, size_t stride, size_t n, gsl_fft_complex_wavetable *wavetable, gsl_fft_complex_workspace *work, gsl_fft_direction sign);


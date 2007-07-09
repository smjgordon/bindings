/* Converted to D from gsl_fft_real_float.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_fft_real_float;
/* fft/gsl_fft_real_float.h
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

extern (C):
int  gsl_fft_real_float_radix2_transform(float *data, size_t stride, size_t n);

struct gsl_fft_real_wavetable_float
{
    size_t n;
    size_t nf;
    size_t [64]factor;
    gsl_complex_float *[64]twiddle;
    gsl_complex_float *trig;
};

struct gsl_fft_real_workspace_float
{
    size_t n;
    float *scratch;
};

gsl_fft_real_wavetable_float * gsl_fft_real_wavetable_float_alloc(size_t n);

void  gsl_fft_real_wavetable_float_free(gsl_fft_real_wavetable_float *wavetable);

gsl_fft_real_workspace_float * gsl_fft_real_workspace_float_alloc(size_t n);

void  gsl_fft_real_workspace_float_free(gsl_fft_real_workspace_float *workspace);

int  gsl_fft_real_float_transform(float *data, size_t stride, size_t n, gsl_fft_real_wavetable_float *wavetable, gsl_fft_real_workspace_float *work);

int  gsl_fft_real_float_unpack(float *real_float_coefficient, float *complex_coefficient, size_t stride, size_t n);


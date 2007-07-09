/* Converted to D from gsl_vector_float.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_vector_float;
/* vector/gsl_vector_float.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Gerard Jungman, Brian Gough
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

import tango.stdc.stdlib;
import tango.stdc.stdio;

public import gsl.gsl_types;

public import gsl.gsl_errno;

public import gsl.gsl_check_range;

public import gsl.gsl_block_float;

extern (C):
struct gsl_vector_float
{
    size_t size;
    size_t stride;
    float *data;
    gsl_block_float *block;
    int owner;
};

struct _gsl_vector_float_view
{
    gsl_vector_float vector;
};
alias _gsl_vector_float_view gsl_vector_float_view;

struct _gsl_vector_float_const_view
{
    gsl_vector_float vector;
};
alias _gsl_vector_float_const_view gsl_vector_float_const_view;

/* Allocation */

gsl_vector_float * gsl_vector_float_alloc(size_t n);

gsl_vector_float * gsl_vector_float_calloc(size_t n);

gsl_vector_float * gsl_vector_float_alloc_from_block(gsl_block_float *b, size_t offset, size_t n, size_t stride);

gsl_vector_float * gsl_vector_float_alloc_from_vector(gsl_vector_float *v, size_t offset, size_t n, size_t stride);

void  gsl_vector_float_free(gsl_vector_float *v);

/* Views */

_gsl_vector_float_view  gsl_vector_float_view_array(float *v, size_t n);

_gsl_vector_float_view  gsl_vector_float_view_array_with_stride(float *base, size_t stride, size_t n);

_gsl_vector_float_const_view  gsl_vector_float_const_view_array(float *v, size_t n);

_gsl_vector_float_const_view  gsl_vector_float_const_view_array_with_stride(float *base, size_t stride, size_t n);

_gsl_vector_float_view  gsl_vector_float_subvector(gsl_vector_float *v, size_t i, size_t n);

_gsl_vector_float_view  gsl_vector_float_subvector_with_stride(gsl_vector_float *v, size_t i, size_t stride, size_t n);

_gsl_vector_float_const_view  gsl_vector_float_const_subvector(gsl_vector_float *v, size_t i, size_t n);

_gsl_vector_float_const_view  gsl_vector_float_const_subvector_with_stride(gsl_vector_float *v, size_t i, size_t stride, size_t n);

/* Operations */

float  gsl_vector_float_get(gsl_vector_float *v, size_t i);

void  gsl_vector_float_set(gsl_vector_float *v, size_t i, float x);

float * gsl_vector_float_ptr(gsl_vector_float *v, size_t i);

float * gsl_vector_float_const_ptr(gsl_vector_float *v, size_t i);

void  gsl_vector_float_set_zero(gsl_vector_float *v);

void  gsl_vector_float_set_all(gsl_vector_float *v, float x);

int  gsl_vector_float_set_basis(gsl_vector_float *v, size_t i);

int  gsl_vector_float_fread(FILE *stream, gsl_vector_float *v);

int  gsl_vector_float_fwrite(FILE *stream, gsl_vector_float *v);

int  gsl_vector_float_fscanf(FILE *stream, gsl_vector_float *v);

int  gsl_vector_float_fprintf(FILE *stream, gsl_vector_float *v, char *format);

int  gsl_vector_float_memcpy(gsl_vector_float *dest, gsl_vector_float *src);

int  gsl_vector_float_reverse(gsl_vector_float *v);

int  gsl_vector_float_swap(gsl_vector_float *v, gsl_vector_float *w);

int  gsl_vector_float_swap_elements(gsl_vector_float *v, size_t i, size_t j);

float  gsl_vector_float_max(gsl_vector_float *v);

float  gsl_vector_float_min(gsl_vector_float *v);

void  gsl_vector_float_minmax(gsl_vector_float *v, float *min_out, float *max_out);

size_t  gsl_vector_float_max_index(gsl_vector_float *v);

size_t  gsl_vector_float_min_index(gsl_vector_float *v);

void  gsl_vector_float_minmax_index(gsl_vector_float *v, size_t *imin, size_t *imax);

int  gsl_vector_float_add(gsl_vector_float *a, gsl_vector_float *b);

int  gsl_vector_float_sub(gsl_vector_float *a, gsl_vector_float *b);

int  gsl_vector_float_mul(gsl_vector_float *a, gsl_vector_float *b);

int  gsl_vector_float_div(gsl_vector_float *a, gsl_vector_float *b);

int  gsl_vector_float_scale(gsl_vector_float *a, double x);

int  gsl_vector_float_add_constant(gsl_vector_float *a, double x);

int  gsl_vector_float_isnull(gsl_vector_float *v);


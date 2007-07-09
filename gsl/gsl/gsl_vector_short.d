/* Converted to D from gsl_vector_short.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_vector_short;
/* vector/gsl_vector_short.h
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

public import gsl.gsl_block_short;

extern (C):
struct gsl_vector_short
{
    size_t size;
    size_t stride;
    short *data;
    gsl_block_short *block;
    int owner;
};

struct _gsl_vector_short_view
{
    gsl_vector_short vector;
};
alias _gsl_vector_short_view gsl_vector_short_view;

struct _gsl_vector_short_const_view
{
    gsl_vector_short vector;
};
alias _gsl_vector_short_const_view gsl_vector_short_const_view;

/* Allocation */

gsl_vector_short * gsl_vector_short_alloc(size_t n);

gsl_vector_short * gsl_vector_short_calloc(size_t n);

gsl_vector_short * gsl_vector_short_alloc_from_block(gsl_block_short *b, size_t offset, size_t n, size_t stride);

gsl_vector_short * gsl_vector_short_alloc_from_vector(gsl_vector_short *v, size_t offset, size_t n, size_t stride);

void  gsl_vector_short_free(gsl_vector_short *v);

/* Views */

_gsl_vector_short_view  gsl_vector_short_view_array(short *v, size_t n);

_gsl_vector_short_view  gsl_vector_short_view_array_with_stride(short *base, size_t stride, size_t n);

_gsl_vector_short_const_view  gsl_vector_short_const_view_array(short *v, size_t n);

_gsl_vector_short_const_view  gsl_vector_short_const_view_array_with_stride(short *base, size_t stride, size_t n);

_gsl_vector_short_view  gsl_vector_short_subvector(gsl_vector_short *v, size_t i, size_t n);

_gsl_vector_short_view  gsl_vector_short_subvector_with_stride(gsl_vector_short *v, size_t i, size_t stride, size_t n);

_gsl_vector_short_const_view  gsl_vector_short_const_subvector(gsl_vector_short *v, size_t i, size_t n);

_gsl_vector_short_const_view  gsl_vector_short_const_subvector_with_stride(gsl_vector_short *v, size_t i, size_t stride, size_t n);

/* Operations */

short  gsl_vector_short_get(gsl_vector_short *v, size_t i);

void  gsl_vector_short_set(gsl_vector_short *v, size_t i, short x);

short * gsl_vector_short_ptr(gsl_vector_short *v, size_t i);

short * gsl_vector_short_const_ptr(gsl_vector_short *v, size_t i);

void  gsl_vector_short_set_zero(gsl_vector_short *v);

void  gsl_vector_short_set_all(gsl_vector_short *v, short x);

int  gsl_vector_short_set_basis(gsl_vector_short *v, size_t i);

int  gsl_vector_short_fread(FILE *stream, gsl_vector_short *v);

int  gsl_vector_short_fwrite(FILE *stream, gsl_vector_short *v);

int  gsl_vector_short_fscanf(FILE *stream, gsl_vector_short *v);

int  gsl_vector_short_fprintf(FILE *stream, gsl_vector_short *v, char *format);

int  gsl_vector_short_memcpy(gsl_vector_short *dest, gsl_vector_short *src);

int  gsl_vector_short_reverse(gsl_vector_short *v);

int  gsl_vector_short_swap(gsl_vector_short *v, gsl_vector_short *w);

int  gsl_vector_short_swap_elements(gsl_vector_short *v, size_t i, size_t j);

short  gsl_vector_short_max(gsl_vector_short *v);

short  gsl_vector_short_min(gsl_vector_short *v);

void  gsl_vector_short_minmax(gsl_vector_short *v, short *min_out, short *max_out);

size_t  gsl_vector_short_max_index(gsl_vector_short *v);

size_t  gsl_vector_short_min_index(gsl_vector_short *v);

void  gsl_vector_short_minmax_index(gsl_vector_short *v, size_t *imin, size_t *imax);

int  gsl_vector_short_add(gsl_vector_short *a, gsl_vector_short *b);

int  gsl_vector_short_sub(gsl_vector_short *a, gsl_vector_short *b);

int  gsl_vector_short_mul(gsl_vector_short *a, gsl_vector_short *b);

int  gsl_vector_short_div(gsl_vector_short *a, gsl_vector_short *b);

int  gsl_vector_short_scale(gsl_vector_short *a, double x);

int  gsl_vector_short_add_constant(gsl_vector_short *a, double x);

int  gsl_vector_short_isnull(gsl_vector_short *v);


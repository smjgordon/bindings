/* Converted to D from gsl_vector_uint.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_vector_uint;
/* vector/gsl_vector_uint.h
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

public import gsl.gsl_block_uint;

extern (C):
struct gsl_vector_uint
{
    size_t size;
    size_t stride;
    uint *data;
    gsl_block_uint *block;
    int owner;
};

struct _gsl_vector_uint_view
{
    gsl_vector_uint vector;
};
alias _gsl_vector_uint_view gsl_vector_uint_view;

struct _gsl_vector_uint_const_view
{
    gsl_vector_uint vector;
};
alias _gsl_vector_uint_const_view gsl_vector_uint_const_view;

/* Allocation */

gsl_vector_uint * gsl_vector_uint_alloc(size_t n);

gsl_vector_uint * gsl_vector_uint_calloc(size_t n);

gsl_vector_uint * gsl_vector_uint_alloc_from_block(gsl_block_uint *b, size_t offset, size_t n, size_t stride);

gsl_vector_uint * gsl_vector_uint_alloc_from_vector(gsl_vector_uint *v, size_t offset, size_t n, size_t stride);

void  gsl_vector_uint_free(gsl_vector_uint *v);

/* Views */

_gsl_vector_uint_view  gsl_vector_uint_view_array(uint *v, size_t n);

_gsl_vector_uint_view  gsl_vector_uint_view_array_with_stride(uint *base, size_t stride, size_t n);

_gsl_vector_uint_const_view  gsl_vector_uint_const_view_array(uint *v, size_t n);

_gsl_vector_uint_const_view  gsl_vector_uint_const_view_array_with_stride(uint *base, size_t stride, size_t n);

_gsl_vector_uint_view  gsl_vector_uint_subvector(gsl_vector_uint *v, size_t i, size_t n);

_gsl_vector_uint_view  gsl_vector_uint_subvector_with_stride(gsl_vector_uint *v, size_t i, size_t stride, size_t n);

_gsl_vector_uint_const_view  gsl_vector_uint_const_subvector(gsl_vector_uint *v, size_t i, size_t n);

_gsl_vector_uint_const_view  gsl_vector_uint_const_subvector_with_stride(gsl_vector_uint *v, size_t i, size_t stride, size_t n);

/* Operations */

uint  gsl_vector_uint_get(gsl_vector_uint *v, size_t i);

void  gsl_vector_uint_set(gsl_vector_uint *v, size_t i, uint x);

uint * gsl_vector_uint_ptr(gsl_vector_uint *v, size_t i);

uint * gsl_vector_uint_const_ptr(gsl_vector_uint *v, size_t i);

void  gsl_vector_uint_set_zero(gsl_vector_uint *v);

void  gsl_vector_uint_set_all(gsl_vector_uint *v, uint x);

int  gsl_vector_uint_set_basis(gsl_vector_uint *v, size_t i);

int  gsl_vector_uint_fread(FILE *stream, gsl_vector_uint *v);

int  gsl_vector_uint_fwrite(FILE *stream, gsl_vector_uint *v);

int  gsl_vector_uint_fscanf(FILE *stream, gsl_vector_uint *v);

int  gsl_vector_uint_fprintf(FILE *stream, gsl_vector_uint *v, char *format);

int  gsl_vector_uint_memcpy(gsl_vector_uint *dest, gsl_vector_uint *src);

int  gsl_vector_uint_reverse(gsl_vector_uint *v);

int  gsl_vector_uint_swap(gsl_vector_uint *v, gsl_vector_uint *w);

int  gsl_vector_uint_swap_elements(gsl_vector_uint *v, size_t i, size_t j);

uint  gsl_vector_uint_max(gsl_vector_uint *v);

uint  gsl_vector_uint_min(gsl_vector_uint *v);

void  gsl_vector_uint_minmax(gsl_vector_uint *v, uint *min_out, uint *max_out);

size_t  gsl_vector_uint_max_index(gsl_vector_uint *v);

size_t  gsl_vector_uint_min_index(gsl_vector_uint *v);

void  gsl_vector_uint_minmax_index(gsl_vector_uint *v, size_t *imin, size_t *imax);

int  gsl_vector_uint_add(gsl_vector_uint *a, gsl_vector_uint *b);

int  gsl_vector_uint_sub(gsl_vector_uint *a, gsl_vector_uint *b);

int  gsl_vector_uint_mul(gsl_vector_uint *a, gsl_vector_uint *b);

int  gsl_vector_uint_div(gsl_vector_uint *a, gsl_vector_uint *b);

int  gsl_vector_uint_scale(gsl_vector_uint *a, double x);

int  gsl_vector_uint_add_constant(gsl_vector_uint *a, double x);

int  gsl_vector_uint_isnull(gsl_vector_uint *v);


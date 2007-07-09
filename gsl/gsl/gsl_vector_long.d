/* Converted to D from gsl_vector_long.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_vector_long;
/* vector/gsl_vector_long.h
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

public import gsl.gsl_block_long;

extern (C):
struct gsl_vector_long
{
    size_t size;
    size_t stride;
    int *data;
    gsl_block_long *block;
    int owner;
};

struct _gsl_vector_long_view
{
    gsl_vector_long vector;
};
alias _gsl_vector_long_view gsl_vector_long_view;

struct _gsl_vector_long_const_view
{
    gsl_vector_long vector;
};
alias _gsl_vector_long_const_view gsl_vector_long_const_view;

/* Allocation */

gsl_vector_long * gsl_vector_long_alloc(size_t n);

gsl_vector_long * gsl_vector_long_calloc(size_t n);

gsl_vector_long * gsl_vector_long_alloc_from_block(gsl_block_long *b, size_t offset, size_t n, size_t stride);

gsl_vector_long * gsl_vector_long_alloc_from_vector(gsl_vector_long *v, size_t offset, size_t n, size_t stride);

void  gsl_vector_long_free(gsl_vector_long *v);

/* Views */

_gsl_vector_long_view  gsl_vector_long_view_array(int *v, size_t n);

_gsl_vector_long_view  gsl_vector_long_view_array_with_stride(int *base, size_t stride, size_t n);

_gsl_vector_long_const_view  gsl_vector_long_const_view_array(int *v, size_t n);

_gsl_vector_long_const_view  gsl_vector_long_const_view_array_with_stride(int *base, size_t stride, size_t n);

_gsl_vector_long_view  gsl_vector_long_subvector(gsl_vector_long *v, size_t i, size_t n);

_gsl_vector_long_view  gsl_vector_long_subvector_with_stride(gsl_vector_long *v, size_t i, size_t stride, size_t n);

_gsl_vector_long_const_view  gsl_vector_long_const_subvector(gsl_vector_long *v, size_t i, size_t n);

_gsl_vector_long_const_view  gsl_vector_long_const_subvector_with_stride(gsl_vector_long *v, size_t i, size_t stride, size_t n);

/* Operations */

int  gsl_vector_long_get(gsl_vector_long *v, size_t i);

void  gsl_vector_long_set(gsl_vector_long *v, size_t i, int x);

int * gsl_vector_long_ptr(gsl_vector_long *v, size_t i);

int * gsl_vector_long_const_ptr(gsl_vector_long *v, size_t i);

void  gsl_vector_long_set_zero(gsl_vector_long *v);

void  gsl_vector_long_set_all(gsl_vector_long *v, int x);

int  gsl_vector_long_set_basis(gsl_vector_long *v, size_t i);

int  gsl_vector_long_fread(FILE *stream, gsl_vector_long *v);

int  gsl_vector_long_fwrite(FILE *stream, gsl_vector_long *v);

int  gsl_vector_long_fscanf(FILE *stream, gsl_vector_long *v);

int  gsl_vector_long_fprintf(FILE *stream, gsl_vector_long *v, char *format);

int  gsl_vector_long_memcpy(gsl_vector_long *dest, gsl_vector_long *src);

int  gsl_vector_long_reverse(gsl_vector_long *v);

int  gsl_vector_long_swap(gsl_vector_long *v, gsl_vector_long *w);

int  gsl_vector_long_swap_elements(gsl_vector_long *v, size_t i, size_t j);

int  gsl_vector_long_max(gsl_vector_long *v);

int  gsl_vector_long_min(gsl_vector_long *v);

void  gsl_vector_long_minmax(gsl_vector_long *v, int *min_out, int *max_out);

size_t  gsl_vector_long_max_index(gsl_vector_long *v);

size_t  gsl_vector_long_min_index(gsl_vector_long *v);

void  gsl_vector_long_minmax_index(gsl_vector_long *v, size_t *imin, size_t *imax);

int  gsl_vector_long_add(gsl_vector_long *a, gsl_vector_long *b);

int  gsl_vector_long_sub(gsl_vector_long *a, gsl_vector_long *b);

int  gsl_vector_long_mul(gsl_vector_long *a, gsl_vector_long *b);

int  gsl_vector_long_div(gsl_vector_long *a, gsl_vector_long *b);

int  gsl_vector_long_scale(gsl_vector_long *a, double x);

int  gsl_vector_long_add_constant(gsl_vector_long *a, double x);

int  gsl_vector_long_isnull(gsl_vector_long *v);


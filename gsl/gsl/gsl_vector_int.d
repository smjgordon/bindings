/* Converted to D from gsl_vector_int.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_vector_int;
/* vector/gsl_vector_int.h
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

public import gsl.gsl_block_int;

extern (C):
struct gsl_vector_int
{
    size_t size;
    size_t stride;
    int *data;
    gsl_block_int *block;
    int owner;
};

struct _gsl_vector_int_view
{
    gsl_vector_int vector;
};
alias _gsl_vector_int_view gsl_vector_int_view;

struct _gsl_vector_int_const_view
{
    gsl_vector_int vector;
};
alias _gsl_vector_int_const_view gsl_vector_int_const_view;

/* Allocation */

gsl_vector_int * gsl_vector_int_alloc(size_t n);

gsl_vector_int * gsl_vector_int_calloc(size_t n);

gsl_vector_int * gsl_vector_int_alloc_from_block(gsl_block_int *b, size_t offset, size_t n, size_t stride);

gsl_vector_int * gsl_vector_int_alloc_from_vector(gsl_vector_int *v, size_t offset, size_t n, size_t stride);

void  gsl_vector_int_free(gsl_vector_int *v);

/* Views */

_gsl_vector_int_view  gsl_vector_int_view_array(int *v, size_t n);

_gsl_vector_int_view  gsl_vector_int_view_array_with_stride(int *base, size_t stride, size_t n);

_gsl_vector_int_const_view  gsl_vector_int_const_view_array(int *v, size_t n);

_gsl_vector_int_const_view  gsl_vector_int_const_view_array_with_stride(int *base, size_t stride, size_t n);

_gsl_vector_int_view  gsl_vector_int_subvector(gsl_vector_int *v, size_t i, size_t n);

_gsl_vector_int_view  gsl_vector_int_subvector_with_stride(gsl_vector_int *v, size_t i, size_t stride, size_t n);

_gsl_vector_int_const_view  gsl_vector_int_const_subvector(gsl_vector_int *v, size_t i, size_t n);

_gsl_vector_int_const_view  gsl_vector_int_const_subvector_with_stride(gsl_vector_int *v, size_t i, size_t stride, size_t n);

/* Operations */

int  gsl_vector_int_get(gsl_vector_int *v, size_t i);

void  gsl_vector_int_set(gsl_vector_int *v, size_t i, int x);

int * gsl_vector_int_ptr(gsl_vector_int *v, size_t i);

int * gsl_vector_int_const_ptr(gsl_vector_int *v, size_t i);

void  gsl_vector_int_set_zero(gsl_vector_int *v);

void  gsl_vector_int_set_all(gsl_vector_int *v, int x);

int  gsl_vector_int_set_basis(gsl_vector_int *v, size_t i);

int  gsl_vector_int_fread(FILE *stream, gsl_vector_int *v);

int  gsl_vector_int_fwrite(FILE *stream, gsl_vector_int *v);

int  gsl_vector_int_fscanf(FILE *stream, gsl_vector_int *v);

int  gsl_vector_int_fprintf(FILE *stream, gsl_vector_int *v, char *format);

int  gsl_vector_int_memcpy(gsl_vector_int *dest, gsl_vector_int *src);

int  gsl_vector_int_reverse(gsl_vector_int *v);

int  gsl_vector_int_swap(gsl_vector_int *v, gsl_vector_int *w);

int  gsl_vector_int_swap_elements(gsl_vector_int *v, size_t i, size_t j);

int  gsl_vector_int_max(gsl_vector_int *v);

int  gsl_vector_int_min(gsl_vector_int *v);

void  gsl_vector_int_minmax(gsl_vector_int *v, int *min_out, int *max_out);

size_t  gsl_vector_int_max_index(gsl_vector_int *v);

size_t  gsl_vector_int_min_index(gsl_vector_int *v);

void  gsl_vector_int_minmax_index(gsl_vector_int *v, size_t *imin, size_t *imax);

int  gsl_vector_int_add(gsl_vector_int *a, gsl_vector_int *b);

int  gsl_vector_int_sub(gsl_vector_int *a, gsl_vector_int *b);

int  gsl_vector_int_mul(gsl_vector_int *a, gsl_vector_int *b);

int  gsl_vector_int_div(gsl_vector_int *a, gsl_vector_int *b);

int  gsl_vector_int_scale(gsl_vector_int *a, double x);

int  gsl_vector_int_add_constant(gsl_vector_int *a, double x);

int  gsl_vector_int_isnull(gsl_vector_int *v);


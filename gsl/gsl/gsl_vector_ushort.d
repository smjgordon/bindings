/* Converted to D from gsl_vector_ushort.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_vector_ushort;
/* vector/gsl_vector_ushort.h
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

public import gsl.gsl_block_ushort;

extern (C):
struct gsl_vector_ushort
{
    size_t size;
    size_t stride;
    ushort *data;
    gsl_block_ushort *block;
    int owner;
};

struct _gsl_vector_ushort_view
{
    gsl_vector_ushort vector;
};
alias _gsl_vector_ushort_view gsl_vector_ushort_view;

struct _gsl_vector_ushort_const_view
{
    gsl_vector_ushort vector;
};
alias _gsl_vector_ushort_const_view gsl_vector_ushort_const_view;

/* Allocation */

gsl_vector_ushort * gsl_vector_ushort_alloc(size_t n);

gsl_vector_ushort * gsl_vector_ushort_calloc(size_t n);

gsl_vector_ushort * gsl_vector_ushort_alloc_from_block(gsl_block_ushort *b, size_t offset, size_t n, size_t stride);

gsl_vector_ushort * gsl_vector_ushort_alloc_from_vector(gsl_vector_ushort *v, size_t offset, size_t n, size_t stride);

void  gsl_vector_ushort_free(gsl_vector_ushort *v);

/* Views */

_gsl_vector_ushort_view  gsl_vector_ushort_view_array(ushort *v, size_t n);

_gsl_vector_ushort_view  gsl_vector_ushort_view_array_with_stride(ushort *base, size_t stride, size_t n);

_gsl_vector_ushort_const_view  gsl_vector_ushort_const_view_array(ushort *v, size_t n);

_gsl_vector_ushort_const_view  gsl_vector_ushort_const_view_array_with_stride(ushort *base, size_t stride, size_t n);

_gsl_vector_ushort_view  gsl_vector_ushort_subvector(gsl_vector_ushort *v, size_t i, size_t n);

_gsl_vector_ushort_view  gsl_vector_ushort_subvector_with_stride(gsl_vector_ushort *v, size_t i, size_t stride, size_t n);

_gsl_vector_ushort_const_view  gsl_vector_ushort_const_subvector(gsl_vector_ushort *v, size_t i, size_t n);

_gsl_vector_ushort_const_view  gsl_vector_ushort_const_subvector_with_stride(gsl_vector_ushort *v, size_t i, size_t stride, size_t n);

/* Operations */

ushort  gsl_vector_ushort_get(gsl_vector_ushort *v, size_t i);

void  gsl_vector_ushort_set(gsl_vector_ushort *v, size_t i, ushort x);

ushort * gsl_vector_ushort_ptr(gsl_vector_ushort *v, size_t i);

ushort * gsl_vector_ushort_const_ptr(gsl_vector_ushort *v, size_t i);

void  gsl_vector_ushort_set_zero(gsl_vector_ushort *v);

void  gsl_vector_ushort_set_all(gsl_vector_ushort *v, ushort x);

int  gsl_vector_ushort_set_basis(gsl_vector_ushort *v, size_t i);

int  gsl_vector_ushort_fread(FILE *stream, gsl_vector_ushort *v);

int  gsl_vector_ushort_fwrite(FILE *stream, gsl_vector_ushort *v);

int  gsl_vector_ushort_fscanf(FILE *stream, gsl_vector_ushort *v);

int  gsl_vector_ushort_fprintf(FILE *stream, gsl_vector_ushort *v, char *format);

int  gsl_vector_ushort_memcpy(gsl_vector_ushort *dest, gsl_vector_ushort *src);

int  gsl_vector_ushort_reverse(gsl_vector_ushort *v);

int  gsl_vector_ushort_swap(gsl_vector_ushort *v, gsl_vector_ushort *w);

int  gsl_vector_ushort_swap_elements(gsl_vector_ushort *v, size_t i, size_t j);

ushort  gsl_vector_ushort_max(gsl_vector_ushort *v);

ushort  gsl_vector_ushort_min(gsl_vector_ushort *v);

void  gsl_vector_ushort_minmax(gsl_vector_ushort *v, ushort *min_out, ushort *max_out);

size_t  gsl_vector_ushort_max_index(gsl_vector_ushort *v);

size_t  gsl_vector_ushort_min_index(gsl_vector_ushort *v);

void  gsl_vector_ushort_minmax_index(gsl_vector_ushort *v, size_t *imin, size_t *imax);

int  gsl_vector_ushort_add(gsl_vector_ushort *a, gsl_vector_ushort *b);

int  gsl_vector_ushort_sub(gsl_vector_ushort *a, gsl_vector_ushort *b);

int  gsl_vector_ushort_mul(gsl_vector_ushort *a, gsl_vector_ushort *b);

int  gsl_vector_ushort_div(gsl_vector_ushort *a, gsl_vector_ushort *b);

int  gsl_vector_ushort_scale(gsl_vector_ushort *a, double x);

int  gsl_vector_ushort_add_constant(gsl_vector_ushort *a, double x);

int  gsl_vector_ushort_isnull(gsl_vector_ushort *v);


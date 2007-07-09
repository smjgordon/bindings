/* Converted to D from gsl_vector_uchar.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_vector_uchar;
/* vector/gsl_vector_uchar.h
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

public import gsl.gsl_block_uchar;

extern (C):
struct gsl_vector_uchar
{
    size_t size;
    size_t stride;
    ubyte *data;
    gsl_block_uchar *block;
    int owner;
};

struct _gsl_vector_uchar_view
{
    gsl_vector_uchar vector;
};
alias _gsl_vector_uchar_view gsl_vector_uchar_view;

struct _gsl_vector_uchar_const_view
{
    gsl_vector_uchar vector;
};
alias _gsl_vector_uchar_const_view gsl_vector_uchar_const_view;

/* Allocation */

gsl_vector_uchar * gsl_vector_uchar_alloc(size_t n);

gsl_vector_uchar * gsl_vector_uchar_calloc(size_t n);

gsl_vector_uchar * gsl_vector_uchar_alloc_from_block(gsl_block_uchar *b, size_t offset, size_t n, size_t stride);

gsl_vector_uchar * gsl_vector_uchar_alloc_from_vector(gsl_vector_uchar *v, size_t offset, size_t n, size_t stride);

void  gsl_vector_uchar_free(gsl_vector_uchar *v);

/* Views */

_gsl_vector_uchar_view  gsl_vector_uchar_view_array(ubyte *v, size_t n);

_gsl_vector_uchar_view  gsl_vector_uchar_view_array_with_stride(ubyte *base, size_t stride, size_t n);

_gsl_vector_uchar_const_view  gsl_vector_uchar_const_view_array(ubyte *v, size_t n);

_gsl_vector_uchar_const_view  gsl_vector_uchar_const_view_array_with_stride(ubyte *base, size_t stride, size_t n);

_gsl_vector_uchar_view  gsl_vector_uchar_subvector(gsl_vector_uchar *v, size_t i, size_t n);

_gsl_vector_uchar_view  gsl_vector_uchar_subvector_with_stride(gsl_vector_uchar *v, size_t i, size_t stride, size_t n);

_gsl_vector_uchar_const_view  gsl_vector_uchar_const_subvector(gsl_vector_uchar *v, size_t i, size_t n);

_gsl_vector_uchar_const_view  gsl_vector_uchar_const_subvector_with_stride(gsl_vector_uchar *v, size_t i, size_t stride, size_t n);

/* Operations */

ubyte  gsl_vector_uchar_get(gsl_vector_uchar *v, size_t i);

void  gsl_vector_uchar_set(gsl_vector_uchar *v, size_t i, ubyte x);

ubyte * gsl_vector_uchar_ptr(gsl_vector_uchar *v, size_t i);

ubyte * gsl_vector_uchar_const_ptr(gsl_vector_uchar *v, size_t i);

void  gsl_vector_uchar_set_zero(gsl_vector_uchar *v);

void  gsl_vector_uchar_set_all(gsl_vector_uchar *v, ubyte x);

int  gsl_vector_uchar_set_basis(gsl_vector_uchar *v, size_t i);

int  gsl_vector_uchar_fread(FILE *stream, gsl_vector_uchar *v);

int  gsl_vector_uchar_fwrite(FILE *stream, gsl_vector_uchar *v);

int  gsl_vector_uchar_fscanf(FILE *stream, gsl_vector_uchar *v);

int  gsl_vector_uchar_fprintf(FILE *stream, gsl_vector_uchar *v, char *format);

int  gsl_vector_uchar_memcpy(gsl_vector_uchar *dest, gsl_vector_uchar *src);

int  gsl_vector_uchar_reverse(gsl_vector_uchar *v);

int  gsl_vector_uchar_swap(gsl_vector_uchar *v, gsl_vector_uchar *w);

int  gsl_vector_uchar_swap_elements(gsl_vector_uchar *v, size_t i, size_t j);

ubyte  gsl_vector_uchar_max(gsl_vector_uchar *v);

ubyte  gsl_vector_uchar_min(gsl_vector_uchar *v);

void  gsl_vector_uchar_minmax(gsl_vector_uchar *v, ubyte *min_out, ubyte *max_out);

size_t  gsl_vector_uchar_max_index(gsl_vector_uchar *v);

size_t  gsl_vector_uchar_min_index(gsl_vector_uchar *v);

void  gsl_vector_uchar_minmax_index(gsl_vector_uchar *v, size_t *imin, size_t *imax);

int  gsl_vector_uchar_add(gsl_vector_uchar *a, gsl_vector_uchar *b);

int  gsl_vector_uchar_sub(gsl_vector_uchar *a, gsl_vector_uchar *b);

int  gsl_vector_uchar_mul(gsl_vector_uchar *a, gsl_vector_uchar *b);

int  gsl_vector_uchar_div(gsl_vector_uchar *a, gsl_vector_uchar *b);

int  gsl_vector_uchar_scale(gsl_vector_uchar *a, double x);

int  gsl_vector_uchar_add_constant(gsl_vector_uchar *a, double x);

int  gsl_vector_uchar_isnull(gsl_vector_uchar *v);


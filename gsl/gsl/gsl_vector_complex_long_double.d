/* Converted to D from gsl_vector_complex_long_double.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_vector_complex_long_double;
/* vector/gsl_vector_complex_long_double.h
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

public import gsl.gsl_complex;

public import gsl.gsl_check_range;

public import gsl.gsl_vector_long_double;

public import gsl.gsl_vector_complex;

public import gsl.gsl_block_complex_long_double;

extern (C):
struct gsl_vector_complex_long_double
{
    size_t size;
    size_t stride;
    real *data;
    gsl_block_complex_long_double *block;
    int owner;
};

struct _gsl_vector_complex_long_double_view
{
    gsl_vector_complex_long_double vector;
};
alias _gsl_vector_complex_long_double_view gsl_vector_complex_long_double_view;

struct _gsl_vector_complex_long_double_const_view
{
    gsl_vector_complex_long_double vector;
};
alias _gsl_vector_complex_long_double_const_view gsl_vector_complex_long_double_const_view;

/* Allocation */

gsl_vector_complex_long_double * gsl_vector_complex_long_double_alloc(size_t n);

gsl_vector_complex_long_double * gsl_vector_complex_long_double_calloc(size_t n);

gsl_vector_complex_long_double * gsl_vector_complex_long_double_alloc_from_block(gsl_block_complex_long_double *b, size_t offset, size_t n, size_t stride);

gsl_vector_complex_long_double * gsl_vector_complex_long_double_alloc_from_vector(gsl_vector_complex_long_double *v, size_t offset, size_t n, size_t stride);

void  gsl_vector_complex_long_double_free(gsl_vector_complex_long_double *v);

/* Views */

_gsl_vector_complex_long_double_view  gsl_vector_complex_long_double_view_array(real *base, size_t n);

_gsl_vector_complex_long_double_view  gsl_vector_complex_long_double_view_array_with_stride(real *base, size_t stride, size_t n);

_gsl_vector_complex_long_double_const_view  gsl_vector_complex_long_double_const_view_array(real *base, size_t n);

_gsl_vector_complex_long_double_const_view  gsl_vector_complex_long_double_const_view_array_with_stride(real *base, size_t stride, size_t n);

_gsl_vector_complex_long_double_view  gsl_vector_complex_long_double_subvector(gsl_vector_complex_long_double *base, size_t i, size_t n);

_gsl_vector_complex_long_double_view  gsl_vector_complex_long_double_subvector_with_stride(gsl_vector_complex_long_double *v, size_t i, size_t stride, size_t n);

_gsl_vector_complex_long_double_const_view  gsl_vector_complex_long_double_const_subvector(gsl_vector_complex_long_double *base, size_t i, size_t n);

_gsl_vector_complex_long_double_const_view  gsl_vector_complex_long_double_const_subvector_with_stride(gsl_vector_complex_long_double *v, size_t i, size_t stride, size_t n);

_gsl_vector_long_double_view  gsl_vector_complex_long_double_real(gsl_vector_complex_long_double *v);

_gsl_vector_long_double_view  gsl_vector_complex_long_double_imag(gsl_vector_complex_long_double *v);

_gsl_vector_long_double_const_view  gsl_vector_complex_long_double_const_real(gsl_vector_complex_long_double *v);

_gsl_vector_long_double_const_view  gsl_vector_complex_long_double_const_imag(gsl_vector_complex_long_double *v);

/* Operations */

gsl_complex_long_double  gsl_vector_complex_long_double_get(gsl_vector_complex_long_double *v, size_t i);

void  gsl_vector_complex_long_double_set(gsl_vector_complex_long_double *v, size_t i, gsl_complex_long_double z);

gsl_complex_long_double * gsl_vector_complex_long_double_ptr(gsl_vector_complex_long_double *v, size_t i);

gsl_complex_long_double * gsl_vector_complex_long_double_const_ptr(gsl_vector_complex_long_double *v, size_t i);

void  gsl_vector_complex_long_double_set_zero(gsl_vector_complex_long_double *v);

void  gsl_vector_complex_long_double_set_all(gsl_vector_complex_long_double *v, gsl_complex_long_double z);

int  gsl_vector_complex_long_double_set_basis(gsl_vector_complex_long_double *v, size_t i);

int  gsl_vector_complex_long_double_fread(FILE *stream, gsl_vector_complex_long_double *v);

int  gsl_vector_complex_long_double_fwrite(FILE *stream, gsl_vector_complex_long_double *v);

int  gsl_vector_complex_long_double_fscanf(FILE *stream, gsl_vector_complex_long_double *v);

int  gsl_vector_complex_long_double_fprintf(FILE *stream, gsl_vector_complex_long_double *v, char *format);

int  gsl_vector_complex_long_double_memcpy(gsl_vector_complex_long_double *dest, gsl_vector_complex_long_double *src);

int  gsl_vector_complex_long_double_reverse(gsl_vector_complex_long_double *v);

int  gsl_vector_complex_long_double_swap(gsl_vector_complex_long_double *v, gsl_vector_complex_long_double *w);

int  gsl_vector_complex_long_double_swap_elements(gsl_vector_complex_long_double *v, size_t i, size_t j);

int  gsl_vector_complex_long_double_isnull(gsl_vector_complex_long_double *v);


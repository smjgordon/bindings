/* Converted to D from gsl_vector_double.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_vector_double;
/* vector/gsl_vector_double.h
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

public import gsl.gsl_block_double;

extern (C):
struct gsl_vector
{
    size_t size;
    size_t stride;
    double *data;
    gsl_block *block;
    int owner;
};

struct _gsl_vector_view
{
    gsl_vector vector;
};
alias _gsl_vector_view gsl_vector_view;

struct _gsl_vector_const_view
{
    gsl_vector vector;
};
alias _gsl_vector_const_view gsl_vector_const_view;

/* Allocation */

gsl_vector * gsl_vector_alloc(size_t n);

gsl_vector * gsl_vector_calloc(size_t n);

gsl_vector * gsl_vector_alloc_from_block(gsl_block *b, size_t offset, size_t n, size_t stride);

gsl_vector * gsl_vector_alloc_from_vector(gsl_vector *v, size_t offset, size_t n, size_t stride);

void  gsl_vector_free(gsl_vector *v);

/* Views */

_gsl_vector_view  gsl_vector_view_array(double *v, size_t n);

_gsl_vector_view  gsl_vector_view_array_with_stride(double *base, size_t stride, size_t n);

_gsl_vector_const_view  gsl_vector_const_view_array(double *v, size_t n);

_gsl_vector_const_view  gsl_vector_const_view_array_with_stride(double *base, size_t stride, size_t n);

_gsl_vector_view  gsl_vector_subvector(gsl_vector *v, size_t i, size_t n);

_gsl_vector_view  gsl_vector_subvector_with_stride(gsl_vector *v, size_t i, size_t stride, size_t n);

_gsl_vector_const_view  gsl_vector_const_subvector(gsl_vector *v, size_t i, size_t n);

_gsl_vector_const_view  gsl_vector_const_subvector_with_stride(gsl_vector *v, size_t i, size_t stride, size_t n);

/* Operations */

double  gsl_vector_get(gsl_vector *v, size_t i);

void  gsl_vector_set(gsl_vector *v, size_t i, double x);

double * gsl_vector_ptr(gsl_vector *v, size_t i);

double * gsl_vector_const_ptr(gsl_vector *v, size_t i);

void  gsl_vector_set_zero(gsl_vector *v);

void  gsl_vector_set_all(gsl_vector *v, double x);

int  gsl_vector_set_basis(gsl_vector *v, size_t i);

int  gsl_vector_fread(FILE *stream, gsl_vector *v);

int  gsl_vector_fwrite(FILE *stream, gsl_vector *v);

int  gsl_vector_fscanf(FILE *stream, gsl_vector *v);

int  gsl_vector_fprintf(FILE *stream, gsl_vector *v, char *format);

int  gsl_vector_memcpy(gsl_vector *dest, gsl_vector *src);

int  gsl_vector_reverse(gsl_vector *v);

int  gsl_vector_swap(gsl_vector *v, gsl_vector *w);

int  gsl_vector_swap_elements(gsl_vector *v, size_t i, size_t j);

double  gsl_vector_max(gsl_vector *v);

double  gsl_vector_min(gsl_vector *v);

void  gsl_vector_minmax(gsl_vector *v, double *min_out, double *max_out);

size_t  gsl_vector_max_index(gsl_vector *v);

size_t  gsl_vector_min_index(gsl_vector *v);

void  gsl_vector_minmax_index(gsl_vector *v, size_t *imin, size_t *imax);

int  gsl_vector_add(gsl_vector *a, gsl_vector *b);

int  gsl_vector_sub(gsl_vector *a, gsl_vector *b);

int  gsl_vector_mul(gsl_vector *a, gsl_vector *b);

int  gsl_vector_div(gsl_vector *a, gsl_vector *b);

int  gsl_vector_scale(gsl_vector *a, double x);

int  gsl_vector_add_constant(gsl_vector *a, double x);

int  gsl_vector_isnull(gsl_vector *v);


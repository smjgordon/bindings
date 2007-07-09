/* Converted to D from gsl_matrix_ushort.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_matrix_ushort;
/* matrix/gsl_matrix_ushort.h
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

public import gsl.gsl_vector_ushort;

extern (C):
struct gsl_matrix_ushort
{
    size_t size1;
    size_t size2;
    size_t tda;
    ushort *data;
    gsl_block_ushort *block;
    int owner;
};

struct _gsl_matrix_ushort_view
{
    gsl_matrix_ushort matrix;
};
alias _gsl_matrix_ushort_view gsl_matrix_ushort_view;

struct _gsl_matrix_ushort_const_view
{
    gsl_matrix_ushort matrix;
};
alias _gsl_matrix_ushort_const_view gsl_matrix_ushort_const_view;

/* Allocation */

gsl_matrix_ushort * gsl_matrix_ushort_alloc(size_t n1, size_t n2);

gsl_matrix_ushort * gsl_matrix_ushort_calloc(size_t n1, size_t n2);

gsl_matrix_ushort * gsl_matrix_ushort_alloc_from_block(gsl_block_ushort *b, size_t offset, size_t n1, size_t n2, size_t d2);

gsl_matrix_ushort * gsl_matrix_ushort_alloc_from_matrix(gsl_matrix_ushort *m, size_t k1, size_t k2, size_t n1, size_t n2);

gsl_vector_ushort * gsl_vector_ushort_alloc_row_from_matrix(gsl_matrix_ushort *m, size_t i);

gsl_vector_ushort * gsl_vector_ushort_alloc_col_from_matrix(gsl_matrix_ushort *m, size_t j);

void  gsl_matrix_ushort_free(gsl_matrix_ushort *m);

/* Views */

_gsl_matrix_ushort_view  gsl_matrix_ushort_submatrix(gsl_matrix_ushort *m, size_t i, size_t j, size_t n1, size_t n2);

_gsl_vector_ushort_view  gsl_matrix_ushort_row(gsl_matrix_ushort *m, size_t i);

_gsl_vector_ushort_view  gsl_matrix_ushort_column(gsl_matrix_ushort *m, size_t j);

_gsl_vector_ushort_view  gsl_matrix_ushort_diagonal(gsl_matrix_ushort *m);

_gsl_vector_ushort_view  gsl_matrix_ushort_subdiagonal(gsl_matrix_ushort *m, size_t k);

_gsl_vector_ushort_view  gsl_matrix_ushort_superdiagonal(gsl_matrix_ushort *m, size_t k);

_gsl_matrix_ushort_view  gsl_matrix_ushort_view_array(ushort *base, size_t n1, size_t n2);

_gsl_matrix_ushort_view  gsl_matrix_ushort_view_array_with_tda(ushort *base, size_t n1, size_t n2, size_t tda);

_gsl_matrix_ushort_view  gsl_matrix_ushort_view_vector(gsl_vector_ushort *v, size_t n1, size_t n2);

_gsl_matrix_ushort_view  gsl_matrix_ushort_view_vector_with_tda(gsl_vector_ushort *v, size_t n1, size_t n2, size_t tda);

_gsl_matrix_ushort_const_view  gsl_matrix_ushort_const_submatrix(gsl_matrix_ushort *m, size_t i, size_t j, size_t n1, size_t n2);

_gsl_vector_ushort_const_view  gsl_matrix_ushort_const_row(gsl_matrix_ushort *m, size_t i);

_gsl_vector_ushort_const_view  gsl_matrix_ushort_const_column(gsl_matrix_ushort *m, size_t j);

_gsl_vector_ushort_const_view  gsl_matrix_ushort_const_diagonal(gsl_matrix_ushort *m);

_gsl_vector_ushort_const_view  gsl_matrix_ushort_const_subdiagonal(gsl_matrix_ushort *m, size_t k);

_gsl_vector_ushort_const_view  gsl_matrix_ushort_const_superdiagonal(gsl_matrix_ushort *m, size_t k);

_gsl_matrix_ushort_const_view  gsl_matrix_ushort_const_view_array(ushort *base, size_t n1, size_t n2);

_gsl_matrix_ushort_const_view  gsl_matrix_ushort_const_view_array_with_tda(ushort *base, size_t n1, size_t n2, size_t tda);

_gsl_matrix_ushort_const_view  gsl_matrix_ushort_const_view_vector(gsl_vector_ushort *v, size_t n1, size_t n2);

_gsl_matrix_ushort_const_view  gsl_matrix_ushort_const_view_vector_with_tda(gsl_vector_ushort *v, size_t n1, size_t n2, size_t tda);

/* Operations */

ushort  gsl_matrix_ushort_get(gsl_matrix_ushort *m, size_t i, size_t j);

void  gsl_matrix_ushort_set(gsl_matrix_ushort *m, size_t i, size_t j, ushort x);

ushort * gsl_matrix_ushort_ptr(gsl_matrix_ushort *m, size_t i, size_t j);

ushort * gsl_matrix_ushort_const_ptr(gsl_matrix_ushort *m, size_t i, size_t j);

void  gsl_matrix_ushort_set_zero(gsl_matrix_ushort *m);

void  gsl_matrix_ushort_set_identity(gsl_matrix_ushort *m);

void  gsl_matrix_ushort_set_all(gsl_matrix_ushort *m, ushort x);

int  gsl_matrix_ushort_fread(FILE *stream, gsl_matrix_ushort *m);

int  gsl_matrix_ushort_fwrite(FILE *stream, gsl_matrix_ushort *m);

int  gsl_matrix_ushort_fscanf(FILE *stream, gsl_matrix_ushort *m);

int  gsl_matrix_ushort_fprintf(FILE *stream, gsl_matrix_ushort *m, char *format);
 

int  gsl_matrix_ushort_memcpy(gsl_matrix_ushort *dest, gsl_matrix_ushort *src);

int  gsl_matrix_ushort_swap(gsl_matrix_ushort *m1, gsl_matrix_ushort *m2);

int  gsl_matrix_ushort_swap_rows(gsl_matrix_ushort *m, size_t i, size_t j);

int  gsl_matrix_ushort_swap_columns(gsl_matrix_ushort *m, size_t i, size_t j);

int  gsl_matrix_ushort_swap_rowcol(gsl_matrix_ushort *m, size_t i, size_t j);

int  gsl_matrix_ushort_transpose(gsl_matrix_ushort *m);

int  gsl_matrix_ushort_transpose_memcpy(gsl_matrix_ushort *dest, gsl_matrix_ushort *src);

ushort  gsl_matrix_ushort_max(gsl_matrix_ushort *m);

ushort  gsl_matrix_ushort_min(gsl_matrix_ushort *m);

void  gsl_matrix_ushort_minmax(gsl_matrix_ushort *m, ushort *min_out, ushort *max_out);

void  gsl_matrix_ushort_max_index(gsl_matrix_ushort *m, size_t *imax, size_t *jmax);

void  gsl_matrix_ushort_min_index(gsl_matrix_ushort *m, size_t *imin, size_t *jmin);

void  gsl_matrix_ushort_minmax_index(gsl_matrix_ushort *m, size_t *imin, size_t *jmin, size_t *imax, size_t *jmax);

int  gsl_matrix_ushort_isnull(gsl_matrix_ushort *m);

int  gsl_matrix_ushort_add(gsl_matrix_ushort *a, gsl_matrix_ushort *b);

int  gsl_matrix_ushort_sub(gsl_matrix_ushort *a, gsl_matrix_ushort *b);

int  gsl_matrix_ushort_mul_elements(gsl_matrix_ushort *a, gsl_matrix_ushort *b);

int  gsl_matrix_ushort_div_elements(gsl_matrix_ushort *a, gsl_matrix_ushort *b);

int  gsl_matrix_ushort_scale(gsl_matrix_ushort *a, double x);

int  gsl_matrix_ushort_add_constant(gsl_matrix_ushort *a, double x);

int  gsl_matrix_ushort_add_diagonal(gsl_matrix_ushort *a, double x);

/***********************************************************************/
/* The functions below are obsolete                                    */
/***********************************************************************/

int  gsl_matrix_ushort_get_row(gsl_vector_ushort *v, gsl_matrix_ushort *m, size_t i);

int  gsl_matrix_ushort_get_col(gsl_vector_ushort *v, gsl_matrix_ushort *m, size_t j);

int  gsl_matrix_ushort_set_row(gsl_matrix_ushort *m, size_t i, gsl_vector_ushort *v);

int  gsl_matrix_ushort_set_col(gsl_matrix_ushort *m, size_t j, gsl_vector_ushort *v);

/* inline functions if you are using GCC */


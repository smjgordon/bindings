/* Converted to D from gsl_matrix_ulong.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_matrix_ulong;
/* matrix/gsl_matrix_ulong.h
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

public import gsl.gsl_vector_ulong;

extern (C):
struct gsl_matrix_ulong
{
    size_t size1;
    size_t size2;
    size_t tda;
    uint *data;
    gsl_block_ulong *block;
    int owner;
};

struct _gsl_matrix_ulong_view
{
    gsl_matrix_ulong matrix;
};
alias _gsl_matrix_ulong_view gsl_matrix_ulong_view;

struct _gsl_matrix_ulong_const_view
{
    gsl_matrix_ulong matrix;
};
alias _gsl_matrix_ulong_const_view gsl_matrix_ulong_const_view;

/* Allocation */

gsl_matrix_ulong * gsl_matrix_ulong_alloc(size_t n1, size_t n2);

gsl_matrix_ulong * gsl_matrix_ulong_calloc(size_t n1, size_t n2);

gsl_matrix_ulong * gsl_matrix_ulong_alloc_from_block(gsl_block_ulong *b, size_t offset, size_t n1, size_t n2, size_t d2);

gsl_matrix_ulong * gsl_matrix_ulong_alloc_from_matrix(gsl_matrix_ulong *m, size_t k1, size_t k2, size_t n1, size_t n2);

gsl_vector_ulong * gsl_vector_ulong_alloc_row_from_matrix(gsl_matrix_ulong *m, size_t i);

gsl_vector_ulong * gsl_vector_ulong_alloc_col_from_matrix(gsl_matrix_ulong *m, size_t j);

void  gsl_matrix_ulong_free(gsl_matrix_ulong *m);

/* Views */

_gsl_matrix_ulong_view  gsl_matrix_ulong_submatrix(gsl_matrix_ulong *m, size_t i, size_t j, size_t n1, size_t n2);

_gsl_vector_ulong_view  gsl_matrix_ulong_row(gsl_matrix_ulong *m, size_t i);

_gsl_vector_ulong_view  gsl_matrix_ulong_column(gsl_matrix_ulong *m, size_t j);

_gsl_vector_ulong_view  gsl_matrix_ulong_diagonal(gsl_matrix_ulong *m);

_gsl_vector_ulong_view  gsl_matrix_ulong_subdiagonal(gsl_matrix_ulong *m, size_t k);

_gsl_vector_ulong_view  gsl_matrix_ulong_superdiagonal(gsl_matrix_ulong *m, size_t k);

_gsl_matrix_ulong_view  gsl_matrix_ulong_view_array(uint *base, size_t n1, size_t n2);

_gsl_matrix_ulong_view  gsl_matrix_ulong_view_array_with_tda(uint *base, size_t n1, size_t n2, size_t tda);

_gsl_matrix_ulong_view  gsl_matrix_ulong_view_vector(gsl_vector_ulong *v, size_t n1, size_t n2);

_gsl_matrix_ulong_view  gsl_matrix_ulong_view_vector_with_tda(gsl_vector_ulong *v, size_t n1, size_t n2, size_t tda);

_gsl_matrix_ulong_const_view  gsl_matrix_ulong_const_submatrix(gsl_matrix_ulong *m, size_t i, size_t j, size_t n1, size_t n2);

_gsl_vector_ulong_const_view  gsl_matrix_ulong_const_row(gsl_matrix_ulong *m, size_t i);

_gsl_vector_ulong_const_view  gsl_matrix_ulong_const_column(gsl_matrix_ulong *m, size_t j);

_gsl_vector_ulong_const_view  gsl_matrix_ulong_const_diagonal(gsl_matrix_ulong *m);

_gsl_vector_ulong_const_view  gsl_matrix_ulong_const_subdiagonal(gsl_matrix_ulong *m, size_t k);

_gsl_vector_ulong_const_view  gsl_matrix_ulong_const_superdiagonal(gsl_matrix_ulong *m, size_t k);

_gsl_matrix_ulong_const_view  gsl_matrix_ulong_const_view_array(uint *base, size_t n1, size_t n2);

_gsl_matrix_ulong_const_view  gsl_matrix_ulong_const_view_array_with_tda(uint *base, size_t n1, size_t n2, size_t tda);

_gsl_matrix_ulong_const_view  gsl_matrix_ulong_const_view_vector(gsl_vector_ulong *v, size_t n1, size_t n2);

_gsl_matrix_ulong_const_view  gsl_matrix_ulong_const_view_vector_with_tda(gsl_vector_ulong *v, size_t n1, size_t n2, size_t tda);

/* Operations */

uint  gsl_matrix_ulong_get(gsl_matrix_ulong *m, size_t i, size_t j);

void  gsl_matrix_ulong_set(gsl_matrix_ulong *m, size_t i, size_t j, uint x);

uint * gsl_matrix_ulong_ptr(gsl_matrix_ulong *m, size_t i, size_t j);

uint * gsl_matrix_ulong_const_ptr(gsl_matrix_ulong *m, size_t i, size_t j);

void  gsl_matrix_ulong_set_zero(gsl_matrix_ulong *m);

void  gsl_matrix_ulong_set_identity(gsl_matrix_ulong *m);

void  gsl_matrix_ulong_set_all(gsl_matrix_ulong *m, uint x);

int  gsl_matrix_ulong_fread(FILE *stream, gsl_matrix_ulong *m);

int  gsl_matrix_ulong_fwrite(FILE *stream, gsl_matrix_ulong *m);

int  gsl_matrix_ulong_fscanf(FILE *stream, gsl_matrix_ulong *m);

int  gsl_matrix_ulong_fprintf(FILE *stream, gsl_matrix_ulong *m, char *format);
 

int  gsl_matrix_ulong_memcpy(gsl_matrix_ulong *dest, gsl_matrix_ulong *src);

int  gsl_matrix_ulong_swap(gsl_matrix_ulong *m1, gsl_matrix_ulong *m2);

int  gsl_matrix_ulong_swap_rows(gsl_matrix_ulong *m, size_t i, size_t j);

int  gsl_matrix_ulong_swap_columns(gsl_matrix_ulong *m, size_t i, size_t j);

int  gsl_matrix_ulong_swap_rowcol(gsl_matrix_ulong *m, size_t i, size_t j);

int  gsl_matrix_ulong_transpose(gsl_matrix_ulong *m);

int  gsl_matrix_ulong_transpose_memcpy(gsl_matrix_ulong *dest, gsl_matrix_ulong *src);

uint  gsl_matrix_ulong_max(gsl_matrix_ulong *m);

uint  gsl_matrix_ulong_min(gsl_matrix_ulong *m);

void  gsl_matrix_ulong_minmax(gsl_matrix_ulong *m, uint *min_out, uint *max_out);

void  gsl_matrix_ulong_max_index(gsl_matrix_ulong *m, size_t *imax, size_t *jmax);

void  gsl_matrix_ulong_min_index(gsl_matrix_ulong *m, size_t *imin, size_t *jmin);

void  gsl_matrix_ulong_minmax_index(gsl_matrix_ulong *m, size_t *imin, size_t *jmin, size_t *imax, size_t *jmax);

int  gsl_matrix_ulong_isnull(gsl_matrix_ulong *m);

int  gsl_matrix_ulong_add(gsl_matrix_ulong *a, gsl_matrix_ulong *b);

int  gsl_matrix_ulong_sub(gsl_matrix_ulong *a, gsl_matrix_ulong *b);

int  gsl_matrix_ulong_mul_elements(gsl_matrix_ulong *a, gsl_matrix_ulong *b);

int  gsl_matrix_ulong_div_elements(gsl_matrix_ulong *a, gsl_matrix_ulong *b);

int  gsl_matrix_ulong_scale(gsl_matrix_ulong *a, double x);

int  gsl_matrix_ulong_add_constant(gsl_matrix_ulong *a, double x);

int  gsl_matrix_ulong_add_diagonal(gsl_matrix_ulong *a, double x);

/***********************************************************************/
/* The functions below are obsolete                                    */
/***********************************************************************/

int  gsl_matrix_ulong_get_row(gsl_vector_ulong *v, gsl_matrix_ulong *m, size_t i);

int  gsl_matrix_ulong_get_col(gsl_vector_ulong *v, gsl_matrix_ulong *m, size_t j);

int  gsl_matrix_ulong_set_row(gsl_matrix_ulong *m, size_t i, gsl_vector_ulong *v);

int  gsl_matrix_ulong_set_col(gsl_matrix_ulong *m, size_t j, gsl_vector_ulong *v);

/* inline functions if you are using GCC */


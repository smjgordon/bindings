/* Converted to D from gsl_matrix_uchar.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_matrix_uchar;
/* matrix/gsl_matrix_uchar.h
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

public import gsl.gsl_vector_uchar;

extern (C):
struct gsl_matrix_uchar
{
    size_t size1;
    size_t size2;
    size_t tda;
    ubyte *data;
    gsl_block_uchar *block;
    int owner;
};

struct _gsl_matrix_uchar_view
{
    gsl_matrix_uchar matrix;
};
alias _gsl_matrix_uchar_view gsl_matrix_uchar_view;

struct _gsl_matrix_uchar_const_view
{
    gsl_matrix_uchar matrix;
};
alias _gsl_matrix_uchar_const_view gsl_matrix_uchar_const_view;

/* Allocation */

gsl_matrix_uchar * gsl_matrix_uchar_alloc(size_t n1, size_t n2);

gsl_matrix_uchar * gsl_matrix_uchar_calloc(size_t n1, size_t n2);

gsl_matrix_uchar * gsl_matrix_uchar_alloc_from_block(gsl_block_uchar *b, size_t offset, size_t n1, size_t n2, size_t d2);

gsl_matrix_uchar * gsl_matrix_uchar_alloc_from_matrix(gsl_matrix_uchar *m, size_t k1, size_t k2, size_t n1, size_t n2);

gsl_vector_uchar * gsl_vector_uchar_alloc_row_from_matrix(gsl_matrix_uchar *m, size_t i);

gsl_vector_uchar * gsl_vector_uchar_alloc_col_from_matrix(gsl_matrix_uchar *m, size_t j);

void  gsl_matrix_uchar_free(gsl_matrix_uchar *m);

/* Views */

_gsl_matrix_uchar_view  gsl_matrix_uchar_submatrix(gsl_matrix_uchar *m, size_t i, size_t j, size_t n1, size_t n2);

_gsl_vector_uchar_view  gsl_matrix_uchar_row(gsl_matrix_uchar *m, size_t i);

_gsl_vector_uchar_view  gsl_matrix_uchar_column(gsl_matrix_uchar *m, size_t j);

_gsl_vector_uchar_view  gsl_matrix_uchar_diagonal(gsl_matrix_uchar *m);

_gsl_vector_uchar_view  gsl_matrix_uchar_subdiagonal(gsl_matrix_uchar *m, size_t k);

_gsl_vector_uchar_view  gsl_matrix_uchar_superdiagonal(gsl_matrix_uchar *m, size_t k);

_gsl_matrix_uchar_view  gsl_matrix_uchar_view_array(ubyte *base, size_t n1, size_t n2);

_gsl_matrix_uchar_view  gsl_matrix_uchar_view_array_with_tda(ubyte *base, size_t n1, size_t n2, size_t tda);

_gsl_matrix_uchar_view  gsl_matrix_uchar_view_vector(gsl_vector_uchar *v, size_t n1, size_t n2);

_gsl_matrix_uchar_view  gsl_matrix_uchar_view_vector_with_tda(gsl_vector_uchar *v, size_t n1, size_t n2, size_t tda);

_gsl_matrix_uchar_const_view  gsl_matrix_uchar_const_submatrix(gsl_matrix_uchar *m, size_t i, size_t j, size_t n1, size_t n2);

_gsl_vector_uchar_const_view  gsl_matrix_uchar_const_row(gsl_matrix_uchar *m, size_t i);

_gsl_vector_uchar_const_view  gsl_matrix_uchar_const_column(gsl_matrix_uchar *m, size_t j);

_gsl_vector_uchar_const_view  gsl_matrix_uchar_const_diagonal(gsl_matrix_uchar *m);

_gsl_vector_uchar_const_view  gsl_matrix_uchar_const_subdiagonal(gsl_matrix_uchar *m, size_t k);

_gsl_vector_uchar_const_view  gsl_matrix_uchar_const_superdiagonal(gsl_matrix_uchar *m, size_t k);

_gsl_matrix_uchar_const_view  gsl_matrix_uchar_const_view_array(ubyte *base, size_t n1, size_t n2);

_gsl_matrix_uchar_const_view  gsl_matrix_uchar_const_view_array_with_tda(ubyte *base, size_t n1, size_t n2, size_t tda);

_gsl_matrix_uchar_const_view  gsl_matrix_uchar_const_view_vector(gsl_vector_uchar *v, size_t n1, size_t n2);

_gsl_matrix_uchar_const_view  gsl_matrix_uchar_const_view_vector_with_tda(gsl_vector_uchar *v, size_t n1, size_t n2, size_t tda);

/* Operations */

ubyte  gsl_matrix_uchar_get(gsl_matrix_uchar *m, size_t i, size_t j);

void  gsl_matrix_uchar_set(gsl_matrix_uchar *m, size_t i, size_t j, ubyte x);

ubyte * gsl_matrix_uchar_ptr(gsl_matrix_uchar *m, size_t i, size_t j);

ubyte * gsl_matrix_uchar_const_ptr(gsl_matrix_uchar *m, size_t i, size_t j);

void  gsl_matrix_uchar_set_zero(gsl_matrix_uchar *m);

void  gsl_matrix_uchar_set_identity(gsl_matrix_uchar *m);

void  gsl_matrix_uchar_set_all(gsl_matrix_uchar *m, ubyte x);

int  gsl_matrix_uchar_fread(FILE *stream, gsl_matrix_uchar *m);

int  gsl_matrix_uchar_fwrite(FILE *stream, gsl_matrix_uchar *m);

int  gsl_matrix_uchar_fscanf(FILE *stream, gsl_matrix_uchar *m);

int  gsl_matrix_uchar_fprintf(FILE *stream, gsl_matrix_uchar *m, char *format);
 

int  gsl_matrix_uchar_memcpy(gsl_matrix_uchar *dest, gsl_matrix_uchar *src);

int  gsl_matrix_uchar_swap(gsl_matrix_uchar *m1, gsl_matrix_uchar *m2);

int  gsl_matrix_uchar_swap_rows(gsl_matrix_uchar *m, size_t i, size_t j);

int  gsl_matrix_uchar_swap_columns(gsl_matrix_uchar *m, size_t i, size_t j);

int  gsl_matrix_uchar_swap_rowcol(gsl_matrix_uchar *m, size_t i, size_t j);

int  gsl_matrix_uchar_transpose(gsl_matrix_uchar *m);

int  gsl_matrix_uchar_transpose_memcpy(gsl_matrix_uchar *dest, gsl_matrix_uchar *src);

ubyte  gsl_matrix_uchar_max(gsl_matrix_uchar *m);

ubyte  gsl_matrix_uchar_min(gsl_matrix_uchar *m);

void  gsl_matrix_uchar_minmax(gsl_matrix_uchar *m, ubyte *min_out, ubyte *max_out);

void  gsl_matrix_uchar_max_index(gsl_matrix_uchar *m, size_t *imax, size_t *jmax);

void  gsl_matrix_uchar_min_index(gsl_matrix_uchar *m, size_t *imin, size_t *jmin);

void  gsl_matrix_uchar_minmax_index(gsl_matrix_uchar *m, size_t *imin, size_t *jmin, size_t *imax, size_t *jmax);

int  gsl_matrix_uchar_isnull(gsl_matrix_uchar *m);

int  gsl_matrix_uchar_add(gsl_matrix_uchar *a, gsl_matrix_uchar *b);

int  gsl_matrix_uchar_sub(gsl_matrix_uchar *a, gsl_matrix_uchar *b);

int  gsl_matrix_uchar_mul_elements(gsl_matrix_uchar *a, gsl_matrix_uchar *b);

int  gsl_matrix_uchar_div_elements(gsl_matrix_uchar *a, gsl_matrix_uchar *b);

int  gsl_matrix_uchar_scale(gsl_matrix_uchar *a, double x);

int  gsl_matrix_uchar_add_constant(gsl_matrix_uchar *a, double x);

int  gsl_matrix_uchar_add_diagonal(gsl_matrix_uchar *a, double x);

/***********************************************************************/
/* The functions below are obsolete                                    */
/***********************************************************************/

int  gsl_matrix_uchar_get_row(gsl_vector_uchar *v, gsl_matrix_uchar *m, size_t i);

int  gsl_matrix_uchar_get_col(gsl_vector_uchar *v, gsl_matrix_uchar *m, size_t j);

int  gsl_matrix_uchar_set_row(gsl_matrix_uchar *m, size_t i, gsl_vector_uchar *v);

int  gsl_matrix_uchar_set_col(gsl_matrix_uchar *m, size_t j, gsl_vector_uchar *v);

/* inline functions if you are using GCC */


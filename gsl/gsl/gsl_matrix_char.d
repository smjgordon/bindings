/* Converted to D from gsl_matrix_char.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_matrix_char;
/* matrix/gsl_matrix_char.h
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

public import gsl.gsl_vector_char;

extern (C):
struct gsl_matrix_char
{
    size_t size1;
    size_t size2;
    size_t tda;
    char *data;
    gsl_block_char *block;
    int owner;
};

struct _gsl_matrix_char_view
{
    gsl_matrix_char matrix;
};
alias _gsl_matrix_char_view gsl_matrix_char_view;

struct _gsl_matrix_char_const_view
{
    gsl_matrix_char matrix;
};
alias _gsl_matrix_char_const_view gsl_matrix_char_const_view;

/* Allocation */

gsl_matrix_char * gsl_matrix_char_alloc(size_t n1, size_t n2);

gsl_matrix_char * gsl_matrix_char_calloc(size_t n1, size_t n2);

gsl_matrix_char * gsl_matrix_char_alloc_from_block(gsl_block_char *b, size_t offset, size_t n1, size_t n2, size_t d2);

gsl_matrix_char * gsl_matrix_char_alloc_from_matrix(gsl_matrix_char *m, size_t k1, size_t k2, size_t n1, size_t n2);

gsl_vector_char * gsl_vector_char_alloc_row_from_matrix(gsl_matrix_char *m, size_t i);

gsl_vector_char * gsl_vector_char_alloc_col_from_matrix(gsl_matrix_char *m, size_t j);

void  gsl_matrix_char_free(gsl_matrix_char *m);

/* Views */

_gsl_matrix_char_view  gsl_matrix_char_submatrix(gsl_matrix_char *m, size_t i, size_t j, size_t n1, size_t n2);

_gsl_vector_char_view  gsl_matrix_char_row(gsl_matrix_char *m, size_t i);

_gsl_vector_char_view  gsl_matrix_char_column(gsl_matrix_char *m, size_t j);

_gsl_vector_char_view  gsl_matrix_char_diagonal(gsl_matrix_char *m);

_gsl_vector_char_view  gsl_matrix_char_subdiagonal(gsl_matrix_char *m, size_t k);

_gsl_vector_char_view  gsl_matrix_char_superdiagonal(gsl_matrix_char *m, size_t k);

_gsl_matrix_char_view  gsl_matrix_char_view_array(char *base, size_t n1, size_t n2);

_gsl_matrix_char_view  gsl_matrix_char_view_array_with_tda(char *base, size_t n1, size_t n2, size_t tda);

_gsl_matrix_char_view  gsl_matrix_char_view_vector(gsl_vector_char *v, size_t n1, size_t n2);

_gsl_matrix_char_view  gsl_matrix_char_view_vector_with_tda(gsl_vector_char *v, size_t n1, size_t n2, size_t tda);

_gsl_matrix_char_const_view  gsl_matrix_char_const_submatrix(gsl_matrix_char *m, size_t i, size_t j, size_t n1, size_t n2);

_gsl_vector_char_const_view  gsl_matrix_char_const_row(gsl_matrix_char *m, size_t i);

_gsl_vector_char_const_view  gsl_matrix_char_const_column(gsl_matrix_char *m, size_t j);

_gsl_vector_char_const_view  gsl_matrix_char_const_diagonal(gsl_matrix_char *m);

_gsl_vector_char_const_view  gsl_matrix_char_const_subdiagonal(gsl_matrix_char *m, size_t k);

_gsl_vector_char_const_view  gsl_matrix_char_const_superdiagonal(gsl_matrix_char *m, size_t k);

_gsl_matrix_char_const_view  gsl_matrix_char_const_view_array(char *base, size_t n1, size_t n2);

_gsl_matrix_char_const_view  gsl_matrix_char_const_view_array_with_tda(char *base, size_t n1, size_t n2, size_t tda);

_gsl_matrix_char_const_view  gsl_matrix_char_const_view_vector(gsl_vector_char *v, size_t n1, size_t n2);

_gsl_matrix_char_const_view  gsl_matrix_char_const_view_vector_with_tda(gsl_vector_char *v, size_t n1, size_t n2, size_t tda);

/* Operations */

char  gsl_matrix_char_get(gsl_matrix_char *m, size_t i, size_t j);

void  gsl_matrix_char_set(gsl_matrix_char *m, size_t i, size_t j, char x);

char * gsl_matrix_char_ptr(gsl_matrix_char *m, size_t i, size_t j);

char * gsl_matrix_char_const_ptr(gsl_matrix_char *m, size_t i, size_t j);

void  gsl_matrix_char_set_zero(gsl_matrix_char *m);

void  gsl_matrix_char_set_identity(gsl_matrix_char *m);

void  gsl_matrix_char_set_all(gsl_matrix_char *m, char x);

int  gsl_matrix_char_fread(FILE *stream, gsl_matrix_char *m);

int  gsl_matrix_char_fwrite(FILE *stream, gsl_matrix_char *m);

int  gsl_matrix_char_fscanf(FILE *stream, gsl_matrix_char *m);

int  gsl_matrix_char_fprintf(FILE *stream, gsl_matrix_char *m, char *format);
 

int  gsl_matrix_char_memcpy(gsl_matrix_char *dest, gsl_matrix_char *src);

int  gsl_matrix_char_swap(gsl_matrix_char *m1, gsl_matrix_char *m2);

int  gsl_matrix_char_swap_rows(gsl_matrix_char *m, size_t i, size_t j);

int  gsl_matrix_char_swap_columns(gsl_matrix_char *m, size_t i, size_t j);

int  gsl_matrix_char_swap_rowcol(gsl_matrix_char *m, size_t i, size_t j);

int  gsl_matrix_char_transpose(gsl_matrix_char *m);

int  gsl_matrix_char_transpose_memcpy(gsl_matrix_char *dest, gsl_matrix_char *src);

char  gsl_matrix_char_max(gsl_matrix_char *m);

char  gsl_matrix_char_min(gsl_matrix_char *m);

void  gsl_matrix_char_minmax(gsl_matrix_char *m, char *min_out, char *max_out);

void  gsl_matrix_char_max_index(gsl_matrix_char *m, size_t *imax, size_t *jmax);

void  gsl_matrix_char_min_index(gsl_matrix_char *m, size_t *imin, size_t *jmin);

void  gsl_matrix_char_minmax_index(gsl_matrix_char *m, size_t *imin, size_t *jmin, size_t *imax, size_t *jmax);

int  gsl_matrix_char_isnull(gsl_matrix_char *m);

int  gsl_matrix_char_add(gsl_matrix_char *a, gsl_matrix_char *b);

int  gsl_matrix_char_sub(gsl_matrix_char *a, gsl_matrix_char *b);

int  gsl_matrix_char_mul_elements(gsl_matrix_char *a, gsl_matrix_char *b);

int  gsl_matrix_char_div_elements(gsl_matrix_char *a, gsl_matrix_char *b);

int  gsl_matrix_char_scale(gsl_matrix_char *a, double x);

int  gsl_matrix_char_add_constant(gsl_matrix_char *a, double x);

int  gsl_matrix_char_add_diagonal(gsl_matrix_char *a, double x);

/***********************************************************************/
/* The functions below are obsolete                                    */
/***********************************************************************/

int  gsl_matrix_char_get_row(gsl_vector_char *v, gsl_matrix_char *m, size_t i);

int  gsl_matrix_char_get_col(gsl_vector_char *v, gsl_matrix_char *m, size_t j);

int  gsl_matrix_char_set_row(gsl_matrix_char *m, size_t i, gsl_vector_char *v);

int  gsl_matrix_char_set_col(gsl_matrix_char *m, size_t j, gsl_vector_char *v);

/* inline functions if you are using GCC */


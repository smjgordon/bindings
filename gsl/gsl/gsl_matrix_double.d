/* Converted to D from gsl_matrix_double.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_matrix_double;
/* matrix/gsl_matrix_double.h
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

public import gsl.gsl_vector_double;

extern (C):
struct gsl_matrix
{
    size_t size1;
    size_t size2;
    size_t tda;
    double *data;
    gsl_block *block;
    int owner;
};

struct _gsl_matrix_view
{
    gsl_matrix matrix;
};
alias _gsl_matrix_view gsl_matrix_view;

struct _gsl_matrix_const_view
{
    gsl_matrix matrix;
};
alias _gsl_matrix_const_view gsl_matrix_const_view;

/* Allocation */

gsl_matrix * gsl_matrix_alloc(size_t n1, size_t n2);

gsl_matrix * gsl_matrix_calloc(size_t n1, size_t n2);

gsl_matrix * gsl_matrix_alloc_from_block(gsl_block *b, size_t offset, size_t n1, size_t n2, size_t d2);

gsl_matrix * gsl_matrix_alloc_from_matrix(gsl_matrix *m, size_t k1, size_t k2, size_t n1, size_t n2);

gsl_vector * gsl_vector_alloc_row_from_matrix(gsl_matrix *m, size_t i);

gsl_vector * gsl_vector_alloc_col_from_matrix(gsl_matrix *m, size_t j);

void  gsl_matrix_free(gsl_matrix *m);

/* Views */

_gsl_matrix_view  gsl_matrix_submatrix(gsl_matrix *m, size_t i, size_t j, size_t n1, size_t n2);

_gsl_vector_view  gsl_matrix_row(gsl_matrix *m, size_t i);

_gsl_vector_view  gsl_matrix_column(gsl_matrix *m, size_t j);

_gsl_vector_view  gsl_matrix_diagonal(gsl_matrix *m);

_gsl_vector_view  gsl_matrix_subdiagonal(gsl_matrix *m, size_t k);

_gsl_vector_view  gsl_matrix_superdiagonal(gsl_matrix *m, size_t k);

_gsl_matrix_view  gsl_matrix_view_array(double *base, size_t n1, size_t n2);

_gsl_matrix_view  gsl_matrix_view_array_with_tda(double *base, size_t n1, size_t n2, size_t tda);

_gsl_matrix_view  gsl_matrix_view_vector(gsl_vector *v, size_t n1, size_t n2);

_gsl_matrix_view  gsl_matrix_view_vector_with_tda(gsl_vector *v, size_t n1, size_t n2, size_t tda);

_gsl_matrix_const_view  gsl_matrix_const_submatrix(gsl_matrix *m, size_t i, size_t j, size_t n1, size_t n2);

_gsl_vector_const_view  gsl_matrix_const_row(gsl_matrix *m, size_t i);

_gsl_vector_const_view  gsl_matrix_const_column(gsl_matrix *m, size_t j);

_gsl_vector_const_view  gsl_matrix_const_diagonal(gsl_matrix *m);

_gsl_vector_const_view  gsl_matrix_const_subdiagonal(gsl_matrix *m, size_t k);

_gsl_vector_const_view  gsl_matrix_const_superdiagonal(gsl_matrix *m, size_t k);

_gsl_matrix_const_view  gsl_matrix_const_view_array(double *base, size_t n1, size_t n2);

_gsl_matrix_const_view  gsl_matrix_const_view_array_with_tda(double *base, size_t n1, size_t n2, size_t tda);

_gsl_matrix_const_view  gsl_matrix_const_view_vector(gsl_vector *v, size_t n1, size_t n2);

_gsl_matrix_const_view  gsl_matrix_const_view_vector_with_tda(gsl_vector *v, size_t n1, size_t n2, size_t tda);

/* Operations */

double  gsl_matrix_get(gsl_matrix *m, size_t i, size_t j);

void  gsl_matrix_set(gsl_matrix *m, size_t i, size_t j, double x);

double * gsl_matrix_ptr(gsl_matrix *m, size_t i, size_t j);

double * gsl_matrix_const_ptr(gsl_matrix *m, size_t i, size_t j);

void  gsl_matrix_set_zero(gsl_matrix *m);

void  gsl_matrix_set_identity(gsl_matrix *m);

void  gsl_matrix_set_all(gsl_matrix *m, double x);

int  gsl_matrix_fread(FILE *stream, gsl_matrix *m);

int  gsl_matrix_fwrite(FILE *stream, gsl_matrix *m);

int  gsl_matrix_fscanf(FILE *stream, gsl_matrix *m);

int  gsl_matrix_fprintf(FILE *stream, gsl_matrix *m, char *format);
 

int  gsl_matrix_memcpy(gsl_matrix *dest, gsl_matrix *src);

int  gsl_matrix_swap(gsl_matrix *m1, gsl_matrix *m2);

int  gsl_matrix_swap_rows(gsl_matrix *m, size_t i, size_t j);

int  gsl_matrix_swap_columns(gsl_matrix *m, size_t i, size_t j);

int  gsl_matrix_swap_rowcol(gsl_matrix *m, size_t i, size_t j);

int  gsl_matrix_transpose(gsl_matrix *m);

int  gsl_matrix_transpose_memcpy(gsl_matrix *dest, gsl_matrix *src);

double  gsl_matrix_max(gsl_matrix *m);

double  gsl_matrix_min(gsl_matrix *m);

void  gsl_matrix_minmax(gsl_matrix *m, double *min_out, double *max_out);

void  gsl_matrix_max_index(gsl_matrix *m, size_t *imax, size_t *jmax);

void  gsl_matrix_min_index(gsl_matrix *m, size_t *imin, size_t *jmin);

void  gsl_matrix_minmax_index(gsl_matrix *m, size_t *imin, size_t *jmin, size_t *imax, size_t *jmax);

int  gsl_matrix_isnull(gsl_matrix *m);

int  gsl_matrix_add(gsl_matrix *a, gsl_matrix *b);

int  gsl_matrix_sub(gsl_matrix *a, gsl_matrix *b);

int  gsl_matrix_mul_elements(gsl_matrix *a, gsl_matrix *b);

int  gsl_matrix_div_elements(gsl_matrix *a, gsl_matrix *b);

int  gsl_matrix_scale(gsl_matrix *a, double x);

int  gsl_matrix_add_constant(gsl_matrix *a, double x);

int  gsl_matrix_add_diagonal(gsl_matrix *a, double x);

/***********************************************************************/
/* The functions below are obsolete                                    */
/***********************************************************************/

int  gsl_matrix_get_row(gsl_vector *v, gsl_matrix *m, size_t i);

int  gsl_matrix_get_col(gsl_vector *v, gsl_matrix *m, size_t j);

int  gsl_matrix_set_row(gsl_matrix *m, size_t i, gsl_vector *v);

int  gsl_matrix_set_col(gsl_matrix *m, size_t j, gsl_vector *v);

/* inline functions if you are using GCC */


/* Converted to D from gsl_eigen.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_eigen;
/* eigen/gsl_eigen.h
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

public import gsl.gsl_vector;

public import gsl.gsl_matrix;

struct gsl_eigen_symm_workspace
{
    size_t size;
    double *d;
    double *sd;
};
extern (C):

gsl_eigen_symm_workspace * gsl_eigen_symm_alloc(size_t n);

void  gsl_eigen_symm_free(gsl_eigen_symm_workspace *w);

int  gsl_eigen_symm(gsl_matrix *A, gsl_vector *eval, gsl_eigen_symm_workspace *w);

struct gsl_eigen_symmv_workspace
{
    size_t size;
    double *d;
    double *sd;
    double *gc;
    double *gs;
};

gsl_eigen_symmv_workspace * gsl_eigen_symmv_alloc(size_t n);

void  gsl_eigen_symmv_free(gsl_eigen_symmv_workspace *w);

int  gsl_eigen_symmv(gsl_matrix *A, gsl_vector *eval, gsl_matrix *evec, gsl_eigen_symmv_workspace *w);

struct gsl_eigen_herm_workspace
{
    size_t size;
    double *d;
    double *sd;
    double *tau;
};

gsl_eigen_herm_workspace * gsl_eigen_herm_alloc(size_t n);

void  gsl_eigen_herm_free(gsl_eigen_herm_workspace *w);

int  gsl_eigen_herm(gsl_matrix_complex *A, gsl_vector *eval, gsl_eigen_herm_workspace *w);

struct gsl_eigen_hermv_workspace
{
    size_t size;
    double *d;
    double *sd;
    double *tau;
    double *gc;
    double *gs;
};

gsl_eigen_hermv_workspace * gsl_eigen_hermv_alloc(size_t n);

void  gsl_eigen_hermv_free(gsl_eigen_hermv_workspace *w);

int  gsl_eigen_hermv(gsl_matrix_complex *A, gsl_vector *eval, gsl_matrix_complex *evec, gsl_eigen_hermv_workspace *w);

enum
{
    GSL_EIGEN_SORT_VAL_ASC,
    GSL_EIGEN_SORT_VAL_DESC,
    GSL_EIGEN_SORT_ABS_ASC,
    GSL_EIGEN_SORT_ABS_DESC,
}
alias int gsl_eigen_sort_t;

/* Sort eigensystem results based on eigenvalues.
 * Sorts in order of increasing value or increasing
 * absolute value.
 *
 * exceptions: GSL_EBADLEN
 */

int  gsl_eigen_symmv_sort(gsl_vector *eval, gsl_matrix *evec, gsl_eigen_sort_t sort_type);

int  gsl_eigen_hermv_sort(gsl_vector *eval, gsl_matrix_complex *evec, gsl_eigen_sort_t sort_type);

/* The following functions are obsolete: */

/* Eigensolve by Jacobi Method
 *
 * The data in the matrix input is destroyed.
 *
 * exceptions: 
 */

int  gsl_eigen_jacobi(gsl_matrix *matrix, gsl_vector *eval, gsl_matrix *evec, uint max_rot, uint *nrot);

/* Invert by Jacobi Method
 *
 * exceptions: 
 */

int  gsl_eigen_invert_jacobi(gsl_matrix *matrix, gsl_matrix *ainv, uint max_rot);


/* Converted to D from gsl_wavelet2d.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_wavelet2d;
/* wavelet/gsl_wavelet.h
 * 
 * Copyright (C) 2004 Ivo Alxneit
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

public import gsl.gsl_errno;

public import gsl.gsl_vector_double;

public import gsl.gsl_matrix_double;

public import gsl.gsl_wavelet;

extern (C):
int  gsl_wavelet2d_transform(gsl_wavelet *w, double *data, size_t tda, size_t size1, size_t size2, gsl_wavelet_direction dir, gsl_wavelet_workspace *work);

int  gsl_wavelet2d_transform_forward(gsl_wavelet *w, double *data, size_t tda, size_t size1, size_t size2, gsl_wavelet_workspace *work);

int  gsl_wavelet2d_transform_inverse(gsl_wavelet *w, double *data, size_t tda, size_t size1, size_t size2, gsl_wavelet_workspace *work);

int  gsl_wavelet2d_nstransform(gsl_wavelet *w, double *data, size_t tda, size_t size1, size_t size2, gsl_wavelet_direction dir, gsl_wavelet_workspace *work);

int  gsl_wavelet2d_nstransform_forward(gsl_wavelet *w, double *data, size_t tda, size_t size1, size_t size2, gsl_wavelet_workspace *work);

int  gsl_wavelet2d_nstransform_inverse(gsl_wavelet *w, double *data, size_t tda, size_t size1, size_t size2, gsl_wavelet_workspace *work);

int  gsl_wavelet2d_transform_matrix(gsl_wavelet *w, gsl_matrix *a, gsl_wavelet_direction dir, gsl_wavelet_workspace *work);

int  gsl_wavelet2d_transform_matrix_forward(gsl_wavelet *w, gsl_matrix *a, gsl_wavelet_workspace *work);

int  gsl_wavelet2d_transform_matrix_inverse(gsl_wavelet *w, gsl_matrix *a, gsl_wavelet_workspace *work);

int  gsl_wavelet2d_nstransform_matrix(gsl_wavelet *w, gsl_matrix *a, gsl_wavelet_direction dir, gsl_wavelet_workspace *work);

int  gsl_wavelet2d_nstransform_matrix_forward(gsl_wavelet *w, gsl_matrix *a, gsl_wavelet_workspace *work);

int  gsl_wavelet2d_nstransform_matrix_inverse(gsl_wavelet *w, gsl_matrix *a, gsl_wavelet_workspace *work);


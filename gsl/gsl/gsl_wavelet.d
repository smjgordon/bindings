/* Converted to D from gsl_wavelet.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_wavelet;
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

public import gsl.gsl_types;

public import gsl.gsl_errno;

enum
{
    forward = 1,
    backward = -1,
    gsl_wavelet_forward = 1,
    gsl_wavelet_backward = -1,
}
extern (C):
alias int gsl_wavelet_direction;

struct gsl_wavelet_type
{
    char *name;
    int  function(double **h1, double **g1, double **h2, double **g2, size_t *nc, size_t *offset, size_t member)init;
};

struct gsl_wavelet
{
    gsl_wavelet_type *type;
    double *h1;
    double *g1;
    double *h2;
    double *g2;
    size_t nc;
    size_t offset;
};

struct gsl_wavelet_workspace
{
    double *scratch;
    size_t n;
};

extern gsl_wavelet_type *gsl_wavelet_daubechies;

extern gsl_wavelet_type *gsl_wavelet_daubechies_centered;

extern gsl_wavelet_type *gsl_wavelet_haar;

extern gsl_wavelet_type *gsl_wavelet_haar_centered;

extern gsl_wavelet_type *gsl_wavelet_bspline;

extern gsl_wavelet_type *gsl_wavelet_bspline_centered;

gsl_wavelet * gsl_wavelet_alloc(gsl_wavelet_type *T, size_t k);

void  gsl_wavelet_free(gsl_wavelet *w);

char * gsl_wavelet_name(gsl_wavelet *w);

gsl_wavelet_workspace * gsl_wavelet_workspace_alloc(size_t n);

void  gsl_wavelet_workspace_free(gsl_wavelet_workspace *work);

int  gsl_wavelet_transform(gsl_wavelet *w, double *data, size_t stride, size_t n, gsl_wavelet_direction dir, gsl_wavelet_workspace *work);

int  gsl_wavelet_transform_forward(gsl_wavelet *w, double *data, size_t stride, size_t n, gsl_wavelet_workspace *work);

int  gsl_wavelet_transform_inverse(gsl_wavelet *w, double *data, size_t stride, size_t n, gsl_wavelet_workspace *work);


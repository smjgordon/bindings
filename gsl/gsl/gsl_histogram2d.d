/* Converted to D from gsl_histogram2d.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_histogram2d;
/* histogram/gsl_histogram2d.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Brian Gough
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

extern (C):
struct gsl_histogram2d
{
    size_t nx;
    size_t ny;
    double *xrange;
    double *yrange;
    double *bin;
};

struct gsl_histogram2d_pdf
{
    size_t nx;
    size_t ny;
    double *xrange;
    double *yrange;
    double *sum;
};

gsl_histogram2d * gsl_histogram2d_alloc(size_t nx, size_t ny);

gsl_histogram2d * gsl_histogram2d_calloc(size_t nx, size_t ny);

gsl_histogram2d * gsl_histogram2d_calloc_uniform(size_t nx, size_t ny, double xmin, double xmax, double ymin, double ymax);

void  gsl_histogram2d_free(gsl_histogram2d *h);

int  gsl_histogram2d_increment(gsl_histogram2d *h, double x, double y);

int  gsl_histogram2d_accumulate(gsl_histogram2d *h, double x, double y, double weight);

int  gsl_histogram2d_find(gsl_histogram2d *h, double x, double y, size_t *i, size_t *j);

double  gsl_histogram2d_get(gsl_histogram2d *h, size_t i, size_t j);

int  gsl_histogram2d_get_xrange(gsl_histogram2d *h, size_t i, double *xlower, double *xupper);

int  gsl_histogram2d_get_yrange(gsl_histogram2d *h, size_t j, double *ylower, double *yupper);

double  gsl_histogram2d_xmax(gsl_histogram2d *h);

double  gsl_histogram2d_xmin(gsl_histogram2d *h);

size_t  gsl_histogram2d_nx(gsl_histogram2d *h);

double  gsl_histogram2d_ymax(gsl_histogram2d *h);

double  gsl_histogram2d_ymin(gsl_histogram2d *h);

size_t  gsl_histogram2d_ny(gsl_histogram2d *h);

void  gsl_histogram2d_reset(gsl_histogram2d *h);

gsl_histogram2d * gsl_histogram2d_calloc_range(size_t nx, size_t ny, double *xrange, double *yrange);

int  gsl_histogram2d_set_ranges_uniform(gsl_histogram2d *h, double xmin, double xmax, double ymin, double ymax);

int  gsl_histogram2d_set_ranges(gsl_histogram2d *h, double *xrange, size_t xsize, double *yrange, size_t ysize);

int  gsl_histogram2d_memcpy(gsl_histogram2d *dest, gsl_histogram2d *source);

gsl_histogram2d * gsl_histogram2d_clone(gsl_histogram2d *source);

double  gsl_histogram2d_max_val(gsl_histogram2d *h);

void  gsl_histogram2d_max_bin(gsl_histogram2d *h, size_t *i, size_t *j);

double  gsl_histogram2d_min_val(gsl_histogram2d *h);

void  gsl_histogram2d_min_bin(gsl_histogram2d *h, size_t *i, size_t *j);

double  gsl_histogram2d_xmean(gsl_histogram2d *h);

double  gsl_histogram2d_ymean(gsl_histogram2d *h);

double  gsl_histogram2d_xsigma(gsl_histogram2d *h);

double  gsl_histogram2d_ysigma(gsl_histogram2d *h);

double  gsl_histogram2d_cov(gsl_histogram2d *h);

double  gsl_histogram2d_sum(gsl_histogram2d *h);

int  gsl_histogram2d_equal_bins_p(gsl_histogram2d *h1, gsl_histogram2d *h2);

int  gsl_histogram2d_add(gsl_histogram2d *h1, gsl_histogram2d *h2);

int  gsl_histogram2d_sub(gsl_histogram2d *h1, gsl_histogram2d *h2);

int  gsl_histogram2d_mul(gsl_histogram2d *h1, gsl_histogram2d *h2);

int  gsl_histogram2d_div(gsl_histogram2d *h1, gsl_histogram2d *h2);

int  gsl_histogram2d_scale(gsl_histogram2d *h, double scale);

int  gsl_histogram2d_shift(gsl_histogram2d *h, double shift);

int  gsl_histogram2d_fwrite(FILE *stream, gsl_histogram2d *h);

int  gsl_histogram2d_fread(FILE *stream, gsl_histogram2d *h);

int  gsl_histogram2d_fprintf(FILE *stream, gsl_histogram2d *h, char *range_format, char *bin_format);

int  gsl_histogram2d_fscanf(FILE *stream, gsl_histogram2d *h);

gsl_histogram2d_pdf * gsl_histogram2d_pdf_alloc(size_t nx, size_t ny);

int  gsl_histogram2d_pdf_init(gsl_histogram2d_pdf *p, gsl_histogram2d *h);

void  gsl_histogram2d_pdf_free(gsl_histogram2d_pdf *p);

int  gsl_histogram2d_pdf_sample(gsl_histogram2d_pdf *p, double r1, double r2, double *x, double *y);


/* Converted to D from gsl_histogram.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_histogram;
/* histogram/gsl_histogram.h
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
struct gsl_histogram
{
    size_t n;
    double *range;
    double *bin;
};

struct gsl_histogram_pdf
{
    size_t n;
    double *range;
    double *sum;
};

gsl_histogram * gsl_histogram_alloc(size_t n);

gsl_histogram * gsl_histogram_calloc(size_t n);

gsl_histogram * gsl_histogram_calloc_uniform(size_t n, double xmin, double xmax);

void  gsl_histogram_free(gsl_histogram *h);

int  gsl_histogram_increment(gsl_histogram *h, double x);

int  gsl_histogram_accumulate(gsl_histogram *h, double x, double weight);

int  gsl_histogram_find(gsl_histogram *h, double x, size_t *i);

double  gsl_histogram_get(gsl_histogram *h, size_t i);

int  gsl_histogram_get_range(gsl_histogram *h, size_t i, double *lower, double *upper);
                                     
double  gsl_histogram_max(gsl_histogram *h);

double  gsl_histogram_min(gsl_histogram *h);

size_t  gsl_histogram_bins(gsl_histogram *h);

void  gsl_histogram_reset(gsl_histogram *h);

gsl_histogram * gsl_histogram_calloc_range(size_t n, double *range);

int  gsl_histogram_set_ranges(gsl_histogram *h, double *range, size_t size);

int  gsl_histogram_set_ranges_uniform(gsl_histogram *h, double xmin, double xmax);

int  gsl_histogram_memcpy(gsl_histogram *dest, gsl_histogram *source);

gsl_histogram * gsl_histogram_clone(gsl_histogram *source);

double  gsl_histogram_max_val(gsl_histogram *h);

size_t  gsl_histogram_max_bin(gsl_histogram *h);

double  gsl_histogram_min_val(gsl_histogram *h);

size_t  gsl_histogram_min_bin(gsl_histogram *h);

int  gsl_histogram_equal_bins_p(gsl_histogram *h1, gsl_histogram *h2);

int  gsl_histogram_add(gsl_histogram *h1, gsl_histogram *h2);

int  gsl_histogram_sub(gsl_histogram *h1, gsl_histogram *h2);

int  gsl_histogram_mul(gsl_histogram *h1, gsl_histogram *h2);
 
int  gsl_histogram_div(gsl_histogram *h1, gsl_histogram *h2);

int  gsl_histogram_scale(gsl_histogram *h, double scale);

int  gsl_histogram_shift(gsl_histogram *h, double shift);

double  gsl_histogram_sigma(gsl_histogram *h);

double  gsl_histogram_mean(gsl_histogram *h);

double  gsl_histogram_sum(gsl_histogram *h);

int  gsl_histogram_fwrite(FILE *stream, gsl_histogram *h);

int  gsl_histogram_fread(FILE *stream, gsl_histogram *h);

int  gsl_histogram_fprintf(FILE *stream, gsl_histogram *h, char *range_format, char *bin_format);

int  gsl_histogram_fscanf(FILE *stream, gsl_histogram *h);

gsl_histogram_pdf * gsl_histogram_pdf_alloc(size_t n);

int  gsl_histogram_pdf_init(gsl_histogram_pdf *p, gsl_histogram *h);

void  gsl_histogram_pdf_free(gsl_histogram_pdf *p);

double  gsl_histogram_pdf_sample(gsl_histogram_pdf *p, double r);


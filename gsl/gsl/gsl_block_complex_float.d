/* Converted to D from gsl_block_complex_float.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_block_complex_float;
/* block/gsl_block_complex_float.h
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

public import gsl.gsl_errno;

struct gsl_block_complex_float_struct
{
    size_t size;
    float *data;
}

extern (C):
alias gsl_block_complex_float_struct gsl_block_complex_float;

gsl_block_complex_float * gsl_block_complex_float_alloc(size_t n);

gsl_block_complex_float * gsl_block_complex_float_calloc(size_t n);

void  gsl_block_complex_float_free(gsl_block_complex_float *b);

int  gsl_block_complex_float_fread(FILE *stream, gsl_block_complex_float *b);

int  gsl_block_complex_float_fwrite(FILE *stream, gsl_block_complex_float *b);

int  gsl_block_complex_float_fscanf(FILE *stream, gsl_block_complex_float *b);

int  gsl_block_complex_float_fprintf(FILE *stream, gsl_block_complex_float *b, char *format);

int  gsl_block_complex_float_raw_fread(FILE *stream, float *b, size_t n, size_t stride);

int  gsl_block_complex_float_raw_fwrite(FILE *stream, float *b, size_t n, size_t stride);

int  gsl_block_complex_float_raw_fscanf(FILE *stream, float *b, size_t n, size_t stride);

int  gsl_block_complex_float_raw_fprintf(FILE *stream, float *b, size_t n, size_t stride, char *format);

size_t  gsl_block_complex_float_size(gsl_block_complex_float *b);

float * gsl_block_complex_float_data(gsl_block_complex_float *b);


/* Converted to D from gsl_block_int.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_block_int;
/* block/gsl_block_int.h
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

struct gsl_block_int_struct
{
    size_t size;
    int *data;
}

extern (C):
alias gsl_block_int_struct gsl_block_int;

gsl_block_int * gsl_block_int_alloc(size_t n);

gsl_block_int * gsl_block_int_calloc(size_t n);

void  gsl_block_int_free(gsl_block_int *b);

int  gsl_block_int_fread(FILE *stream, gsl_block_int *b);

int  gsl_block_int_fwrite(FILE *stream, gsl_block_int *b);

int  gsl_block_int_fscanf(FILE *stream, gsl_block_int *b);

int  gsl_block_int_fprintf(FILE *stream, gsl_block_int *b, char *format);

int  gsl_block_int_raw_fread(FILE *stream, int *b, size_t n, size_t stride);

int  gsl_block_int_raw_fwrite(FILE *stream, int *b, size_t n, size_t stride);

int  gsl_block_int_raw_fscanf(FILE *stream, int *b, size_t n, size_t stride);

int  gsl_block_int_raw_fprintf(FILE *stream, int *b, size_t n, size_t stride, char *format);

size_t  gsl_block_int_size(gsl_block_int *b);

int * gsl_block_int_data(gsl_block_int *b);


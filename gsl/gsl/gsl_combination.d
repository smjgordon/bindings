/* Converted to D from gsl_combination.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_combination;
/* combination/gsl_combination.h
 * based on permutation/gsl_permutation.h by Brian Gough
 * 
 * Copyright (C) 2001 Szymon Jaroszewicz
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

public import gsl.gsl_types;

public import gsl.gsl_check_range;

struct gsl_combination_struct
{
    size_t n;
    size_t k;
    size_t *data;
}

extern (C):
alias gsl_combination_struct gsl_combination;

gsl_combination * gsl_combination_alloc(size_t n, size_t k);

gsl_combination * gsl_combination_calloc(size_t n, size_t k);

void  gsl_combination_init_first(gsl_combination *c);

void  gsl_combination_init_last(gsl_combination *c);

void  gsl_combination_free(gsl_combination *c);

int  gsl_combination_memcpy(gsl_combination *dest, gsl_combination *src);

int  gsl_combination_fread(FILE *stream, gsl_combination *c);

int  gsl_combination_fwrite(FILE *stream, gsl_combination *c);

int  gsl_combination_fscanf(FILE *stream, gsl_combination *c);

int  gsl_combination_fprintf(FILE *stream, gsl_combination *c, char *format);

size_t  gsl_combination_n(gsl_combination *c);

size_t  gsl_combination_k(gsl_combination *c);

size_t * gsl_combination_data(gsl_combination *c);

size_t  gsl_combination_get(gsl_combination *c, size_t i);

int  gsl_combination_valid(gsl_combination *c);

int  gsl_combination_next(gsl_combination *c);

int  gsl_combination_prev(gsl_combination *c);


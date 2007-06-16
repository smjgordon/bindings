/* Converted to D from gsl_permutation.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_permutation;
/* permutation/gsl_permutation.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004 Brian Gough
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

import tango.stdc.stdio;

import tango.stdc.stdlib;

public import gsl.gsl_types;

public import gsl.gsl_errno;

public import gsl.gsl_check_range;

struct gsl_permutation_struct
{
    size_t size;
    size_t *data;
}

extern (C):
alias gsl_permutation_struct gsl_permutation;

gsl_permutation * gsl_permutation_alloc(size_t n);

gsl_permutation * gsl_permutation_calloc(size_t n);

void  gsl_permutation_init(gsl_permutation *p);

void  gsl_permutation_free(gsl_permutation *p);

int  gsl_permutation_memcpy(gsl_permutation *dest, gsl_permutation *src);

int  gsl_permutation_fread(FILE *stream, gsl_permutation *p);

int  gsl_permutation_fwrite(FILE *stream, gsl_permutation *p);

int  gsl_permutation_fscanf(FILE *stream, gsl_permutation *p);

int  gsl_permutation_fprintf(FILE *stream, gsl_permutation *p, char *format);

size_t  gsl_permutation_size(gsl_permutation *p);

size_t * gsl_permutation_data(gsl_permutation *p);

size_t  gsl_permutation_get(gsl_permutation *p, size_t i);

int  gsl_permutation_swap(gsl_permutation *p, size_t i, size_t j);

int  gsl_permutation_valid(gsl_permutation *p);

void  gsl_permutation_reverse(gsl_permutation *p);

int  gsl_permutation_inverse(gsl_permutation *inv, gsl_permutation *p);

int  gsl_permutation_next(gsl_permutation *p);

int  gsl_permutation_prev(gsl_permutation *p);

int  gsl_permutation_mul(gsl_permutation *p, gsl_permutation *pa, gsl_permutation *pb);

int  gsl_permutation_linear_to_canonical(gsl_permutation *q, gsl_permutation *p);

int  gsl_permutation_canonical_to_linear(gsl_permutation *p, gsl_permutation *q);

size_t  gsl_permutation_inversions(gsl_permutation *p);

size_t  gsl_permutation_linear_cycles(gsl_permutation *p);

size_t  gsl_permutation_canonical_cycles(gsl_permutation *q);


/* Converted to D from gsl_sort_vector_ulong.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sort_vector_ulong;
/* sort/gsl_sort_vector_ulong.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Thomas Walter, Brian Gough
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

public import gsl.gsl_permutation;

public import gsl.gsl_vector_ulong;

extern (C):
void  gsl_sort_vector_ulong(gsl_vector_ulong *v);

int  gsl_sort_vector_ulong_index(gsl_permutation *p, gsl_vector_ulong *v);

int  gsl_sort_vector_ulong_smallest(uint *dest, size_t k, gsl_vector_ulong *v);

int  gsl_sort_vector_ulong_largest(uint *dest, size_t k, gsl_vector_ulong *v);

int  gsl_sort_vector_ulong_smallest_index(size_t *p, size_t k, gsl_vector_ulong *v);

int  gsl_sort_vector_ulong_largest_index(size_t *p, size_t k, gsl_vector_ulong *v);


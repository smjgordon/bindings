/* Converted to D from gsl_dht.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_dht;
/* dht/gsl_dht.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Gerard Jungman
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

/* Author:  G. Jungman
 */

struct gsl_dht_struct
{
    int size_t;
    double nu;
    double xmax;
    double kmax;
    double *j;
    double *Jjj;
    double *J2;
}

extern (C):
alias gsl_dht_struct gsl_dht;

/* Create a new transform object for a given size
 * sampling array on the domain [0, xmax].
 */

/* Recalculate a transform object for given values of nu, xmax.
 * You cannot change the size of the object since the internal
 * allocation is reused.
 */

/* The n'th computed x sample point for a given transform.
 * 0 <= n <= size-1
 */


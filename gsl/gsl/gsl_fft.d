/* Converted to D from gsl_fft.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_fft;
/* fft/gsl_fft.h
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

public import gsl.gsl_complex;

extern (C):
enum
{
    forward = -1,
    backward = 1,
    gsl_fft_forward = -1,
    gsl_fft_backward = 1,
}
alias int gsl_fft_direction;

/* this gives the sign in the formula

   h(f) = \sum x(t) exp(+/- 2 pi i f t) 
       
   where - is the forward transform direction and + the inverse direction */


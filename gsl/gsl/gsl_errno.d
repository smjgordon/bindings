/* Converted to D from gsl_errno.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_errno;
/* err/gsl_errno.h
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

import tango.stdc.stdio;

import tango.stdc.errno;

public import gsl.gsl_types;

enum
{
    GSL_SUCCESS,
    GSL_FAILURE = -1,
    GSL_CONTINUE = -2,
    GSL_EDOM = 1,
    GSL_ERANGE,
    GSL_EFAULT,
    GSL_EINVAL,
    GSL_EFAILED,
    GSL_EFACTOR,
    GSL_ESANITY,
    GSL_ENOMEM,
    GSL_EBADFUNC,
    GSL_ERUNAWAY,
    GSL_EMAXITER,
    GSL_EZERODIV,
    GSL_EBADTOL,
    GSL_ETOL,
    GSL_EUNDRFLW,
    GSL_EOVRFLW,
    GSL_ELOSS,
    GSL_EROUND,
    GSL_EBADLEN,
    GSL_ENOTSQR,
    GSL_ESING,
    GSL_EDIVERGE,
    GSL_EUNSUP,
    GSL_EUNIMPL,
    GSL_ECACHE,
    GSL_ETABLE,
    GSL_ENOPROG,
    GSL_ENOPROGJ,
    GSL_ETOLF,
    GSL_ETOLX,
    GSL_ETOLG,
    GSL_EOF,
}

extern (C):
void  gsl_error(char *reason, char *file, int line, int gsl_errno);

void  gsl_stream_printf(char *label, char *file, int line, char *reason);

char * gsl_strerror(int gsl_errno);

//alias void C func(char *reason, char *file, int line, int gsl_errno)gsl_error_handler_t;
alias void function(char *reason, char *file, int line, int gsl_errno) gsl_error_handler_t;

//alias void C func(char *label, char *file, int line, char *reason)gsl_stream_handler_t;
alias void function(char *label, char *file, int line, char *reason) gsl_stream_handler_t;

void  function(char *reason, char *file, int line, int gsl_errno) gsl_set_error_handler(void  function(char *reason, char *file, int line, int gsl_errno)new_handler);

void  function(char *reason, char *file, int line, int gsl_errno) gsl_set_error_handler_off();

void  function(char *label, char *file, int line, char *reason) gsl_set_stream_handler(void  function(char *label, char *file, int line, char *reason)new_handler);

FILE * gsl_set_stream(FILE *new_stream);

/* GSL_ERROR: call the error handler, and return the error code */

/* GSL_ERROR_VAL: call the error handler, and return the given value */

/* GSL_ERROR_VOID: call the error handler, and then return
   (for void functions which still need to generate an error) */

/* GSL_ERROR_NULL suitable for out-of-memory conditions */

/* Sometimes you have several status results returned from
 * function calls and you want to combine them in some sensible
 * way. You cannot produce a "total" status condition, but you can
 * pick one from a set of conditions based on an implied hierarchy.
 *
 * In other words:
 *    you have: status_a, status_b, ...
 *    you want: status = (status_a if it is bad, or status_b if it is bad,...)
 *
 * In this example you consider status_a to be more important and
 * it is checked first, followed by the others in the order specified.
 *
 * Here are some dumb macros to do this.
 */


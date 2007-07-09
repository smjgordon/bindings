/* Converted to D from gsl_ntuple.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_ntuple;
/* histogram/ntuple.h
 * 
 * Copyright (C) 2000 Simone Piccardi
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
 *
 */

/* Jan/2001 Modified by Brian Gough. Minor changes for GSL */

import tango.stdc.stdlib;

import tango.stdc.stdio;

public import gsl.gsl_errno;

public import gsl.gsl_histogram;

extern (C):
struct gsl_ntuple
{
    FILE *file;
    void *ntuple_data;
    size_t size;
};

struct gsl_ntuple_select_fn
{
    int  function(void *ntuple_data, void *params)func;
    void *params;
};

struct gsl_ntuple_value_fn
{
    double  function(void *ntuple_data, void *params)func;
    void *params;
};

gsl_ntuple * gsl_ntuple_open(char *filename, void *ntuple_data, size_t size);

gsl_ntuple * gsl_ntuple_create(char *filename, void *ntuple_data, size_t size);

int  gsl_ntuple_write(gsl_ntuple *ntuple);

int  gsl_ntuple_read(gsl_ntuple *ntuple);

int  gsl_ntuple_bookdata(gsl_ntuple *ntuple);

int  gsl_ntuple_project(gsl_histogram *h, gsl_ntuple *ntuple, gsl_ntuple_value_fn *value_func, gsl_ntuple_select_fn *select_func);

int  gsl_ntuple_close(gsl_ntuple *ntuple);


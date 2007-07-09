/* Converted to D from gsl_rng.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_rng;
/* rng/gsl_rng.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004 James Theiler, Brian Gough
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

public import gsl.gsl_types;

public import gsl.gsl_errno;

extern (C):
struct gsl_rng_type
{
    char *name;
    uint max;
    uint min;
    size_t size;
    void  function(void *state, uint seed)set;
    uint  function(void *state)get;
    double  function(void *state)get_double;
};

struct gsl_rng
{
    gsl_rng_type *type;
    void *state;
};

/* These structs also need to appear in default.c so you can select
   them via the environment variable GSL_RNG_TYPE */

extern gsl_rng_type *gsl_rng_borosh13;

extern gsl_rng_type *gsl_rng_coveyou;

extern gsl_rng_type *gsl_rng_cmrg;

extern gsl_rng_type *gsl_rng_fishman18;

extern gsl_rng_type *gsl_rng_fishman20;

extern gsl_rng_type *gsl_rng_fishman2x;

extern gsl_rng_type *gsl_rng_gfsr4;

extern gsl_rng_type *gsl_rng_knuthran;

extern gsl_rng_type *gsl_rng_knuthran2;

extern gsl_rng_type *gsl_rng_lecuyer21;

extern gsl_rng_type *gsl_rng_minstd;

extern gsl_rng_type *gsl_rng_mrg;

extern gsl_rng_type *gsl_rng_mt19937;

extern gsl_rng_type *gsl_rng_mt19937_1999;

extern gsl_rng_type *gsl_rng_mt19937_1998;

extern gsl_rng_type *gsl_rng_r250;

extern gsl_rng_type *gsl_rng_ran0;

extern gsl_rng_type *gsl_rng_ran1;

extern gsl_rng_type *gsl_rng_ran2;

extern gsl_rng_type *gsl_rng_ran3;

extern gsl_rng_type *gsl_rng_rand;

extern gsl_rng_type *gsl_rng_rand48;

extern gsl_rng_type *gsl_rng_random128_bsd;

extern gsl_rng_type *gsl_rng_random128_glibc2;

extern gsl_rng_type *gsl_rng_random128_libc5;

extern gsl_rng_type *gsl_rng_random256_bsd;

extern gsl_rng_type *gsl_rng_random256_glibc2;

extern gsl_rng_type *gsl_rng_random256_libc5;

extern gsl_rng_type *gsl_rng_random32_bsd;

extern gsl_rng_type *gsl_rng_random32_glibc2;

extern gsl_rng_type *gsl_rng_random32_libc5;

extern gsl_rng_type *gsl_rng_random64_bsd;

extern gsl_rng_type *gsl_rng_random64_glibc2;

extern gsl_rng_type *gsl_rng_random64_libc5;

extern gsl_rng_type *gsl_rng_random8_bsd;

extern gsl_rng_type *gsl_rng_random8_glibc2;

extern gsl_rng_type *gsl_rng_random8_libc5;

extern gsl_rng_type *gsl_rng_random_bsd;

extern gsl_rng_type *gsl_rng_random_glibc2;

extern gsl_rng_type *gsl_rng_random_libc5;

extern gsl_rng_type *gsl_rng_randu;

extern gsl_rng_type *gsl_rng_ranf;

extern gsl_rng_type *gsl_rng_ranlux;

extern gsl_rng_type *gsl_rng_ranlux389;

extern gsl_rng_type *gsl_rng_ranlxd1;

extern gsl_rng_type *gsl_rng_ranlxd2;

extern gsl_rng_type *gsl_rng_ranlxs0;

extern gsl_rng_type *gsl_rng_ranlxs1;

extern gsl_rng_type *gsl_rng_ranlxs2;

extern gsl_rng_type *gsl_rng_ranmar;

extern gsl_rng_type *gsl_rng_slatec;

extern gsl_rng_type *gsl_rng_taus;

extern gsl_rng_type *gsl_rng_taus2;

extern gsl_rng_type *gsl_rng_taus113;

extern gsl_rng_type *gsl_rng_transputer;

extern gsl_rng_type *gsl_rng_tt800;

extern gsl_rng_type *gsl_rng_uni;

extern gsl_rng_type *gsl_rng_uni32;

extern gsl_rng_type *gsl_rng_vax;

extern gsl_rng_type *gsl_rng_waterman14;

extern gsl_rng_type *gsl_rng_zuf;

gsl_rng_type ** gsl_rng_types_setup();

extern gsl_rng_type *gsl_rng_default;

extern uint gsl_rng_default_seed;

gsl_rng * gsl_rng_alloc(gsl_rng_type *T);

int  gsl_rng_memcpy(gsl_rng *dest, gsl_rng *src);

gsl_rng * gsl_rng_clone(gsl_rng *r);

void  gsl_rng_free(gsl_rng *r);

void  gsl_rng_set(gsl_rng *r, uint seed);

uint  gsl_rng_max(gsl_rng *r);

uint  gsl_rng_min(gsl_rng *r);

char * gsl_rng_name(gsl_rng *r);

int  gsl_rng_fread(FILE *stream, gsl_rng *r);

int  gsl_rng_fwrite(FILE *stream, gsl_rng *r);

size_t  gsl_rng_size(gsl_rng *r);

void * gsl_rng_state(gsl_rng *r);

void  gsl_rng_print_state(gsl_rng *r);

gsl_rng_type * gsl_rng_env_setup();

uint  gsl_rng_get(gsl_rng *r);

double  gsl_rng_uniform(gsl_rng *r);

double  gsl_rng_uniform_pos(gsl_rng *r);

uint  gsl_rng_uniform_int(gsl_rng *r, uint n);


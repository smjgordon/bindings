/* Converted to D from gsl_qrng.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_qrng;
/* Author: G. Jungman
 */

import tango.stdc.stdlib;

public import gsl.gsl_types;

public import gsl.gsl_errno;

/* Once again, more inane C-style OOP... kill me now. */

/* Structure describing a type of generator.
 */

extern (C):
struct gsl_qrng_type
{
    char *name;
    uint max_dimension;
    size_t  function(uint dimension)state_size;
    int  function(void *state, uint dimension)init_state;
    int  function(void *state, uint dimension, double *x)get;
};

/* Structure describing a generator instance of a
 * specified type, with generator-specific state info
 * and dimension-specific info.
 */

struct gsl_qrng
{
    gsl_qrng_type *type;
    uint dimension;
    size_t state_size;
    void *state;
};

/* Supported generator types.
 */

extern gsl_qrng_type *gsl_qrng_niederreiter_2;

extern gsl_qrng_type *gsl_qrng_sobol;

/* Allocate and initialize a generator
 * of the specified type, in the given
 * space dimension.
 */

gsl_qrng * gsl_qrng_alloc(gsl_qrng_type *T, uint dimension);

/* Copy a generator. */

int  gsl_qrng_memcpy(gsl_qrng *dest, gsl_qrng *src);

/* Clone a generator. */

gsl_qrng * gsl_qrng_clone(gsl_qrng *r);

/* Free a generator. */

void  gsl_qrng_free(gsl_qrng *r);

/* Intialize a generator. */

void  gsl_qrng_init(gsl_qrng *r);

/* Get the standardized name of the generator. */

char * gsl_qrng_name(gsl_qrng *r);

/* ISN'T THIS CONFUSING FOR PEOPLE?
  WHAT IF SOMEBODY TRIES TO COPY WITH THIS ???
  */

size_t  gsl_qrng_size(gsl_qrng *r);

void * gsl_qrng_state(gsl_qrng *r);

/* Retrieve next vector in sequence. */

int  gsl_qrng_get(gsl_qrng *r, double *x);


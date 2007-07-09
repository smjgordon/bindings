/* Converted to D from gsl_integration.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_integration;
/* integration/gsl_integration.h
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

import tango.stdc.stdlib;

public import gsl.gsl_math;

/* Workspace for adaptive integrators */

extern (C):
struct gsl_integration_workspace
{
    size_t limit;
    size_t size;
    size_t nrmax;
    size_t i;
    size_t maximum_level;
    double *alist;
    double *blist;
    double *rlist;
    double *elist;
    size_t *order;
    size_t *level;
};

gsl_integration_workspace * gsl_integration_workspace_alloc(size_t n);

void  gsl_integration_workspace_free(gsl_integration_workspace *w);

/* Workspace for QAWS integrator */

struct gsl_integration_qaws_table
{
    double alpha;
    double beta;
    int mu;
    int nu;
    double [25]ri;
    double [25]rj;
    double [25]rg;
    double [25]rh;
};

gsl_integration_qaws_table * gsl_integration_qaws_table_alloc(double alpha, double beta, int mu, int nu);

int  gsl_integration_qaws_table_set(gsl_integration_qaws_table *t, double alpha, double beta, int mu, int nu);

void  gsl_integration_qaws_table_free(gsl_integration_qaws_table *t);

/* Workspace for QAWO integrator */

enum gsl_integration_qawo_enum
{
    GSL_INTEG_COSINE,
    GSL_INTEG_SINE,
}

struct gsl_integration_qawo_table
{
    size_t n;
    double omega;
    double L;
    double par;
    gsl_integration_qawo_enum sine;
    double *chebmo;
};

gsl_integration_qawo_table * gsl_integration_qawo_table_alloc(double omega, double L, gsl_integration_qawo_enum sine, size_t n);

int  gsl_integration_qawo_table_set(gsl_integration_qawo_table *t, double omega, double L, gsl_integration_qawo_enum sine);

int  gsl_integration_qawo_table_set_length(gsl_integration_qawo_table *t, double L);

void  gsl_integration_qawo_table_free(gsl_integration_qawo_table *t);

/* Definition of an integration rule */

//alias void C func(gsl_function *f, double a, double b, double *result, double *abserr, double *defabs, double *resabs)gsl_integration_rule;
alias void function(gsl_function *f, double a, double b, double *result, double *abserr, double *defabs, double *resabs) gsl_integration_rule;

void  gsl_integration_qk15(gsl_function *f, double a, double b, double *result, double *abserr, double *resabs, double *resasc);

void  gsl_integration_qk21(gsl_function *f, double a, double b, double *result, double *abserr, double *resabs, double *resasc);

void  gsl_integration_qk31(gsl_function *f, double a, double b, double *result, double *abserr, double *resabs, double *resasc);

void  gsl_integration_qk41(gsl_function *f, double a, double b, double *result, double *abserr, double *resabs, double *resasc);

void  gsl_integration_qk51(gsl_function *f, double a, double b, double *result, double *abserr, double *resabs, double *resasc);

void  gsl_integration_qk61(gsl_function *f, double a, double b, double *result, double *abserr, double *resabs, double *resasc);

void  gsl_integration_qcheb(gsl_function *f, double a, double b, double *cheb12, double *cheb24);

/* The low-level integration rules in QUADPACK are identified by small
   integers (1-6). We'll use symbolic constants to refer to them.  */

enum
{
    GSL_INTEG_GAUSS15 = 1,
    GSL_INTEG_GAUSS21,
    GSL_INTEG_GAUSS31,
    GSL_INTEG_GAUSS41,
    GSL_INTEG_GAUSS51,
    GSL_INTEG_GAUSS61,
}

void  gsl_integration_qk(int n, double *xgk, double *wg, double *wgk, double *fv1, double *fv2, gsl_function *f, double a, double b, double *result, double *abserr, double *resabs, double *resasc);

int  gsl_integration_qng(gsl_function *f, double a, double b, double epsabs, double epsrel, double *result, double *abserr, size_t *neval);

int  gsl_integration_qag(gsl_function *f, double a, double b, double epsabs, double epsrel, size_t limit, int key, gsl_integration_workspace *workspace, double *result, double *abserr);

int  gsl_integration_qagi(gsl_function *f, double epsabs, double epsrel, size_t limit, gsl_integration_workspace *workspace, double *result, double *abserr);

int  gsl_integration_qagiu(gsl_function *f, double a, double epsabs, double epsrel, size_t limit, gsl_integration_workspace *workspace, double *result, double *abserr);

int  gsl_integration_qagil(gsl_function *f, double b, double epsabs, double epsrel, size_t limit, gsl_integration_workspace *workspace, double *result, double *abserr);

int  gsl_integration_qags(gsl_function *f, double a, double b, double epsabs, double epsrel, size_t limit, gsl_integration_workspace *workspace, double *result, double *abserr);

int  gsl_integration_qagp(gsl_function *f, double *pts, size_t npts, double epsabs, double epsrel, size_t limit, gsl_integration_workspace *workspace, double *result, double *abserr);

int  gsl_integration_qawc(gsl_function *f, double a, double b, double c, double epsabs, double epsrel, size_t limit, gsl_integration_workspace *workspace, double *result, double *abserr);

int  gsl_integration_qaws(gsl_function *f, double a, double b, gsl_integration_qaws_table *t, double epsabs, double epsrel, size_t limit, gsl_integration_workspace *workspace, double *result, double *abserr);

int  gsl_integration_qawo(gsl_function *f, double a, double epsabs, double epsrel, size_t limit, gsl_integration_workspace *workspace, gsl_integration_qawo_table *wf, double *result, double *abserr);

int  gsl_integration_qawf(gsl_function *f, double a, double epsabs, size_t limit, gsl_integration_workspace *workspace, gsl_integration_workspace *cycle_workspace, gsl_integration_qawo_table *wf, double *result, double *abserr);


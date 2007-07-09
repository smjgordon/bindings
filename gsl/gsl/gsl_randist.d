/* Converted to D from gsl_randist.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_randist;
/* randist/gsl_randist.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 James Theiler, Brian Gough
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

public import gsl.gsl_rng;

extern (C):
uint  gsl_ran_bernoulli(gsl_rng *r, double p);

double  gsl_ran_bernoulli_pdf(uint k, double p);

double  gsl_ran_beta(gsl_rng *r, double a, double b);

double  gsl_ran_beta_pdf(double x, double a, double b);

uint  gsl_ran_binomial(gsl_rng *r, double p, uint n);

uint  gsl_ran_binomial_knuth(gsl_rng *r, double p, uint n);

uint  gsl_ran_binomial_tpe(gsl_rng *r, double p, uint n);

double  gsl_ran_binomial_pdf(uint k, double p, uint n);

double  gsl_ran_exponential(gsl_rng *r, double mu);

double  gsl_ran_exponential_pdf(double x, double mu);

double  gsl_ran_exppow(gsl_rng *r, double a, double b);

double  gsl_ran_exppow_pdf(double x, double a, double b);

double  gsl_ran_cauchy(gsl_rng *r, double a);

double  gsl_ran_cauchy_pdf(double x, double a);

double  gsl_ran_chisq(gsl_rng *r, double nu);

double  gsl_ran_chisq_pdf(double x, double nu);

void  gsl_ran_dirichlet(gsl_rng *r, size_t K, double *alpha, double *theta);

double  gsl_ran_dirichlet_pdf(size_t K, double *alpha, double *theta);

double  gsl_ran_dirichlet_lnpdf(size_t K, double *alpha, double *theta);

double  gsl_ran_erlang(gsl_rng *r, double a, double n);

double  gsl_ran_erlang_pdf(double x, double a, double n);

double  gsl_ran_fdist(gsl_rng *r, double nu1, double nu2);

double  gsl_ran_fdist_pdf(double x, double nu1, double nu2);

double  gsl_ran_flat(gsl_rng *r, double a, double b);

double  gsl_ran_flat_pdf(double x, double a, double b);

double  gsl_ran_gamma(gsl_rng *r, double a, double b);

double  gsl_ran_gamma_int(gsl_rng *r, uint a);

double  gsl_ran_gamma_pdf(double x, double a, double b);

double  gsl_ran_gamma_mt(gsl_rng *r, double a, double b);

double  gsl_ran_gaussian(gsl_rng *r, double sigma);

double  gsl_ran_gaussian_ratio_method(gsl_rng *r, double sigma);

double  gsl_ran_gaussian_ziggurat(gsl_rng *r, double sigma);

double  gsl_ran_gaussian_pdf(double x, double sigma);

double  gsl_ran_ugaussian(gsl_rng *r);

double  gsl_ran_ugaussian_ratio_method(gsl_rng *r);

double  gsl_ran_ugaussian_pdf(double x);

double  gsl_ran_gaussian_tail(gsl_rng *r, double a, double sigma);

double  gsl_ran_gaussian_tail_pdf(double x, double a, double sigma);

double  gsl_ran_ugaussian_tail(gsl_rng *r, double a);

double  gsl_ran_ugaussian_tail_pdf(double x, double a);

void  gsl_ran_bivariate_gaussian(gsl_rng *r, double sigma_x, double sigma_y, double rho, double *x, double *y);

double  gsl_ran_bivariate_gaussian_pdf(double x, double y, double sigma_x, double sigma_y, double rho);

double  gsl_ran_landau(gsl_rng *r);

double  gsl_ran_landau_pdf(double x);

uint  gsl_ran_geometric(gsl_rng *r, double p);

double  gsl_ran_geometric_pdf(uint k, double p);

uint  gsl_ran_hypergeometric(gsl_rng *r, uint n1, uint n2, uint t);

double  gsl_ran_hypergeometric_pdf(uint k, uint n1, uint n2, uint t);

double  gsl_ran_gumbel1(gsl_rng *r, double a, double b);

double  gsl_ran_gumbel1_pdf(double x, double a, double b);

double  gsl_ran_gumbel2(gsl_rng *r, double a, double b);

double  gsl_ran_gumbel2_pdf(double x, double a, double b);

double  gsl_ran_logistic(gsl_rng *r, double a);

double  gsl_ran_logistic_pdf(double x, double a);

double  gsl_ran_lognormal(gsl_rng *r, double zeta, double sigma);

double  gsl_ran_lognormal_pdf(double x, double zeta, double sigma);

uint  gsl_ran_logarithmic(gsl_rng *r, double p);

double  gsl_ran_logarithmic_pdf(uint k, double p);

void  gsl_ran_multinomial(gsl_rng *r, size_t K, uint N, double *p, uint *n);

double  gsl_ran_multinomial_pdf(size_t K, double *p, uint *n);

double  gsl_ran_multinomial_lnpdf(size_t K, double *p, uint *n);

uint  gsl_ran_negative_binomial(gsl_rng *r, double p, double n);

double  gsl_ran_negative_binomial_pdf(uint k, double p, double n);

uint  gsl_ran_pascal(gsl_rng *r, double p, uint n);

double  gsl_ran_pascal_pdf(uint k, double p, uint n);

double  gsl_ran_pareto(gsl_rng *r, double a, double b);

double  gsl_ran_pareto_pdf(double x, double a, double b);

uint  gsl_ran_poisson(gsl_rng *r, double mu);

void  gsl_ran_poisson_array(gsl_rng *r, size_t n, uint *array, double mu);

double  gsl_ran_poisson_pdf(uint k, double mu);

double  gsl_ran_rayleigh(gsl_rng *r, double sigma);

double  gsl_ran_rayleigh_pdf(double x, double sigma);

double  gsl_ran_rayleigh_tail(gsl_rng *r, double a, double sigma);

double  gsl_ran_rayleigh_tail_pdf(double x, double a, double sigma);

double  gsl_ran_tdist(gsl_rng *r, double nu);

double  gsl_ran_tdist_pdf(double x, double nu);

double  gsl_ran_laplace(gsl_rng *r, double a);

double  gsl_ran_laplace_pdf(double x, double a);

double  gsl_ran_levy(gsl_rng *r, double c, double alpha);

double  gsl_ran_levy_skew(gsl_rng *r, double c, double alpha, double beta);

double  gsl_ran_weibull(gsl_rng *r, double a, double b);

double  gsl_ran_weibull_pdf(double x, double a, double b);

void  gsl_ran_dir_2d(gsl_rng *r, double *x, double *y);

void  gsl_ran_dir_2d_trig_method(gsl_rng *r, double *x, double *y);

void  gsl_ran_dir_3d(gsl_rng *r, double *x, double *y, double *z);

void  gsl_ran_dir_nd(gsl_rng *r, size_t n, double *x);

void  gsl_ran_shuffle(gsl_rng *r, void *base, size_t nmembm, size_t size);

int  gsl_ran_choose(gsl_rng *r, void *dest, size_t k, void *src, size_t n, size_t size);

void  gsl_ran_sample(gsl_rng *r, void *dest, size_t k, void *src, size_t n, size_t size);

struct gsl_ran_discrete_t
{
    size_t K;
    size_t *A;
    double *F;
};

gsl_ran_discrete_t * gsl_ran_discrete_preproc(size_t K, double *P);

void  gsl_ran_discrete_free(gsl_ran_discrete_t *g);

size_t  gsl_ran_discrete(gsl_rng *r, gsl_ran_discrete_t *g);

double  gsl_ran_discrete_pdf(size_t k, gsl_ran_discrete_t *g);


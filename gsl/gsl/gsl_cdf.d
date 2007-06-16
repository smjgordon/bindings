/* Converted to D from gsl_cdf.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_cdf;
/* cdf/gsl_cdf.h
 * 
 * Copyright (C) 2002 Jason H. Stover.
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
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307, USA.
 */

/* Author:  J. Stover */

extern (C):
double  gsl_cdf_ugaussian_P(double x);

double  gsl_cdf_ugaussian_Q(double x);

double  gsl_cdf_ugaussian_Pinv(double P);

double  gsl_cdf_ugaussian_Qinv(double Q);

double  gsl_cdf_gaussian_P(double x, double sigma);

double  gsl_cdf_gaussian_Q(double x, double sigma);

double  gsl_cdf_gaussian_Pinv(double P, double sigma);

double  gsl_cdf_gaussian_Qinv(double Q, double sigma);

double  gsl_cdf_gamma_P(double x, double a, double b);

double  gsl_cdf_gamma_Q(double x, double a, double b);

double  gsl_cdf_gamma_Pinv(double P, double a, double b);

double  gsl_cdf_gamma_Qinv(double Q, double a, double b);

double  gsl_cdf_cauchy_P(double x, double a);

double  gsl_cdf_cauchy_Q(double x, double a);

double  gsl_cdf_cauchy_Pinv(double P, double a);

double  gsl_cdf_cauchy_Qinv(double Q, double a);

double  gsl_cdf_laplace_P(double x, double a);

double  gsl_cdf_laplace_Q(double x, double a);

double  gsl_cdf_laplace_Pinv(double P, double a);

double  gsl_cdf_laplace_Qinv(double Q, double a);

double  gsl_cdf_rayleigh_P(double x, double sigma);

double  gsl_cdf_rayleigh_Q(double x, double sigma);

double  gsl_cdf_rayleigh_Pinv(double P, double sigma);

double  gsl_cdf_rayleigh_Qinv(double Q, double sigma);

double  gsl_cdf_chisq_P(double x, double nu);

double  gsl_cdf_chisq_Q(double x, double nu);

double  gsl_cdf_chisq_Pinv(double P, double nu);

double  gsl_cdf_chisq_Qinv(double Q, double nu);

double  gsl_cdf_exponential_P(double x, double mu);

double  gsl_cdf_exponential_Q(double x, double mu);

double  gsl_cdf_exponential_Pinv(double P, double mu);

double  gsl_cdf_exponential_Qinv(double Q, double mu);

double  gsl_cdf_exppow_P(double x, double a, double b);

double  gsl_cdf_exppow_Q(double x, double a, double b);

double  gsl_cdf_tdist_P(double x, double nu);

double  gsl_cdf_tdist_Q(double x, double nu);

double  gsl_cdf_tdist_Pinv(double P, double nu);

double  gsl_cdf_tdist_Qinv(double Q, double nu);

double  gsl_cdf_fdist_P(double x, double nu1, double nu2);

double  gsl_cdf_fdist_Q(double x, double nu1, double nu2);

double  gsl_cdf_fdist_Pinv(double P, double nu1, double nu2);

double  gsl_cdf_fdist_Qinv(double Q, double nu1, double nu2);

double  gsl_cdf_beta_P(double x, double a, double b);

double  gsl_cdf_beta_Q(double x, double a, double b);

double  gsl_cdf_beta_Pinv(double P, double a, double b);

double  gsl_cdf_beta_Qinv(double Q, double a, double b);

double  gsl_cdf_flat_P(double x, double a, double b);

double  gsl_cdf_flat_Q(double x, double a, double b);

double  gsl_cdf_flat_Pinv(double P, double a, double b);

double  gsl_cdf_flat_Qinv(double Q, double a, double b);

double  gsl_cdf_lognormal_P(double x, double zeta, double sigma);

double  gsl_cdf_lognormal_Q(double x, double zeta, double sigma);

double  gsl_cdf_lognormal_Pinv(double P, double zeta, double sigma);

double  gsl_cdf_lognormal_Qinv(double Q, double zeta, double sigma);

double  gsl_cdf_gumbel1_P(double x, double a, double b);

double  gsl_cdf_gumbel1_Q(double x, double a, double b);

double  gsl_cdf_gumbel1_Pinv(double P, double a, double b);

double  gsl_cdf_gumbel1_Qinv(double Q, double a, double b);

double  gsl_cdf_gumbel2_P(double x, double a, double b);

double  gsl_cdf_gumbel2_Q(double x, double a, double b);

double  gsl_cdf_gumbel2_Pinv(double P, double a, double b);

double  gsl_cdf_gumbel2_Qinv(double Q, double a, double b);

double  gsl_cdf_weibull_P(double x, double a, double b);

double  gsl_cdf_weibull_Q(double x, double a, double b);

double  gsl_cdf_weibull_Pinv(double P, double a, double b);

double  gsl_cdf_weibull_Qinv(double Q, double a, double b);

double  gsl_cdf_pareto_P(double x, double a, double b);

double  gsl_cdf_pareto_Q(double x, double a, double b);

double  gsl_cdf_pareto_Pinv(double P, double a, double b);

double  gsl_cdf_pareto_Qinv(double Q, double a, double b);

double  gsl_cdf_logistic_P(double x, double a);

double  gsl_cdf_logistic_Q(double x, double a);

double  gsl_cdf_logistic_Pinv(double P, double a);

double  gsl_cdf_logistic_Qinv(double Q, double a);

double  gsl_cdf_binomial_P(uint k, double p, uint n);

double  gsl_cdf_binomial_Q(uint k, double p, uint n);

double  gsl_cdf_poisson_P(uint k, double mu);

double  gsl_cdf_poisson_Q(uint k, double mu);

double  gsl_cdf_geometric_P(uint k, double p);

double  gsl_cdf_geometric_Q(uint k, double p);

double  gsl_cdf_negative_binomial_P(uint k, double p, double n);

double  gsl_cdf_negative_binomial_Q(uint k, double p, double n);

double  gsl_cdf_pascal_P(uint k, double p, uint n);

double  gsl_cdf_pascal_Q(uint k, double p, uint n);

double  gsl_cdf_hypergeometric_P(uint k, uint n1, uint n2, uint t);

double  gsl_cdf_hypergeometric_Q(uint k, uint n1, uint n2, uint t);


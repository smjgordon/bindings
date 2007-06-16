/* Converted to D from gsl_sf_coulomb.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_sf_coulomb;
/* specfunc/gsl_sf_coulomb.h
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

/* Author:  G. Jungman */

public import gsl.gsl_mode;

public import gsl.gsl_sf_result;

/* Normalized hydrogenic bound states, radial dependence. */

/* R_1 := 2Z sqrt(Z) exp(-Z r)
 */

extern (C):
int  gsl_sf_hydrogenicR_1_e(double Z, double r, gsl_sf_result *result);

double  gsl_sf_hydrogenicR_1(double Z, double r);

/* R_n := norm exp(-Z r/n) (2Z/n)^l Laguerre[n-l-1, 2l+1, 2Z/n r]
 *
 * normalization such that psi(n,l,r) = R_n Y_{lm}
 */

int  gsl_sf_hydrogenicR_e(int n, int l, double Z, double r, gsl_sf_result *result);

double  gsl_sf_hydrogenicR(int n, int l, double Z, double r);

/* Coulomb wave functions F_{lam_F}(eta,x), G_{lam_G}(eta,x)
 * and their derivatives; lam_G := lam_F - k_lam_G
 *
 * lam_F, lam_G > -0.5
 * x > 0.0
 *
 * Conventions of Abramowitz+Stegun.
 *
 * Because there can be a large dynamic range of values,
 * overflows are handled gracefully. If an overflow occurs,
 * GSL_EOVRFLW is signalled and exponent(s) are returned
 * through exp_F, exp_G. These are such that
 *
 *   F_L(eta,x)  =  fc[k_L] * exp(exp_F)
 *   G_L(eta,x)  =  gc[k_L] * exp(exp_G)
 *   F_L'(eta,x) = fcp[k_L] * exp(exp_F)
 *   G_L'(eta,x) = gcp[k_L] * exp(exp_G)
 */

int  gsl_sf_coulomb_wave_FG_e(double eta, double x, double lam_F, int k_lam_G, gsl_sf_result *F, gsl_sf_result *Fp, gsl_sf_result *G, gsl_sf_result *Gp, double *exp_F, double *exp_G);

/* F_L(eta,x) as array */

int  gsl_sf_coulomb_wave_F_array(double lam_min, int kmax, double eta, double x, double *fc_array, double *F_exponent);

/* F_L(eta,x), G_L(eta,x) as arrays */

int  gsl_sf_coulomb_wave_FG_array(double lam_min, int kmax, double eta, double x, double *fc_array, double *gc_array, double *F_exponent, double *G_exponent);

/* F_L(eta,x), G_L(eta,x), F'_L(eta,x), G'_L(eta,x) as arrays */

int  gsl_sf_coulomb_wave_FGp_array(double lam_min, int kmax, double eta, double x, double *fc_array, double *fcp_array, double *gc_array, double *gcp_array, double *F_exponent, double *G_exponent);

/* Coulomb wave function divided by the argument,
 * F(eta, x)/x. This is the function which reduces to
 * spherical Bessel functions in the limit eta->0.
 */

int  gsl_sf_coulomb_wave_sphF_array(double lam_min, int kmax, double eta, double x, double *fc_array, double *F_exponent);

/* Coulomb wave function normalization constant.
 * [Abramowitz+Stegun 14.1.8, 14.1.9]
 */

int  gsl_sf_coulomb_CL_e(double L, double eta, gsl_sf_result *result);

int  gsl_sf_coulomb_CL_array(double Lmin, int kmax, double eta, double *cl);


/* Converted to D from gsl_statistics_long_double.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_statistics_long_double;
/* statistics/gsl_statistics_long_double.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Jim Davies, Brian Gough
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

import tango.stdc.stddef;

extern (C):
double  gsl_stats_long_double_mean(real *data, size_t stride, size_t n);

double  gsl_stats_long_double_variance(real *data, size_t stride, size_t n);

double  gsl_stats_long_double_sd(real *data, size_t stride, size_t n);

double  gsl_stats_long_double_variance_with_fixed_mean(real *data, size_t stride, size_t n, double mean);

double  gsl_stats_long_double_sd_with_fixed_mean(real *data, size_t stride, size_t n, double mean);

double  gsl_stats_long_double_absdev(real *data, size_t stride, size_t n);

double  gsl_stats_long_double_skew(real *data, size_t stride, size_t n);

double  gsl_stats_long_double_kurtosis(real *data, size_t stride, size_t n);

double  gsl_stats_long_double_lag1_autocorrelation(real *data, size_t stride, size_t n);

double  gsl_stats_long_double_covariance(real *data1, size_t stride1, real *data2, size_t stride2, size_t n);

double  gsl_stats_long_double_variance_m(real *data, size_t stride, size_t n, double mean);

double  gsl_stats_long_double_sd_m(real *data, size_t stride, size_t n, double mean);

double  gsl_stats_long_double_absdev_m(real *data, size_t stride, size_t n, double mean);

double  gsl_stats_long_double_skew_m_sd(real *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_long_double_kurtosis_m_sd(real *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_long_double_lag1_autocorrelation_m(real *data, size_t stride, size_t n, double mean);

double  gsl_stats_long_double_covariance_m(real *data1, size_t stride1, real *data2, size_t stride2, size_t n, double mean1, double mean2);

/* DEFINED FOR FLOATING POINT TYPES ONLY */

double  gsl_stats_long_double_wmean(real *w, size_t wstride, real *data, size_t stride, size_t n);

double  gsl_stats_long_double_wvariance(real *w, size_t wstride, real *data, size_t stride, size_t n);

double  gsl_stats_long_double_wsd(real *w, size_t wstride, real *data, size_t stride, size_t n);

double  gsl_stats_long_double_wvariance_with_fixed_mean(real *w, size_t wstride, real *data, size_t stride, size_t n, double mean);

double  gsl_stats_long_double_wsd_with_fixed_mean(real *w, size_t wstride, real *data, size_t stride, size_t n, double mean);

double  gsl_stats_long_double_wabsdev(real *w, size_t wstride, real *data, size_t stride, size_t n);

double  gsl_stats_long_double_wskew(real *w, size_t wstride, real *data, size_t stride, size_t n);

double  gsl_stats_long_double_wkurtosis(real *w, size_t wstride, real *data, size_t stride, size_t n);

double  gsl_stats_long_double_wvariance_m(real *w, size_t wstride, real *data, size_t stride, size_t n, double wmean);

double  gsl_stats_long_double_wsd_m(real *w, size_t wstride, real *data, size_t stride, size_t n, double wmean);

double  gsl_stats_long_double_wabsdev_m(real *w, size_t wstride, real *data, size_t stride, size_t n, double wmean);

double  gsl_stats_long_double_wskew_m_sd(real *w, size_t wstride, real *data, size_t stride, size_t n, double wmean, double wsd);

double  gsl_stats_long_double_wkurtosis_m_sd(real *w, size_t wstride, real *data, size_t stride, size_t n, double wmean, double wsd);

/* END OF FLOATING POINT TYPES */

double  gsl_stats_long_double_pvariance(real *data1, size_t stride1, size_t n1, real *data2, size_t stride2, size_t n2);

double  gsl_stats_long_double_ttest(real *data1, size_t stride1, size_t n1, real *data2, size_t stride2, size_t n2);

real  gsl_stats_long_double_max(real *data, size_t stride, size_t n);

real  gsl_stats_long_double_min(real *data, size_t stride, size_t n);

void  gsl_stats_long_double_minmax(real *min, real *max, real *data, size_t stride, size_t n);

size_t  gsl_stats_long_double_max_index(real *data, size_t stride, size_t n);

size_t  gsl_stats_long_double_min_index(real *data, size_t stride, size_t n);

void  gsl_stats_long_double_minmax_index(size_t *min_index, size_t *max_index, real *data, size_t stride, size_t n);

double  gsl_stats_long_double_median_from_sorted_data(real *sorted_data, size_t stride, size_t n);

double  gsl_stats_long_double_quantile_from_sorted_data(real *sorted_data, size_t stride, size_t n, double f);


/* Converted to D from gsl_statistics_float.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_statistics_float;
/* statistics/gsl_statistics_float.h
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
double  gsl_stats_float_mean(float *data, size_t stride, size_t n);

double  gsl_stats_float_variance(float *data, size_t stride, size_t n);

double  gsl_stats_float_sd(float *data, size_t stride, size_t n);

double  gsl_stats_float_variance_with_fixed_mean(float *data, size_t stride, size_t n, double mean);

double  gsl_stats_float_sd_with_fixed_mean(float *data, size_t stride, size_t n, double mean);

double  gsl_stats_float_absdev(float *data, size_t stride, size_t n);

double  gsl_stats_float_skew(float *data, size_t stride, size_t n);

double  gsl_stats_float_kurtosis(float *data, size_t stride, size_t n);

double  gsl_stats_float_lag1_autocorrelation(float *data, size_t stride, size_t n);

double  gsl_stats_float_covariance(float *data1, size_t stride1, float *data2, size_t stride2, size_t n);

double  gsl_stats_float_variance_m(float *data, size_t stride, size_t n, double mean);

double  gsl_stats_float_sd_m(float *data, size_t stride, size_t n, double mean);

double  gsl_stats_float_absdev_m(float *data, size_t stride, size_t n, double mean);

double  gsl_stats_float_skew_m_sd(float *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_float_kurtosis_m_sd(float *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_float_lag1_autocorrelation_m(float *data, size_t stride, size_t n, double mean);

double  gsl_stats_float_covariance_m(float *data1, size_t stride1, float *data2, size_t stride2, size_t n, double mean1, double mean2);

/* DEFINED FOR FLOATING POINT TYPES ONLY */

double  gsl_stats_float_wmean(float *w, size_t wstride, float *data, size_t stride, size_t n);

double  gsl_stats_float_wvariance(float *w, size_t wstride, float *data, size_t stride, size_t n);

double  gsl_stats_float_wsd(float *w, size_t wstride, float *data, size_t stride, size_t n);

double  gsl_stats_float_wvariance_with_fixed_mean(float *w, size_t wstride, float *data, size_t stride, size_t n, double mean);

double  gsl_stats_float_wsd_with_fixed_mean(float *w, size_t wstride, float *data, size_t stride, size_t n, double mean);

double  gsl_stats_float_wabsdev(float *w, size_t wstride, float *data, size_t stride, size_t n);

double  gsl_stats_float_wskew(float *w, size_t wstride, float *data, size_t stride, size_t n);

double  gsl_stats_float_wkurtosis(float *w, size_t wstride, float *data, size_t stride, size_t n);

double  gsl_stats_float_wvariance_m(float *w, size_t wstride, float *data, size_t stride, size_t n, double wmean);

double  gsl_stats_float_wsd_m(float *w, size_t wstride, float *data, size_t stride, size_t n, double wmean);

double  gsl_stats_float_wabsdev_m(float *w, size_t wstride, float *data, size_t stride, size_t n, double wmean);

double  gsl_stats_float_wskew_m_sd(float *w, size_t wstride, float *data, size_t stride, size_t n, double wmean, double wsd);

double  gsl_stats_float_wkurtosis_m_sd(float *w, size_t wstride, float *data, size_t stride, size_t n, double wmean, double wsd);

/* END OF FLOATING POINT TYPES */

double  gsl_stats_float_pvariance(float *data1, size_t stride1, size_t n1, float *data2, size_t stride2, size_t n2);

double  gsl_stats_float_ttest(float *data1, size_t stride1, size_t n1, float *data2, size_t stride2, size_t n2);

float  gsl_stats_float_max(float *data, size_t stride, size_t n);

float  gsl_stats_float_min(float *data, size_t stride, size_t n);

void  gsl_stats_float_minmax(float *min, float *max, float *data, size_t stride, size_t n);

size_t  gsl_stats_float_max_index(float *data, size_t stride, size_t n);

size_t  gsl_stats_float_min_index(float *data, size_t stride, size_t n);

void  gsl_stats_float_minmax_index(size_t *min_index, size_t *max_index, float *data, size_t stride, size_t n);

double  gsl_stats_float_median_from_sorted_data(float *sorted_data, size_t stride, size_t n);

double  gsl_stats_float_quantile_from_sorted_data(float *sorted_data, size_t stride, size_t n, double f);


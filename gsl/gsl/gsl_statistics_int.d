/* Converted to D from gsl_statistics_int.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_statistics_int;
/* statistics/gsl_statistics_int.h
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
double  gsl_stats_int_mean(int *data, size_t stride, size_t n);

double  gsl_stats_int_variance(int *data, size_t stride, size_t n);

double  gsl_stats_int_sd(int *data, size_t stride, size_t n);

double  gsl_stats_int_variance_with_fixed_mean(int *data, size_t stride, size_t n, double mean);

double  gsl_stats_int_sd_with_fixed_mean(int *data, size_t stride, size_t n, double mean);

double  gsl_stats_int_absdev(int *data, size_t stride, size_t n);

double  gsl_stats_int_skew(int *data, size_t stride, size_t n);

double  gsl_stats_int_kurtosis(int *data, size_t stride, size_t n);

double  gsl_stats_int_lag1_autocorrelation(int *data, size_t stride, size_t n);

double  gsl_stats_int_covariance(int *data1, size_t stride1, int *data2, size_t stride2, size_t n);

double  gsl_stats_int_variance_m(int *data, size_t stride, size_t n, double mean);

double  gsl_stats_int_sd_m(int *data, size_t stride, size_t n, double mean);

double  gsl_stats_int_absdev_m(int *data, size_t stride, size_t n, double mean);

double  gsl_stats_int_skew_m_sd(int *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_int_kurtosis_m_sd(int *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_int_lag1_autocorrelation_m(int *data, size_t stride, size_t n, double mean);

double  gsl_stats_int_covariance_m(int *data1, size_t stride1, int *data2, size_t stride2, size_t n, double mean1, double mean2);

double  gsl_stats_int_pvariance(int *data1, size_t stride1, size_t n1, int *data2, size_t stride2, size_t n2);

double  gsl_stats_int_ttest(int *data1, size_t stride1, size_t n1, int *data2, size_t stride2, size_t n2);

int  gsl_stats_int_max(int *data, size_t stride, size_t n);

int  gsl_stats_int_min(int *data, size_t stride, size_t n);

void  gsl_stats_int_minmax(int *min, int *max, int *data, size_t stride, size_t n);

size_t  gsl_stats_int_max_index(int *data, size_t stride, size_t n);

size_t  gsl_stats_int_min_index(int *data, size_t stride, size_t n);

void  gsl_stats_int_minmax_index(size_t *min_index, size_t *max_index, int *data, size_t stride, size_t n);

double  gsl_stats_int_median_from_sorted_data(int *sorted_data, size_t stride, size_t n);

double  gsl_stats_int_quantile_from_sorted_data(int *sorted_data, size_t stride, size_t n, double f);


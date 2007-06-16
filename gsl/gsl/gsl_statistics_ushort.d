/* Converted to D from gsl_statistics_ushort.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_statistics_ushort;
/* statistics/gsl_statistics_ushort.h
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
double  gsl_stats_ushort_mean(ushort *data, size_t stride, size_t n);

double  gsl_stats_ushort_variance(ushort *data, size_t stride, size_t n);

double  gsl_stats_ushort_sd(ushort *data, size_t stride, size_t n);

double  gsl_stats_ushort_variance_with_fixed_mean(ushort *data, size_t stride, size_t n, double mean);

double  gsl_stats_ushort_sd_with_fixed_mean(ushort *data, size_t stride, size_t n, double mean);

double  gsl_stats_ushort_absdev(ushort *data, size_t stride, size_t n);

double  gsl_stats_ushort_skew(ushort *data, size_t stride, size_t n);

double  gsl_stats_ushort_kurtosis(ushort *data, size_t stride, size_t n);

double  gsl_stats_ushort_lag1_autocorrelation(ushort *data, size_t stride, size_t n);

double  gsl_stats_ushort_covariance(ushort *data1, size_t stride1, ushort *data2, size_t stride2, size_t n);

double  gsl_stats_ushort_variance_m(ushort *data, size_t stride, size_t n, double mean);

double  gsl_stats_ushort_sd_m(ushort *data, size_t stride, size_t n, double mean);

double  gsl_stats_ushort_absdev_m(ushort *data, size_t stride, size_t n, double mean);

double  gsl_stats_ushort_skew_m_sd(ushort *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_ushort_kurtosis_m_sd(ushort *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_ushort_lag1_autocorrelation_m(ushort *data, size_t stride, size_t n, double mean);

double  gsl_stats_ushort_covariance_m(ushort *data1, size_t stride1, ushort *data2, size_t stride2, size_t n, double mean1, double mean2);

double  gsl_stats_ushort_pvariance(ushort *data1, size_t stride1, size_t n1, ushort *data2, size_t stride2, size_t n2);

double  gsl_stats_ushort_ttest(ushort *data1, size_t stride1, size_t n1, ushort *data2, size_t stride2, size_t n2);

ushort  gsl_stats_ushort_max(ushort *data, size_t stride, size_t n);

ushort  gsl_stats_ushort_min(ushort *data, size_t stride, size_t n);

void  gsl_stats_ushort_minmax(ushort *min, ushort *max, ushort *data, size_t stride, size_t n);

size_t  gsl_stats_ushort_max_index(ushort *data, size_t stride, size_t n);

size_t  gsl_stats_ushort_min_index(ushort *data, size_t stride, size_t n);

void  gsl_stats_ushort_minmax_index(size_t *min_index, size_t *max_index, ushort *data, size_t stride, size_t n);

double  gsl_stats_ushort_median_from_sorted_data(ushort *sorted_data, size_t stride, size_t n);

double  gsl_stats_ushort_quantile_from_sorted_data(ushort *sorted_data, size_t stride, size_t n, double f);


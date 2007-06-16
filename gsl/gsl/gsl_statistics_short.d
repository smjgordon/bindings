/* Converted to D from gsl_statistics_short.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_statistics_short;
/* statistics/gsl_statistics_short.h
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
double  gsl_stats_short_mean(short *data, size_t stride, size_t n);

double  gsl_stats_short_variance(short *data, size_t stride, size_t n);

double  gsl_stats_short_sd(short *data, size_t stride, size_t n);

double  gsl_stats_short_variance_with_fixed_mean(short *data, size_t stride, size_t n, double mean);

double  gsl_stats_short_sd_with_fixed_mean(short *data, size_t stride, size_t n, double mean);

double  gsl_stats_short_absdev(short *data, size_t stride, size_t n);

double  gsl_stats_short_skew(short *data, size_t stride, size_t n);

double  gsl_stats_short_kurtosis(short *data, size_t stride, size_t n);

double  gsl_stats_short_lag1_autocorrelation(short *data, size_t stride, size_t n);

double  gsl_stats_short_covariance(short *data1, size_t stride1, short *data2, size_t stride2, size_t n);

double  gsl_stats_short_variance_m(short *data, size_t stride, size_t n, double mean);

double  gsl_stats_short_sd_m(short *data, size_t stride, size_t n, double mean);

double  gsl_stats_short_absdev_m(short *data, size_t stride, size_t n, double mean);

double  gsl_stats_short_skew_m_sd(short *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_short_kurtosis_m_sd(short *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_short_lag1_autocorrelation_m(short *data, size_t stride, size_t n, double mean);

double  gsl_stats_short_covariance_m(short *data1, size_t stride1, short *data2, size_t stride2, size_t n, double mean1, double mean2);

double  gsl_stats_short_pvariance(short *data1, size_t stride1, size_t n1, short *data2, size_t stride2, size_t n2);

double  gsl_stats_short_ttest(short *data1, size_t stride1, size_t n1, short *data2, size_t stride2, size_t n2);

short  gsl_stats_short_max(short *data, size_t stride, size_t n);

short  gsl_stats_short_min(short *data, size_t stride, size_t n);

void  gsl_stats_short_minmax(short *min, short *max, short *data, size_t stride, size_t n);

size_t  gsl_stats_short_max_index(short *data, size_t stride, size_t n);

size_t  gsl_stats_short_min_index(short *data, size_t stride, size_t n);

void  gsl_stats_short_minmax_index(size_t *min_index, size_t *max_index, short *data, size_t stride, size_t n);

double  gsl_stats_short_median_from_sorted_data(short *sorted_data, size_t stride, size_t n);

double  gsl_stats_short_quantile_from_sorted_data(short *sorted_data, size_t stride, size_t n, double f);


/* Converted to D from gsl_statistics_uchar.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_statistics_uchar;
/* statistics/gsl_statistics_uchar.h
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
double  gsl_stats_uchar_mean(ubyte *data, size_t stride, size_t n);

double  gsl_stats_uchar_variance(ubyte *data, size_t stride, size_t n);

double  gsl_stats_uchar_sd(ubyte *data, size_t stride, size_t n);

double  gsl_stats_uchar_variance_with_fixed_mean(ubyte *data, size_t stride, size_t n, double mean);

double  gsl_stats_uchar_sd_with_fixed_mean(ubyte *data, size_t stride, size_t n, double mean);

double  gsl_stats_uchar_absdev(ubyte *data, size_t stride, size_t n);

double  gsl_stats_uchar_skew(ubyte *data, size_t stride, size_t n);

double  gsl_stats_uchar_kurtosis(ubyte *data, size_t stride, size_t n);

double  gsl_stats_uchar_lag1_autocorrelation(ubyte *data, size_t stride, size_t n);

double  gsl_stats_uchar_covariance(ubyte *data1, size_t stride1, ubyte *data2, size_t stride2, size_t n);

double  gsl_stats_uchar_variance_m(ubyte *data, size_t stride, size_t n, double mean);

double  gsl_stats_uchar_sd_m(ubyte *data, size_t stride, size_t n, double mean);

double  gsl_stats_uchar_absdev_m(ubyte *data, size_t stride, size_t n, double mean);

double  gsl_stats_uchar_skew_m_sd(ubyte *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_uchar_kurtosis_m_sd(ubyte *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_uchar_lag1_autocorrelation_m(ubyte *data, size_t stride, size_t n, double mean);

double  gsl_stats_uchar_covariance_m(ubyte *data1, size_t stride1, ubyte *data2, size_t stride2, size_t n, double mean1, double mean2);

double  gsl_stats_uchar_pvariance(ubyte *data1, size_t stride1, size_t n1, ubyte *data2, size_t stride2, size_t n2);

double  gsl_stats_uchar_ttest(ubyte *data1, size_t stride1, size_t n1, ubyte *data2, size_t stride2, size_t n2);

ubyte  gsl_stats_uchar_max(ubyte *data, size_t stride, size_t n);

ubyte  gsl_stats_uchar_min(ubyte *data, size_t stride, size_t n);

void  gsl_stats_uchar_minmax(ubyte *min, ubyte *max, ubyte *data, size_t stride, size_t n);

size_t  gsl_stats_uchar_max_index(ubyte *data, size_t stride, size_t n);

size_t  gsl_stats_uchar_min_index(ubyte *data, size_t stride, size_t n);

void  gsl_stats_uchar_minmax_index(size_t *min_index, size_t *max_index, ubyte *data, size_t stride, size_t n);

double  gsl_stats_uchar_median_from_sorted_data(ubyte *sorted_data, size_t stride, size_t n);

double  gsl_stats_uchar_quantile_from_sorted_data(ubyte *sorted_data, size_t stride, size_t n, double f);


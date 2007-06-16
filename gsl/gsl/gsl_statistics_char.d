/* Converted to D from gsl_statistics_char.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_statistics_char;
/* statistics/gsl_statistics_char.h
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
double  gsl_stats_char_mean(char *data, size_t stride, size_t n);

double  gsl_stats_char_variance(char *data, size_t stride, size_t n);

double  gsl_stats_char_sd(char *data, size_t stride, size_t n);

double  gsl_stats_char_variance_with_fixed_mean(char *data, size_t stride, size_t n, double mean);

double  gsl_stats_char_sd_with_fixed_mean(char *data, size_t stride, size_t n, double mean);

double  gsl_stats_char_absdev(char *data, size_t stride, size_t n);

double  gsl_stats_char_skew(char *data, size_t stride, size_t n);

double  gsl_stats_char_kurtosis(char *data, size_t stride, size_t n);

double  gsl_stats_char_lag1_autocorrelation(char *data, size_t stride, size_t n);

double  gsl_stats_char_covariance(char *data1, size_t stride1, char *data2, size_t stride2, size_t n);

double  gsl_stats_char_variance_m(char *data, size_t stride, size_t n, double mean);

double  gsl_stats_char_sd_m(char *data, size_t stride, size_t n, double mean);

double  gsl_stats_char_absdev_m(char *data, size_t stride, size_t n, double mean);

double  gsl_stats_char_skew_m_sd(char *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_char_kurtosis_m_sd(char *data, size_t stride, size_t n, double mean, double sd);

double  gsl_stats_char_lag1_autocorrelation_m(char *data, size_t stride, size_t n, double mean);

double  gsl_stats_char_covariance_m(char *data1, size_t stride1, char *data2, size_t stride2, size_t n, double mean1, double mean2);

double  gsl_stats_char_pvariance(char *data1, size_t stride1, size_t n1, char *data2, size_t stride2, size_t n2);

double  gsl_stats_char_ttest(char *data1, size_t stride1, size_t n1, char *data2, size_t stride2, size_t n2);

char  gsl_stats_char_max(char *data, size_t stride, size_t n);

char  gsl_stats_char_min(char *data, size_t stride, size_t n);

void  gsl_stats_char_minmax(char *min, char *max, char *data, size_t stride, size_t n);

size_t  gsl_stats_char_max_index(char *data, size_t stride, size_t n);

size_t  gsl_stats_char_min_index(char *data, size_t stride, size_t n);

void  gsl_stats_char_minmax_index(size_t *min_index, size_t *max_index, char *data, size_t stride, size_t n);

double  gsl_stats_char_median_from_sorted_data(char *sorted_data, size_t stride, size_t n);

double  gsl_stats_char_quantile_from_sorted_data(char *sorted_data, size_t stride, size_t n, double f);


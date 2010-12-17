/* Converted to D from ./jack/statistics.h by htod */
module jack.statistics;
/*
*  Copyright (C) 2004 Rui Nuno Capela, Lee Revell
*  
*  This program is free software; you can redistribute it and/or
*  modify it under the terms of the GNU Lesser General Public License
*  as published by the Free Software Foundation; either version 2.1
*  of the License, or (at your option) any later version.
*  
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
*  Lesser General Public License for more details.
*  
*  You should have received a copy of the GNU Lesser General Public
*  License along with this program; if not, write to the Free
*  Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
*  02111-1307, USA.
*
*/

//C     #ifndef __statistics_h__
//C     #define __statistics_h__

//C     #ifdef __cplusplus
//C     extern "C"
//C     {
//C     #endif

//C     #include <jack/types.h>
import jack.types;

/**
 * @return the maximum delay reported by the backend since
 * startup or reset.  When compared to the period size in usecs, this
 * can be used to estimate the ideal period size for a given setup.
 */
//C     float jack_get_max_delayed_usecs (jack_client_t *client);
extern (C):
float  jack_get_max_delayed_usecs(jack_client_t *client);

/**
 * @return the delay in microseconds due to the most recent XRUN
 * occurrence.  This probably only makes sense when called from a @ref
 * JackXRunCallback defined using jack_set_xrun_callback().
 */
//C     float jack_get_xrun_delayed_usecs (jack_client_t *client);
float  jack_get_xrun_delayed_usecs(jack_client_t *client);

/**
 * Reset the maximum delay counter.  This would be useful
 * to estimate the effect that a change to the configuration of a running
 * system (e.g. toggling kernel preemption) has on the delay
 * experienced by JACK, without having to restart the JACK engine.
 */
//C     void jack_reset_max_delayed_usecs (jack_client_t *client);
void  jack_reset_max_delayed_usecs(jack_client_t *client);

//C     #ifdef __cplusplus
//C     }
//C     #endif

//C     #endif /* __statistics_h__ */

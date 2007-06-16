/* Converted to D from gsl_message.h by htod
 * and edited by daniel truemper <truemped.dsource <with> hence22.org>
 */
module gsl.gsl_message;
/* err/gsl_message.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000 Gerard Jungman, Brian Gough
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

public import gsl.gsl_types;

/* Provide a general messaging service for client use.  Messages can
 * be selectively turned off at compile time by defining an
 * appropriate message mask. Client code which uses the GSL_MESSAGE()
 * macro must provide a mask which is or'ed with the GSL_MESSAGE_MASK.
 *
 * The messaging service can be completely turned off
 * by defining GSL_MESSAGING_OFF.  */

extern (C):
void  gsl_message(char *message, char *file, int line, uint mask);

const GSL_MESSAGE_MASK = 0xffffffffU;

extern uint gsl_message_mask;

/* Provide some symolic masks for client ease of use. */

enum
{
    GSL_MESSAGE_MASK_A = 1,
    GSL_MESSAGE_MASK_B,
    GSL_MESSAGE_MASK_C = 4,
    GSL_MESSAGE_MASK_D = 8,
    GSL_MESSAGE_MASK_E = 16,
    GSL_MESSAGE_MASK_F = 32,
    GSL_MESSAGE_MASK_G = 64,
    GSL_MESSAGE_MASK_H = 128,
}


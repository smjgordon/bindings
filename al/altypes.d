module c.al.altypes;

/*
 * OpenAL cross platform audio library
 * Copyright  (C) 1999-2000 by authors.
 * This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Library General Public
 *  License as published by the Free Software Foundation; either
 *  version 2 of the License, or  (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 *  License along with this library; if not, write to the
 *  Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 *  Boston, MA  02111-1307, USA.
 * Or go to http://www.gnu.org/copyleft/lgpl.html
 */

alias byte	ALboolean;
alias char	ALchar;
alias byte	ALbyte;
alias ubyte	ALubyte;
alias short	ALshort;
alias ushort	ALushort;
alias int	ALint;
alias uint	ALuint;
alias float	ALfloat;
alias double	ALdouble;
alias uint	ALsizei;
alias void	ALvoid;
alias int	ALenum;
alias uint	ALbitfield;
alias float	ALclampf;
alias double	ALclampd;

const byte AL_INVALID			= -1;
const ubyte AL_NONE			= 0;
const ubyte AL_FALSE			= 0;
const ubyte AL_TRUE			= 1;
const uint AL_SOURCE_RELATIVE		= 0x202;
const uint AL_CONE_INNER_ANGLE		= 0x1001;
const uint AL_CONE_OUTER_ANGLE		= 0x1002;
const uint AL_PITCH			= 0x1003;
const uint AL_POSITION			= 0x1004;
const uint AL_DIRECTION			= 0x1005;
const uint AL_VELOCITY			= 0x1006;
const uint AL_LOOPING			= 0x1007;
const uint AL_BUFFER			= 0x1009;
const uint AL_GAIN			= 0x100A;
const uint AL_MIN_GAIN			= 0x100D;
const uint AL_MAX_GAIN			= 0x100E;
const uint AL_ORIENTATION		= 0x100F;
const uint AL_CHANNEL_MASK		= 0x3000;
const uint AL_SOURCE_STATE		= 0x1010;
const uint AL_INITIAL			= 0x1011;
const uint AL_PLAYING			= 0x1012;
const uint AL_PAUSED			= 0x1013;
const uint AL_STOPPED			= 0x1014;
const uint AL_BUFFERS_QUEUED		= 0x1015;
const uint AL_BUFFERS_PROCESSED		= 0x1016;
const uint AL_SEC_OFFSET		= 0x1024;
const uint AL_SAMPLE_OFFSET		= 0x1025;
const uint AL_BYTE_OFFSET		= 0x1026;
const uint AL_SOURCE_TYPE		= 0x1027;
const uint AL_STATIC			= 0x1028;
const uint AL_STREAMING			= 0x1029;
const uint AL_UNDETERMINED		= 0x1030;
const uint AL_FORMAT_MONO8		= 0x1100;
const uint AL_FORMAT_MONO16		= 0x1101;
const uint AL_FORMAT_STEREO8		= 0x1102;
const uint AL_FORMAT_STEREO16		= 0x1103;
const uint AL_REFERENCE_DISTANCE	= 0x1020;
const uint AL_ROLLOFF_FACTOR		= 0x1021;
const uint AL_CONE_OUTER_GAIN		= 0x1022;
const uint AL_MAX_DISTANCE		= 0x1023;
const uint AL_FREQUENCY			= 0x2001;
const uint AL_BITS			= 0x2002;
const uint AL_CHANNELS			= 0x2003;
const uint AL_SIZE			= 0x2004;
const uint AL_UNUSED			= 0x2010;
const uint AL_PENDING			= 0x2011;
const uint AL_PROCESSED			= 0x2012;
const uint AL_NO_ERROR			= AL_FALSE;
const uint AL_INVALID_NAME		= 0xA001;
const uint AL_ILLEGAL_ENUM		= 0xA002;
const uint AL_INVALID_ENUM		= 0xA002;
const uint AL_INVALID_VALUE		= 0xA003;
const uint AL_ILLEGAL_COMMAND		= 0xA004;
const uint AL_INVALID_OPERATION		= 0xA004;
const uint AL_OUT_OF_MEMORY		= 0xA005;
const uint AL_VENDOR			= 0xB001;
const uint AL_VERSION			= 0xB002;
const uint AL_RENDERER			= 0xB003;
const uint AL_EXTENSIONS		= 0xB004;
const uint AL_DOPPLER_FACTOR		= 0xC000;
const uint AL_DOPPLER_VELOCITY		= 0xC001;
const uint AL_SPEED_OF_SOUND		= 0xC003;
const uint AL_DISTANCE_MODEL		= 0xD000;
const uint AL_INVERSE_DISTANCE		= 0xD001;
const uint AL_INVERSE_DISTANCE_CLAMPED	= 0xD002;
const uint AL_LINEAR_DISTANCE		= 0xD003;
const uint AL_LINEAR_DISTANCE_CLAMPED	= 0xD004;
const uint AL_EXPONENT_DISTANCE		= 0xD005;
const uint AL_EXPONENT_DISTANCE_CLAMPED	= 0xD006;
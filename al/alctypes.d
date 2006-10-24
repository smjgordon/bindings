module c.al.alctypes;

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

alias int ALCdevice;
alias int ALCcontext;

alias byte ALCboolean;
alias char ALCchar;
alias byte ALCbyte;
alias ubyte ALCubyte;
alias short ALCshort;
alias ushort ALCushort;
alias int ALCint;
alias uint ALCuint;
alias uint ALCsizei;
alias int ALCenum;
alias float ALCfloat;
alias double ALCdouble;
alias void ALCvoid;

const ushort ALC_INVALID				= 0;
const ushort ALC_FALSE					= 0;
const ushort ALC_TRUE					= 1;
const ushort ALC_FREQUENCY				= 0x1007;
const ushort ALC_REFRESH				= 0x1008;
const ushort ALC_SYNC					= 0x1009;
const ushort ALC_MONO_SOURCES				= 0x1010;
const ushort ALC_STEREO_SOURCES				= 0x1011;
const ushort ALC_NO_ERROR				= ALC_FALSE;
const ushort ALC_INVALID_DEVICE				= 0xA001;
const ushort ALC_INVALID_CONTEXT			= 0xA002;
const ushort ALC_INVALID_ENUM				= 0xA003;
const ushort ALC_INVALID_VALUE				= 0xA004;
const ushort ALC_OUT_OF_MEMORY				= 0xA005;
const ushort ALC_DEFAULT_DEVICE_SPECIFIER		= 0x1004;
const ushort ALC_DEVICE_SPECIFIER			= 0x1005;
const ushort ALC_EXTENSIONS				= 0x1006;
const ushort ALC_MAJOR_VERSION				= 0x1000;
const ushort ALC_MINOR_VERSION				= 0x1001;
const ushort ALC_ATTRIBUTES_SIZE			= 0x1002;
const ushort ALC_ALL_ATTRIBUTES				= 0x1003;
const ushort ALC_CAPTURE_DEVICE_SPECIFIER		= 0x310;
const ushort ALC_CAPTURE_DEFAULT_DEVICE_SPECIFIER	= 0x311;
const ushort ALC_CAPTURE_SAMPLES			= 0x312;
module c.al.alc;

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

private import c.al.altypes;
private import c.al.alctypes;

const ubyte ALC_VERSION_0_1 = 1;

extern (C):
typedef ALCcontext* function(ALCdevice*, ALCint*) pfalcCreateContext;
typedef ALCenum function(ALCcontext*) pfalcMakeContextCurrent;
typedef void function(ALCcontext*) pfalcProcessContext;
typedef void function(ALCcontext*) pfalcSuspendContext;
typedef ALCenum function(ALCcontext*) pfalcDestroyContext;
typedef ALCcontext* function() pfalcGetCurrentContext;
typedef ALCdevice* function(ALCcontext*) pfalcGetContextsDevice;
typedef ALCdevice* function(ALchar*) pfalcOpenDevice;
typedef ALCboolean function(ALCdevice*) pfalcCloseDevice;
typedef ALCenum function(ALCdevice*) pfalcGetError;
typedef ALCboolean function(ALCdevice*, ALchar*) pfalcIsExtensionPresent;
typedef void* function(ALCdevice*, ALchar*) pfalcGetProcAddress;
typedef ALCenum function(ALCdevice*, ALchar*) pfalcGetEnumValue;
typedef ALchar* function(ALCdevice*, ALCenum) pfalcGetString;
typedef void function(ALCdevice*, ALCenum, ALCsizei, ALCint*) pfalcGetIntegerv;
typedef ALCdevice* function(ALCchar*, ALCuint, ALCenum, ALCsizei) pfalcCaptureOpenDevice;
typedef void function(ALCdevice*) pfalcCaptureCloseDevice;
typedef void function(ALCdevice*) pfalcCaptureStart;
typedef void function(ALCdevice*) pfalcCaptureStop;
typedef void function(ALCdevice*, ALCvoid*, ALCsizei) pfalcCaptureSamples;

pfalcCreateContext	alcCreateContext;
pfalcMakeContextCurrent	alcMakeContextCurrent;
pfalcProcessContext	alcProcessContext;
pfalcSuspendContext	alcSuspendContext;
pfalcDestroyContext	alcDestroyContext;
pfalcGetCurrentContext	alcGetCurrentContext;
pfalcGetContextsDevice	alcGetContextsDevice;
pfalcOpenDevice		alcOpenDevice;
pfalcCloseDevice	alcCloseDevice;
pfalcGetError		alcGetError;
pfalcIsExtensionPresent	alcIsExtensionPresent;
pfalcGetProcAddress	alcGetProcAddress;
pfalcGetEnumValue	alcGetEnumValue;
pfalcGetString		alcGetString;
pfalcGetIntegerv	alcGetIntegerv;
pfalcCaptureOpenDevice	alcCaptureOpenDevice;
pfalcCaptureCloseDevice	alcCaptureCloseDevice;
pfalcCaptureStart	alcCaptureStart;
pfalcCaptureStop	alcCaptureStop;
pfalcCaptureSamples	alcCaptureSamples;
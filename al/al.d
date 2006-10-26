module c.al.al;

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

private import std.loader;
public import c.al.altypes;
public import c.al.alc;
public import c.al.alctypes;

private HXModule aldrv;

private void* getProc (char[] procname) {
	void* symbol = ExeModule_GetSymbol (aldrv, procname);
	if (symbol == null) {
		printf("Failed to load OpenAL function " ~ procname ~ ".\n");
	}
	return (symbol);
}

static this() {
	version (Windows) {
		aldrv = ExeModule_Load("OpenAL32.dll");
	} else version (linux) {
		aldrv = ExeModule_Load("libal.so");
	} else version (darwin) {
		aldrv = ExeModule_Load("/System/Library/Frameworks/OpenAL.framework");
	}
	//al.d
	alEnable = cast(pfalEnable)getProc("alEnable");
	alDisable = cast(pfalDisable)getProc("alDisable");
	alIsEnabled = cast(pfalIsEnabled)getProc("alIsEnabled");
	alGetBooleanv = cast(pfalGetBooleanv)getProc("alGetBooleanv");
	alGetIntegerv = cast(pfalGetIntegerv)getProc("alGetIntegerv");
	alGetFloatv = cast(pfalGetFloatv)getProc("alGetFloatv");
	alGetDoublev = cast(pfalGetDoublev)getProc("alGetDoublev");
	alGetString = cast(pfalGetString)getProc("alGetString");
	alGetBoolean = cast(pfalGetBoolean)getProc("alGetBoolean");
	alGetInteger = cast(pfalGetInteger)getProc("alGetInteger");
	alGetFloat = cast(pfalGetFloat)getProc("alGetFloat");
	alGetDouble = cast(pfalGetDouble)getProc("alGetDouble");
	alGetError = cast(pfalGetError)getProc("alGetError");
	alIsExtensionPresent = cast(pfalIsExtensionPresent)getProc("alIsExtensionPresent");
	alGetProcAddress = cast(pfalGetProcAddress)getProc("alGetProcAddress");
	alGetEnumValue = cast(pfalGetEnumValue)getProc("alGetEnumValue");
	alListenerf = cast(pfalListenerf)getProc("alListenerf");
	alListener3f = cast(pfalListener3f)getProc("alListener3f");
	alListenerfv = cast(pfalListenerfv)getProc("alListenerfv");
	alListeneri = cast(pfalListeneri)getProc("alListeneri");
	alListener3i = cast(pfalListener3i)getProc("alListener3i");
	alListeneriv = cast(pfalListeneriv)getProc("alListeneriv");
	alGetListenerf = cast(pfalGetListenerf)getProc("alGetListenerf");
	alGetListener3f = cast(pfalGetListener3f)getProc("alGetListener3f");
	alGetListenerfv = cast(pfalGetListenerfv)getProc("alGetListenerfv");
	alGetListeneri = cast(pfalGetListeneri)getProc("alGetListeneri");
	alGetListener3i = cast(pfalGetListener3i)getProc("alGetListener3i");
	alGetListeneriv = cast(pfalGetListeneriv)getProc("alGetListeneriv");
	alGenSources = cast(pfalGenSources)getProc("alGenSources");
	alDeleteSources = cast(pfalDeleteSources)getProc("alDeleteSources");
	alIsSource = cast(pfalIsSource)getProc("alIsSource");
	alSourcef = cast(pfalSourcef)getProc("alSourcef");
	alSource3f = cast(pfalSource3f)getProc("alSource3f");
	alSourcefv = cast(pfalSourcefv)getProc("alSourcefv");
	alSourcei = cast(pfalSourcei)getProc("alSourcei");
	alSource3i = cast(pfalSource3i)getProc("alSource3i");
	alSourceiv = cast(pfalSourceiv)getProc("alSourceiv");
	alGetSourcef = cast(pfalGetSourcef)getProc("alGetSourcef");
	alGetSourcefv = cast(pfalGetSourcefv)getProc("alGetSourcefv");
	alGetSource3f = cast(pfalGetSource3f)getProc("alGetSource3f");
	alGetSourcei = cast(pfalGetSourcei)getProc("alGetSourcei");
	alGetSource3i = cast(pfalGetSource3i)getProc("alGetSource3i");
	alGetSourceiv = cast(pfalGetSourceiv)getProc("alGetSourceiv");
	alSourcePlayv = cast(pfalSourcePlayv)getProc("alSourcePlayv");
	alSourceStopv = cast(pfalSourceStopv)getProc("alSourceStopv");
	alSourceRewindv = cast(pfalSourceRewindv)getProc("alSourceRewindv");
	alSourcePausev = cast(pfalSourcePausev)getProc("alSourcePausev");
	alSourcePlay = cast(pfalSourcePlay)getProc("alSourcePlay");
	alSourceStop = cast(pfalSourceStop)getProc("alSourceStop");
	alSourceRewind = cast(pfalSourceRewind)getProc("alSourceRewind");
	alSourcePause = cast(pfalSourcePause)getProc("alSourcePause");
	alSourceQueueBuffers = cast(pfalSourceQueueBuffers)getProc("alSourceQueueBuffers");
	alSourceUnqueueBuffers = cast(pfalSourceUnqueueBuffers)getProc("alSourceUnqueueBuffers");
	alGenBuffers = cast(pfalGenBuffers)getProc("alGenBuffers");
	alDeleteBuffers = cast(pfalDeleteBuffers)getProc("alDeleteBuffers");
	alIsBuffer = cast(pfalIsBuffer)getProc("alIsBuffer");
	alBufferData = cast(pfalBufferData)getProc("alBufferData");
	alBufferf = cast(pfalBufferf)getProc("alBufferf");
	alBuffer3f = cast(pfalBuffer3f)getProc("alBuffer3f");
	alBufferfv = cast(pfalBufferfv)getProc("alBufferfv");
	alBufferi = cast(pfalBufferi)getProc("alBufferi");
	alBuffer3i = cast(pfalBuffer3i)getProc("alBuffer3i");
	alBufferiv = cast(pfalBufferiv)getProc("alBufferiv");
	alGetBufferf = cast(pfalGetBufferf)getProc("alGetBufferf");
	alGetBufferfv = cast(pfalGetBufferfv)getProc("alGetBufferfv");
	alGetBuffer3f = cast(pfalGetBuffer3f)getProc("alGetBuffer3f");
	alGetBufferi = cast(pfalGetBufferi)getProc("alGetBufferi");
	alGetBuffer3i = cast(pfalGetBuffer3i)getProc("alGetBuffer3i");
	alGetBufferiv = cast(pfalGetBufferiv)getProc("alGetBufferiv");
	alDopplerFactor = cast(pfalDopplerFactor)getProc("alDopplerFactor");
	alDopplerVelocity = cast(pfalDopplerVelocity)getProc("alDopplerVelocity");
	alSpeedOfSound = cast(pfalSpeedOfSound)getProc("alSpeedOfSound");
	alDistanceModel = cast(pfalDistanceModel)getProc("alDistanceModel");
	//alc.d
	alcCreateContext = cast(pfalcCreateContext)getProc("alcCreateContext");
	alcMakeContextCurrent = cast(pfalcMakeContextCurrent)getProc("alcMakeContextCurrent");
	alcProcessContext = cast(pfalcProcessContext)getProc("alcProcessContext");
	alcSuspendContext = cast(pfalcSuspendContext)getProc("alcSuspendContext");
	alcDestroyContext = cast(pfalcDestroyContext)getProc("alcDestroyContext");
	alcGetCurrentContext = cast(pfalcGetCurrentContext)getProc("alcGetCurrentContext");
	alcGetContextsDevice = cast(pfalcGetContextsDevice)getProc("alcGetContextsDevice");
	alcOpenDevice = cast(pfalcOpenDevice)getProc("alcOpenDevice");
	alcCloseDevice = cast(pfalcCloseDevice)getProc("alcCloseDevice");
	alcGetError = cast(pfalcGetError)getProc("alcGetError");
	alcIsExtensionPresent = cast(pfalcIsExtensionPresent)getProc("alcIsExtensionPresent");
	alcGetProcAddress = cast(pfalcGetProcAddress)getProc("alcGetProcAddress");
	alcGetEnumValue = cast(pfalcGetEnumValue)getProc("alcGetEnumValue");
	alcGetString = cast(pfalcGetString)getProc("alcGetString");
	alcGetIntegerv = cast(pfalcGetIntegerv)getProc("alcGetIntegerv");
	alcCaptureOpenDevice = cast(pfalcCaptureOpenDevice)getProc("alcCaptureOpenDevice");
	alcCaptureCloseDevice = cast(pfalcCaptureCloseDevice)getProc("alcCaptureCloseDevice");
	alcCaptureStart = cast(pfalcCaptureStart)getProc("alcCaptureStart");
	alcCaptureStop = cast(pfalcCaptureStop)getProc("alcCaptureStop");
	alcCaptureSamples = cast(pfalcCaptureSamples)getProc("alcCaptureSamples");
}

static ~this() {
	ExeModule_Release(aldrv);
}

extern (C):
typedef void function(ALenum) pfalEnable;
typedef void function(ALenum) pfalDisable;
typedef ALboolean function(ALenum) pfalIsEnabled;
typedef ALchar* function(ALenum) pfalGetString;
typedef void function(ALenum, ALboolean*) pfalGetBooleanv;
typedef void function(ALenum, ALint*) pfalGetIntegerv;
typedef void function(ALenum, ALfloat*) pfalGetFloatv;
typedef void function(ALenum, ALdouble*) pfalGetDoublev;
typedef ALboolean function(ALenum) pfalGetBoolean;
typedef ALint function(ALenum) pfalGetInteger;
typedef ALfloat function(ALenum) pfalGetFloat;
typedef ALdouble function(ALenum) pfalGetDouble;
typedef ALenum function() pfalGetError;
typedef ALboolean function(ALchar*) pfalIsExtensionPresent;
typedef void* function(ALchar*) pfalGetProcAddress;
typedef ALenum function(ALchar*) pfalGetEnumValue;
typedef void function(ALenum, ALfloat) pfalListenerf;
typedef void function(ALenum, ALfloat, ALfloat, ALfloat) pfalListener3f;
typedef void function(ALenum, ALfloat*) pfalListenerfv;
typedef void function(ALenum, ALint) pfalListeneri;
typedef void function(ALenum, ALint, ALint, ALint) pfalListener3i;
typedef void function(ALenum, ALint*) pfalListeneriv;
typedef void function(ALenum, ALfloat*) pfalGetListenerf;
typedef void function(ALenum, ALfloat*, ALfloat*, ALfloat*) pfalGetListener3f;
typedef void function(ALenum, ALfloat*) pfalGetListenerfv;
typedef void function(ALenum, ALint*) pfalGetListeneri;
typedef void function(ALenum, ALint*, ALint*, ALint*) pfalGetListener3i;
typedef void function(ALenum, ALint*) pfalGetListeneriv;
typedef void function(ALsizei, ALuint*) pfalGenSources;
typedef void function(ALsizei, ALuint*) pfalDeleteSources;
typedef ALboolean function(ALuint) pfalIsSource;
typedef void function(ALuint, ALenum, ALfloat) pfalSourcef;
typedef void function(ALuint, ALenum, ALfloat, ALfloat, ALfloat) pfalSource3f;
typedef void function(ALuint, ALenum, ALfloat*) pfalSourcefv;
typedef void function(ALuint, ALenum, ALint) pfalSourcei;
typedef void function(ALuint, ALenum, ALint, ALint, ALint) pfalSource3i;
typedef void function(ALuint, ALenum, ALint*) pfalSourceiv;
typedef void function(ALuint, ALenum, ALfloat*) pfalGetSourcef;
typedef void function(ALuint, ALenum, ALfloat*, ALfloat*, ALfloat*) pfalGetSource3f;
typedef void function(ALuint, ALenum, ALfloat*) pfalGetSourcefv;
typedef void function(ALuint, ALenum, ALint*) pfalGetSourcei;
typedef void function(ALuint, ALenum, ALint*, ALint*, ALint*) pfalGetSource3i;
typedef void function(ALuint, ALenum, ALint*) pfalGetSourceiv;
typedef void function(ALsizei, ALuint*) pfalSourcePlayv;
typedef void function(ALsizei, ALuint*) pfalSourceStopv;
typedef void function(ALsizei, ALuint*) pfalSourceRewindv;
typedef void function(ALsizei, ALuint*) pfalSourcePausev;
typedef void function(ALuint) pfalSourcePlay;
typedef void function(ALuint) pfalSourceStop;
typedef void function(ALuint) pfalSourceRewind;
typedef void function(ALuint) pfalSourcePause;
typedef void function(ALuint, ALsizei, ALuint*) pfalSourceQueueBuffers;
typedef void function(ALuint, ALsizei, ALuint*) pfalSourceUnqueueBuffers;
typedef void function(ALsizei, ALuint*) pfalGenBuffers;
typedef void function(ALsizei, ALuint*) pfalDeleteBuffers;
typedef ALboolean function(ALuint) pfalIsBuffer;
typedef void function(ALuint, ALenum, ALvoid*, ALsizei, ALsizei) pfalBufferData;
typedef void function(ALuint, ALenum, ALfloat) pfalBufferf;
typedef void function(ALuint, ALenum, ALfloat, ALfloat, ALfloat) pfalBuffer3f;
typedef void function(ALuint, ALenum, ALfloat*) pfalBufferfv;
typedef void function(ALuint, ALenum, ALint) pfalBufferi;
typedef void function(ALuint, ALenum, ALint, ALint, ALint) pfalBuffer3i;
typedef void function(ALuint, ALenum, ALint*) pfalBufferiv;
typedef void function(ALuint, ALenum, ALfloat*) pfalGetBufferf;
typedef void function(ALuint, ALenum, ALfloat*, ALfloat*, ALfloat*) pfalGetBuffer3f;
typedef void function(ALuint, ALenum, ALfloat*) pfalGetBufferfv;
typedef void function(ALuint, ALenum, ALint*) pfalGetBufferi;
typedef void function(ALuint, ALenum, ALint*, ALint*, ALint*) pfalGetBuffer3i;
typedef void function(ALuint, ALenum, ALint*) pfalGetBufferiv;
typedef void function(ALfloat) pfalDopplerFactor;
typedef void function(ALfloat) pfalDopplerVelocity;
typedef void function(ALfloat) pfalSpeedOfSound;
typedef void function(ALenum) pfalDistanceModel;

pfalEnable		alEnable;
pfalDisable		alDisable;
pfalIsEnabled		alIsEnabled;
pfalGetBooleanv		alGetBooleanv;
pfalGetIntegerv		alGetIntegerv;
pfalGetFloatv		alGetFloatv;
pfalGetDoublev		alGetDoublev;
pfalGetString		alGetString;
pfalGetBoolean		alGetBoolean;
pfalGetInteger		alGetInteger;
pfalGetFloat		alGetFloat;
pfalGetDouble		alGetDouble;
pfalGetError		alGetError;
pfalIsExtensionPresent	alIsExtensionPresent;
pfalGetProcAddress	alGetProcAddress;
pfalGetEnumValue	alGetEnumValue;
pfalListenerf		alListenerf;
pfalListener3f		alListener3f;
pfalListenerfv		alListenerfv;
pfalListeneri		alListeneri;
pfalListener3i		alListener3i;
pfalListeneriv		alListeneriv;
pfalGetListenerf	alGetListenerf;
pfalGetListener3f	alGetListener3f;
pfalGetListenerfv	alGetListenerfv;
pfalGetListeneri	alGetListeneri;
pfalGetListener3i	alGetListener3i;
pfalGetListeneriv	alGetListeneriv;
pfalGenSources		alGenSources;
pfalDeleteSources	alDeleteSources;
pfalIsSource		alIsSource;
pfalSourcef		alSourcef;
pfalSource3f		alSource3f;
pfalSourcefv		alSourcefv;
pfalSourcei		alSourcei;
pfalSource3i		alSource3i;
pfalSourceiv		alSourceiv;
pfalGetSourcef		alGetSourcef;
pfalGetSourcefv		alGetSourcefv;
pfalGetSource3f		alGetSource3f;
pfalGetSourcei		alGetSourcei;
pfalGetSource3i		alGetSource3i;
pfalGetSourceiv		alGetSourceiv;
pfalSourcePlayv		alSourcePlayv;
pfalSourceStopv		alSourceStopv;
pfalSourceRewindv	alSourceRewindv;
pfalSourcePausev	alSourcePausev;
pfalSourcePlay		alSourcePlay;
pfalSourceStop		alSourceStop;
pfalSourceRewind	alSourceRewind;
pfalSourcePause		alSourcePause;
pfalSourceQueueBuffers	alSourceQueueBuffers;
pfalSourceUnqueueBuffers alSourceUnqueueBuffers;
pfalGenBuffers		alGenBuffers;
pfalDeleteBuffers	alDeleteBuffers;
pfalIsBuffer		alIsBuffer;
pfalBufferData		alBufferData;
pfalBufferf		alBufferf;
pfalBuffer3f		alBuffer3f;
pfalBufferfv		alBufferfv;
pfalBufferi		alBufferi;
pfalBuffer3i		alBuffer3i;
pfalBufferiv		alBufferiv;
pfalGetBufferf		alGetBufferf;
pfalGetBufferfv		alGetBufferfv;
pfalGetBuffer3f		alGetBuffer3f;
pfalGetBufferi		alGetBufferi;
pfalGetBuffer3i		alGetBuffer3i;
pfalGetBufferiv		alGetBufferiv;
pfalDopplerFactor	alDopplerFactor;
pfalDopplerVelocity	alDopplerVelocity;
pfalSpeedOfSound	alSpeedOfSound;
pfalDistanceModel	alDistanceModel;
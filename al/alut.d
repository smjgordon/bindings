module c.al.alut;

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
private import std.loader;

private HXModule alutdrv;

private void* getProc (char[] procname) {
	void* symbol = ExeModule_GetSymbol (alutdrv, procname);
	if (symbol == null) {
		printf("Failed to load alut function " ~ procname ~ ".\n");
	}
	return (symbol);
}

static this() {
	version (Windows) {
		alutdrv = ExeModule_Load("OpenAL32.dll");
	} else version (linux) {
		alutdrv = ExeModule_Load("libalut.so");
	} else version (darwin) {
		alutdrv = ExeModule_Load("/System/Library/Frameworks/ALUT.framework");
	}
	alutInit = cast(pfalutInit)getProc("alutInit");
	alutExit = cast(pfalutExit)getProc("alutExit");
	alutLoadWAVFile = cast(pfalutLoadWAVFile)getProc("alutLoadWAVFile");
	alutLoadWAVMemory = cast(pfalutLoadWAVMemory)getProc("alutLoadWAVMemory");
	alutUnloadWAV = cast(pfalutUnloadWAV)getProc("alutUnloadWAV");
}

static ~this() {
	ExeModule_Release(alutdrv);
}

typedef void function(int*, char*[]) pfalutInit;
typedef void function() pfalutExit;

/* Windows and Linux versions have a loop parameter, Macintosh doesn't */
version (darwin) {
	typedef void function(ALbyte*, ALenum*, ALvoid**, ALsizei*, ALsizei*) pfalutLoadWAVFile;
	typedef void function(ALbyte*, ALenum*, ALvoid**, ALsizei*, ALsizei*) pfalutLoadWAVMemory;
} else {
	typedef void function(ALbyte*, ALenum*, ALvoid**, ALsizei*, ALsizei*, ALboolean*) pfalutLoadWAVFile;
	typedef void function(ALbyte*, ALenum*, ALvoid**, ALsizei*, ALsizei*, ALboolean*) pfalutLoadWAVMemory;
}
typedef void function(ALenum, ALvoid*, ALsizei, ALsizei) pfalutUnloadWAV;

pfalutInit		alutInit;
pfalutExit		alutExit;
pfalutLoadWAVFile	alutLoadWAVFile;
pfalutLoadWAVMemory	alutLoadWAVMemory;
pfalutUnloadWAV		alutUnloadWAV;
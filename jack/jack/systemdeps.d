/* Converted to D from ./jack/jack/systemdeps.h by htod */
module jack.systemdeps;
/*
Copyright (C) 2004-2009 Grame

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

*/

//C     #ifndef __jack_systemdeps_h__
//C     #define __jack_systemdeps_h__

//#ifdef WIN32

//#include <windows.h>
/*
#ifdef _MSC_VER
    #define __inline__ inline
    #ifndef int8_t
        typedef char int8_t;
        typedef unsigned char uint8_t;
        typedef short int16_t;
        typedef unsigned short uint16_t;
        typedef long int32_t;
        typedef unsigned long uint32_t;
        typedef LONGLONG int64_t;
        typedef ULONGLONG uint64_t;
    #endif
    #ifndef pthread_t
        typedef HANDLE pthread_t;
    #endif
#elif __MINGW32__
    #include <stdint.h>
    #include <sys/types.h>
    #ifndef pthread_t
        typedef HANDLE pthread_t;
    #endif
#else               // other compilers ...
    #include <inttypes.h>
    #include <pthread.h>
    #include <sys/types.h>
#endif

#endif // WIN32
*/
//#if defined(__APPLE__) || defined(__linux__) || defined(__sun__) || defined(sun) || defined(__unix__)
    //#include "inttypes.h"
    //#include <pthread.h>
    //#include <sys/types.h>
//#endif /* __APPLE__ || __linux__ || __sun__ || sun */

//C     typedef unsigned long int pthread_t;
extern (C):
alias uint pthread_t;

//C     typedef unsigned long int ulong;
//alias uint ulong;
//C     typedef unsigned short int ushort;
//C     typedef unsigned int uint;

/* These types are defined by the ISO C99 header <inttypes.h>. */
//# ifndef __int8_t_defined
//#  define __int8_t_defined
//C     typedef	char int8_t;
alias byte int8_t;
//C     typedef	short int int16_t;
alias short int16_t;
//C     typedef	int int32_t;
alias int int32_t;
//C     typedef long int int64_t;
alias long int64_t;
//__extension__ typedef long long int int64_t;

/* But these were defined by ISO C without the first `_'.  */
//C     typedef	unsigned char uint8_t;
alias ubyte uint8_t;
//C     typedef	unsigned short int uint16_t;
alias ushort uint16_t;
//C     typedef	unsigned int uint32_t;
alias uint uint32_t;
//# if __WORDSIZE == 64
//C     typedef unsigned long int uint64_t;
alias ulong uint64_t;

//C     #endif

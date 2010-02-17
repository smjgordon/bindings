/* Converted to D from ./magick/magick_types.h by htod */
module magick.magick_types;

align(1):

/*
  Copyright (C) 2003, 2007 GraphicsMagick Group
 
  This program is covered by multiple licenses, which are described in
  Copyright.txt. You should have received a copy of Copyright.txt with this
  package; otherwise see http://www.graphicsmagick.org/www/Copyright.html.
 
  GraphicsMagick types typedefs
*/

//C     #ifndef _MAGICK_TYPES_H
//C     #define _MAGICK_TYPES_H

//C     #if defined(__cplusplus) || defined(c_plusplus)
//C     extern "C" {
//C     #endif

/*
  Assign ANSI C stdint.h-like typedefs based on the sizes of native types
  magick_int8_t   --                       -128 to 127
  magick_uint8_t  --                          0 to 255
  magick_int16_t  --                    -32,768 to 32,767
  magick_uint16_t --                          0 to 65,535
  magick_int32_t  --             -2,147,483,648 to 2,147,483,647
  magick_uint32_t --                          0 to 4,294,967,295
  magick_int64_t  -- -9,223,372,036,854,775,807 to 9,223,372,036,854,775,807
  magick_uint64_t --                          0 to 18,446,744,073,709,551,615
*/

//C     #if defined(WIN32) && !defined(__MINGW32__) || defined (_CH_)

  /* The following typedefs are used for WIN32 */
//C       typedef signed char   magick_int8_t;
extern (C):
alias	byte magick_int8_t;
//C       typedef unsigned char  magick_uint8_t;
alias ubyte magick_uint8_t;

//C       typedef signed short  magick_int16_t;
alias short magick_int16_t;
//C       typedef unsigned short magick_uint16_t;
alias ushort magick_uint16_t;

//C       typedef signed int  magick_int32_t;
alias int magick_int32_t;
//C       typedef unsigned int magick_uint32_t;
alias uint magick_uint32_t;

//C     #  if defined(_CH_)
//C     #  include <stdint.h>
//C       typedef int64_t  magick_int64_t;
//C       typedef uint64_t magick_uint64_t;
//C     #  else
//C       typedef signed __int64  magick_int64_t;
alias long magick_int64_t;
//C       typedef unsigned __int64 magick_uint64_t;
alias ulong magick_uint64_t;
//C     #  endif

//C       typedef magick_uint64_t magick_uintmax_t;
alias magick_uint64_t magick_uintmax_t;
//C       typedef unsigned long magick_uintptr_t;
alias uint magick_uintptr_t;

//C     #else

  /* The following typedefs are subtituted when using Unixish configure */
//C       typedef signed char   magick_int8_t;
//C       typedef unsigned char  magick_uint8_t;

//C       typedef signed short  magick_int16_t;
//C       typedef unsigned short magick_uint16_t;

//C       typedef signed int  magick_int32_t;
//C       typedef unsigned int magick_uint32_t;

//C       typedef signed long long  magick_int64_t;
//C       typedef unsigned long long magick_uint64_t;

//C       typedef unsigned long long magick_uintmax_t;
//C       typedef unsigned long magick_uintptr_t;

//C     #endif

  /* 64-bit file and blob offset type */
//C       typedef magick_int64_t magick_off_t;
alias magick_int64_t magick_off_t;

//C     #if defined(__cplusplus) || defined(c_plusplus)
//C     }
//C     #endif /* defined(__cplusplus) || defined(c_plusplus) */

//C     #endif /* _MAGICK_TYPES_H */

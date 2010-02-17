/* Converted to D from ./magick/api.h by htod */
module magick.api;
/*
  Copyright (C) 2003, 2004, 2007 GraphicsMagick Group
  Copyright (C) 2002 ImageMagick Studio
  Copyright 1991-1999 E. I. du Pont de Nemours and Company
 
  This program is covered by multiple licenses, which are described in
  Copyright.txt. You should have received a copy of Copyright.txt with this
  package; otherwise see http://www.graphicsmagick.org/www/Copyright.html.
 
  GraphicsMagick Application Programming Interface declarations.

*/

//C     #if !defined(_MAGICK_API_H)
//C     #define _MAGICK_API_H

//C     #if defined(__cplusplus) || defined(c_plusplus)
//C     extern "C" {
//C     #endif

//C     #include "magick/magick_config.h"
public import magick.magick_config;
//#if defined(__cplusplus) || defined(c_plusplus)
//#  undef inline
//#endif

//#include <stdio.h>
//#include <stdarg.h>
//#include <stdlib.h>

public import magick.globals;

/*
  Note that the WIN32 and WIN64 definitions are provided by the build
  configuration rather than the compiler.  Definitions available from
  the Windows compiler are _WIN32 and _WIN64.
*/
//C     #if defined(WIN32) || defined(WIN64)
//C     #  define MSWINDOWS
//C     #endif /* defined(WIN32) || defined(WIN64) */

//C     #if defined(MSWINDOWS) && !defined(__CYGWIN__)
//C     #  if defined(_MT) && defined(_DLL) && !defined(_MAGICKDLL_) && !defined(_LIB)
//C     #    define _MAGICKDLL_
//C     #  endif

//C     #  if defined(_MAGICKDLL_)
//C     #    if defined(_VISUALC_)
//C     #      pragma warning( disable: 4273 )  /* Disable the dll linkage warnings */
//C     #    endif
//C     #    if !defined(_MAGICKLIB_)
//C     #      define  __declspec(dllimport)
//C     #      if defined(_VISUALC_)
//C     #        pragma message( "Magick lib DLL import interface" )
//C     #      endif
//C     #    else
//C     #      define  __declspec(dllexport)
//C     #      if defined(_VISUALC_)
//C     #        pragma message( "Magick lib DLL export interface" )
//C     #      endif
//C     #    endif
//C     #  else
//C     #    define MagickExport
//C     #    if defined(_VISUALC_)
//C     #      pragma message( "Magick lib static interface" )
//C     #    endif
//C     #  endif

//C     #  if defined(_DLL) && !defined(_LIB)
//C     #    define ModuleExport  __declspec(dllexport)
//C     #    if defined(_VISUALC_)
//C     #      pragma message( "Magick module DLL export interface" ) 
//C     #    endif
//C     #  else
//C     #    define ModuleExport
//C     #    if defined(_VISUALC_)
//C     #      pragma message( "Magick module static interface" ) 
//C     #    endif
//C     #  endif

//C     #  define MagickGlobal __declspec(thread)
//C     #  if defined(_VISUALC_)
//C     #    pragma warning(disable : 4018)
//C     #    pragma warning(disable : 4244)
//C     #    pragma warning(disable : 4142)
//C     #    pragma warning(disable : 4800)
//C     #    pragma warning(disable : 4786)
//C     #  endif
//C     #else
//C     #  define MagickExport
//C     #  define ModuleExport
//C     #  define MagickGlobal
//C     #endif

//C     #define MaxTextExtent  2053
//C     #define MagickSignature  0xabacadabUL
/////Moved to globals: const MaxTextExtent = 2053;

align(1):

//MOVED stuff to globals.

//C     #if defined(MAGICK_IMPLEMENTATION)
//C     #  if defined(MSWINDOWS)
  /* Use Visual C++ C inline method extension to improve performance */
//C     #    if !defined(inline) && !defined(__cplusplus) && !defined(c_plusplus)
//C     #      define inline __inline
//C     #    endif
//C     #  endif
//C     #endif

//C     #if defined(PREFIX_MAGICK_SYMBOLS)
//C     #  include "magick/symbols.h"
//C     #endif /* defined(PREFIX_MAGICK_SYMBOLS) */

//C     #include "magick/magick_types.h"
public import magick.magick_types;
//C     #include "magick/error.h"
public import magick.error;
//C     #include "magick/log.h"
public import magick.log;
//C     #include "magick/timer.h"
public import magick.timer;
//C     #include "magick/image.h"
public import magick.image;


//C     #include "magick/channel.h"
//C     #include "magick/compare.h"
//C     #include "magick/list.h"
//C     #include "magick/paint.h"
//C     #include "magick/render.h"
//C     #include "magick/draw.h"
//C     #include "magick/gem.h"
//C     #include "magick/quantize.h"
//C     #include "magick/compress.h"
//C     #include "magick/attribute.h"
//C     #include "magick/command.h"
//C     #include "magick/utility.h"
//C     #include "magick/signature.h"
//C     #include "magick/blob.h"
//C     #include "magick/color.h"
//C     #include "magick/constitute.h"
public import magick.constitute;
//C     #include "magick/decorate.h"
//C     #include "magick/enhance.h"
//C     #include "magick/fx.h"
//C     #include "magick/magick.h"
public import magick.magick;
//C     #include "magick/memory.h"
//C     #include "magick/montage.h"
//C     #include "magick/effect.h"
//C     #include "magick/resize.h"
import magick.resize; 
//C     #include "magick/shear.h"
//C     #include "magick/transform.h"
//C     #include "magick/composite.h"
//C     #include "magick/registry.h"
//C     #include "magick/magick.h"
//C     #include "magick/magic.h"
//C     #include "magick/delegate.h"
//C     #include "magick/module.h"
//C     #include "magick/monitor.h"
//C     #include "magick/operator.h"
//C     #include "magick/pixel_cache.h"
import magick.pixel_cache;
//C     #include "magick/pixel_iterator.h"
//C     #include "magick/profile.h"
//C     #include "magick/resource.h"
//C     #include "magick/version.h"
//C     #include "magick/deprecate.h"


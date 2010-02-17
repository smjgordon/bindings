/* Converted to D from ./magick/magick_config.h by htod */
module magick.magick_config;

align(1):

/* magick/magick_config.h.  Generated from magick_config.h.in by configure.  */
/* magick/magick_config.h.in.  Generated from configure.ac by autoheader.  */

/* Define if building universal (internal helper macro) */
/* #undef AC_APPLE_UNIVERSAL_BUILD */

/* Define if coders and filters are to be built as modules. */
/* #undef BuildMagickModules */

/* C compiler used for compilation */
//C     #define GM_BUILD_CC "gcc -std=gnu99"

/* CFLAGS used for C compilation */
//C     #define GM_BUILD_CFLAGS "-fopenmp -g -O2 -Wall -pthread"

/* arguments passed to configure */
//C     #define GM_BUILD_CONFIGURE_ARGS "./configure  '--without-perl' --enable-ltdl-convenience"

/* CPPFLAGS used for preprocessing */
//C     #define GM_BUILD_CPPFLAGS "-I/usr/include/freetype2 -I/usr/include/libxml2"

/* C++ compiler used for compilation */
//C     #define GM_BUILD_CXX "g++"

/* CXXFLAGS used for C++ compilation */
//C     #define GM_BUILD_CXXFLAGS "-pthread"

/* Host identification triplet */
//C     #define GM_BUILD_HOST "i686-pc-linux-gnu"

/* LDFLAGS used for linking */
//C     #define GM_BUILD_LDFLAGS "-L/usr/lib -L/usr/lib"

/* LIBS used for linking */
//C     #define GM_BUILD_LIBS "-ltiff -lfreetype -ljasper -ljpeg -lpng -lXext -lSM -lICE -lX11 -lxml2 -lz -lm -lgomp -lpthread"

/* Define if C++ compiler supports __func__ */
//C     #define HAS_CPP__func__ 1

const HAS_CPP__func__ = 1;
/* Define if C compiler supports __func__ */
//C     #define HAS_C__func__ 1

const HAS_C__func__ = 1;
/* Define to 1 if you have the `argz_add' function. */
//C     #define HAVE_ARGZ_ADD 1

const HAVE_ARGZ_ADD = 1;
/* Define to 1 if you have the `argz_append' function. */
//C     #define HAVE_ARGZ_APPEND 1

const HAVE_ARGZ_APPEND = 1;
/* Define to 1 if you have the `argz_count' function. */
//C     #define HAVE_ARGZ_COUNT 1

const HAVE_ARGZ_COUNT = 1;
/* Define to 1 if you have the `argz_create_sep' function. */
//C     #define HAVE_ARGZ_CREATE_SEP 1

const HAVE_ARGZ_CREATE_SEP = 1;
/* Define to 1 if you have the <argz.h> header file. */
//C     #define HAVE_ARGZ_H 1

const HAVE_ARGZ_H = 1;
/* Define to 1 if you have the `argz_insert' function. */
//C     #define HAVE_ARGZ_INSERT 1

const HAVE_ARGZ_INSERT = 1;
/* Define to 1 if you have the `argz_next' function. */
//C     #define HAVE_ARGZ_NEXT 1

const HAVE_ARGZ_NEXT = 1;
/* Define to 1 if you have the `argz_stringify' function. */
//C     #define HAVE_ARGZ_STRINGIFY 1

const HAVE_ARGZ_STRINGIFY = 1;
/* Define to 1 if you have the `atoll' function. */
//C     #define HAVE_ATOLL 1

const HAVE_ATOLL = 1;
/* define if bool is a built-in type */
//C     #define HAVE_BOOL /**/

/* Define to 1 if you have the `closedir' function. */
//C     #define HAVE_CLOSEDIR 1

const HAVE_CLOSEDIR = 1;
/* define if the compiler supports const_cast<> */
//C     #define HAVE_CONST_CAST /**/

/* Define to 1 if you have the declaration of `cygwin_conv_path', and to 0 if
   you don't. */
/* #undef HAVE_DECL_CYGWIN_CONV_PATH */

/* Define to 1 if you have the declaration of `pread', and to 0 if you don't.
   */
//C     #define HAVE_DECL_PREAD 0

const HAVE_DECL_PREAD = 0;
/* Define to 1 if you have the declaration of `pwrite', and to 0 if you don't.
   */
//C     #define HAVE_DECL_PWRITE 0

const HAVE_DECL_PWRITE = 0;
/* Define to 1 if you have the declaration of `strlcpy', and to 0 if you
   don't. */
//C     #define HAVE_DECL_STRLCPY 0

const HAVE_DECL_STRLCPY = 0;
/* Define to 1 if you have the declaration of `vsnprintf', and to 0 if you
   don't. */
//C     #define HAVE_DECL_VSNPRINTF 1

const HAVE_DECL_VSNPRINTF = 1;
/* define if the compiler supports default template parameters */
//C     #define HAVE_DEFAULT_TEMPLATE_PARAMETERS /**/

/* Define to 1 if you have the <dirent.h> header file, and it defines `DIR'.
   */
//C     #define HAVE_DIRENT_H 1

const HAVE_DIRENT_H = 1;
/* Define if you have the GNU dld library. */
/* #undef HAVE_DLD */

/* Define to 1 if you have the <dld.h> header file. */
/* #undef HAVE_DLD_H */

/* Define to 1 if you have the `dlerror' function. */
//C     #define HAVE_DLERROR 1

const HAVE_DLERROR = 1;
/* Define to 1 if you have the <dlfcn.h> header file. */
//C     #define HAVE_DLFCN_H 1

const HAVE_DLFCN_H = 1;
/* Define to 1 if you have the <dl.h> header file. */
/* #undef HAVE_DL_H */

/* Define if you have the _dyld_func_lookup function. */
/* #undef HAVE_DYLD */

/* Define to 1 if the system has the type `error_t'. */
//C     #define HAVE_ERROR_T 1

const HAVE_ERROR_T = 1;
/* define if the compiler supports exceptions */
//C     #define HAVE_EXCEPTIONS /**/

/* define if the compiler supports the explicit keyword */
//C     #define HAVE_EXPLICIT /**/

/* Define to 1 if fseeko (and presumably ftello) exists and is declared. */
//C     #define HAVE_FSEEKO 1

const HAVE_FSEEKO = 1;
/* Define to 1 if you have the <ft2build.h> header file. */
//C     #define HAVE_FT2BUILD_H 1

const HAVE_FT2BUILD_H = 1;
/* Define to 1 if you have the `ftime' function. */
//C     #define HAVE_FTIME 1

const HAVE_FTIME = 1;
/* Define to 1 if you have the `getc_unlocked' function. */
//C     #define HAVE_GETC_UNLOCKED 1

const HAVE_GETC_UNLOCKED = 1;
/* Define to 1 if you have the `getexecname' function. */
/* #undef HAVE_GETEXECNAME */

/* Define to 1 if you have the `getpagesize' function. */
//C     #define HAVE_GETPAGESIZE 1

const HAVE_GETPAGESIZE = 1;
/* Define to 1 if you have the `getpid' function. */
//C     #define HAVE_GETPID 1

const HAVE_GETPID = 1;
/* Define to 1 if you have the <inttypes.h> header file. */
//C     #define HAVE_INTTYPES_H 1

const HAVE_INTTYPES_H = 1;
/* Define if you have the <lcms.h> header file. */
/* #undef HAVE_LCMS_H */

/* Define if you have the <lcms/lcms.h> header file. */
/* #undef HAVE_LCMS_LCMS_H */

/* Define if you have the libdl library or equivalent. */
//C     #define HAVE_LIBDL 1

const HAVE_LIBDL = 1;
/* Define if libdlloader will be built on this platform */
//C     #define HAVE_LIBDLLOADER 1

const HAVE_LIBDLLOADER = 1;
/* Define to 1 if you have the `lltostr' function. */
/* #undef HAVE_LLTOSTR */

/* Define to 1 if the type `long double' works and has more range or precision
   than `double'. */
//C     #define HAVE_LONG_DOUBLE 1

const HAVE_LONG_DOUBLE = 1;
/* Define to 1 if the type `long double' works and has more range or precision
   than `double'. */
//C     #define HAVE_LONG_DOUBLE_WIDER 1

const HAVE_LONG_DOUBLE_WIDER = 1;
/* Define this if a modern libltdl is already installed */
/* #undef HAVE_LTDL */

/* Define to 1 if you have the <machine/param.h> header file. */
/* #undef HAVE_MACHINE_PARAM_H */

/* Define to 1 if you have the <mach-o/dyld.h> header file. */
/* #undef HAVE_MACH_O_DYLD_H */

/* Define to 1 if you have the `madvise' function. */
//C     #define HAVE_MADVISE 1

const HAVE_MADVISE = 1;
/* Define to 1 if you have the <memory.h> header file. */
//C     #define HAVE_MEMORY_H 1

const HAVE_MEMORY_H = 1;
/* Define to 1 if you have the `mkstemp' function. */
//C     #define HAVE_MKSTEMP 1

const HAVE_MKSTEMP = 1;
/* Define to 1 if you have a `mmap' system call which handles coherent file
   I/O. */
//C     #define HAVE_MMAP_FILEIO 1

const HAVE_MMAP_FILEIO = 1;
/* define if the compiler supports the mutable keyword */
//C     #define HAVE_MUTABLE /**/

/* define if the compiler implements namespaces */
//C     #define HAVE_NAMESPACES /**/

/* Define to 1 if you have the <ndir.h> header file, and it defines `DIR'. */
/* #undef HAVE_NDIR_H */

/* define if the compiler accepts the new for scoping rules */
//C     #define HAVE_NEW_FOR_SCOPING /**/

/* Define to 1 if you have the `opendir' function. */
//C     #define HAVE_OPENDIR 1

const HAVE_OPENDIR = 1;
/* Define to 1 if you have the `pclose' function. */
//C     #define HAVE_PCLOSE 1

const HAVE_PCLOSE = 1;
/* Define to 1 if you have the `poll' function. */
//C     #define HAVE_POLL 1

const HAVE_POLL = 1;
/* Define to 1 if you have the `popen' function. */
//C     #define HAVE_POPEN 1

const HAVE_POPEN = 1;
/* Define to 1 if you have the `posix_fallocate' function. */
//C     #define HAVE_POSIX_FALLOCATE 1

const HAVE_POSIX_FALLOCATE = 1;
/* Define to 1 if you have the `pread' function. */
//C     #define HAVE_PREAD 1

const HAVE_PREAD = 1;
/* Define if libtool can extract symbol lists from object files. */
//C     #define HAVE_PRELOADED_SYMBOLS 1

const HAVE_PRELOADED_SYMBOLS = 1;
/* Define if you have POSIX threads libraries and header files. */
//C     #define HAVE_PTHREAD 1

const HAVE_PTHREAD = 1;
/* Define to 1 if you have the `putc_unlocked' function. */
//C     #define HAVE_PUTC_UNLOCKED 1

const HAVE_PUTC_UNLOCKED = 1;
/* Define to 1 if you have the `pwrite' function. */
//C     #define HAVE_PWRITE 1

const HAVE_PWRITE = 1;
/* Define to 1 if you have the `raise' function. */
//C     #define HAVE_RAISE 1

const HAVE_RAISE = 1;
/* Define to 1 if you have the `rand_r' function. */
//C     #define HAVE_RAND_R 1

const HAVE_RAND_R = 1;
/* Define to 1 if you have the `readdir' function. */
//C     #define HAVE_READDIR 1

const HAVE_READDIR = 1;
/* Define to 1 if you have the `readlink' function. */
//C     #define HAVE_READLINK 1

const HAVE_READLINK = 1;
/* Define to 1 if you have the `realpath' function. */
//C     #define HAVE_REALPATH 1

const HAVE_REALPATH = 1;
/* Define to 1 if you have the `seekdir' function. */
//C     #define HAVE_SEEKDIR 1

const HAVE_SEEKDIR = 1;
/* Define to 1 if you have the `select' function. */
//C     #define HAVE_SELECT 1

const HAVE_SELECT = 1;
/* Define if you have the shl_load function. */
/* #undef HAVE_SHL_LOAD */

/* Define to 1 if you have the `sigaction' function. */
//C     #define HAVE_SIGACTION 1

const HAVE_SIGACTION = 1;
/* Define to 1 if you have the `sigemptyset' function. */
//C     #define HAVE_SIGEMPTYSET 1

const HAVE_SIGEMPTYSET = 1;
/* define if the compiler supports static_cast<> */
//C     #define HAVE_STATIC_CAST /**/

/* define if the compiler supports ISO C++ standard library */
//C     #define HAVE_STD /**/

/* Define to 1 if you have the <stdint.h> header file. */
//C     #define HAVE_STDINT_H 1

const HAVE_STDINT_H = 1;
/* Define to 1 if you have the <stdlib.h> header file. */
//C     #define HAVE_STDLIB_H 1

const HAVE_STDLIB_H = 1;
/* define if the compiler supports Standard Template Library */
//C     #define HAVE_STL /**/

/* Define to 1 if you have the `strerror' function. */
//C     #define HAVE_STRERROR 1

const HAVE_STRERROR = 1;
/* Define to 1 if you have the <strings.h> header file. */
//C     #define HAVE_STRINGS_H 1

const HAVE_STRINGS_H = 1;
/* Define to 1 if you have the <string.h> header file. */
//C     #define HAVE_STRING_H 1

const HAVE_STRING_H = 1;
/* Define to 1 if you have the `strlcat' function. */
/* #undef HAVE_STRLCAT */

/* Define to 1 if you have the `strlcpy' function. */
/* #undef HAVE_STRLCPY */

/* Define to 1 if you have the `strtoll' function. */
//C     #define HAVE_STRTOLL 1

const HAVE_STRTOLL = 1;
/* Define to 1 if you have the `sysconf' function. */
//C     #define HAVE_SYSCONF 1

const HAVE_SYSCONF = 1;
/* Define to 1 if you have the <sys/dir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_DIR_H */

/* Define to 1 if you have the <sys/dl.h> header file. */
/* #undef HAVE_SYS_DL_H */

/* Define to 1 if you have the <sys/ndir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_NDIR_H */

/* Define to 1 if you have the <sys/stat.h> header file. */
//C     #define HAVE_SYS_STAT_H 1

const HAVE_SYS_STAT_H = 1;
/* Define to 1 if you have the <sys/times.h> header file. */
//C     #define HAVE_SYS_TIMES_H 1

const HAVE_SYS_TIMES_H = 1;
/* Define to 1 if you have the <sys/types.h> header file. */
//C     #define HAVE_SYS_TYPES_H 1

const HAVE_SYS_TYPES_H = 1;
/* Define to 1 if you have the `telldir' function. */
//C     #define HAVE_TELLDIR 1

const HAVE_TELLDIR = 1;
/* define if the compiler supports basic templates */
//C     #define HAVE_TEMPLATES /**/

/* Define to 1 if you have the `tempnam' function. */
//C     #define HAVE_TEMPNAM 1

const HAVE_TEMPNAM = 1;
/* Define to 1 if you have the <tiffconf.h> header file. */
//C     #define HAVE_TIFFCONF_H 1

const HAVE_TIFFCONF_H = 1;
/* Define to 1 if you have the `TIFFIsCODECConfigured' function. */
//C     #define HAVE_TIFFISCODECCONFIGURED 1

const HAVE_TIFFISCODECCONFIGURED = 1;
/* Define to 1 if you have the `TIFFMergeFieldInfo' function. */
//C     #define HAVE_TIFFMERGEFIELDINFO 1

const HAVE_TIFFMERGEFIELDINFO = 1;
/* Define to 1 if you have the `TIFFSetErrorHandlerExt' function. */
//C     #define HAVE_TIFFSETERRORHANDLEREXT 1

const HAVE_TIFFSETERRORHANDLEREXT = 1;
/* Define to 1 if you have the `TIFFSetTagExtender' function. */
//C     #define HAVE_TIFFSETTAGEXTENDER 1

const HAVE_TIFFSETTAGEXTENDER = 1;
/* Define to 1 if you have the `TIFFSetWarningHandlerExt' function. */
//C     #define HAVE_TIFFSETWARNINGHANDLEREXT 1

const HAVE_TIFFSETWARNINGHANDLEREXT = 1;
/* Define to 1 if you have the `TIFFSwabArrayOfTriples' function. */
//C     #define HAVE_TIFFSWABARRAYOFTRIPLES 1

const HAVE_TIFFSWABARRAYOFTRIPLES = 1;
/* Define to 1 if you have the `times' function. */
//C     #define HAVE_TIMES 1

const HAVE_TIMES = 1;
/* Define to 1 if you have the `ulltostr' function. */
/* #undef HAVE_ULLTOSTR */

/* Define to 1 if you have the <unistd.h> header file. */
//C     #define HAVE_UNISTD_H 1

const HAVE_UNISTD_H = 1;
/* Define to 1 if you have the `vsnprintf' function. */
//C     #define HAVE_VSNPRINTF 1

const HAVE_VSNPRINTF = 1;
/* Define to 1 if you have the `vsprintf' function. */
//C     #define HAVE_VSPRINTF 1

const HAVE_VSPRINTF = 1;
/* This value is set to 1 to indicate that the system argz facility works */
//C     #define HAVE_WORKING_ARGZ 1

const HAVE_WORKING_ARGZ = 1;
/* Define to 1 if you have the `_exit' function. */
//C     #define HAVE__EXIT 1

const HAVE__EXIT = 1;
/* Define to 1 if you have the `_NSGetExecutablePath' function. */
/* #undef HAVE__NSGETEXECUTABLEPATH */

/* Define to 1 if you have the `_pclose' function. */
/* #undef HAVE__PCLOSE */

/* Define to 1 if you have the `_popen' function. */
/* #undef HAVE__POPEN */

/* Define if you have the bzip2 library */
/* #undef HasBZLIB */

/* Define if you have Display Postscript */
/* #undef HasDPS */

/* Define if you have FlashPIX library */
/* #undef HasFPX */

/* Define if you have Ghostscript library */
/* #undef HasGS */

/* Define if you have JBIG library */
/* #undef HasJBIG */

/* Define if you have JPEG version 2 "Jasper" library */
//C     #define HasJP2 1

const HasJP2 = 1;
/* Define if you have JPEG library */
//C     #define HasJPEG 1

const HasJPEG = 1;
/* Define if you have LCMS library */
/* #undef HasLCMS */

/* Define if using libltdl to support dynamically loadable modules */
/* #undef HasLTDL */

/* Define if you have PNG library */
//C     #define HasPNG 1

const HasPNG = 1;
/* X11 server supports shape extension */
//C     #define HasShape 1

const HasShape = 1;
/* X11 server supports shared memory extension */
//C     #define HasSharedMemory 1

const HasSharedMemory = 1;
/* Define if you have TIFF library */
//C     #define HasTIFF 1

const HasTIFF = 1;
/* Define if you have TRIO vsnprintf replacement library */
/* #undef HasTRIO */

/* Define if you have FreeType (TrueType font) library */
//C     #define HasTTF 1

const HasTTF = 1;
/* Define if you have umem memory allocation library */
/* #undef HasUMEM */

/* Define to use the Windows GDI32 library */
/* #undef HasWINGDI32 */

/* Define if you have wmf library */
/* #undef HasWMF */

/* Define if you have wmflite library */
/* #undef HasWMFlite */

/* Define if you have X11 library */
//C     #define HasX11 1

const HasX11 = 1;
/* Define if you have XML library */
//C     #define HasXML 1

const HasXML = 1;
/* Define if you have zlib compression library */
//C     #define HasZLIB 1

const HasZLIB = 1;
/* Define if the OS needs help to load dependent libraries for dlopen(). */
/* #undef LTDL_DLOPEN_DEPLIBS */

/* Define to the system default library search path. */
//C     #define LT_DLSEARCH_PATH "/lib:/usr/lib:/lib/i486-linux-gnu:/usr/lib/i486-linux-gnu:/usr/local/lib"

/* The archive extension */
//C     #define LT_LIBEXT "a"

/* Define to the extension used for runtime loadable modules, say, ".so". */
//C     #define LT_MODULE_EXT ".so"

/* Define to the name of the environment variable that determines the run-time
   module search path. */
//C     #define LT_MODULE_PATH_VAR "LD_LIBRARY_PATH"

/* Define to the sub-directory in which libtool stores uninstalled libraries.
   */
//C     #define LT_OBJDIR ".libs/"

/* Define to prepend to default font search path. */
/* #undef MAGICK_FONT_PATH */

/* Command which returns total physical memory in bytes */
/* #undef MAGICK_PHYSICAL_MEMORY_COMMAND */

/* define if the compiler lacks ios::binary */
/* #undef MISSING_STD_IOS_BINARY */

/* Directory where executables are installed. */
//C     #define MagickBinPath "/usr/local/bin/"

/* Location of coder modules */
//C     #define MagickCoderModulesPath "/usr/local/lib/GraphicsMagick-1.3/modules-Q8/coders/"

/* Subdirectory of lib where coder modules are installed */
//C     #define MagickCoderModulesSubdir "GraphicsMagick-1.3/modules-Q8/coders"

/* Location of filter modules */
//C     #define MagickFilterModulesPath "/usr/local/lib/GraphicsMagick-1.3/modules-Q8/filters/"

/* Subdirectory of lib where filter modules are installed */
//C     #define MagickFilterModulesSubdir "GraphicsMagick-1.3/modules-Q8/filters"

/* Directory where architecture-dependent configuration files live. */
//C     #define MagickLibConfigPath "/usr/local/lib/GraphicsMagick-1.3/config/"

/* Subdirectory of lib where architecture-dependent configuration files live.
   */
//C     #define MagickLibConfigSubDir "GraphicsMagick-1.3/config"

/* Directory where architecture-dependent files live. */
//C     #define MagickLibPath "/usr/local/lib/GraphicsMagick-1.3/"

/* Subdirectory of lib where GraphicsMagick architecture dependent files are
   installed */
//C     #define MagickLibSubdir "GraphicsMagick-1.3"

/* Directory where architecture-independent configuration files live. */
//C     #define MagickShareConfigPath "/usr/local/share/GraphicsMagick-1.3/config/"

/* Subdirectory of lib where architecture-independent configuration files
   live. */
//C     #define MagickShareConfigSubDir "GraphicsMagick-1.3/config"

/* Directory where architecture-independent files live. */
//C     #define MagickSharePath "/usr/local/share/GraphicsMagick-1.3/"

/* Define if dlsym() requires a leading underscore in symbol names. */
/* #undef NEED_USCORE */

/* Define to 1 if your C compiler doesn't accept -c and -o together. */
/* #undef NO_MINUS_C_MINUS_O */

/* Define to the address where bug reports for this package should be sent. */
//C     #define PACKAGE_BUGREPORT ""

/* Define to the full name of this package. */
//C     #define PACKAGE_NAME ""

/* Define to the full name and version of this package. */
//C     #define PACKAGE_STRING ""

/* Define to the one symbol short name of this package. */
//C     #define PACKAGE_TARNAME ""

/* Define to the version of this package. */
//C     #define PACKAGE_VERSION ""

/* Prefix Magick library symbols with a common string. */
/* #undef PREFIX_MAGICK_SYMBOLS */

/* Define to necessary symbol if this constant uses a non-standard name on
   your system. */
/* #undef PTHREAD_CREATE_JOINABLE */

/* Number of bits in a pixel Quantum (8/16/32) */
//C     #define QuantumDepth 8

const QuantumDepth = 8;
/* Define as the return type of signal handlers (`int' or `void'). */
//C     #define RETSIGTYPE void

alias void RETSIGTYPE;
/* The size of `off_t', as computed by sizeof. */
//C     #define SIZEOF_OFF_T 8

const SIZEOF_OFF_T = 8;
/* The size of `signed int', as computed by sizeof. */
//C     #define SIZEOF_SIGNED_INT 4

const SIZEOF_SIGNED_INT = 4;
/* The size of `signed long', as computed by sizeof. */
//C     #define SIZEOF_SIGNED_LONG 4

const SIZEOF_SIGNED_LONG = 4;
/* The size of `signed long long', as computed by sizeof. */
//C     #define SIZEOF_SIGNED_LONG_LONG 8

const SIZEOF_SIGNED_LONG_LONG = 8;
/* The size of `signed short', as computed by sizeof. */
//C     #define SIZEOF_SIGNED_SHORT 2

const SIZEOF_SIGNED_SHORT = 2;
/* The size of `size_t', as computed by sizeof. */
//C     #define SIZEOF_SIZE_T 4

const SIZEOF_SIZE_T = 4;
/* The size of `unsigned int', as computed by sizeof. */
//C     #define SIZEOF_UNSIGNED_INT 4

const SIZEOF_UNSIGNED_INT = 4;
/* The size of `unsigned int*', as computed by sizeof. */
//C     #define SIZEOF_UNSIGNED_INTP 4

const SIZEOF_UNSIGNED_INTP = 4;
/* The size of `unsigned long', as computed by sizeof. */
//C     #define SIZEOF_UNSIGNED_LONG 4

const SIZEOF_UNSIGNED_LONG = 4;
/* The size of `unsigned long long', as computed by sizeof. */
//C     #define SIZEOF_UNSIGNED_LONG_LONG 8

const SIZEOF_UNSIGNED_LONG_LONG = 8;
/* The size of `unsigned short', as computed by sizeof. */
//C     #define SIZEOF_UNSIGNED_SHORT 2

const SIZEOF_UNSIGNED_SHORT = 2;
/* Define to 1 if you have the ANSI C header files. */
//C     #define STDC_HEADERS 1

const STDC_HEADERS = 1;
/* GraphicsMagick is formally installed under prefix */
//C     #define UseInstalledMagick 1

const UseInstalledMagick = 1;
/* Define WORDS_BIGENDIAN to 1 if your processor stores words with the most
   significant byte first (like Motorola and SPARC, unlike Intel). */
//C     #if defined AC_APPLE_UNIVERSAL_BUILD
//C     # if defined __BIG_ENDIAN__
//C     #  define WORDS_BIGENDIAN 1
//C     # endif
//C     #else
//C     # ifndef WORDS_BIGENDIAN
/* #  undef WORDS_BIGENDIAN */
//C     # endif
//C     #endif

/* Location of X11 configure files */
//C     #define X11ConfigurePath "X11ConfigurePath"

/* Define to 1 if the X Window System is missing or not being used. */
/* #undef X_DISPLAY_MISSING */

/* Number of bits in a file offset, on hosts where this is settable. */
//C     #define _FILE_OFFSET_BITS 64

const _FILE_OFFSET_BITS = 64;
/* Define to 1 to make fseeko visible on some hosts (e.g. glibc 2.2). */
/* #undef _LARGEFILE_SOURCE */

/* Define for large files, on AIX-style hosts. */
/* #undef _LARGE_FILES */

/* Define to 1 if type `char' is unsigned and you are not using gcc.  */
//C     #ifndef __CHAR_UNSIGNED__
/* # undef __CHAR_UNSIGNED__ */
//C     #endif

/* Define so that glibc/gnulib argp.h does not typedef error_t. */
/* #undef __error_t_defined */

/* Define to empty if `const' does not conform to ANSI C. */
/* #undef const */

/* Define to a type to use for `error_t' if it is not otherwise available. */
/* #undef error_t */

/* Define to `__inline__' or `__inline' if that's what the C compiler
   calls it, or to nothing if 'inline' is not supported under any name.  */
//C     #ifndef __cplusplus
/* #undef inline */
//C     #endif

/* Define to `int' if <sys/types.h> does not define. */
/* #undef mode_t */

/* Define to `long int' if <sys/types.h> does not define. */
/* #undef off_t */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef pid_t */

/* Define to `unsigned int' if <sys/types.h> does not define. */
/* #undef size_t */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef ssize_t */

// ==========================================================
// FreeImage 3
//
// D header conversion by
// - Jascha Wetzel
//
// Design and implementation by
// - Floris van den Berg
// - Hervé Drolon
//
// Contributors:
// - Adam Gates
// - Alex Kwak
// - Alexander Dymerets
// - Detlev Vendt
// - Jan L. Nauta
// - Jani Kajala
// - Juergen Riecker
// - Karl-Heinz Bussian
// - Laurent Rocher
// - Luca Piergentili
// - Machiel ten Brinke
// - Markus Loibl
// - Martin Weber
// - Matthias Wandel
// - Michal Novotny
// - Petr Pytelka
// - Riley McNiff
// - Ryan Rubley
// - Volker Gärtner
//
// This file is part of FreeImage 3
//
// COVERED CODE IS PROVIDED UNDER THIS LICENSE ON AN "AS IS" BASIS, WITHOUT WARRANTY
// OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, WITHOUT LIMITATION, WARRANTIES
// THAT THE COVERED CODE IS FREE OF DEFECTS, MERCHANTABLE, FIT FOR A PARTICULAR PURPOSE
// OR NON-INFRINGING. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE COVERED
// CODE IS WITH YOU. SHOULD ANY COVERED CODE PROVE DEFECTIVE IN ANY RESPECT, YOU (NOT
// THE INITIAL DEVELOPER OR ANY OTHER CONTRIBUTOR) ASSUME THE COST OF ANY NECESSARY
// SERVICING, REPAIR OR CORRECTION. THIS DISCLAIMER OF WARRANTY CONSTITUTES AN ESSENTIAL
// PART OF THIS LICENSE. NO USE OF ANY COVERED CODE IS AUTHORIZED HEREUNDER EXCEPT UNDER
// THIS DISCLAIMER.
//
// Use at your own risk!
// ==========================================================

module freeimage;

pragma(lib, "freeimage.lib");

// Version information ------------------------------------------------------

const uint  FREEIMAGE_MAJOR_VERSION = 3,
            FREEIMAGE_MINOR_VERSION = 9,
            FREEIMAGE_RELEASE_SERIAL = 3;

// Bitmap types -------------------------------------------------------------

struct FIBITMAP { void *data; };
struct FIMULTIBITMAP { void *data; };

// Types used in the library (directly copied from Windows) -----------------

const uint FALSE = 0,
           TRUE = 1;
const void* NULL = null;

const uint  SEEK_SET = 0,
            SEEK_CUR = 1,
            SEEK_END = 2;

alias int BOOL;
alias ubyte BYTE;
alias ushort WORD;
alias uint DWORD;
alias int LONG;

align(1) struct RGBQUAD
{
    version(BigEndian) {
        BYTE rgbRed;
        BYTE rgbGreen;
        BYTE rgbBlue;
    } else {
        BYTE rgbBlue;
        BYTE rgbGreen;
        BYTE rgbRed;
    } // BigEndian
    BYTE rgbReserved;
}

align(1) struct RGBTRIPLE
{
    version(BigEndian) {
        BYTE rgbtRed;
        BYTE rgbtGreen;
        BYTE rgbtBlue;
    } else {
        BYTE rgbtBlue;
        BYTE rgbtGreen;
        BYTE rgbtRed;
    } // BigEndian
}

struct BITMAPINFOHEADER{
  DWORD biSize;
  LONG  biWidth;
  LONG  biHeight;
  WORD  biPlanes;
  WORD  biBitCount;
  DWORD biCompression;
  DWORD biSizeImage;
  LONG  biXPelsPerMeter;
  LONG  biYPelsPerMeter;
  DWORD biClrUsed;
  DWORD biClrImportant;
}
alias BITMAPINFOHEADER* PBITMAPINFOHEADER;

struct BITMAPINFO {
  BITMAPINFOHEADER bmiHeader;
  RGBQUAD          bmiColors[1];
}
alias BITMAPINFO* PBITMAPINFO;

// Types used in the library (specific to FreeImage) ------------------------

alias uint unsigned;

/** 48-bit RGB
*/
align(1) struct FIRGB16 {
	WORD red;
	WORD green;
	WORD blue;
}

/** 64-bit RGBA
*/
align(1) struct FIRGBA16 {
	WORD red;
	WORD green;
	WORD blue;
	WORD alpha;
}

/** 96-bit RGB Float
*/
align(1) struct FIRGBF {
	float red;
	float green;
	float blue;
}

/** 128-bit RGBA Float
*/
align(1) struct FIRGBAF {
	float red;
	float green;
	float blue;
	float alpha;
}

/** Data structure for COMPLEX type (complex number)
*/
align(1) struct FICOMPLEX {
    /// real part
	double r;
	/// imaginary part
    double i;
}

// Indexes for byte arrays, masks and shifts for treating pixels as words ---
// These coincide with the order of RGBQUAD and RGBTRIPLE -------------------

version(BigEndian) {
// Big Endian (PPC / Linux, MaxOSX) : RGB(A) order
const uint  FI_RGBA_RED			= 0,
            FI_RGBA_GREEN		= 1,
            FI_RGBA_BLUE		= 2,
            FI_RGBA_ALPHA		= 3,
            FI_RGBA_RED_MASK	= 0xFF000000,
            FI_RGBA_GREEN_MASK	= 0x00FF0000,
            FI_RGBA_BLUE_MASK	= 0x0000FF00,
            FI_RGBA_ALPHA_MASK	= 0x000000FF,
            FI_RGBA_RED_SHIFT	= 24,
            FI_RGBA_GREEN_SHIFT	= 16,
            FI_RGBA_BLUE_SHIFT	= 8,
            FI_RGBA_ALPHA_SHIFT	= 0;
} else {
// Little Endian (x86 / MS Windows, Linux) : BGR(A) order
const uint  FI_RGBA_RED				= 2,
            FI_RGBA_GREEN			= 1,
            FI_RGBA_BLUE			= 0,
            FI_RGBA_ALPHA			= 3,
            FI_RGBA_RED_MASK		= 0x00FF0000,
            FI_RGBA_GREEN_MASK		= 0x0000FF00,
            FI_RGBA_BLUE_MASK		= 0x000000FF,
            FI_RGBA_ALPHA_MASK		= 0xFF000000,
            FI_RGBA_RED_SHIFT		= 16,
            FI_RGBA_GREEN_SHIFT		= 8,
            FI_RGBA_BLUE_SHIFT		= 0,
            FI_RGBA_ALPHA_SHIFT		= 24;
} // BigEndian

const uint FI_RGBA_RGB_MASK	= (FI_RGBA_RED_MASK|FI_RGBA_GREEN_MASK|FI_RGBA_BLUE_MASK);

// The 16bit macros only include masks and shifts, since each color element is not byte aligned

const ushort    FI16_555_RED_MASK		= 0x7C00,
                FI16_555_GREEN_MASK		= 0x03E0,
                FI16_555_BLUE_MASK		= 0x001F,
                FI16_555_RED_SHIFT		= 10,
                FI16_555_GREEN_SHIFT	= 5,
                FI16_555_BLUE_SHIFT		= 0,
                FI16_565_RED_MASK		= 0xF800,
                FI16_565_GREEN_MASK		= 0x07E0,
                FI16_565_BLUE_MASK		= 0x001F,
                FI16_565_RED_SHIFT		= 11,
                FI16_565_GREEN_SHIFT	= 5,
                FI16_565_BLUE_SHIFT		= 0;

// ICC profile support ------------------------------------------------------

const uint  FIICC_DEFAULT       = 0x00,
            FIICC_COLOR_IS_CMYK = 0x01;

struct FIICCPROFILE {
	WORD    flags;	// info flag
	DWORD	size;	// profile's size measured in bytes
	void   *data;	// points to a block of contiguous memory containing the profile
};

// Important enums ----------------------------------------------------------

/** I/O image format identifiers.
*/
enum FREE_IMAGE_FORMAT
{
	FIF_UNKNOWN = -1,
	FIF_BMP		= 0,
	FIF_ICO		= 1,
	FIF_JPEG	= 2,
	FIF_JNG		= 3,
	FIF_KOALA	= 4,
	FIF_LBM		= 5,
	FIF_IFF = FIF_LBM,
	FIF_MNG		= 6,
	FIF_PBM		= 7,
	FIF_PBMRAW	= 8,
	FIF_PCD		= 9,
	FIF_PCX		= 10,
	FIF_PGM		= 11,
	FIF_PGMRAW	= 12,
	FIF_PNG		= 13,
	FIF_PPM		= 14,
	FIF_PPMRAW	= 15,
	FIF_RAS		= 16,
	FIF_TARGA	= 17,
	FIF_TIFF	= 18,
	FIF_WBMP	= 19,
	FIF_PSD		= 20,
	FIF_CUT		= 21,
	FIF_XBM		= 22,
	FIF_XPM		= 23,
	FIF_DDS		= 24,
	FIF_GIF     = 25,
	FIF_HDR		= 26,
	FIF_FAXG3	= 27,
	FIF_SGI		= 28
};

/** Image type used in FreeImage.
*/
enum FREE_IMAGE_TYPE {
	FIT_UNKNOWN = 0,	// unknown type
	FIT_BITMAP  = 1,	// standard image			: 1-, 4-, 8-, 16-, 24-, 32-bit
	FIT_UINT16	= 2,	// array of unsigned short	: unsigned 16-bit
	FIT_INT16	= 3,	// array of short			: signed 16-bit
	FIT_UINT32	= 4,	// array of unsigned long	: unsigned 32-bit
	FIT_INT32	= 5,	// array of long			: signed 32-bit
	FIT_FLOAT	= 6,	// array of float			: 32-bit IEEE floating point
	FIT_DOUBLE	= 7,	// array of double			: 64-bit IEEE floating point
	FIT_COMPLEX	= 8,	// array of FICOMPLEX		: 2 x 64-bit IEEE floating point
	FIT_RGB16	= 9,	// 48-bit RGB image			: 3 x 16-bit
	FIT_RGBA16	= 10,	// 64-bit RGBA image		: 4 x 16-bit
	FIT_RGBF	= 11,	// 96-bit RGB float image	: 3 x 32-bit IEEE floating point
	FIT_RGBAF	= 12	// 128-bit RGBA float image	: 4 x 32-bit IEEE floating point
};

/** Image color type used in FreeImage.
*/
enum FREE_IMAGE_COLOR_TYPE {
	FIC_MINISWHITE = 0,		// min value is white
    FIC_MINISBLACK = 1,		// min value is black
    FIC_RGB        = 2,		// RGB color model
    FIC_PALETTE    = 3,		// color map indexed
	FIC_RGBALPHA   = 4,		// RGB color model with alpha channel
	FIC_CMYK       = 5		// CMYK color model
};

/** Color quantization algorithms.
Constants used in FreeImage_ColorQuantize.
*/
enum FREE_IMAGE_QUANTIZE {
    FIQ_WUQUANT = 0,		// Xiaolin Wu color quantization algorithm
    FIQ_NNQUANT = 1			// NeuQuant neural-net quantization algorithm by Anthony Dekker
};

/** Dithering algorithms.
Constants used in FreeImage_Dither.
*/
enum FREE_IMAGE_DITHER {
    FID_FS			= 0,	// Floyd & Steinberg error diffusion
	FID_BAYER4x4	= 1,	// Bayer ordered dispersed dot dithering (order 2 dithering matrix)
	FID_BAYER8x8	= 2,	// Bayer ordered dispersed dot dithering (order 3 dithering matrix)
	FID_CLUSTER6x6	= 3,	// Ordered clustered dot dithering (order 3 - 6x6 matrix)
	FID_CLUSTER8x8	= 4,	// Ordered clustered dot dithering (order 4 - 8x8 matrix)
	FID_CLUSTER16x16= 5,	// Ordered clustered dot dithering (order 8 - 16x16 matrix)
	FID_BAYER16x16	= 6		// Bayer ordered dispersed dot dithering (order 4 dithering matrix)
};

/** Lossless JPEG transformations
Constants used in FreeImage_JPEGTransform
*/
enum FREE_IMAGE_JPEG_OPERATION {
	FIJPEG_OP_NONE			= 0,	// no transformation
	FIJPEG_OP_FLIP_H		= 1,	// horizontal flip
	FIJPEG_OP_FLIP_V		= 2,	// vertical flip
	FIJPEG_OP_TRANSPOSE		= 3,	// transpose across UL-to-LR axis
	FIJPEG_OP_TRANSVERSE	= 4,	// transpose across UR-to-LL axis
	FIJPEG_OP_ROTATE_90		= 5,	// 90-degree clockwise rotation
	FIJPEG_OP_ROTATE_180	= 6,	// 180-degree rotation
	FIJPEG_OP_ROTATE_270	= 7		// 270-degree clockwise (or 90 ccw)
};

/** Tone mapping operators.
Constants used in FreeImage_ToneMapping.
*/
enum FREE_IMAGE_TMO {
    FITMO_DRAGO03	 = 0,	// Adaptive logarithmic mapping (F. Drago, 2003)
	FITMO_REINHARD05 = 1,	// Dynamic range reduction inspired by photoreceptor physiology (E. Reinhard, 2005)
};

/** Upsampling / downsampling filters.
Constants used in FreeImage_Rescale.
*/
enum FREE_IMAGE_FILTER {
	FILTER_BOX		  = 0,	// Box, pulse, Fourier window, 1st order (constant) b-spline
	FILTER_BICUBIC	  = 1,	// Mitchell & Netravali's two-param cubic filter
	FILTER_BILINEAR   = 2,	// Bilinear filter
	FILTER_BSPLINE	  = 3,	// 4th order (cubic) b-spline
	FILTER_CATMULLROM = 4,	// Catmull-Rom spline, Overhauser spline
	FILTER_LANCZOS3	  = 5	// Lanczos3 filter
};

/** Color channels.
Constants used in color manipulation routines.
*/
enum FREE_IMAGE_COLOR_CHANNEL {
	FICC_RGB	= 0,	// Use red, green and blue channels
	FICC_RED	= 1,	// Use red channel
	FICC_GREEN	= 2,	// Use green channel
	FICC_BLUE	= 3,	// Use blue channel
	FICC_ALPHA	= 4,	// Use alpha channel
	FICC_BLACK	= 5,	// Use black channel
	FICC_REAL	= 6,	// Complex images: use real part
	FICC_IMAG	= 7,	// Complex images: use imaginary part
	FICC_MAG	= 8,	// Complex images: use magnitude
	FICC_PHASE	= 9		// Complex images: use phase
};

// Metadata support ---------------------------------------------------------

/**
  Tag data type information (based on TIFF specifications)

  Note: RATIONALs are the ratio of two 32-bit integer values.
*/
enum FREE_IMAGE_MDTYPE {
	FIDT_NOTYPE		= 0,	// placeholder
	FIDT_BYTE		= 1,	// 8-bit unsigned integer
	FIDT_ASCII		= 2,	// 8-bit bytes w/ last byte null
	FIDT_SHORT		= 3,	// 16-bit unsigned integer
	FIDT_LONG		= 4,	// 32-bit unsigned integer
	FIDT_RATIONAL	= 5,	// 64-bit unsigned fraction
	FIDT_SBYTE		= 6,	// 8-bit signed integer
	FIDT_UNDEFINED	= 7,	// 8-bit untyped data
	FIDT_SSHORT		= 8,	// 16-bit signed integer
	FIDT_SLONG		= 9,	// 32-bit signed integer
	FIDT_SRATIONAL	= 10,	// 64-bit signed fraction
	FIDT_FLOAT		= 11,	// 32-bit IEEE floating point
	FIDT_DOUBLE		= 12,	// 64-bit IEEE floating point
	FIDT_IFD		= 13,	// 32-bit unsigned integer (offset)
	FIDT_PALETTE	= 14	// 32-bit RGBQUAD
};

/**
  Metadata models supported by FreeImage
*/
enum FREE_IMAGE_MDMODEL {
	FIMD_NODATA			= -1,
	FIMD_COMMENTS		= 0,	// single comment or keywords
	FIMD_EXIF_MAIN		= 1,	// Exif-TIFF metadata
	FIMD_EXIF_EXIF		= 2,	// Exif-specific metadata
	FIMD_EXIF_GPS		= 3,	// Exif GPS metadata
	FIMD_EXIF_MAKERNOTE = 4,	// Exif maker note metadata
	FIMD_EXIF_INTEROP	= 5,	// Exif interoperability metadata
	FIMD_IPTC			= 6,	// IPTC/NAA metadata
	FIMD_XMP			= 7,	// Abobe XMP metadata
	FIMD_GEOTIFF		= 8,	// GeoTIFF metadata
	FIMD_ANIMATION		= 9,	// Animation metadata
	FIMD_CUSTOM			= 10	// Used to attach other metadata types to a dib
};

/**
  Handle to a metadata model
*/
struct FIMETADATA { void *data; };

/**
  Handle to a FreeImage tag
*/
struct FITAG { void *data; };

// File IO routines ---------------------------------------------------------

version(FREEIMAGE_IO) {

alias void* fi_handle;
alias unsigned function (void *buffer, unsigned size, unsigned count, fi_handle handle)     FI_ReadProc;
alias unsigned function (void *buffer, unsigned size, unsigned count, fi_handle handle)     FI_WriteProc;
alias int function (fi_handle handle, long offset, int origin)                              FI_SeekProc;
alias long function (fi_handle handle)                                                      FI_TellProc;

align(1) struct FreeImageIO {
	FI_ReadProc  read_proc;     // pointer to the function used to read data
    FI_WriteProc write_proc;    // pointer to the function used to write data
    FI_SeekProc  seek_proc;     // pointer to the function used to seek
    FI_TellProc  tell_proc;     // pointer to the function used to aquire the current position
};

/**
Handle to a memory I/O stream
*/
struct FIMEMORY { void *data; };

} // FREEIMAGE_IO

// Plugin routines ----------------------------------------------------------

version(PLUGINS) {

alias const char *function ()                                           FI_FormatProc;
alias const char *function ()                                           FI_DescriptionProc;
alias const char *function ()                                           FI_ExtensionListProc;
alias const char *function ()                                           FI_RegExprProc;
alias void *function(FreeImageIO *io, fi_handle handle, BOOL read)      FI_OpenProc;
alias void function(FreeImageIO *io, fi_handle handle, void *data)      FI_CloseProc;
alias int function(FreeImageIO *io, fi_handle handle, void *data)       FI_PageCountProc;
alias int function(FreeImageIO *io, fi_handle handle, void *data)       FI_PageCapabilityProc;
alias FIBITMAP *function(FreeImageIO *io, fi_handle handle, int page, int flags, void *data)            FI_LoadProc;
alias BOOL function(FreeImageIO *io, FIBITMAP *dib, fi_handle handle, int page, int flags, void *data)  FI_SaveProc;
alias BOOL function(FreeImageIO *io, fi_handle handle)                  FI_ValidateProc;
alias const char *function ()                                           FI_MimeProc;
alias BOOL function(int bpp)                                            FI_SupportsExportBPPProc;
alias BOOL function(FREE_IMAGE_TYPE type)                               FI_SupportsExportTypeProc;
alias BOOL function()                                                   FI_SupportsICCProfilesProc;

struct Plugin {
	FI_FormatProc format_proc;
	FI_DescriptionProc description_proc;
	FI_ExtensionListProc extension_proc;
	FI_RegExprProc regexpr_proc;
	FI_OpenProc open_proc;
	FI_CloseProc close_proc;
	FI_PageCountProc pagecount_proc;
	FI_PageCapabilityProc pagecapability_proc;
	FI_LoadProc load_proc;
	FI_SaveProc save_proc;
	FI_ValidateProc validate_proc;
	FI_MimeProc mime_proc;
	FI_SupportsExportBPPProc supports_export_bpp_proc;
	FI_SupportsExportTypeProc supports_export_type_proc;
	FI_SupportsICCProfilesProc supports_icc_profiles_proc;
};

alias void function(Plugin *plugin, int format_id) FI_InitProc;

} // PLUGINS


// Load / Save flag constants -----------------------------------------------

const uint  BMP_DEFAULT         = 0,
            BMP_SAVE_RLE        = 1,
            CUT_DEFAULT         = 0,
            DDS_DEFAULT			= 0,
            FAXG3_DEFAULT		= 0,
            GIF_DEFAULT			= 0,
            GIF_LOAD256			= 1,	// Load the image as a 256 color image with ununsed palette entries, if it's 16 or 2 color
            GIF_PLAYBACK		= 2,	// 'Play' the GIF to generate each frame (as 32bpp) instead of returning raw frame data when loading
            HDR_DEFAULT			= 0,
            ICO_DEFAULT         = 0,
            ICO_MAKEALPHA		= 1,	// convert to 32bpp and create an alpha channel from the AND-mask when loading
            IFF_DEFAULT         = 0,
            JPEG_DEFAULT        = 0,		// loading (see JPEG_FAST); saving (see JPEG_QUALITYGOOD)
            JPEG_FAST           = 0x0001,	// load the file as fast as possible, sacrificing some quality
            JPEG_ACCURATE       = 0x0002,	// load the file with the best quality, sacrificing some speed
            JPEG_CMYK			= 0x0004,	// load separated CMYK "as is" (use | to combine with other load flags)
            JPEG_QUALITYSUPERB  = 0x80,	// save with superb quality (100:1)
            JPEG_QUALITYGOOD    = 0x0100,	// save with good quality (75:1)
            JPEG_QUALITYNORMAL  = 0x0200,	// save with normal quality (50:1)
            JPEG_QUALITYAVERAGE = 0x0400,	// save with average quality (25:1)
            JPEG_QUALITYBAD     = 0x0800,	// save with bad quality (10:1)
            JPEG_PROGRESSIVE	= 0x2000,	// save as a progressive-JPEG (use | to combine with other save flags)
            KOALA_DEFAULT       = 0,
            LBM_DEFAULT         = 0,
            MNG_DEFAULT         = 0,
            PCD_DEFAULT         = 0,
            PCD_BASE            = 1,	// load the bitmap sized 768 x 512
            PCD_BASEDIV4        = 2,	// load the bitmap sized 384 x 256
            PCD_BASEDIV16       = 3,	// load the bitmap sized 192 x 128
            PCX_DEFAULT         = 0,
            PNG_DEFAULT         = 0,
            PNG_IGNOREGAMMA		= 1,	// avoid gamma correction
            PNM_DEFAULT         = 0,
            PNM_SAVE_RAW        = 0,       // If set the writer saves in RAW format (i.e. P4, P5 or P6)
            PNM_SAVE_ASCII      = 1,       // If set the writer saves in ASCII format (i.e. P1, P2 or P3)
            PSD_DEFAULT         = 0,
            RAS_DEFAULT         = 0,
            SGI_DEFAULT			= 0,
            TARGA_DEFAULT       = 0,
            TARGA_LOAD_RGB888   = 1,       // If set the loader converts RGB555 and ARGB8888 -> RGB888.
            TIFF_DEFAULT        = 0,
            TIFF_CMYK			= 0x0001,	// reads/stores tags for separated CMYK (use | to combine with compression flags)
            TIFF_PACKBITS       = 0x0100,  // save using PACKBITS compression
            TIFF_DEFLATE        = 0x0200,  // save using DEFLATE compression (a.k.a. ZLIB compression)
            TIFF_ADOBE_DEFLATE  = 0x0400,  // save using ADOBE DEFLATE compression
            TIFF_NONE           = 0x0800,  // save without any compression
            TIFF_CCITTFAX3		= 0x1000,  // save using CCITT Group 3 fax encoding
            TIFF_CCITTFAX4		= 0x2000,  // save using CCITT Group 4 fax encoding
            TIFF_LZW			= 0x4000,	// save using LZW compression
            TIFF_JPEG			= 0x8000,	// save using JPEG compression
            WBMP_DEFAULT        = 0,
            XBM_DEFAULT			= 0,
            XPM_DEFAULT			= 0;


//version(Windows) {
    extern(Windows):
//}
//else {
//    extern(C):
//}

// Init / Error routines ----------------------------------------------------

void FreeImage_Initialise(BOOL load_local_plugins_only = FALSE);
void FreeImage_DeInitialise();

// Version routines ---------------------------------------------------------

char *FreeImage_GetVersion();
char *FreeImage_GetCopyrightMessage();

// Message output functions -------------------------------------------------

void FreeImage_OutputMessageProc(int fif, char *fmt, ...);

alias void function(FREE_IMAGE_FORMAT fif, char *msg) FreeImage_OutputMessageFunction;
void FreeImage_SetOutputMessage(FreeImage_OutputMessageFunction omf);

// Allocate / Clone / Unload routines ---------------------------------------

FIBITMAP *FreeImage_Allocate(int width, int height, int bpp, unsigned red_mask = 0, unsigned green_mask = 0, unsigned blue_mask = 0);
FIBITMAP *FreeImage_AllocateT(FREE_IMAGE_TYPE type, int width, int height, int bpp = 8, unsigned red_mask = 0, unsigned green_mask = 0, unsigned blue_mask = 0);
FIBITMAP * FreeImage_Clone(FIBITMAP *dib);
void FreeImage_Unload(FIBITMAP *dib);

// Load / Save routines -----------------------------------------------------

FIBITMAP *FreeImage_Load(FREE_IMAGE_FORMAT fif, char *filename, int flags = 0);
FIBITMAP *FreeImage_LoadU(FREE_IMAGE_FORMAT fif, wchar *filename, int flags = 0);
BOOL FreeImage_Save(FREE_IMAGE_FORMAT fif, FIBITMAP *dib, char *filename, int flags = 0);
BOOL FreeImage_SaveU(FREE_IMAGE_FORMAT fif, FIBITMAP *dib, wchar *filename, int flags = 0);

version(FREEIMAGE_IO) {

FIBITMAP *FreeImage_LoadFromHandle(FREE_IMAGE_FORMAT fif, FreeImageIO *io, fi_handle handle, int flags = 0);
BOOL FreeImage_SaveToHandle(FREE_IMAGE_FORMAT fif, FIBITMAP *dib, FreeImageIO *io, fi_handle handle, int flags = 0);

}

// Memory I/O stream routines -----------------------------------------------

version(FREEIMAGE_IO) {

FIMEMORY *FreeImage_OpenMemory(BYTE *data = 0, DWORD size_in_bytes = 0);
void FreeImage_CloseMemory(FIMEMORY *stream);
FIBITMAP *FreeImage_LoadFromMemory(FREE_IMAGE_FORMAT fif, FIMEMORY *stream, int flags = 0);
BOOL FreeImage_SaveToMemory(FREE_IMAGE_FORMAT fif, FIBITMAP *dib, FIMEMORY *stream, int flags = 0);
long FreeImage_TellMemory(FIMEMORY *stream);
BOOL FreeImage_SeekMemory(FIMEMORY *stream, long offset, int origin);
BOOL FreeImage_AcquireMemory(FIMEMORY *stream, BYTE **data, DWORD *size_in_bytes);
unsigned FreeImage_ReadMemory(void *buffer, unsigned size, unsigned count, FIMEMORY *stream);
unsigned FreeImage_WriteMemory(void *buffer, unsigned size, unsigned count, FIMEMORY *stream);
FIMULTIBITMAP *FreeImage_LoadMultiBitmapFromMemory(FREE_IMAGE_FORMAT fif, FIMEMORY *stream, int flags = 0);

}

// Plugin Interface ---------------------------------------------------------

version(PLUGIN) {

FREE_IMAGE_FORMAT FreeImage_RegisterLocalPlugin(FI_InitProc proc_address, char *format = 0, char *description = 0, char *extension = 0, char *regexpr = 0);
FREE_IMAGE_FORMAT FreeImage_RegisterExternalPlugin(char *path, char *format = 0, char *description = 0, char *extension = 0, char *regexpr = 0);
int FreeImage_GetFIFCount();
int FreeImage_SetPluginEnabled(FREE_IMAGE_FORMAT fif, BOOL enable);
int FreeImage_IsPluginEnabled(FREE_IMAGE_FORMAT fif);
FREE_IMAGE_FORMAT FreeImage_GetFIFFromFormat(char *format);
FREE_IMAGE_FORMAT FreeImage_GetFIFFromMime(char *mime);
char *FreeImage_GetFormatFromFIF(FREE_IMAGE_FORMAT fif);
char *FreeImage_GetFIFExtensionList(FREE_IMAGE_FORMAT fif);
char *FreeImage_GetFIFDescription(FREE_IMAGE_FORMAT fif);
char *FreeImage_GetFIFRegExpr(FREE_IMAGE_FORMAT fif);
char *FreeImage_GetFIFMimeType(FREE_IMAGE_FORMAT fif);
FREE_IMAGE_FORMAT FreeImage_GetFIFFromFilename(char *filename);
FREE_IMAGE_FORMAT FreeImage_GetFIFFromFilenameU(wchar *filename);
BOOL FreeImage_FIFSupportsReading(FREE_IMAGE_FORMAT fif);
BOOL FreeImage_FIFSupportsWriting(FREE_IMAGE_FORMAT fif);
BOOL FreeImage_FIFSupportsExportBPP(FREE_IMAGE_FORMAT fif, int bpp);
BOOL FreeImage_FIFSupportsExportType(FREE_IMAGE_FORMAT fif, FREE_IMAGE_TYPE type);
BOOL FreeImage_FIFSupportsICCProfiles(FREE_IMAGE_FORMAT fif);

}

// Multipaging interface ----------------------------------------------------

FIMULTIBITMAP * FreeImage_OpenMultiBitmap(FREE_IMAGE_FORMAT fif, char *filename, BOOL create_new, BOOL read_only, BOOL keep_cache_in_memory = FALSE, int flags = 0);
BOOL FreeImage_CloseMultiBitmap(FIMULTIBITMAP *bitmap, int flags = 0);
int FreeImage_GetPageCount(FIMULTIBITMAP *bitmap);
void FreeImage_AppendPage(FIMULTIBITMAP *bitmap, FIBITMAP *data);
void FreeImage_InsertPage(FIMULTIBITMAP *bitmap, int page, FIBITMAP *data);
void FreeImage_DeletePage(FIMULTIBITMAP *bitmap, int page);
FIBITMAP * FreeImage_LockPage(FIMULTIBITMAP *bitmap, int page);
void FreeImage_UnlockPage(FIMULTIBITMAP *bitmap, FIBITMAP *data, BOOL changed);
BOOL FreeImage_MovePage(FIMULTIBITMAP *bitmap, int target, int source);
BOOL FreeImage_GetLockedPageNumbers(FIMULTIBITMAP *bitmap, int *pages, int *count);

// Filetype request routines ------------------------------------------------

FREE_IMAGE_FORMAT FreeImage_GetFileType(char *filename, int size = 0);
FREE_IMAGE_FORMAT FreeImage_GetFileTypeU(wchar *filename, int size = 0);

version(FREEIMAGE_IO) {

FREE_IMAGE_FORMAT FreeImage_GetFileTypeFromHandle(FreeImageIO *io, fi_handle handle, int size = 0);
FREE_IMAGE_FORMAT FreeImage_GetFileTypeFromMemory(FIMEMORY *stream, int size = 0);

}

// Image type request routine -----------------------------------------------

FREE_IMAGE_TYPE FreeImage_GetImageType(FIBITMAP *dib);

// FreeImage helper routines ------------------------------------------------

BOOL FreeImage_IsLittleEndian();
BOOL FreeImage_LookupX11Color(char *szColor, BYTE *nRed, BYTE *nGreen, BYTE *nBlue);
BOOL FreeImage_LookupSVGColor(char *szColor, BYTE *nRed, BYTE *nGreen, BYTE *nBlue);


// Pixel access routines ----------------------------------------------------

BYTE *FreeImage_GetBits(FIBITMAP *dib);
BYTE *FreeImage_GetScanLine(FIBITMAP *dib, int scanline);

BOOL FreeImage_GetPixelIndex(FIBITMAP *dib, unsigned x, unsigned y, BYTE *value);
BOOL FreeImage_GetPixelColor(FIBITMAP *dib, unsigned x, unsigned y, RGBQUAD *value);
BOOL FreeImage_SetPixelIndex(FIBITMAP *dib, unsigned x, unsigned y, BYTE *value);
BOOL FreeImage_SetPixelColor(FIBITMAP *dib, unsigned x, unsigned y, RGBQUAD *value);

// DIB info routines --------------------------------------------------------

unsigned FreeImage_GetColorsUsed(FIBITMAP *dib);
unsigned FreeImage_GetBPP(FIBITMAP *dib);
unsigned FreeImage_GetWidth(FIBITMAP *dib);
unsigned FreeImage_GetHeight(FIBITMAP *dib);
unsigned FreeImage_GetLine(FIBITMAP *dib);
unsigned FreeImage_GetPitch(FIBITMAP *dib);
unsigned FreeImage_GetDIBSize(FIBITMAP *dib);
RGBQUAD *FreeImage_GetPalette(FIBITMAP *dib);

unsigned FreeImage_GetDotsPerMeterX(FIBITMAP *dib);
unsigned FreeImage_GetDotsPerMeterY(FIBITMAP *dib);
void FreeImage_SetDotsPerMeterX(FIBITMAP *dib, unsigned res);
void FreeImage_SetDotsPerMeterY(FIBITMAP *dib, unsigned res);

BITMAPINFOHEADER *FreeImage_GetInfoHeader(FIBITMAP *dib);
BITMAPINFO *FreeImage_GetInfo(FIBITMAP *dib);
FREE_IMAGE_COLOR_TYPE FreeImage_GetColorType(FIBITMAP *dib);

unsigned FreeImage_GetRedMask(FIBITMAP *dib);
unsigned FreeImage_GetGreenMask(FIBITMAP *dib);
unsigned FreeImage_GetBlueMask(FIBITMAP *dib);

unsigned FreeImage_GetTransparencyCount(FIBITMAP *dib);
BYTE * FreeImage_GetTransparencyTable(FIBITMAP *dib);
void FreeImage_SetTransparent(FIBITMAP *dib, BOOL enabled);
void FreeImage_SetTransparencyTable(FIBITMAP *dib, BYTE *table, int count);
BOOL FreeImage_IsTransparent(FIBITMAP *dib);

BOOL FreeImage_HasBackgroundColor(FIBITMAP *dib);
BOOL FreeImage_GetBackgroundColor(FIBITMAP *dib, RGBQUAD *bkcolor);
BOOL FreeImage_SetBackgroundColor(FIBITMAP *dib, RGBQUAD *bkcolor);


// ICC profile routines -----------------------------------------------------

FIICCPROFILE *FreeImage_GetICCProfile(FIBITMAP *dib);
FIICCPROFILE *FreeImage_CreateICCProfile(FIBITMAP *dib, void *data, long size);
void FreeImage_DestroyICCProfile(FIBITMAP *dib);

// Line conversion routines -------------------------------------------------

void FreeImage_ConvertLine1To4(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine8To4(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine16To4_555(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine16To4_565(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine24To4(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine32To4(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine1To8(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine4To8(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine16To8_555(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine16To8_565(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine24To8(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine32To8(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine1To16_555(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine4To16_555(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine8To16_555(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine16_565_To16_555(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine24To16_555(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine32To16_555(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine1To16_565(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine4To16_565(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine8To16_565(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine16_555_To16_565(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine24To16_565(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine32To16_565(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine1To24(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine4To24(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine8To24(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine16To24_555(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine16To24_565(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine32To24(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine1To32(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine4To32(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine8To32(BYTE *target, BYTE *source, int width_in_pixels, RGBQUAD *palette);
void FreeImage_ConvertLine16To32_555(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine16To32_565(BYTE *target, BYTE *source, int width_in_pixels);
void FreeImage_ConvertLine24To32(BYTE *target, BYTE *source, int width_in_pixels);

// Smart conversion routines ------------------------------------------------

FIBITMAP *FreeImage_ConvertTo4Bits(FIBITMAP *dib);
FIBITMAP *FreeImage_ConvertTo8Bits(FIBITMAP *dib);
FIBITMAP *FreeImage_ConvertToGreyscale(FIBITMAP *dib);
FIBITMAP *FreeImage_ConvertTo16Bits555(FIBITMAP *dib);
FIBITMAP *FreeImage_ConvertTo16Bits565(FIBITMAP *dib);
FIBITMAP *FreeImage_ConvertTo24Bits(FIBITMAP *dib);
FIBITMAP *FreeImage_ConvertTo32Bits(FIBITMAP *dib);
FIBITMAP *FreeImage_ColorQuantize(FIBITMAP *dib, FREE_IMAGE_QUANTIZE quantize);
FIBITMAP *FreeImage_ColorQuantizeEx(FIBITMAP *dib, FREE_IMAGE_QUANTIZE quantize = FREE_IMAGE_QUANTIZE.FIQ_WUQUANT, int PaletteSize = 256, int ReserveSize = 0, RGBQUAD *ReservePalette = NULL);
FIBITMAP *FreeImage_Threshold(FIBITMAP *dib, BYTE T);
FIBITMAP *FreeImage_Dither(FIBITMAP *dib, FREE_IMAGE_DITHER algorithm);

FIBITMAP *FreeImage_ConvertFromRawBits(BYTE *bits, int width, int height, int pitch, unsigned bpp, unsigned red_mask, unsigned green_mask, unsigned blue_mask, BOOL topdown = FALSE);
void FreeImage_ConvertToRawBits(BYTE *bits, FIBITMAP *dib, int pitch, unsigned bpp, unsigned red_mask, unsigned green_mask, unsigned blue_mask, BOOL topdown = FALSE);

FIBITMAP *FreeImage_ConvertToRGBF(FIBITMAP *dib);

FIBITMAP *FreeImage_ConvertToStandardType(FIBITMAP *src, BOOL scale_linear = TRUE);
FIBITMAP *FreeImage_ConvertToType(FIBITMAP *src, FREE_IMAGE_TYPE dst_type, BOOL scale_linear = TRUE);

// tone mapping operators
FIBITMAP *FreeImage_ToneMapping(FIBITMAP *dib, FREE_IMAGE_TMO tmo, double first_param = 0, double second_param = 0);
FIBITMAP* FreeImage_TmoDrago03(FIBITMAP *src, double gamma = 2.2, double exposure = 0);
FIBITMAP* FreeImage_TmoReinhard05(FIBITMAP *src, double intensity = 0, double contrast = 0);

// ZLib interface -----------------------------------------------------------

DWORD FreeImage_ZLibCompress(BYTE *target, DWORD target_size, BYTE *source, DWORD source_size);
DWORD FreeImage_ZLibUncompress(BYTE *target, DWORD target_size, BYTE *source, DWORD source_size);
DWORD FreeImage_ZLibGZip(BYTE *target, DWORD target_size, BYTE *source, DWORD source_size);
DWORD FreeImage_ZLibGUnzip(BYTE *target, DWORD target_size, BYTE *source, DWORD source_size);
DWORD FreeImage_ZLibCRC32(DWORD crc, BYTE *source, DWORD source_size);

// --------------------------------------------------------------------------
// Metadata routines --------------------------------------------------------
// --------------------------------------------------------------------------

// tag creation / destruction
FITAG *FreeImage_CreateTag();
void FreeImage_DeleteTag(FITAG *tag);
FITAG *FreeImage_CloneTag(FITAG *tag);

// tag getters and setters
char *FreeImage_GetTagKey(FITAG *tag);
char *FreeImage_GetTagDescription(FITAG *tag);
WORD FreeImage_GetTagID(FITAG *tag);
FREE_IMAGE_MDTYPE FreeImage_GetTagType(FITAG *tag);
DWORD FreeImage_GetTagCount(FITAG *tag);
DWORD FreeImage_GetTagLength(FITAG *tag);
void *FreeImage_GetTagValue(FITAG *tag);

BOOL FreeImage_SetTagKey(FITAG *tag, char *key);
BOOL FreeImage_SetTagDescription(FITAG *tag, char *description);
BOOL FreeImage_SetTagID(FITAG *tag, WORD id);
BOOL FreeImage_SetTagType(FITAG *tag, FREE_IMAGE_MDTYPE type);
BOOL FreeImage_SetTagCount(FITAG *tag, DWORD count);
BOOL FreeImage_SetTagLength(FITAG *tag, DWORD length);
BOOL FreeImage_SetTagValue(FITAG *tag, void *value);

// iterator
FIMETADATA *FreeImage_FindFirstMetadata(FREE_IMAGE_MDMODEL model, FIBITMAP *dib, FITAG **tag);
BOOL FreeImage_FindNextMetadata(FIMETADATA *mdhandle, FITAG **tag);
void FreeImage_FindCloseMetadata(FIMETADATA *mdhandle);

// metadata setter and getter
BOOL FreeImage_SetMetadata(FREE_IMAGE_MDMODEL model, FIBITMAP *dib, char *key, FITAG *tag);
BOOL FreeImage_GetMetadata(FREE_IMAGE_MDMODEL model, FIBITMAP *dib, char *key, FITAG **tag);

// helpers
unsigned FreeImage_GetMetadataCount(FREE_IMAGE_MDMODEL model, FIBITMAP *dib);

// tag to C string conversion
char* FreeImage_TagToString(FREE_IMAGE_MDMODEL model, FITAG *tag, char *Make = NULL);

// --------------------------------------------------------------------------
// Image manipulation toolkit -----------------------------------------------
// --------------------------------------------------------------------------

// rotation and flipping
FIBITMAP *FreeImage_RotateClassic(FIBITMAP *dib, double angle);
FIBITMAP *FreeImage_RotateEx(FIBITMAP *dib, double angle, double x_shift, double y_shift, double x_origin, double y_origin, BOOL use_mask);
BOOL FreeImage_FlipHorizontal(FIBITMAP *dib);
BOOL FreeImage_FlipVertical(FIBITMAP *dib);
BOOL FreeImage_JPEGTransform(char *src_file, char *dst_file, FREE_IMAGE_JPEG_OPERATION operation, BOOL perfect = FALSE);

// upsampling / downsampling
FIBITMAP *FreeImage_Rescale(FIBITMAP *dib, int dst_width, int dst_height, FREE_IMAGE_FILTER filter);
FIBITMAP *FreeImage_MakeThumbnail(FIBITMAP *dib, int max_pixel_size, BOOL convert = TRUE);

// color manipulation routines (point operations)
BOOL FreeImage_AdjustCurve(FIBITMAP *dib, BYTE *LUT, FREE_IMAGE_COLOR_CHANNEL channel);
BOOL FreeImage_AdjustGamma(FIBITMAP *dib, double gamma);
BOOL FreeImage_AdjustBrightness(FIBITMAP *dib, double percentage);
BOOL FreeImage_AdjustContrast(FIBITMAP *dib, double percentage);
BOOL FreeImage_Invert(FIBITMAP *dib);
BOOL FreeImage_GetHistogram(FIBITMAP *dib, DWORD *histo, FREE_IMAGE_COLOR_CHANNEL channel = FREE_IMAGE_COLOR_CHANNEL.FICC_BLACK);

// channel processing routines
FIBITMAP *FreeImage_GetChannel(FIBITMAP *dib, FREE_IMAGE_COLOR_CHANNEL channel);
BOOL FreeImage_SetChannel(FIBITMAP *dib, FIBITMAP *dib8, FREE_IMAGE_COLOR_CHANNEL channel);
FIBITMAP *FreeImage_GetComplexChannel(FIBITMAP *src, FREE_IMAGE_COLOR_CHANNEL channel);
BOOL FreeImage_SetComplexChannel(FIBITMAP *dst, FIBITMAP *src, FREE_IMAGE_COLOR_CHANNEL channel);

// copy / paste / composite routines
FIBITMAP *FreeImage_Copy(FIBITMAP *dib, int left, int top, int right, int bottom);
BOOL FreeImage_Paste(FIBITMAP *dst, FIBITMAP *src, int left, int top, int alpha);
FIBITMAP *FreeImage_Composite(FIBITMAP *fg, BOOL useFileBkg = FALSE, RGBQUAD *appBkColor = NULL, FIBITMAP *bg = NULL);
BOOL FreeImage_JPEGCrop(char *src_file, char *dst_file, int left, int top, int right, int bottom);



// Wrapper class ------------------------------------------------------------
alias char[] string;
class FreeImageBitmap
{
    FIBITMAP*   fib;

    this(string filename)
    {
        load(filename);
    }

    this(uint width, uint height, uint bpp)
    {
        fib = FreeImage_Allocate(width, height, bpp);
    }

    ~this()
    {
        FreeImage_Unload(fib);
    }

    void load(string filename)
    {
        FREE_IMAGE_FORMAT format = FreeImage_GetFileType((filename~\0).ptr);
        if ( format == FREE_IMAGE_FORMAT.FIF_PCX || format == FREE_IMAGE_FORMAT.FIF_UNKNOWN )
            return;
        fib = FreeImage_Load(
            format,
            (filename~\0).ptr
        );
    }

    bool save(string filename)
    {
        if ( !isValid )
            return false;
        return cast(bool)FreeImage_Save(
            FREE_IMAGE_FORMAT.FIF_PNG,
            fib, (filename~\0).ptr
        );
    }

    bool isValid()
    {
        return fib !is null;
    }

    uint width()
    {
        return FreeImage_GetWidth(fib);
    }

    uint height()
    {
        return FreeImage_GetHeight(fib);
    }

    uint bpp()
    {
        return FreeImage_GetBPP(fib);
    }

    ubyte* bits()
    {
        return FreeImage_GetBits(fib);
    }
}

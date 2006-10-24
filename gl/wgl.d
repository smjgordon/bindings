module c.gl.wgl;

version (Windows) {
private import c.gl.gl;
private import std.c.windows.windows, std.loader;
import c.gl.wglext;

/*
 * Constants
 */
const ubyte WGL_FONT_LINES	= 0;
const ubyte WGL_FONT_POLYGONS	= 1;

const ubyte LPD_TYPE_RGBA	= 0;
const ubyte LPD_TYPE_COLORINDEX	= 1;

// wglSwapLayerBuffers flags
const uint WGL_SWAP_MAIN_PLANE	= 0x00000001;
const uint WGL_SWAP_OVERLAY1	= 0x00000002;
const uint WGL_SWAP_OVERLAY2	= 0x00000004;
const uint WGL_SWAP_OVERLAY3	= 0x00000008;
const uint WGL_SWAP_OVERLAY4	= 0x00000010;
const uint WGL_SWAP_OVERLAY5	= 0x00000020;
const uint WGL_SWAP_OVERLAY6	= 0x00000040;
const uint WGL_SWAP_OVERLAY7	= 0x00000080;
const uint WGL_SWAP_OVERLAY8	= 0x00000100;
const uint WGL_SWAP_OVERLAY9	= 0x00000200;
const uint WGL_SWAP_OVERLAY10	= 0x00000400;
const uint WGL_SWAP_OVERLAY11	= 0x00000800;
const uint WGL_SWAP_OVERLAY12	= 0x00001000;
const uint WGL_SWAP_OVERLAY13	= 0x00002000;
const uint WGL_SWAP_OVERLAY14	= 0x00004000;
const uint WGL_SWAP_OVERLAY15	= 0x00008000;
const uint WGL_SWAP_UNDERLAY1	= 0x00010000;
const uint WGL_SWAP_UNDERLAY2	= 0x00020000;
const uint WGL_SWAP_UNDERLAY3	= 0x00040000;
const uint WGL_SWAP_UNDERLAY4	= 0x00080000;
const uint WGL_SWAP_UNDERLAY5	= 0x00100000;
const uint WGL_SWAP_UNDERLAY6	= 0x00200000;
const uint WGL_SWAP_UNDERLAY7	= 0x00400000;
const uint WGL_SWAP_UNDERLAY8	= 0x00800000;
const uint WGL_SWAP_UNDERLAY9	= 0x01000000;
const uint WGL_SWAP_UNDERLAY10	= 0x02000000;
const uint WGL_SWAP_UNDERLAY11	= 0x04000000;
const uint WGL_SWAP_UNDERLAY12	= 0x08000000;
const uint WGL_SWAP_UNDERLAY13	= 0x10000000;
const uint WGL_SWAP_UNDERLAY14	= 0x20000000;
const uint WGL_SWAP_UNDERLAY15	= 0x40000000;

// LAYERPLANEDESCRIPTOR flags
const uint LPD_DOUBLEBUFFER	= 0x00000001;
const uint LPD_STEREO		= 0x00000002;
const uint LPD_SUPPORT_GDI	= 0x00000010;
const uint LPD_SUPPORT_OPENGL	= 0x00000020;
const uint LPD_SHARE_DEPTH	= 0x00000040;
const uint LPD_SHARE_STENCIL	= 0x00000080;
const uint LPD_SHARE_ACCUM	= 0x00000100;
const uint LPD_SWAP_EXCHANGE	= 0x00000200;
const uint LPD_SWAP_COPY	= 0x00000400;
const uint LPD_TRANSPARENT	= 0x00001000;

/*
 * Structs and classes
 */
struct _POINTFLOAT {
	FLOAT		x;
	FLOAT		y;
}
alias _POINTFLOAT POINTFLOAT;
alias _POINTFLOAT* PPOINTFLOAT;

struct _GLYPHMETRICSFLOAT {
	FLOAT		gmfBlackBoxX;
	FLOAT		gmfBlackBoxY;
	POINTFLOAT	gmfptGlyphOrigin;
	FLOAT		gmfCellIncX;
	FLOAT		gmfCellIncY;
}
alias _GLYPHMETRICSFLOAT GLYPHMETRICSFLOAT;
alias _GLYPHMETRICSFLOAT* PGLYPHMETRICSFLOAT, LPGLYPHMETRICSFLOAT;

struct tagLAYERPLANEDESCRIPTOR {
	WORD		nSize;
	WORD		nVersion;
	DWORD		dwFlags;
	BYTE		iPixelType;
	BYTE		cColorBits;
	BYTE		cRedBits;
	BYTE		cRedShift;
	BYTE		cGreenBits;
	BYTE		cGreenShift;
	BYTE		cBlueBits;
	BYTE		cBlueShift;
	BYTE		cAlphaBits;
	BYTE		cAlphaShift;
	BYTE		cAccumBits;
	BYTE		cAccumRedBits;
	BYTE		cAccumGreenBits;
	BYTE		cAccumBlueBits;
	BYTE		cAccumAlphaBits;
	BYTE		cDepthBits;
	BYTE		cStencilBits;
	BYTE		cAuxBuffers;
	BYTE		iLayerPlane;
	BYTE		bReserved;
	COLORREF	crTransparent;
}
alias tagLAYERPLANEDESCRIPTOR LAYERPLANEDESCRIPTOR;
alias tagLAYERPLANEDESCRIPTOR* PLAYERPLANEDESCRIPTOR, LPLAYERPLANEDESCRIPTOR;

/*
 * Functions
 */
private HXModule wgldrv;
private void* getProc(char[] procname) {
	void* symbol = ExeModule_GetSymbol(wgldrv, procname);
	if (symbol is null) {
		printf ("Failed to load WGL proc address " ~ procname ~ ".\n");
	}
	return (symbol);
}

static this () {
	wgldrv = ExeModule_Load("OpenGL32.dll");
//	SwapBuffers = cast(pfSwapBuffers)getProc("SwapBuffers");
	wglCopyContext = cast(pfwglCopyContext)getProc("wglCopyContext");
	wglCreateContext = cast(pfwglCreateContext)getProc("wglCreateContext");
	wglCreateLayerContext = cast(pfwglCreateLayerContext)getProc("wglCreateLayerContext");
	wglDeleteContext = cast(pfwglDeleteContext)getProc("wglDeleteContext");
	wglDescribeLayerPlane = cast(pfwglDescribeLayerPlane)getProc("wglDescribeLayerPlane");
	wglGetCurrentContext = cast(pfwglGetCurrentContext)getProc("wglGetCurrentContext");
	wglGetCurrentDC = cast(pfwglGetCurrentDC)getProc("wglGetCurrentDC");
	wglGetLayerPaletteEntries = cast(pfwglGetLayerPaletteEntries)getProc("wglGetLayerPaletteEntries");
	wglGetProcAddress = cast(pfwglGetProcAddress)getProc("wglGetProcAddress");
	wglMakeCurrent = cast(pfwglMakeCurrent)getProc("wglMakeCurrent");
	wglRealizeLayerPalette = cast(pfwglRealizeLayerPalette)getProc("wglRealizeLayerPalette");
	wglSetLayerPaletteEntries = cast(pfwglSetLayerPaletteEntries)getProc("wglSetLayerPaletteEntries");
	wglShareLists = cast(pfwglShareLists)getProc("wglShareLists");
	wglSwapLayerBuffers = cast(pfwglSwapLayerBuffers)getProc("wglSwapLayerBuffers");
	wglUseFontBitmapsA = cast(pfwglUseFontBitmapsA)getProc("wglUseFontBitmapsA");
	wglUseFontBitmapsW = cast(pfwglUseFontBitmapsW)getProc("wglUseFontBitmapsW");
	wglUseFontOutlinesA = cast(pfwglUseFontOutlinesA)getProc("wglUseFontOutlinesA");
	wglUseFontOutlinesW = cast(pfwglUseFontOutlinesW)getProc("wglUseFontOutlinesW");
}

static ~this () {
	ExeModule_Release(wgldrv);
}

/*
 * Functions
 */
extern (Windows):
typedef BOOL function(HDC) pfSwapBuffers;
typedef BOOL function(HGLRC, HGLRC, UINT) pfwglCopyContext;
typedef HGLRC function(HDC) pfwglCreateContext;
typedef HGLRC function(HDC, GLint) pfwglCreateLayerContext;
typedef BOOL function(HGLRC) pfwglDeleteContext;
typedef BOOL function(HDC, GLint, GLint, UINT, LPLAYERPLANEDESCRIPTOR) pfwglDescribeLayerPlane;
typedef HGLRC function() pfwglGetCurrentContext;
typedef HDC function() pfwglGetCurrentDC;
typedef int function(HDC, GLint, GLint, GLint, COLORREF*) pfwglGetLayerPaletteEntries;
typedef FARPROC function(LPCSTR) pfwglGetProcAddress;
typedef BOOL function(HDC, HGLRC) pfwglMakeCurrent;
typedef BOOL function(HDC, GLint, BOOL) pfwglRealizeLayerPalette;
typedef int function(HDC, GLint, GLint, GLint, COLORREF*) pfwglSetLayerPaletteEntries;
typedef BOOL function(HGLRC, HGLRC) pfwglShareLists;
typedef BOOL function(HDC, UINT) pfwglSwapLayerBuffers;
typedef BOOL function(HDC, DWORD, DWORD, DWORD) pfwglUseFontBitmapsA;
typedef BOOL function(HDC, DWORD, DWORD, DWORD) pfwglUseFontBitmapsW;
typedef BOOL function(HDC, DWORD, DWORD, DWORD, FLOAT, FLOAT, GLint, LPGLYPHMETRICSFLOAT) pfwglUseFontOutlinesA;
typedef BOOL function(HDC, DWORD, DWORD, DWORD, FLOAT, FLOAT, GLint, LPGLYPHMETRICSFLOAT) pfwglUseFontOutlinesW;

pfSwapBuffers			SwapBuffers;
pfwglCopyContext		wglCopyContext;
pfwglCreateContext		wglCreateContext;
pfwglCreateLayerContext		wglCreateLayerContext;
pfwglDeleteContext		wglDeleteContext;
pfwglDescribeLayerPlane		wglDescribeLayerPlane;
pfwglGetCurrentContext		wglGetCurrentContext;
pfwglGetCurrentDC		wglGetCurrentDC;
pfwglGetLayerPaletteEntries	wglGetLayerPaletteEntries;
pfwglGetProcAddress		wglGetProcAddress;
pfwglMakeCurrent		wglMakeCurrent;
pfwglRealizeLayerPalette	wglRealizeLayerPalette;
pfwglSetLayerPaletteEntries	wglSetLayerPaletteEntries;
pfwglShareLists			wglShareLists;
pfwglSwapLayerBuffers		wglSwapLayerBuffers;
pfwglUseFontBitmapsA		wglUseFontBitmapsA;
pfwglUseFontBitmapsW		wglUseFontBitmapsW;
pfwglUseFontOutlinesA		wglUseFontOutlinesA;
pfwglUseFontOutlinesW		wglUseFontOutlinesW;

version (UNICODE) {
	alias wglUseFontBitmapsW  wglUseFontBitmaps;
	alias wglUseFontOutlinesW wglUseFontOutlines;
} else {
	alias wglUseFontBitmapsA  wglUseFontBitmaps;
	alias wglUseFontOutlinesA wglUseFontOutlines;
}
}
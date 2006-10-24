module c.gl.glx;

/*
 * Mesa 3-D graphics library
 * Version:  6.3
 * 
 * Copyright (C) 1999-2005  Brian Paul   All Rights Reserved.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * BRIAN PAUL BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

version (linux) {
import c.gl.glxext;
private import std.loader;

/*
 * Constants
 */
const GLchar[] GLX_EXTENSION_NAME	= "GLX";

// Names for attributes to glXGetConfig.
const GLuint GLX_USE_GL			= 1;
const GLuint GLX_BUFFER_SIZE		= 2;
const GLuint GLX_LEVEL			= 3;
const GLuint GLX_RGBA			= 4;
const GLuint GLX_DOUBLEBUFFER		= 5;
const GLuint GLX_STEREO			= 6;
const GLuint GLX_AUX_BUFFERS		= 7;
const GLuint GLX_RED_SIZE		= 8;
const GLuint GLX_GREEN_SIZE		= 9;
const GLuint GLX_BLUE_SIZE		= 10;
const GLuint GLX_ALPHA_SIZE		= 11;
const GLuint GLX_DEPTH_SIZE		= 12;
const GLuint GLX_STENCIL_SIZE		= 13;
const GLuint GLX_ACCUM_RED_SIZE		= 14;
const GLuint GLX_ACCUM_GREEN_SIZE	= 15;
const GLuint GLX_ACCUM_BLUE_SIZE	= 16;
const GLuint GLX_ACCUM_ALPHA_SIZE	= 17;

// Error return values from glXGetConfig.  Success is indicated by a value of 0.
const GLuint GLX_BAD_SCREEN		= 1;
const GLuint GLX_BAD_ATTRIBUTE		= 2;
const GLuint GLX_NO_EXTENSION		= 3;
const GLuint GLX_BAD_VISUAL		= 4;
const GLuint GLX_BAD_CONTEXT		= 5;
const GLuint GLX_BAD_VALUE		= 6;
const GLuint GLX_BAD_ENUM		= 7;

// Version 1.1
const GLuint GLX_VENDOR			= 1;
const GLuint GLX_VERSION		= 2;
const GLuint GLX_EXTENSIONS		= 3;

// Version 1.3
const GLuint GLX_CONFIG_CAVEAT		= 0x20;
const GLuint GLX_DONT_CARE		= 0xFFFFFFFF;
const GLuint GLX_X_VISUAL_TYPE		= 0x22;
const GLuint GLX_TRANSPARENT_TYPE	= 0x23;
const GLuint GLX_TRANSPARENT_INDEX_VALUE= 0x24;
const GLuint GLX_TRANSPARENT_RED_VALUE	= 0x25;
const GLuint GLX_TRANSPARENT_GREEN_VALUE= 0x26;
const GLuint GLX_TRANSPARENT_BLUE_VALUE	= 0x27;
const GLuint GLX_TRANSPARENT_ALPHA_VALUE= 0x28;
const GLuint GLX_WINDOW_BIT		= 0x00000001;
const GLuint GLX_PIXMAP_BIT		= 0x00000002;
const GLuint GLX_PBUFFER_BIT		= 0x00000004;
const GLuint GLX_AUX_BUFFERS_BIT	= 0x00000010;
const GLuint GLX_FRONT_LEFT_BUFFER_BIT	= 0x00000001;
const GLuint GLX_FRONT_RIGHT_BUFFER_BIT	= 0x00000002;
const GLuint GLX_BACK_LEFT_BUFFER_BIT	= 0x00000004;
const GLuint GLX_BACK_RIGHT_BUFFER_BIT	= 0x00000008;
const GLuint GLX_DEPTH_BUFFER_BIT	= 0x00000020;
const GLuint GLX_STENCIL_BUFFER_BIT	= 0x00000040;
const GLuint GLX_ACCUM_BUFFER_BIT	= 0x00000080;
const GLuint GLX_NONE			= 0x8000;
const GLuint GLX_SLOW_CONFIG		= 0x8001;
const GLuint GLX_TRUE_COLOR		= 0x8002;
const GLuint GLX_DIRECT_COLOR		= 0x8003;
const GLuint GLX_PSEUDO_COLOR		= 0x8004;
const GLuint GLX_STATIC_COLOR		= 0x8005;
const GLuint GLX_GRAY_SCALE		= 0x8006;
const GLuint GLX_STATIC_GRAY		= 0x8007;
const GLuint GLX_TRANSPARENT_RGB	= 0x8008;
const GLuint GLX_TRANSPARENT_INDEX	= 0x8009;
const GLuint GLX_VISUAL_ID		= 0x800B;
const GLuint GLX_SCREEN			= 0x800C;
const GLuint GLX_NON_CONFORMANT_CONFIG	= 0x800D;
const GLuint GLX_DRAWABLE_TYPE		= 0x8010;
const GLuint GLX_RENDER_TYPE		= 0x8011;
const GLuint GLX_X_RENDERABLE		= 0x8012;
const GLuint GLX_FBCONFIG_ID		= 0x8013;
const GLuint GLX_RGBA_TYPE		= 0x8014;
const GLuint GLX_COLOR_INDEX_TYPE	= 0x8015;
const GLuint GLX_MAX_PBUFFER_WIDTH	= 0x8016;
const GLuint GLX_MAX_PBUFFER_HEIGHT	= 0x8017;
const GLuint GLX_MAX_PBUFFER_PIXELS	= 0x8018;
const GLuint GLX_PRESERVED_CONTENTS	= 0x801B;
const GLuint GLX_LARGEST_PBUFFER	= 0x801C;
const GLuint GLX_WIDTH			= 0x801D;
const GLuint GLX_HEIGHT			= 0x801E;
const GLuint GLX_EVENT_MASK		= 0x801F;
const GLuint GLX_DAMAGED		= 0x8020;
const GLuint GLX_SAVED			= 0x8021;
const GLuint GLX_WINDOW			= 0x8022;
const GLuint GLX_PBUFFER		= 0x8023;
const GLuint GLX_PBUFFER_HEIGHT		= 0x8040;
const GLuint GLX_PBUFFER_WIDTH		= 0x8041;
const GLuint GLX_RGBA_BIT		= 0x00000001;
const GLuint GLX_COLOR_INDEX_BIT	= 0x00000002;
const GLuint GLX_PBUFFER_CLOBBER_MASK	= 0x08000000;

// Version 1.4
const GLuint  GLX_SAMPLE_BUFFERS	= 0x186a0;
const GLuint  GLX_SAMPLES		= 0x186a1;

/*
 * Structs and classes
 */
alias uint XID;

struct __GLXcontextRec;
struct __GLXFBConfigRec;
alias __GLXcontextRec* GLXContext;
alias __GLXFBConfigRec* GLXFBConfig;
alias XID GLXPixmap;
alias XID GLXDrawable;
alias XID GLXFBConfigID;
alias XID GLXContentID;
alias XID GLXWindow;
alias XID GLXPbuffer;

alias int Bool;
alias uint VisualID;
alias byte* XPointer;
alias GLvoid Display;
alias XID Pixmap;
alias XID Font;
alias XID Window;

struct XExtData {
	int			number;
	XExtData*		next;
	int function(XExtData*)	free_private;
	XPointer		private_data;
}

struct Visual {
	XExtData*	ext_data;
	VisualID	visualid;
	int		_class;
	uint		red_mask, green_mask, blue_mask;
	int		bits_per_rgb;
	int		map_entries;
}

struct XVisualInfo {
	Visual*		visual;
	VisualID	visualid;
	int		screen;
	int		depth;
	int		_class;
	uint		red_mask, green_mask, blue_mask;
	int		colormap_size;
	int		bits_per_rgb;
}

struct GLXPbufferClobberEvent {
	int		event_type;
	int		draw_type;
	uint		serial;
	Bool		send_event;
	Display*	display;
	GLXDrawable	drawable;
	uint		buffer_mask;
	uint		aux_buffer;
	int		x, y;
	int		width, height;
	int		count;
}

union GLXEvent {
	GLXPbufferClobberEvent	glxpbufferclobber;
	int[24]			pad;
}

class XVisualInfo {
	int bits_per_rgb;
	int colormap_size;
	int blue_mask;
	int green_mask;
	int red_mask;
	int cllass;
	int depth;
	int screen;
	int visualid;
	int visual;
}

/*
 * Functions
 */

private HXModule glxdrv;
private void* getProc(char[] procname) {
	void* symbol = ExeModule_GetSymbol(glxdrv, procname);
	if (symbol is null) {
		printf ("Failed to load GLX proc address " ~ procname ~ ".\n");
	}
	return (symbol);
}

static this () {
	glxdrv = ExeModule_Load("libGLX.so");
	glXChooseFBConfig = cast(pfglXChooseFBConfig)getProc("glXChooseFBConfig");
	glXChooseVisual = cast(pfglXChooseVisual)getProc("glXChooseVisual");
	glXCopyContext = cast(pfglXCopyContext)getProc("glXCopyContext");
	glXCreateContext = cast(pfglXCreateContext)getProc("glXCreateContext");
	glXCreateGLXPixmap = cast(pfglXCreateGLXPixmap)getProc("glXCreateGLXPixmap");
	glXCreateNewContext = cast(pfglXCreateNewContext)getProc("glXCreateNewContext");
	glXCreatePbuffer = cast(pfglXCreatePbuffer)getProc("glXCreatePbuffer");
	glXCreatePixmap = cast(pfglXCreatePixmap)getProc("glXCreatePixmap");
	glXCreateWindow = cast(pfglXCreateWindow)getProc("glXCreateWindow");
	glXDestroyContext = cast(pfglXDestroyContext)getProc("glXDestroyContext");
	glXDestroyGLXPixmap = cast(pfglXDestroyGLXPixmap)getProc("glXDestroyGLXPixmap");
	glXDestroyPbuffer = cast(pfglXDestroyPbuffer)getProc("glXDestroyPbuffer");
	glXDestroyPixmap = cast(pfglXDestroyPixmap)getProc("glXDestroyPixmap");
	glXDestroyWindow = cast(pfglXDestroyWindow)getProc("glXDestroyWindow");
	glXGetClientString = cast(pfglXGetClientString)getProc("glXGetClientString");
	glXGetConfig = cast(pfglXGetConfig)getProc("glXGetConfig");
	glXGetCurrentContext = cast(pfglXGetCurrentContext)getProc("glXGetCurrentContext");
	glXGetCurrentDisplay = cast(pfglXGetCurrentDisplay)getProc("glXGetCurrentDisplay");
	glXGetCurrentDrawable = cast(pfglXGetCurrentDrawable)getProc("glXGetCurrentDrawable");
	glXGetCurrentReadDrawable = cast(pfglXGetCurrentReadDrawable)getProc("glXGetCurrentReadDrawable");
	glXGetFBConfigAttrib = cast(pfglXGetFBConfigAttrib)getProc("glXGetFBConfigAttrib");
	glXGetFBConfigs = cast(pfglXGetFBConfigs)getProc("glXGetFBConfigs");
	glXGetSelectedEvent = cast(pfglXGetSelectedEvent)getProc("glXGetSelectedEvent");
	glXGetVisualFromFBConfig = cast(pfglXGetVisualFromFBConfig)getProc("glXGetVisualFromFBConfig");
	glXIsDirect = cast(pfglXIsDirect)getProc("glXIsDirect");
	glXMakeContextCurrent = cast(pfglXMakeContextCurrent)getProc("glXMakeContextCurrent");
	glXMakeCurrent = cast(pfglXMakeCurrent)getProc("glXMakeCurrent");
	glXQueryContext = cast(pfglXQueryContext)getProc("glXQueryContext");
	glXQueryDrawable = cast(pfglXQueryDrawable)getProc("glXQueryDrawable");
	glXQueryExtension = cast(pfglXQueryExtension)getProc("glXQueryExtension");
	glXQueryExtensionsString = cast(pfglXQueryExtensionsString)getProc("glXQueryExtensionsString");
	glXQueryServerString = cast(pfglXQueryServerString)getProc("glXQueryServerString");
	glXQueryVersion = cast(pfglXQueryVersion)getProc("glXQueryVersion");
	glXSelectEvent = cast(pfglXSelectEvent)getProc("glXSelectEvent");
	glXSwapBuffers = cast(pfglXSwapBuffers)getProc("glXSwapBuffers");
	glXUseXFont = cast(pfglXUseXFont)getProc("glXUseXFont");
	glXWaitGL = cast(pfglXWaitGL)getProc("glXWaitGL");
	glXWaitX = cast(pfglXWaitX)getProc("glXWaitX");
}

static ~this () {
	ExeModule_Release(glxdrv);
}

extern (C):
typedef GLXFBConfig* function(Display*, GLint, GLint*, GLint*) pfglXChooseFBConfig;
typedef XVisualInfo* function(Display*, GLint, GLint*) pfglXChooseVisual;
typedef GLvoid function(Display*, GLXContext, GLXContext, GLuint) pfglXCopyContext;
typedef GLXContext function(Display*, XVisualInfo*, GLXContext, Bool) pfglXCreateContext;
typedef GLXPixmap function(Display*, XVisualInfo*, Pixmap) pfglXCreateGLXPixmap;
typedef GLXContext function(Display*, GLXFBConfig, GLint, GLXContext, Bool) pfglXCreateNewContext;
typedef GLXPbuffer function(Display*, GLXFBConfig, GLint*) pfglXCreatePbuffer;
typedef GLXPixmap function(Display*, GLXFBConfig, Pixmap, GLint*) pfglXCreatePixmap;
typedef GLXWindow function(Display*, GLXFBConfig, Window, GLint*) pfglXCreateWindow;
typedef GLvoid function(Display*, GLXContext) pfglXDestroyContext;
typedef GLvoid function(Display*, GLXPixmap) pfglXDestroyGLXPixmap;
typedef GLvoid function(Display*, GLXPbuffer) pfglXDestroyPbuffer;
typedef GLvoid function(Display*, GLXPixmap) pfglXDestroyPixmap;
typedef GLvoid function(Display*, GLXWindow) pfglXDestroyWindow;
typedef GLchar* function(Display*, GLint) pfglXGetClientString;
typedef GLint function(Display*, XVisualInfo*, GLint, GLint*) pfglXGetConfig;
typedef GLXContext function() pfglXGetCurrentContext;
typedef Display* function() pfglXGetCurrentDisplay;
typedef GLXDrawable function() pfglXGetCurrentDrawable;
typedef GLXDrawable function() pfglXGetCurrentReadDrawable;
typedef GLint function(Display*, GLXFBConfig, GLint, GLint*) pfglXGetFBConfigAttrib;
typedef GLXFBConfig* function(Display*, GLint, GLint*) pfglXGetFBConfigs;
typedef GLvoid function(Display*, GLXDrawable, GLulong*) pfglXGetSelectedEvent;
typedef XVisualInfo* function(Display*, GLXFBConfig) pfglXGetVisualFromFBConfig;
typedef Bool function(Display*, GLXContext) pfglXIsDirect;
typedef Bool function(Display*, GLXDrawable, GLXDrawable, GLXContext) pfglXMakeContextCurrent;
typedef Bool function(Display*, GLXDrawable, GLXContext) pfglXMakeCurrent;
typedef GLint function(Display*, GLXContext, GLint, GLint*) pfglXQueryContext;
typedef GLint function(Display*, GLXDrawable, GLint, GLuint*) pfglXQueryDrawable;
typedef Bool function(Display*, GLint*, GLint*) pfglXQueryExtension;
typedef GLchar* function(Display*, GLint) pfglXQueryExtensionsString;
typedef GLchar* function(Display*, GLint, GLint) pfglXQueryServerString;
typedef Bool function(Display*, GLint*, GLint*) pfglXQueryVersion;
typedef GLvoid function(Display*, GLXDrawable, GLulong) pfglXSelectEvent;
typedef GLvoid function(Display*, GLXDrawable) pfglXSwapBuffers;
typedef GLvoid function(Font, GLint, GLint, GLint) pfglXUseXFont;
typedef GLvoid function() pfglXWaitGL;
typedef GLvoid function() pfglXWaitX;

pfglXChooseFBConfig		glXChooseFBConfig;
pfglXChooseVisual		glXChooseVisual;
pfglXCopyContext		glXCopyContext;
pfglXCreateContext		glXCreateContext;
pfglXCreateGLXPixmap		glXCreateGLXPixmap;
pfglXCreateNewContext		glXCreateNewContext;
pfglXCreatePbuffer		glXCreatePbuffer;
pfglXCreatePixmap		glXCreatePixmap;
pfglXCreateWindow		glXCreateWindow;
pfglXDestroyContext		glXDestroyContext;
pfglXDestroyGLXPixmap		glXDestroyGLXPixmap;
pfglXDestroyPbuffer		glXDestroyPbuffer;
pfglXDestroyPixmap		glXDestroyPixmap;
pfglXDestroyWindow		glXDestroyWindow;
pfglXGetClientString		glXGetClientString;
pfglXGetConfig			glXGetConfig;
pfglXGetCurrentContext		glXGetCurrentContext;
pfglXGetCurrentDisplay		glXGetCurrentDisplay;
pfglXGetCurrentDrawable		glXGetCurrentDrawable;
pfglXGetCurrentReadDrawable	glXGetCurrentReadDrawable;
pfglXGetFBConfigAttrib		glXGetFBConfigAttrib;
pfglXGetFBConfigs		glXGetFBConfigs;
pfglXGetSelectedEvent		glXGetSelectedEvent;
pfglXGetVisualFromFBConfig	glXGetVisualFromFBConfig;
pfglXIsDirect			glXIsDirect;
pfglXMakeContextCurrent		glXMakeContextCurrent;
pfglXMakeCurrent		glXMakeCurrent;
pfglXQueryContext		glXQueryContext;
pfglXQueryDrawable		glXQueryDrawable;
pfglXQueryExtension		glXQueryExtension;
pfglXQueryExtensionsString	glXQueryExtensionsString;
pfglXQueryServerString		glXQueryServerString;
pfglXQueryVersion		glXQueryVersion;
pfglXSelectEvent		glXSelectEvent;
pfglXSwapBuffers		glXSwapBuffers;
pfglXUseXFont			glXUseXFont;
pfglXWaitGL			glXWaitGL;
pfglXWaitX			glXWaitX;
}
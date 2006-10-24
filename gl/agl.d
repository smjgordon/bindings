module c.gl.agl;

/*
    File:	AGL/agl.h and more

    Contains:	Basic AGL data types, constants and function prototypes.

    Version:	Technology:	Mac OS X
                Release:	GM
 
     Copyright:	(c) 2000, 2001, 2002, 2003 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:	For bug reports, consult the following page on
		the World Wide Web:
 
		http://developer.apple.com/bugreporter/
*/

version (darwin) {
private import c.gl.gl;

/*
 * Constants
 */
// Renderer ID numbers
const uint AGL_RENDERER_GENERIC_ID		= 0x00020200;
const uint AGL_RENDERER_APPLE_SW_ID		= 0x00020600;
const uint AGL_RENDERER_ATI_RAGE_128_ID		= 0x00021000;
const uint AGL_RENDERER_ATI_RADEON_ID		= 0x00021200;
const uint AGL_RENDERER_ATI_RAGE_PRO_ID		= 0x00021400;
const uint AGL_RENDERER_ATI_RADEON_8500_ID	= 0x00021600;
const uint AGL_RENDERER_NVIDIA_GEFORCE_2MX_ID	= 0x00022000; /* also for GeForce 4MX */
const uint AGL_RENDERER_NVIDIA_GEFORCE_3_ID	= 0x00022200; /* also for GeForce 4 Ti */
const uint AGL_RENDERER_MESA_3DFX_ID		= 0x00040000;

const uint AGL_NONE				= 0;
const uint AGL_ALL_RENDERERS			= 1; /* choose from all available renderers */
const uint AGL_BUFFER_SIZE			= 2; /* depth of the index buffer */
const uint AGL_LEVEL				= 3; /* level in plane stacking */
const uint AGL_RGBA				= 4; /* choose an RGBA format */
const uint AGL_DOUBLEBUFFER			= 5; /* double buffering supported */
const uint AGL_STEREO				= 6; /* stereo buffering supported */
const uint AGL_AUX_BUFFERS			= 7; /* number of aux buffers */
const uint AGL_RED_SIZE				= 8; /* number of red component bits */
const uint AGL_GREEN_SIZE			= 9; /* number of green component bits */
const uint AGL_BLUE_SIZE			= 10; /* number of blue component bits */
const uint AGL_ALPHA_SIZE			= 11; /* number of alpha component bits */
const uint AGL_DEPTH_SIZE			= 12; /* number of depth bits */
const uint AGL_STENCIL_SIZE			= 13; /* number of stencil bits */
const uint AGL_ACCUM_RED_SIZE			= 14; /* number of red accum bits */
const uint AGL_ACCUM_GREEN_SIZE			= 15; /* number of green accum bits */
const uint AGL_ACCUM_BLUE_SIZE			= 16; /* number of blue accum bits */
const uint AGL_ACCUM_ALPHA_SIZE			= 17; /* number of alpha accum bits */


const uint AGL_PIXEL_SIZE			= 50; /* frame buffer bits per pixel */
const uint AGL_MINIMUM_POLICY			= 51; /* never choose smaller buffers than requested */
const uint AGL_MAXIMUM_POLICY			= 52; /* choose largest buffers of type requested */
const uint AGL_OFFSCREEN			= 53; /* choose an off-screen capable renderer */
const uint AGL_FULLSCREEN			= 54; /* choose a full-screen capable renderer */
const uint AGL_SAMPLE_BUFFERS_ARB		= 55; /* number of multi sample buffers */
const uint AGL_SAMPLES_ARB			= 56; /* number of samples per multi sample buffer */
const uint AGL_AUX_DEPTH_STENCIL		= 57; /* independent depth and/or stencil buffers for the aux buffer */

const uint AGL_RENDERER_ID			= 70; /* request renderer by ID */
const uint AGL_SINGLE_RENDERER			= 71; /* choose a single renderer for all screens */
const uint AGL_NO_RECOVERY			= 72; /* disable all failure recovery systems */
const uint AGL_ACCELERATED			= 73; /* choose a hardware accelerated renderer */
const uint AGL_CLOSEST_POLICY			= 74; /* choose the closest color buffer to request */
const uint AGL_ROBUST				= 75; /* renderer does not need failure recovery */
const uint AGL_BACKING_STORE			= 76; /* back buffer contents are valid after swap */
const uint AGL_MP_SAFE				= 78; /* renderer is multi-processor safe */

const uint AGL_WINDOW				= 80; /* can be used to render to an onscreen window */
const uint AGL_MULTISCREEN			= 81; /* single window can span multiple screens */
const uint AGL_VIRTUAL_SCREEN			= 82; /* virtual screen number */
const uint AGL_COMPLIANT			= 83; /* renderer is opengl compliant */

/* const uint AGL_OFFSCREEN			= 53; */
/* const uint AGL_FULLSCREEN			= 54; */
/* const uint AGL_RENDERER_ID			= 70; */
/* const uint AGL_ACCELERATED			= 73; */
/* const uint AGL_ROBUST			= 75; */
/* const uint AGL_BACKING_STORE			= 76; */
/* const uint AGL_MP_SAFE			= 78; */
/* const uint AGL_WINDOW			= 80; */
/* const uint AGL_MULTISCREEN			= 81; */
/* const uint AGL_COMPLIANT			= 83; */
const uint AGL_BUFFER_MODES			= 100;
const uint AGL_MIN_LEVEL			= 101;
const uint AGL_MAX_LEVEL			= 102;
const uint AGL_COLOR_MODES			= 103;
const uint AGL_ACCUM_MODES			= 104;
const uint AGL_DEPTH_MODES			= 105;
const uint AGL_STENCIL_MODES			= 106;
const uint AGL_MAX_AUX_BUFFERS			= 107;
const uint AGL_VIDEO_MEMORY			= 120;
const uint AGL_TEXTURE_MEMORY			= 121;

const uint AGL_SWAP_RECT			= 200; /* Enable or set the swap rectangle */
const uint AGL_BUFFER_RECT			= 202; /* Enable or set the buffer rectangle */
const uint AGL_SWAP_LIMIT			= 203; /* Enable or disable the swap async limit */
const uint AGL_COLORMAP_TRACKING		= 210; /* Enable or disable colormap tracking */
const uint AGL_COLORMAP_ENTRY			= 212; /* Set a colormap entry to {index, r, g, b} */
const uint AGL_RASTERIZATION			= 220; /* Enable or disable all rasterization */
const uint AGL_SWAP_INTERVAL			= 222; /* 0 -> Don't sync, n -> Sync every n retrace */
const uint AGL_STATE_VALIDATION			= 230; /* Validate state for multi-screen functionality */
const uint AGL_BUFFER_NAME			= 231; /* Set the buffer name. Allows for multi ctx to share a buffer */
const uint AGL_ORDER_CONTEXT_TO_FRONT		= 232; /* Order the current context in front of all the other contexts. */
const uint AGL_CONTEXT_SURFACE_ID		= 233; /* aglGetInteger only - returns the ID of the drawable surface for the context */
const uint AGL_CONTEXT_DISPLAY_ID		= 234; /* aglGetInteger only - returns the display ID(s) of all displays touched by the context, up to a maximum of 32 displays */
const uint AGL_SURFACE_ORDER			= 235; /* Position of OpenGL surface relative to window: 1 -> Above window, -1 -> Below Window */
const uint AGL_SURFACE_OPACITY			= 236; /* Opacity of OpenGL surface: 1 -> Surface is opaque (default), 0 -> non-opaque */
const uint AGL_CLIP_REGION			= 254; /* Enable or set the drawable clipping region */
const uint AGL_FS_CAPTURE_SINGLE		= 255; /* Enable the capture of only a single display for aglFullScreen, normally disabled */

const uint AGL_FORMAT_CACHE_SIZE		= 501; /* Set the size of the pixel format cache */
const uint AGL_CLEAR_FORMAT_CACHE		= 502; /* Reset the pixel format cache */
const uint AGL_RETAIN_RENDERERS			= 503; /* Whether to retain loaded renderers in memory */

const uint AGL_MONOSCOPIC_BIT			= 0x00000001;
const uint AGL_STEREOSCOPIC_BIT			= 0x00000002;
const uint AGL_SINGLEBUFFER_BIT			= 0x00000004;
const uint AGL_DOUBLEBUFFER_BIT			= 0x00000008;

const uint AGL_0_BIT				= 0x00000001;
const uint AGL_1_BIT				= 0x00000002;
const uint AGL_2_BIT				= 0x00000004;
const uint AGL_3_BIT				= 0x00000008;
const uint AGL_4_BIT				= 0x00000010;
const uint AGL_5_BIT				= 0x00000020;
const uint AGL_6_BIT				= 0x00000040;
const uint AGL_8_BIT				= 0x00000080;
const uint AGL_10_BIT				= 0x00000100;
const uint AGL_12_BIT				= 0x00000200;
const uint AGL_16_BIT				= 0x00000400;
const uint AGL_24_BIT				= 0x00000800;
const uint AGL_32_BIT				= 0x00001000;
const uint AGL_48_BIT				= 0x00002000;
const uint AGL_64_BIT				= 0x00004000;
const uint AGL_96_BIT				= 0x00008000;
const uint AGL_128_BIT				= 0x00010000;

const uint AGL_RGB8_BIT				= 0x00000001; /* 8 rgb bit/pixel,     RGB=7:0, inverse colormap */
const uint AGL_RGB8_A8_BIT			= 0x00000002; /* 8-8 argb bit/pixel,  A=7:0, RGB=7:0, inverse colormap */
const uint AGL_BGR233_BIT			= 0x00000004; /* 8 rgb bit/pixel,     B=7:6, G=5:3, R=2:0 */
const uint AGL_BGR233_A8_BIT			= 0x00000008; /* 8-8 argb bit/pixel,  A=7:0, B=7:6, G=5:3, R=2:0 */
const uint AGL_RGB332_BIT			= 0x00000010; /* 8 rgb bit/pixel,     R=7:5, G=4:2, B=1:0 */
const uint AGL_RGB332_A8_BIT			= 0x00000020; /* 8-8 argb bit/pixel,  A=7:0, R=7:5, G=4:2, B=1:0 */
const uint AGL_RGB444_BIT			= 0x00000040; /* 16 rgb bit/pixel,    R=11:8, G=7:4, B=3:0 */
const uint AGL_ARGB4444_BIT			= 0x00000080; /* 16 argb bit/pixel,   A=15:12, R=11:8, G=7:4, B=3:0 */
const uint AGL_RGB444_A8_BIT			= 0x00000100; /* 8-16 argb bit/pixel, A=7:0, R=11:8, G=7:4, B=3:0 */
const uint AGL_RGB555_BIT			= 0x00000200; /* 16 rgb bit/pixel,    R=14:10, G=9:5, B=4:0 */
const uint AGL_ARGB1555_BIT			= 0x00000400; /* 16 argb bit/pixel,   A=15, R=14:10, G=9:5, B=4:0 */
const uint AGL_RGB555_A8_BIT			= 0x00000800; /* 8-16 argb bit/pixel, A=7:0, R=14:10, G=9:5, B=4:0 */
const uint AGL_RGB565_BIT			= 0x00001000; /* 16 rgb bit/pixel,    R=15:11, G=10:5, B=4:0 */
const uint AGL_RGB565_A8_BIT			= 0x00002000; /* 8-16 argb bit/pixel, A=7:0, R=15:11, G=10:5, B=4:0 */
const uint AGL_RGB888_BIT			= 0x00004000; /* 32 rgb bit/pixel,    R=23:16, G=15:8, B=7:0 */
const uint AGL_ARGB8888_BIT			= 0x00008000; /* 32 argb bit/pixel,   A=31:24, R=23:16, G=15:8, B=7:0 */
const uint AGL_RGB888_A8_BIT			= 0x00010000; /* 8-32 argb bit/pixel, A=7:0, R=23:16, G=15:8, B=7:0 */
const uint AGL_RGB101010_BIT			= 0x00020000; /* 32 rgb bit/pixel,    R=29:20, G=19:10, B=9:0 */
const uint AGL_ARGB2101010_BIT			= 0x00040000; /* 32 argb bit/pixel,   A=31:30  R=29:20, G=19:10, B=9:0 */
const uint AGL_RGB101010_A8_BIT			= 0x00080000; /* 8-32 argb bit/pixel, A=7:0  R=29:20, G=19:10, B=9:0 */
const uint AGL_RGB121212_BIT			= 0x00100000; /* 48 rgb bit/pixel,    R=35:24, G=23:12, B=11:0 */
const uint AGL_ARGB12121212_BIT			= 0x00200000; /* 48 argb bit/pixel,   A=47:36, R=35:24, G=23:12, B=11:0 */
const uint AGL_RGB161616_BIT			= 0x00400000; /* 64 rgb bit/pixel,    R=47:32, G=31:16, B=15:0 */
const uint AGL_ARGB16161616_BIT			= 0x00800000; /* 64 argb bit/pixel,   A=63:48, R=47:32, G=31:16, B=15:0 */
const uint AGL_INDEX8_BIT			= 0x20000000; /* 8 bit color look up table */
const uint AGL_INDEX16_BIT			= 0x40000000; /* 16 bit color look up table */

const uint AGL_NO_ERROR				= 0; /* no error */
const uint AGL_BAD_ATTRIBUTE			= 10000; /* invalid pixel format attribute */
const uint AGL_BAD_PROPERTY			= 10001; /* invalid renderer property */
const uint AGL_BAD_PIXELFMT			= 10002; /* invalid pixel format */
const uint AGL_BAD_RENDINFO			= 10003; /* invalid renderer info */
const uint AGL_BAD_CONTEXT			= 10004; /* invalid context */
const uint AGL_BAD_DRAWABLE			= 10005; /* invalid drawable */
const uint AGL_BAD_GDEV				= 10006; /* invalid graphics device */
const uint AGL_BAD_STATE			= 10007; /* invalid context state */
const uint AGL_BAD_VALUE			= 10008; /* invalid numerical value */
const uint AGL_BAD_MATCH			= 10009; /* invalid share context */
const uint AGL_BAD_ENUM				= 10010; /* invalid enumerant */
const uint AGL_BAD_OFFSCREEN			= 10011; /* invalid offscreen drawable */
const uint AGL_BAD_FULLSCREEN			= 10012; /* invalid offscreen drawable */
const uint AGL_BAD_WINDOW			= 10013; /* invalid window */
const uint AGL_BAD_POINTER			= 10014; /* invalid pointer */
const uint AGL_BAD_MODULE			= 10015; /* invalid code module */
const uint AGL_BAD_ALLOC			= 10016; /* memory allocation failure */

/*
 * Types and Structs
 */
alias byte** Handle;
alias int* AGLPrivate;
alias int* GLIContext;
alias int* AGLDevice;
alias int* AGLRendererInfo;
alias int* AGLPixelFormat;
alias int* AGLContext;
alias int* AGLPbuffer;
alias ubyte Style;

struct RGBColor {
	ushort red;
	ushort green;
	ushort blue;
}

struct GrafVars {
	RGBColor rgbOpColor;
	RGBColor rgbHiliteColor;
	Handle pmFgColor;
	short pmFgIndex;
	Handle pmBkColor;
	short pmBkIndex;
	short pmFlags;
}
alias GrafVars AGLDrawable;

struct __GLIFunctionDispatchRec { extern (C) {
	void (*accum)(GLIContext ctx, GLenum op, GLfloat value);
	void (*alpha_func)(GLIContext ctx, GLenum func, GLclampf ref);
	GLboolean (*are_textures_resident)(GLIContext ctx, GLsizei n, GLuint* textures, GLboolean* residences);
	void (*array_element)(GLIContext ctx, GLint i);
	void (*begin)(GLIContext ctx, GLenum mode);
	void (*bind_texture)(GLIContext ctx, GLenum target, GLuint texture);
	void (*bitmap)(GLIContext ctx, GLsizei width, GLsizei height, GLfloat xorig, GLfloat yorig, GLfloat xmove, GLfloat ymove, GLubyte* bitmap);
	void (*blend_func)(GLIContext ctx, GLenum sfactor, GLenum dfactor);
	void (*call_list)(GLIContext ctx, GLuint list);
	void (*call_lists)(GLIContext ctx, GLsizei n, GLenum type, GLvoid* lists);
	void (*clear)(GLIContext ctx, GLbitfield mask);
	void (*clear_accum)(GLIContext ctx, GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
	void (*clear_color)(GLIContext ctx, GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
	void (*clear_depth)(GLIContext ctx, GLclampd depth);
	void (*clear_index)(GLIContext ctx, GLfloat c);
	void (*clear_stencil)(GLIContext ctx, GLint s);
	void (*clip_plane)(GLIContext ctx, GLenum plane, GLdouble* equation);
	void (*color3b)(GLIContext ctx, GLbyte red, GLbyte green, GLbyte blue);
	void (*color3bv)(GLIContext ctx, GLbyte* v);
	void (*color3d)(GLIContext ctx, GLdouble red, GLdouble green, GLdouble blue);
	void (*color3dv)(GLIContext ctx, GLdouble* v);
	void (*color3f)(GLIContext ctx, GLfloat red, GLfloat green, GLfloat blue);
	void (*color3fv)(GLIContext ctx, GLfloat* v);
	void (*color3i)(GLIContext ctx, GLint red, GLint green, GLint blue);
	void (*color3iv)(GLIContext ctx, GLint* v);
	void (*color3s)(GLIContext ctx, GLshort red, GLshort green, GLshort blue);
	void (*color3sv)(GLIContext ctx, GLshort* v);
	void (*color3ub)(GLIContext ctx, GLubyte red, GLubyte green, GLubyte blue);
	void (*color3ubv)(GLIContext ctx, GLubyte* v);
	void (*color3ui)(GLIContext ctx, GLuint red, GLuint green, GLuint blue);
	void (*color3uiv)(GLIContext ctx, GLuint* v);
	void (*color3us)(GLIContext ctx, GLushort red, GLushort green, GLushort blue);
	void (*color3usv)(GLIContext ctx, GLushort* v);
	void (*color4b)(GLIContext ctx, GLbyte red, GLbyte green, GLbyte blue, GLbyte alpha);
	void (*color4bv)(GLIContext ctx, GLbyte* v);
	void (*color4d)(GLIContext ctx, GLdouble red, GLdouble green, GLdouble blue, GLdouble alpha);
	void (*color4dv)(GLIContext ctx, GLdouble* v);
	void (*color4f)(GLIContext ctx, GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
	void (*color4fv)(GLIContext ctx, GLfloat* v);
	void (*color4i)(GLIContext ctx, GLint red, GLint green, GLint blue, GLint alpha);
	void (*color4iv)(GLIContext ctx, GLint* v);
	void (*color4s)(GLIContext ctx, GLshort red, GLshort green, GLshort blue, GLshort alpha);
	void (*color4sv)(GLIContext ctx, GLshort* v);
	void (*color4ub)(GLIContext ctx, GLubyte red, GLubyte green, GLubyte blue, GLubyte alpha);
	void (*color4ubv)(GLIContext ctx, GLubyte* v);
	void (*color4ui)(GLIContext ctx, GLuint red, GLuint green, GLuint blue, GLuint alpha);
	void (*color4uiv)(GLIContext ctx, GLuint* v);
	void (*color4us)(GLIContext ctx, GLushort red, GLushort green, GLushort blue, GLushort alpha);
	void (*color4usv)(GLIContext ctx, GLushort* v);
	void (*color_mask)(GLIContext ctx, GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);
	void (*color_material)(GLIContext ctx, GLenum face, GLenum mode);
	void (*color_pointer)(GLIContext ctx, GLint size, GLenum type, GLsizei stride, GLvoid* pointer);
	void (*copy_pixels)(GLIContext ctx, GLint x, GLint y, GLsizei width, GLsizei height, GLenum type);
	void (*copy_tex_image1D)(GLIContext ctx, GLenum target, GLint level, GLenum internalFormat, GLint x, GLint y, GLsizei width, GLint border);
	void (*copy_tex_image2D)(GLIContext ctx, GLenum target, GLint level, GLenum internalFormat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
	void (*copy_tex_sub_image1D)(GLIContext ctx, GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
	void (*copy_tex_sub_image2D)(GLIContext ctx, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
	void (*cull_face)(GLIContext ctx, GLenum mode);
	void (*delete_lists)(GLIContext ctx, GLuint list, GLsizei range);
	void (*delete_textures)(GLIContext ctx, GLsizei n, GLuint* textures);
	void (*depth_func)(GLIContext ctx, GLenum func);
	void (*depth_mask)(GLIContext ctx, GLboolean flag);
	void (*depth_range)(GLIContext ctx, GLclampd zNear, GLclampd zFar);
	void (*disable)(GLIContext ctx, GLenum cap);
	void (*disable_client_state)(GLIContext ctx, GLenum array);
	void (*draw_arrays)(GLIContext ctx, GLenum mode, GLint first, GLsizei count);
	void (*draw_buffer)(GLIContext ctx, GLenum mode);
	void (*draw_elements)(GLIContext ctx, GLenum mode, GLsizei count, GLenum type, GLvoid* indices);
	void (*draw_pixels)(GLIContext ctx, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid* pixels);
	void (*edge_flag)(GLIContext ctx, GLboolean flag);
	void (*edge_flag_pointer)(GLIContext ctx, GLsizei stride, GLvoid* pointer);
	void (*edge_flagv)(GLIContext ctx, GLboolean* flag);
	void (*enable)(GLIContext ctx, GLenum cap);
	void (*enable_client_state)(GLIContext ctx, GLenum array);
	void (*end)(GLIContext ctx);
	void (*end_list)(GLIContext ctx);
	void (*eval_coord1d)(GLIContext ctx, GLdouble u);
	void (*eval_coord1dv)(GLIContext ctx, GLdouble* u);
	void (*eval_coord1f)(GLIContext ctx, GLfloat u);
	void (*eval_coord1fv)(GLIContext ctx, GLfloat* u);
	void (*eval_coord2d)(GLIContext ctx, GLdouble u, GLdouble v);
	void (*eval_coord2dv)(GLIContext ctx, GLdouble* u);
	void (*eval_coord2f)(GLIContext ctx, GLfloat u, GLfloat v);
	void (*eval_coord2fv)(GLIContext ctx, GLfloat* u);
	void (*eval_mesh1)(GLIContext ctx, GLenum mode, GLint i1, GLint i2);
	void (*eval_mesh2)(GLIContext ctx, GLenum mode, GLint i1, GLint i2, GLint j1, GLint j2);
	void (*eval_point1)(GLIContext ctx, GLint i);
	void (*eval_point2)(GLIContext ctx, GLint i, GLint j);
	void (*feedback_buffer)(GLIContext ctx, GLsizei size, GLenum type, GLfloat* buffer);
	void (*finish)(GLIContext ctx);
	void (*flush)(GLIContext ctx);
	void (*fogf)(GLIContext ctx, GLenum pname, GLfloat param);
	void (*fogfv)(GLIContext ctx, GLenum pname, GLfloat* params);
	void (*fogi)(GLIContext ctx, GLenum pname, GLint param);
	void (*fogiv)(GLIContext ctx, GLenum pname, GLint* params);
	void (*front_face)(GLIContext ctx, GLenum mode);
	void (*frustum)(GLIContext ctx, GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
	GLuint (*gen_lists)(GLIContext ctx, GLsizei range);
	void (*gen_textures)(GLIContext ctx, GLsizei n, GLuint* textures);
	void (*get_booleanv)(GLIContext ctx, GLenum pname, GLboolean* params);
	void (*get_clip_plane)(GLIContext ctx, GLenum plane, GLdouble* equation);
	void (*get_doublev)(GLIContext ctx, GLenum pname, GLdouble* params);
	GLenum (*get_error)(GLIContext ctx);
	void (*get_floatv)(GLIContext ctx, GLenum pname, GLfloat* params);
	void (*get_integerv)(GLIContext ctx, GLenum pname, GLint* params);
	void (*get_lightfv)(GLIContext ctx, GLenum light, GLenum pname, GLfloat* params);
	void (*get_lightiv)(GLIContext ctx, GLenum light, GLenum pname, GLint* params);
	void (*get_mapdv)(GLIContext ctx, GLenum target, GLenum query, GLdouble* v);
	void (*get_mapfv)(GLIContext ctx, GLenum target, GLenum query, GLfloat* v);
	void (*get_mapiv)(GLIContext ctx, GLenum target, GLenum query, GLint* v);
	void (*get_materialfv)(GLIContext ctx, GLenum face, GLenum pname, GLfloat* params);
	void (*get_materialiv)(GLIContext ctx, GLenum face, GLenum pname, GLint* params);
	void (*get_pixel_mapfv)(GLIContext ctx, GLenum map, GLfloat* values);
	void (*get_pixel_mapuiv)(GLIContext ctx, GLenum map, GLuint* values);
	void (*get_pixel_mapusv)(GLIContext ctx, GLenum map, GLushort* values);
	void (*get_pointerv)(GLIContext ctx, GLenum pname, GLvoid** params);
	void (*get_polygon_stipple)(GLIContext ctx, GLubyte* mask);
	const GLubyte* (*get_string)(GLIContext ctx, GLenum name);
	void (*get_tex_envfv)(GLIContext ctx, GLenum target, GLenum pname, GLfloat* params);
	void (*get_tex_enviv)(GLIContext ctx, GLenum target, GLenum pname, GLint* params);
	void (*get_tex_gendv)(GLIContext ctx, GLenum coord, GLenum pname, GLdouble* params);
	void (*get_tex_genfv)(GLIContext ctx, GLenum coord, GLenum pname, GLfloat* params);
	void (*get_tex_geniv)(GLIContext ctx, GLenum coord, GLenum pname, GLint* params);
	void (*get_tex_image)(GLIContext ctx, GLenum target, GLint level, GLenum format, GLenum type, GLvoid* pixels);
	void (*get_tex_level_parameterfv)(GLIContext ctx, GLenum target, GLint level, GLenum pname, GLfloat* params);
	void (*get_tex_level_parameteriv)(GLIContext ctx, GLenum target, GLint level, GLenum pname, GLint* params);
	void (*get_tex_parameterfv)(GLIContext ctx, GLenum target, GLenum pname, GLfloat* params);
	void (*get_tex_parameteriv)(GLIContext ctx, GLenum target, GLenum pname, GLint* params);
	void (*hint)(GLIContext ctx, GLenum target, GLenum mode);
	void (*index_mask)(GLIContext ctx, GLuint mask);
	void (*index_pointer)(GLIContext ctx, GLenum type, GLsizei stride, GLvoid* pointer);
	void (*indexd)(GLIContext ctx, GLdouble c);
	void (*indexdv)(GLIContext ctx, GLdouble* c);
	void (*indexf)(GLIContext ctx, GLfloat c);
	void (*indexfv)(GLIContext ctx, GLfloat* c);
	void (*indexi)(GLIContext ctx, GLint c);
	void (*indexiv)(GLIContext ctx, GLint* c);
	void (*indexs)(GLIContext ctx, GLshort c);
	void (*indexsv)(GLIContext ctx, GLshort* c);
	void (*indexub)(GLIContext ctx, GLubyte c);
	void (*indexubv)(GLIContext ctx, GLubyte* c);
	void (*init_names)(GLIContext ctx);
	void (*interleaved_arrays)(GLIContext ctx, GLenum format, GLsizei stride, GLvoid* pointer);
	GLboolean (*is_enabled)(GLIContext ctx, GLenum cap);
	GLboolean (*is_list)(GLIContext ctx, GLuint list);
	GLboolean (*is_texture)(GLIContext ctx, GLuint texture);
	void (*light_modelf)(GLIContext ctx, GLenum pname, GLfloat param);
	void (*light_modelfv)(GLIContext ctx, GLenum pname, GLfloat* params);
	void (*light_modeli)(GLIContext ctx, GLenum pname, GLint param);
	void (*light_modeliv)(GLIContext ctx, GLenum pname, GLint* params);
	void (*lightf)(GLIContext ctx, GLenum light, GLenum pname, GLfloat param);
	void (*lightfv)(GLIContext ctx, GLenum light, GLenum pname, GLfloat* params);
	void (*lighti)(GLIContext ctx, GLenum light, GLenum pname, GLint param);
	void (*lightiv)(GLIContext ctx, GLenum light, GLenum pname, GLint* params);
	void (*line_stipple)(GLIContext ctx, GLint factor, GLushort pattern);
	void (*line_width)(GLIContext ctx, GLfloat width);
	void (*list_base)(GLIContext ctx, GLuint base);
	void (*load_identity)(GLIContext ctx);
	void (*load_matrixd)(GLIContext ctx, GLdouble* m);
	void (*load_matrixf)(GLIContext ctx, GLfloat* m);
	void (*load_name)(GLIContext ctx, GLuint name);
	void (*logic_op)(GLIContext ctx, GLenum opcode);
	void (*map1d)(GLIContext ctx, GLenum target, GLdouble u1, GLdouble u2, GLint stride, GLint order, GLdouble* points);
	void (*map1f)(GLIContext ctx, GLenum target, GLfloat u1, GLfloat u2, GLint stride, GLint order, GLfloat* points);
	void (*map2d)(GLIContext ctx, GLenum target, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, GLdouble* points);
	void (*map2f)(GLIContext ctx, GLenum target, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, GLfloat* points);
	void (*map_grid1d)(GLIContext ctx, GLint un, GLdouble u1, GLdouble u2);
	void (*map_grid1f)(GLIContext ctx, GLint un, GLfloat u1, GLfloat u2);
	void (*map_grid2d)(GLIContext ctx, GLint un, GLdouble u1, GLdouble u2, GLint vn, GLdouble v1, GLdouble v2);
	void (*map_grid2f)(GLIContext ctx, GLint un, GLfloat u1, GLfloat u2, GLint vn, GLfloat v1, GLfloat v2);
	void (*materialf)(GLIContext ctx, GLenum face, GLenum pname, GLfloat param);
	void (*materialfv)(GLIContext ctx, GLenum face, GLenum pname, GLfloat* params);
	void (*materiali)(GLIContext ctx, GLenum face, GLenum pname, GLint param);
	void (*materialiv)(GLIContext ctx, GLenum face, GLenum pname, GLint* params);
	void (*matrix_mode)(GLIContext ctx, GLenum mode);
	void (*mult_matrixd)(GLIContext ctx, GLdouble* m);
	void (*mult_matrixf)(GLIContext ctx, GLfloat* m);
	void (*new_list)(GLIContext ctx, GLuint list, GLenum mode);
	void (*normal3b)(GLIContext ctx, GLbyte nx, GLbyte ny, GLbyte nz);
	void (*normal3bv)(GLIContext ctx, GLbyte* v);
	void (*normal3d)(GLIContext ctx, GLdouble nx, GLdouble ny, GLdouble nz);
	void (*normal3dv)(GLIContext ctx, GLdouble* v);
	void (*normal3f)(GLIContext ctx, GLfloat nx, GLfloat ny, GLfloat nz);
	void (*normal3fv)(GLIContext ctx, GLfloat* v);
	void (*normal3i)(GLIContext ctx, GLint nx, GLint ny, GLint nz);
	void (*normal3iv)(GLIContext ctx, GLint* v);
	void (*normal3s)(GLIContext ctx, GLshort nx, GLshort ny, GLshort nz);
	void (*normal3sv)(GLIContext ctx, GLshort* v);
	void (*normal_pointer)(GLIContext ctx, GLenum type, GLsizei stride, GLvoid* pointer);
	void (*ortho)(GLIContext ctx, GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
	void (*pass_through)(GLIContext ctx, GLfloat token);
	void (*pixel_mapfv)(GLIContext ctx, GLenum map, GLsizei mapsize, GLfloat* values);
	void (*pixel_mapuiv)(GLIContext ctx, GLenum map, GLsizei mapsize, GLuint* values);
	void (*pixel_mapusv)(GLIContext ctx, GLenum map, GLsizei mapsize, GLushort* values);
	void (*pixel_storef)(GLIContext ctx, GLenum pname, GLfloat param);
	void (*pixel_storei)(GLIContext ctx, GLenum pname, GLint param);
	void (*pixel_transferf)(GLIContext ctx, GLenum pname, GLfloat param);
	void (*pixel_transferi)(GLIContext ctx, GLenum pname, GLint param);
	void (*pixel_zoom)(GLIContext ctx, GLfloat xfactor, GLfloat yfactor);
	void (*point_size)(GLIContext ctx, GLfloat size);
	void (*polygon_mode)(GLIContext ctx, GLenum face, GLenum mode);
	void (*polygon_offset)(GLIContext ctx, GLfloat factor, GLfloat units);
	void (*polygon_stipple)(GLIContext ctx, GLubyte* mask);
	void (*pop_attrib)(GLIContext ctx);
	void (*pop_client_attrib)(GLIContext ctx);
	void (*pop_matrix)(GLIContext ctx);
	void (*pop_name)(GLIContext ctx);
	void (*prioritize_textures)(GLIContext ctx, GLsizei n, GLuint* textures, GLclampf* priorities);
	void (*push_attrib)(GLIContext ctx, GLbitfield mask);
	void (*push_client_attrib)(GLIContext ctx, GLbitfield mask);
	void (*push_matrix)(GLIContext ctx);
	void (*push_name)(GLIContext ctx, GLuint name);
	void (*raster_pos2d)(GLIContext ctx, GLdouble x, GLdouble y);
	void (*raster_pos2dv)(GLIContext ctx, GLdouble* v);
	void (*raster_pos2f)(GLIContext ctx, GLfloat x, GLfloat y);
	void (*raster_pos2fv)(GLIContext ctx, GLfloat* v);
	void (*raster_pos2i)(GLIContext ctx, GLint x, GLint y);
	void (*raster_pos2iv)(GLIContext ctx, GLint* v);
	void (*raster_pos2s)(GLIContext ctx, GLshort x, GLshort y);
	void (*raster_pos2sv)(GLIContext ctx, GLshort* v);
	void (*raster_pos3d)(GLIContext ctx, GLdouble x, GLdouble y, GLdouble z);
	void (*raster_pos3dv)(GLIContext ctx, GLdouble* v);
	void (*raster_pos3f)(GLIContext ctx, GLfloat x, GLfloat y, GLfloat z);
	void (*raster_pos3fv)(GLIContext ctx, GLfloat* v);
	void (*raster_pos3i)(GLIContext ctx, GLint x, GLint y, GLint z);
	void (*raster_pos3iv)(GLIContext ctx, GLint* v);
	void (*raster_pos3s)(GLIContext ctx, GLshort x, GLshort y, GLshort z);
	void (*raster_pos3sv)(GLIContext ctx, GLshort* v);
	void (*raster_pos4d)(GLIContext ctx, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
	void (*raster_pos4dv)(GLIContext ctx, GLdouble* v);
	void (*raster_pos4f)(GLIContext ctx, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
	void (*raster_pos4fv)(GLIContext ctx, GLfloat* v);
	void (*raster_pos4i)(GLIContext ctx, GLint x, GLint y, GLint z, GLint w);
	void (*raster_pos4iv)(GLIContext ctx, GLint* v);
	void (*raster_pos4s)(GLIContext ctx, GLshort x, GLshort y, GLshort z, GLshort w);
	void (*raster_pos4sv)(GLIContext ctx, GLshort* v);
	void (*read_buffer)(GLIContext ctx, GLenum mode);
	void (*read_pixels)(GLIContext ctx, GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid* pixels);
	void (*rectd)(GLIContext ctx, GLdouble x1, GLdouble y1, GLdouble x2, GLdouble y2);
	void (*rectdv)(GLIContext ctx, GLdouble* v1, GLdouble* v2);
	void (*rectf)(GLIContext ctx, GLfloat x1, GLfloat y1, GLfloat x2, GLfloat y2);
	void (*rectfv)(GLIContext ctx, GLfloat* v1, GLfloat* v2);
	void (*recti)(GLIContext ctx, GLint x1, GLint y1, GLint x2, GLint y2);
	void (*rectiv)(GLIContext ctx, GLint* v1, GLint* v2);
	void (*rects)(GLIContext ctx, GLshort x1, GLshort y1, GLshort x2, GLshort y2);
	void (*rectsv)(GLIContext ctx, GLshort* v1, GLshort* v2);
	GLint (*render_mode)(GLIContext ctx, GLenum mode);
	void (*rotated)(GLIContext ctx, GLdouble angle, GLdouble x, GLdouble y, GLdouble z);
	void (*rotatef)(GLIContext ctx, GLfloat angle, GLfloat x, GLfloat y, GLfloat z);
	void (*scaled)(GLIContext ctx, GLdouble x, GLdouble y, GLdouble z);
	void (*scalef)(GLIContext ctx, GLfloat x, GLfloat y, GLfloat z);
	void (*scissor)(GLIContext ctx, GLint x, GLint y, GLsizei width, GLsizei height);
	void (*select_buffer)(GLIContext ctx, GLsizei size, GLuint* buffer);
	void (*shade_model)(GLIContext ctx, GLenum mode);
	void (*stencil_func)(GLIContext ctx, GLenum func, GLint ref, GLuint mask);
	void (*stencil_mask)(GLIContext ctx, GLuint mask);
	void (*stencil_op)(GLIContext ctx, GLenum fail, GLenum zfail, GLenum zpass);
	void (*tex_coord1d)(GLIContext ctx, GLdouble s);
	void (*tex_coord1dv)(GLIContext ctx, GLdouble* v);
	void (*tex_coord1f)(GLIContext ctx, GLfloat s);
	void (*tex_coord1fv)(GLIContext ctx, GLfloat* v);
	void (*tex_coord1i)(GLIContext ctx, GLint s);
	void (*tex_coord1iv)(GLIContext ctx, GLint* v);
	void (*tex_coord1s)(GLIContext ctx, GLshort s);
	void (*tex_coord1sv)(GLIContext ctx, GLshort* v);
	void (*tex_coord2d)(GLIContext ctx, GLdouble s, GLdouble t);
	void (*tex_coord2dv)(GLIContext ctx, GLdouble* v);
	void (*tex_coord2f)(GLIContext ctx, GLfloat s, GLfloat t);
	void (*tex_coord2fv)(GLIContext ctx, GLfloat* v);
	void (*tex_coord2i)(GLIContext ctx, GLint s, GLint t);
	void (*tex_coord2iv)(GLIContext ctx, GLint* v);
	void (*tex_coord2s)(GLIContext ctx, GLshort s, GLshort t);
	void (*tex_coord2sv)(GLIContext ctx, GLshort* v);
	void (*tex_coord3d)(GLIContext ctx, GLdouble s, GLdouble t, GLdouble r);
	void (*tex_coord3dv)(GLIContext ctx, GLdouble* v);
	void (*tex_coord3f)(GLIContext ctx, GLfloat s, GLfloat t, GLfloat r);
	void (*tex_coord3fv)(GLIContext ctx, GLfloat* v);
	void (*tex_coord3i)(GLIContext ctx, GLint s, GLint t, GLint r);
	void (*tex_coord3iv)(GLIContext ctx, GLint* v);
	void (*tex_coord3s)(GLIContext ctx, GLshort s, GLshort t, GLshort r);
	void (*tex_coord3sv)(GLIContext ctx, GLshort* v);
	void (*tex_coord4d)(GLIContext ctx, GLdouble s, GLdouble t, GLdouble r, GLdouble q);
	void (*tex_coord4dv)(GLIContext ctx, GLdouble* v);
	void (*tex_coord4f)(GLIContext ctx, GLfloat s, GLfloat t, GLfloat r, GLfloat q);
	void (*tex_coord4fv)(GLIContext ctx, GLfloat* v);
	void (*tex_coord4i)(GLIContext ctx, GLint s, GLint t, GLint r, GLint q);
	void (*tex_coord4iv)(GLIContext ctx, GLint* v);
	void (*tex_coord4s)(GLIContext ctx, GLshort s, GLshort t, GLshort r, GLshort q);
	void (*tex_coord4sv)(GLIContext ctx, GLshort* v);
	void (*tex_coord_pointer)(GLIContext ctx, GLint size, GLenum type, GLsizei stride, GLvoid* pointer);
	void (*tex_envf)(GLIContext ctx, GLenum target, GLenum pname, GLfloat param);
	void (*tex_envfv)(GLIContext ctx, GLenum target, GLenum pname, GLfloat* params);
	void (*tex_envi)(GLIContext ctx, GLenum target, GLenum pname, GLint param);
	void (*tex_enviv)(GLIContext ctx, GLenum target, GLenum pname, GLint* params);
	void (*tex_gend)(GLIContext ctx, GLenum coord, GLenum pname, GLdouble param);
	void (*tex_gendv)(GLIContext ctx, GLenum coord, GLenum pname, GLdouble* params);
	void (*tex_genf)(GLIContext ctx, GLenum coord, GLenum pname, GLfloat param);
	void (*tex_genfv)(GLIContext ctx, GLenum coord, GLenum pname, GLfloat* params);
	void (*tex_geni)(GLIContext ctx, GLenum coord, GLenum pname, GLint param);
	void (*tex_geniv)(GLIContext ctx, GLenum coord, GLenum pname, GLint* params);
	void (*tex_image1D)(GLIContext ctx, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLenum format, GLenum type, GLvoid* pixels);
	void (*tex_image2D)(GLIContext ctx, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, GLvoid* pixels);
	void (*tex_parameterf)(GLIContext ctx, GLenum target, GLenum pname, GLfloat param);
	void (*tex_parameterfv)(GLIContext ctx, GLenum target, GLenum pname, GLfloat* params);
	void (*tex_parameteri)(GLIContext ctx, GLenum target, GLenum pname, GLint param);
	void (*tex_parameteriv)(GLIContext ctx, GLenum target, GLenum pname, GLint* params);
	void (*tex_sub_image1D)(GLIContext ctx, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, GLvoid* pixels);
	void (*tex_sub_image2D)(GLIContext ctx, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid* pixels);
	void (*translated)(GLIContext ctx, GLdouble x, GLdouble y, GLdouble z);
	void (*translatef)(GLIContext ctx, GLfloat x, GLfloat y, GLfloat z);
	void (*vertex2d)(GLIContext ctx, GLdouble x, GLdouble y);
	void (*vertex2dv)(GLIContext ctx, GLdouble* v);
	void (*vertex2f)(GLIContext ctx, GLfloat x, GLfloat y);
	void (*vertex2fv)(GLIContext ctx, GLfloat* v);
	void (*vertex2i)(GLIContext ctx, GLint x, GLint y);
	void (*vertex2iv)(GLIContext ctx, GLint* v);
	void (*vertex2s)(GLIContext ctx, GLshort x, GLshort y);
	void (*vertex2sv)(GLIContext ctx, GLshort* v);
	void (*vertex3d)(GLIContext ctx, GLdouble x, GLdouble y, GLdouble z);
	void (*vertex3dv)(GLIContext ctx, GLdouble* v);
	void (*vertex3f)(GLIContext ctx, GLfloat x, GLfloat y, GLfloat z);
	void (*vertex3fv)(GLIContext ctx, GLfloat* v);
	void (*vertex3i)(GLIContext ctx, GLint x, GLint y, GLint z);
	void (*vertex3iv)(GLIContext ctx, GLint* v);
	void (*vertex3s)(GLIContext ctx, GLshort x, GLshort y, GLshort z);
	void (*vertex3sv)(GLIContext ctx, GLshort* v);
	void (*vertex4d)(GLIContext ctx, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
	void (*vertex4dv)(GLIContext ctx, GLdouble* v);
	void (*vertex4f)(GLIContext ctx, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
	void (*vertex4fv)(GLIContext ctx, GLfloat* v);
	void (*vertex4i)(GLIContext ctx, GLint x, GLint y, GLint z, GLint w);
	void (*vertex4iv)(GLIContext ctx, GLint* v);
	void (*vertex4s)(GLIContext ctx, GLshort x, GLshort y, GLshort z, GLshort w);
	void (*vertex4sv)(GLIContext ctx, GLshort* v);
	void (*vertex_pointer)(GLIContext ctx, GLint size, GLenum type, GLsizei stride, GLvoid* pointer);
	void (*viewport)(GLIContext ctx, GLint x, GLint y, GLsizei width, GLsizei height);
	void (*blend_func_separate)(GLIContext ctx, GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);
	void (*blend_color)(GLIContext ctx, GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
	void (*blend_equation)(GLIContext ctx, GLenum mode);
	void (*lock_arrays_EXT)(GLIContext ctx, GLint first, GLsizei count);
	void (*unlock_arrays_EXT)(GLIContext ctx);
	void (*client_active_texture)(GLIContext ctx, GLenum target);
	void (*active_texture)(GLIContext ctx, GLenum target);
	void (*multi_tex_coord1d)(GLIContext ctx, GLenum target, GLdouble s);
	void (*multi_tex_coord1dv)(GLIContext ctx, GLenum target, GLdouble* v);
	void (*multi_tex_coord1f)(GLIContext ctx, GLenum target, GLfloat s);
	void (*multi_tex_coord1fv)(GLIContext ctx, GLenum target, GLfloat* v);
	void (*multi_tex_coord1i)(GLIContext ctx, GLenum target, GLint s);
	void (*multi_tex_coord1iv)(GLIContext ctx, GLenum target, GLint* v);
	void (*multi_tex_coord1s)(GLIContext ctx, GLenum target, GLshort s);
	void (*multi_tex_coord1sv)(GLIContext ctx, GLenum target, GLshort* v);
	void (*multi_tex_coord2d)(GLIContext ctx, GLenum target, GLdouble s, GLdouble t);
	void (*multi_tex_coord2dv)(GLIContext ctx, GLenum target, GLdouble* v);
	void (*multi_tex_coord2f)(GLIContext ctx, GLenum target, GLfloat s, GLfloat t);
	void (*multi_tex_coord2fv)(GLIContext ctx, GLenum target, GLfloat* v);
	void (*multi_tex_coord2i)(GLIContext ctx, GLenum target, GLint s, GLint t);
	void (*multi_tex_coord2iv)(GLIContext ctx, GLenum target, GLint* v);
	void (*multi_tex_coord2s)(GLIContext ctx, GLenum target, GLshort s, GLshort t);
	void (*multi_tex_coord2sv)(GLIContext ctx, GLenum target, GLshort* v);
	void (*multi_tex_coord3d)(GLIContext ctx, GLenum target, GLdouble s, GLdouble t, GLdouble r);
	void (*multi_tex_coord3dv)(GLIContext ctx, GLenum target, GLdouble* v);
	void (*multi_tex_coord3f)(GLIContext ctx, GLenum target, GLfloat s, GLfloat t, GLfloat r);
	void (*multi_tex_coord3fv)(GLIContext ctx, GLenum target, GLfloat* v);
	void (*multi_tex_coord3i)(GLIContext ctx, GLenum target, GLint s, GLint t, GLint r);
	void (*multi_tex_coord3iv)(GLIContext ctx, GLenum target, GLint* v);
	void (*multi_tex_coord3s)(GLIContext ctx, GLenum target, GLshort s, GLshort t, GLshort r);
	void (*multi_tex_coord3sv)(GLIContext ctx, GLenum target, GLshort* v);
	void (*multi_tex_coord4d)(GLIContext ctx, GLenum target, GLdouble s, GLdouble t, GLdouble r, GLdouble q);
	void (*multi_tex_coord4dv)(GLIContext ctx, GLenum target, GLdouble* v);
	void (*multi_tex_coord4f)(GLIContext ctx, GLenum target, GLfloat s, GLfloat t, GLfloat r, GLfloat q);
	void (*multi_tex_coord4fv)(GLIContext ctx, GLenum target, GLfloat* v);
	void (*multi_tex_coord4i)(GLIContext ctx, GLenum target, GLint s, GLint t, GLint r, GLint q);
	void (*multi_tex_coord4iv)(GLIContext ctx, GLenum target, GLint* v);
	void (*multi_tex_coord4s)(GLIContext ctx, GLenum target, GLshort s, GLshort t, GLshort r, GLshort q);
	void (*multi_tex_coord4sv)(GLIContext ctx, GLenum target, GLshort* v);
	void (*load_transpose_matrixd)(GLIContext ctx, GLdouble* m);
	void (*load_transpose_matrixf)(GLIContext ctx, GLfloat* m);
	void (*mult_transpose_matrixd)(GLIContext ctx, GLdouble* m);
	void (*mult_transpose_matrixf)(GLIContext ctx, GLfloat* m);
	void (*compressed_tex_image3D)(GLIContext ctx, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, GLvoid* data);
	void (*compressed_tex_image2D)(GLIContext ctx, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, GLvoid* data);
	void (*compressed_tex_image1D)(GLIContext ctx, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, GLvoid* data);
	void (*compressed_tex_sub_image3D)(GLIContext ctx, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, GLvoid* data);
	void (*compressed_tex_sub_image2D)(GLIContext ctx, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, GLvoid* data);
	void (*compressed_tex_sub_image1D)(GLIContext ctx, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, GLvoid* data);
	void (*get_compressed_tex_image)(GLIContext ctx, GLenum target, GLint level, GLvoid* img);
	void (*secondary_color3b)(GLIContext ctx, GLbyte red, GLbyte green, GLbyte blue);
	void (*secondary_color3bv)(GLIContext ctx, GLbyte* v);
	void (*secondary_color3d)(GLIContext ctx, GLdouble red, GLdouble green, GLdouble blue);
	void (*secondary_color3dv)(GLIContext ctx, GLdouble* v);
	void (*secondary_color3f)(GLIContext ctx, GLfloat red, GLfloat green, GLfloat blue);
	void (*secondary_color3fv)(GLIContext ctx, GLfloat* v);
	void (*secondary_color3i)(GLIContext ctx, GLint red, GLint green, GLint blue);
	void (*secondary_color3iv)(GLIContext ctx, GLint* v);
	void (*secondary_color3s)(GLIContext ctx, GLshort red, GLshort green, GLshort blue);
	void (*secondary_color3sv)(GLIContext ctx, GLshort* v);
	void (*secondary_color3ub)(GLIContext ctx, GLubyte red, GLubyte green, GLubyte blue);
	void (*secondary_color3ubv)(GLIContext ctx, GLubyte* v);
	void (*secondary_color3ui)(GLIContext ctx, GLuint red, GLuint green, GLuint blue);
	void (*secondary_color3uiv)(GLIContext ctx, GLuint* v);
	void (*secondary_color3us)(GLIContext ctx, GLushort red, GLushort green, GLushort blue);
	void (*secondary_color3usv)(GLIContext ctx, GLushort* v);
	void (*secondary_color_pointer)(GLIContext ctx, GLint size, GLenum type, GLsizei stride, GLvoid* pointer);
	void (*vertex_array_range_EXT)(GLIContext ctx, GLsizei count, GLvoid* pointer);
	void (*flush_vertex_array_range_EXT)(GLIContext ctx, GLsizei count, GLvoid* pointer);
	void (*draw_range_elements)(GLIContext ctx, GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, GLvoid* indices);
	void (*color_table)(GLIContext ctx, GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, GLvoid* table);
	void (*color_table_parameterfv)(GLIContext ctx, GLenum target, GLenum pname, GLfloat* params);
	void (*color_table_parameteriv)(GLIContext ctx, GLenum target, GLenum pname, GLint* params);
	void (*copy_color_table)(GLIContext ctx, GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);
	void (*get_color_table)(GLIContext ctx, GLenum target, GLenum format, GLenum type, GLvoid* table);
	void (*get_color_table_parameterfv)(GLIContext ctx, GLenum target, GLenum pname, GLfloat* params);
	void (*get_color_table_parameteriv)(GLIContext ctx, GLenum target, GLenum pname, GLint* params);
	void (*color_sub_table)(GLIContext ctx, GLenum target, GLsizei start, GLsizei count, GLenum format, GLenum type, GLvoid* data);
	void (*copy_color_sub_table)(GLIContext ctx, GLenum target, GLsizei start, GLint x, GLint y, GLsizei width);
	void (*convolution_filter1D)(GLIContext ctx, GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, GLvoid* image);
	void (*convolution_filter2D)(GLIContext ctx, GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid* image);
	void (*convolution_parameterf)(GLIContext ctx, GLenum target, GLenum pname, GLfloat params);
	void (*convolution_parameterfv)(GLIContext ctx, GLenum target, GLenum pname, GLfloat* params);
	void (*convolution_parameteri)(GLIContext ctx, GLenum target, GLenum pname, GLint params);
	void (*convolution_parameteriv)(GLIContext ctx, GLenum target, GLenum pname, GLint* params);
	void (*copy_convolution_filter1D)(GLIContext ctx, GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);
	void (*copy_convolution_filter2D)(GLIContext ctx, GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height);
	void (*get_convolution_filter)(GLIContext ctx, GLenum target, GLenum format, GLenum type, GLvoid* image);
	void (*get_convolution_parameterfv)(GLIContext ctx, GLenum target, GLenum pname, GLfloat* params);
	void (*get_convolution_parameteriv)(GLIContext ctx, GLenum target, GLenum pname, GLint* params);
	void (*get_separable_filter)(GLIContext ctx, GLenum target, GLenum format, GLenum type, GLvoid* row, GLvoid* column, GLvoid* span);
	void (*separable_filter2D)(GLIContext ctx, GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid* row, GLvoid* column);
	void (*get_histogram)(GLIContext ctx, GLenum target, GLboolean reset, GLenum format, GLenum type, GLvoid* values);
	void (*get_histogram_parameterfv)(GLIContext ctx, GLenum target, GLenum pname, GLfloat* params);
	void (*get_histogram_parameteriv)(GLIContext ctx, GLenum target, GLenum pname, GLint* params);
	void (*get_minmax)(GLIContext ctx, GLenum target, GLboolean reset, GLenum format, GLenum type, GLvoid* values);
	void (*get_minmax_parameterfv)(GLIContext ctx, GLenum target, GLenum pname, GLfloat* params);
	void (*get_minmax_parameteriv)(GLIContext ctx, GLenum target, GLenum pname, GLint* params);
	void (*histogram)(GLIContext ctx, GLenum target, GLsizei width, GLenum internalformat, GLboolean sink);
	void (*minmax)(GLIContext ctx, GLenum target, GLenum internalformat, GLboolean sink);
	void (*reset_histogram)(GLIContext ctx, GLenum target);
	void (*reset_minmax)(GLIContext ctx, GLenum target);
	void (*tex_image3D)(GLIContext ctx, GLenum target, GLint level, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, GLvoid* pixels);
	void (*tex_sub_image3D)(GLIContext ctx, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, GLvoid* pixels);
	void (*copy_tex_sub_image3D)(GLIContext ctx, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
	void (*combiner_parameterfv_NV)(GLIContext ctx, GLenum pname, GLfloat* params);
	void (*combiner_parameterf_NV)(GLIContext ctx, GLenum pname, GLfloat param);
	void (*combiner_parameteriv_NV)(GLIContext ctx, GLenum pname, GLint* params);
	void (*combiner_parameteri_NV)(GLIContext ctx, GLenum pname, GLint param);
	void (*combiner_input_NV)(GLIContext ctx, GLenum stage, GLenum portion, GLenum variable, GLenum input, GLenum mapping, GLenum componentUsage);
	void (*combiner_output_NV)(GLIContext ctx, GLenum stage, GLenum portion, GLenum abOutput, GLenum cdOutput, GLenum sumOutput, GLenum scale, GLenum bias, GLboolean abDotProduct, GLboolean cdDotProduct, GLboolean muxSum);
	void (*final_combiner_input_NV)(GLIContext ctx, GLenum variable, GLenum input, GLenum mapping, GLenum componentUsage);
	void (*get_combiner_input_parameterfv_NV)(GLIContext ctx, GLenum stage, GLenum portion, GLenum variable, GLenum pname, GLfloat* params);
	void (*get_combiner_input_parameteriv_NV)(GLIContext ctx, GLenum stage, GLenum portion, GLenum variable, GLenum pname, GLint* params);
	void (*get_combiner_output_parameterfv_NV)(GLIContext ctx, GLenum stage, GLenum portion, GLenum pname, GLfloat* params);
	void (*get_combiner_output_parameteriv_NV)(GLIContext ctx, GLenum stage, GLenum portion, GLenum pname, GLint* params);
	void (*get_final_combiner_input_parameterfv_NV)(GLIContext ctx, GLenum variable, GLenum pname, GLfloat* params);
	void (*get_final_combiner_input_parameteriv_NV)(GLIContext ctx, GLenum variable, GLenum pname, GLint* params);
	void (*combiner_stage_parameterfv_NV)(GLIContext ctx, GLenum stage, GLenum pname, GLfloat* params);
	void (*get_combiner_stage_parameterfv_NV)(GLIContext ctx, GLenum stage, GLenum pname, GLfloat* params);
	void (*texture_range_APPLE)(GLIContext ctx, GLenum target, GLsizei length, GLvoid* pointer);
	void (*get_tex_parameter_pointerv_APPLE)(GLIContext ctx, GLenum target, GLenum pname, GLvoid** params);
	void (*blend_equation_separate_ATI)(GLIContext ctx, GLenum equationRGB, GLenum equationAlpha);
	void (*sample_coverage)(GLIContext ctx, GLclampf value, GLboolean invert);
	void (*sample_pass)(GLIContext ctx, GLenum mode);
	void (*pn_trianglesi_ATI)(GLIContext ctx, GLenum pname, GLint param);
	void (*pn_trianglesf_ATI)(GLIContext ctx, GLenum pname, GLfloat param);
	void (*gen_fences_APPLE)(GLIContext ctx, GLsizei n, GLuint* fences);
	void (*delete_fences_APPLE)(GLIContext ctx, GLsizei n, GLuint* fences);
	void (*set_fence_APPLE)(GLIContext ctx, GLuint fence);
	GLboolean (*is_fence_APPLE)(GLIContext ctx, GLuint fence);
	GLboolean (*test_fence_APPLE)(GLIContext ctx, GLuint fence);
	void (*finish_fence_APPLE)(GLIContext ctx, GLuint fence);
	GLboolean (*test_object_APPLE)(GLIContext ctx, GLenum object, GLuint name);
	void (*finish_object_APPLE)(GLIContext ctx, GLenum object, GLuint name);
	void (*bind_program_ARB)(GLIContext ctx, GLenum target, GLuint program);
	void (*delete_programs_ARB)(GLIContext ctx, GLsizei n, GLuint* programs);
	void (*gen_programs_ARB)(GLIContext ctx, GLsizei n, GLuint* programs);
	GLboolean (*is_program_ARB)(GLIContext ctx, GLuint program);
	void (*vertex_attrib1s_ARB)(GLIContext ctx, GLuint index, GLshort x);
	void (*vertex_attrib1f_ARB)(GLIContext ctx, GLuint index, GLfloat x);
	void (*vertex_attrib1d_ARB)(GLIContext ctx, GLuint index, GLdouble x);
	void (*vertex_attrib2s_ARB)(GLIContext ctx, GLuint index, GLshort x, GLshort y);
	void (*vertex_attrib2f_ARB)(GLIContext ctx, GLuint index, GLfloat x, GLfloat y);
	void (*vertex_attrib2d_ARB)(GLIContext ctx, GLuint index, GLdouble x, GLdouble y);
	void (*vertex_attrib3s_ARB)(GLIContext ctx, GLuint index, GLshort x, GLshort y, GLshort z);
	void (*vertex_attrib3f_ARB)(GLIContext ctx, GLuint index, GLfloat x, GLfloat y, GLfloat z);
	void (*vertex_attrib3d_ARB)(GLIContext ctx, GLuint index, GLdouble x, GLdouble y, GLdouble z);
	void (*vertex_attrib4s_ARB)(GLIContext ctx, GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);
	void (*vertex_attrib4f_ARB)(GLIContext ctx, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
	void (*vertex_attrib4d_ARB)(GLIContext ctx, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
	void (*vertex_attrib4Nub_ARB)(GLIContext ctx, GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);
	void (*vertex_attrib1sv_ARB)(GLIContext ctx, GLuint index, GLshort* v);
	void (*vertex_attrib1fv_ARB)(GLIContext ctx, GLuint index, GLfloat* v);
	void (*vertex_attrib1dv_ARB)(GLIContext ctx, GLuint index, GLdouble* v);
	void (*vertex_attrib2sv_ARB)(GLIContext ctx, GLuint index, GLshort* v);
	void (*vertex_attrib2fv_ARB)(GLIContext ctx, GLuint index, GLfloat* v);
	void (*vertex_attrib2dv_ARB)(GLIContext ctx, GLuint index, GLdouble* v);
	void (*vertex_attrib3sv_ARB)(GLIContext ctx, GLuint index, GLshort* v);
	void (*vertex_attrib3fv_ARB)(GLIContext ctx, GLuint index, GLfloat* v);
	void (*vertex_attrib3dv_ARB)(GLIContext ctx, GLuint index, GLdouble* v);
	void (*vertex_attrib4bv_ARB)(GLIContext ctx, GLuint index, GLbyte* v);
	void (*vertex_attrib4sv_ARB)(GLIContext ctx, GLuint index, GLshort* v);
	void (*vertex_attrib4iv_ARB)(GLIContext ctx, GLuint index, GLint* v);
	void (*vertex_attrib4ubv_ARB)(GLIContext ctx, GLuint index, GLubyte* v);
	void (*vertex_attrib4usv_ARB)(GLIContext ctx, GLuint index, GLushort* v);
	void (*vertex_attrib4uiv_ARB)(GLIContext ctx, GLuint index, GLuint* v);
	void (*vertex_attrib4fv_ARB)(GLIContext ctx, GLuint index, GLfloat* v);
	void (*vertex_attrib4dv_ARB)(GLIContext ctx, GLuint index, GLdouble* v);
	void (*vertex_attrib4Nbv_ARB)(GLIContext ctx, GLuint index, GLbyte* v);
	void (*vertex_attrib4Nsv_ARB)(GLIContext ctx, GLuint index, GLshort* v);
	void (*vertex_attrib4Niv_ARB)(GLIContext ctx, GLuint index, GLint* v);
	void (*vertex_attrib4Nubv_ARB)(GLIContext ctx, GLuint index, GLubyte* v);
	void (*vertex_attrib4Nusv_ARB)(GLIContext ctx, GLuint index, GLushort* v);
	void (*vertex_attrib4Nuiv_ARB)(GLIContext ctx, GLuint index, GLuint* v);
	void (*vertex_attrib_pointer_ARB)(GLIContext ctx, GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, GLvoid* pointer);
	void (*enable_vertex_attrib_array_ARB)(GLIContext ctx, GLuint index);
	void (*disable_vertex_attrib_array_ARB)(GLIContext ctx, GLuint index);
	void (*get_vertex_attribdv_ARB)(GLIContext ctx, GLuint index, GLenum pname, GLdouble* params);
	void (*get_vertex_attribfv_ARB)(GLIContext ctx, GLuint index, GLenum pname, GLfloat* params);
	void (*get_vertex_attribiv_ARB)(GLIContext ctx, GLuint index, GLenum pname, GLint* params);
	void (*get_vertex_attrib_pointerv_ARB)(GLIContext ctx, GLuint index, GLenum pname, GLvoid** pointer);
	void (*program_env_parameter4d_ARB)(GLIContext ctx, GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
	void (*program_env_parameter4dv_ARB)(GLIContext ctx, GLenum target, GLuint index, GLdouble* params);
	void (*program_env_parameter4f_ARB)(GLIContext ctx, GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
	void (*program_env_parameter4fv_ARB)(GLIContext ctx, GLenum target, GLuint index, GLfloat* params);
	void (*program_local_parameter4d_ARB)(GLIContext ctx, GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
	void (*program_local_parameter4dv_ARB)(GLIContext ctx, GLenum target, GLuint index, GLdouble* params);
	void (*program_local_parameter4f_ARB)(GLIContext ctx, GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
	void (*program_local_parameter4fv_ARB)(GLIContext ctx, GLenum target, GLuint index, GLfloat* params);
	void (*get_program_env_parameterdv_ARB)(GLIContext ctx, GLenum target, GLuint index, GLdouble* params);
	void (*get_program_env_parameterfv_ARB)(GLIContext ctx, GLenum target, GLuint index, GLfloat* params);
	void (*get_program_local_parameterdv_ARB)(GLIContext ctx, GLenum target, GLuint index, GLdouble* params);
	void (*get_program_local_parameterfv_ARB)(GLIContext ctx, GLenum target, GLuint index, GLfloat* params);
	void (*program_string_ARB)(GLIContext ctx, GLenum target, GLenum format, GLsizei len, GLvoid* string);
	void (*get_program_string_ARB)(GLIContext ctx, GLenum target, GLenum pname, GLvoid* string);
	void (*get_programiv_ARB)(GLIContext ctx, GLenum target, GLenum pname, GLint* params);
	void (*enable_vertex_attrib_ARB)(GLIContext ctx, GLuint index, GLenum pname);
	void (*disable_vertex_attrib_ARB)(GLIContext ctx, GLuint index, GLenum pname);
	GLboolean (*is_vertex_attrib_enabled_ARB)(GLIContext ctx, GLuint index, GLenum pname);
	void (*map_vertex_attrib1d_ARB)(GLIContext ctx, GLuint index, GLuint size, GLdouble u1, GLdouble u2, GLint stride, GLint order, GLdouble* points);
	void (*map_vertex_attrib1f_ARB)(GLIContext ctx, GLuint index, GLuint size, GLfloat u1, GLfloat u2, GLint stride, GLint order, GLfloat* points);
	void (*map_vertex_attrib2d_ARB)(GLIContext ctx, GLuint index, GLuint size, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, GLdouble* points);
	void (*map_vertex_attrib2f_ARB)(GLIContext ctx, GLuint index, GLuint size, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, GLfloat* points);
	void (*point_parameterf)(GLIContext ctx, GLenum pname, GLfloat param);
	void (*point_parameterfv)(GLIContext ctx, GLenum pname, GLfloat* params);
	void (*point_parameteri)(GLIContext ctx, GLenum pname, GLint param);
	void (*point_parameteriv)(GLIContext ctx, GLenum pname, GLint* params);
	void (*fog_coordf)(GLIContext ctx, GLfloat coord);
	void (*fog_coordfv)(GLIContext ctx, GLfloat* coord);
	void (*fog_coordd)(GLIContext ctx, GLdouble coord);
	void (*fog_coorddv)(GLIContext ctx, GLdouble* coord);
	void (*fog_coord_pointer)(GLIContext ctx, GLenum type, GLsizei stride, GLvoid* pointer);
	void (*vertex_array_parameteri_EXT)(GLIContext ctx, GLenum pname, GLint param);
	void (*bind_vertex_array_EXT)(GLIContext ctx, GLuint id);
	void (*delete_vertex_arrays_EXT)(GLIContext ctx, GLsizei n, GLuint* ids);
	void (*gen_vertex_arrays_EXT)(GLIContext ctx, GLsizei n, GLuint* ids);
	GLboolean (*is_vertex_array_EXT)(GLIContext ctx, GLuint id);
	void (*element_pointer_APPLE)(GLIContext ctx, GLenum type, GLvoid* pointer);
	void (*draw_element_array_APPLE)(GLIContext ctx, GLenum mode, GLint first, GLsizei count);
	void (*draw_range_element_array_APPLE)(GLIContext ctx, GLenum mode, GLuint start, GLuint end, GLint first, GLsizei count);
	void (*weightbv_ARB)(GLIContext ctx, GLint size, GLbyte* weights);
	void (*weightsv_ARB)(GLIContext ctx, GLint size, GLshort* weights);
	void (*weightiv_ARB)(GLIContext ctx, GLint size, GLint* weights);
	void (*weightfv_ARB)(GLIContext ctx, GLint size, GLfloat* weights);
	void (*weightdv_ARB)(GLIContext ctx, GLint size, GLdouble* weights);
	void (*weightubv_ARB)(GLIContext ctx, GLint size, GLubyte* weights);
	void (*weightusv_ARB)(GLIContext ctx, GLint size, GLushort* weights);
	void (*weightuiv_ARB)(GLIContext ctx, GLint size, GLuint* weights);
	void (*weight_pointer_ARB)(GLIContext ctx, GLint size, GLenum type, GLsizei stride, GLvoid* pointer);
	void (*vertex_blend_ARB)(GLIContext ctx, GLint count);
	void (*multi_draw_arrays)(GLIContext ctx, GLenum mode, GLint* first, GLsizei* count, GLsizei primcount);
	void (*multi_draw_elements)(GLIContext ctx, GLenum mode, GLsizei* count, GLenum type, GLvoid** indices, GLsizei primcount);
	void (*window_pos2d) (GLIContext ctx, GLdouble x, GLdouble y);
	void (*window_pos2dv) (GLIContext ctx, GLdouble* v);
	void (*window_pos2f) (GLIContext ctx, GLfloat x, GLfloat y);
	void (*window_pos2fv) (GLIContext ctx, GLfloat* v);
	void (*window_pos2i) (GLIContext ctx, GLint x, GLint y);
	void (*window_pos2iv) (GLIContext ctx, GLint* v);
	void (*window_pos2s) (GLIContext ctx, GLshort x, GLshort y);
	void (*window_pos2sv) (GLIContext ctx, GLshort* v);
	void (*window_pos3d) (GLIContext ctx, GLdouble x, GLdouble y, GLdouble z);
	void (*window_pos3dv) (GLIContext ctx, GLdouble* v);
	void (*window_pos3f) (GLIContext ctx, GLfloat x, GLfloat y, GLfloat z);
	void (*window_pos3fv) (GLIContext ctx, GLfloat* v);
	void (*window_pos3i) (GLIContext ctx, GLint x, GLint y, GLint z);
	void (*window_pos3iv) (GLIContext ctx, GLint* v);
	void (*window_pos3s) (GLIContext ctx, GLshort x, GLshort y, GLshort z);
	void (*window_pos3sv) (GLIContext ctx, GLshort* v);
	void (*active_stencil_face_EXT) (GLIContext ctx, GLenum face);
} }
alias __GLIFunctionDispatchRec GLIFunctionDispatch;

struct __AGLContextRec {
	GLIContext		rend;
	GLIFunctionDispatch	disp;
	AGLPrivate		priv;
}

/*
 * Functions
 */
extern (C):
AGLPixelFormat aglChoosePixelFormat (AGLDevice* gdevs, GLint ndev, GLint* attribs);
void aglDestroyPixelFormat (AGLPixelFormat pix);
AGLPixelFormat aglNextPixelFormat( AGLPixelFormat pix);
GLboolean aglDescribePixelFormat (AGLPixelFormat pix, GLint attrib, GLint* value);
AGLDevice* aglDevicesOfPixelFormat (AGLPixelFormat pix, GLint* ndevs);

AGLRendererInfo aglQueryRendererInfo (AGLDevice* gdevs, GLint ndev);
void aglDestroyRendererInfo (AGLRendererInfo rend);
AGLRendererInfo aglNextRendererInfo (AGLRendererInfo rend);
GLboolean aglDescribeRenderer (AGLRendererInfo rend, GLint prop, GLint* value);

AGLContext aglCreateContext (AGLPixelFormat pix, AGLContext share);
GLboolean aglDestroyContext (AGLContext ctx);
GLboolean aglCopyContext (AGLContext src, AGLContext dst, GLuint mask);
GLboolean aglUpdateContext (AGLContext ctx);

GLboolean aglSetCurrentContext (AGLContext ctx);
AGLContext aglGetCurrentContext ();

GLboolean aglSetDrawable (AGLContext ctx, AGLDrawable draw);
GLboolean aglSetOffScreen (AGLContext ctx, GLsizei width, GLsizei height, GLsizei rowbytes, GLvoid* baseaddr);
GLboolean aglSetFullScreen (AGLContext ctx, GLsizei width, GLsizei height, GLsizei freq, GLint device);
AGLDrawable aglGetDrawable (AGLContext ctx);

GLboolean aglSetVirtualScreen (AGLContext ctx, GLint screen);
GLint aglGetVirtualScreen (AGLContext ctx);

void aglGetVersion (GLint* major, GLint* minor);

GLboolean aglConfigure (GLenum pname, GLuint param);

void aglSwapBuffers (AGLContext ctx);

GLboolean aglEnable (AGLContext ctx, GLenum pname);
GLboolean aglDisable (AGLContext ctx, GLenum pname);
GLboolean aglIsEnabled (AGLContext ctx, GLenum pname);
GLboolean aglSetInteger (AGLContext ctx, GLenum pname, GLint* params);
GLboolean aglGetInteger (AGLContext ctx, GLenum pname, GLint* params);

GLboolean aglUseFont (AGLContext ctx, GLint fontID, Style face, GLint size, GLint first, GLint count, GLint base);

GLenum aglGetError ();
GLubyte* aglErrorString (GLenum code);

void aglResetLibrary ();

void aglSurfaceTexture (AGLContext context, GLenum target, GLenum internalformat, AGLContext surfacecontext);

GLboolean aglCreatePBuffer (GLint width, GLint height, GLenum target, GLenum internalFormat, long max_level, AGLPbuffer* pbuffer);
GLboolean aglDestroyPBuffer (AGLPbuffer pbuffer);
GLboolean aglDescribePBuffer (AGLPbuffer pbuffer, GLint* width, GLint* height, GLenum* target, GLenum* internalFormat, GLint* max_level);
GLboolean aglTexImagePBuffer (AGLContext ctx, AGLPbuffer pbuffer, GLint source);

GLboolean aglSetPBuffer (AGLContext ctx, AGLPbuffer pbuffer, GLint face, GLint level, GLint screen);
GLboolean aglGetPBuffer (AGLContext ctx, AGLPbuffer* pbuffer, GLint* face, GLint* level, GLint* screen);
}
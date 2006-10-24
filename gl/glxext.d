module c.gl.glxext;

version (linux) {
private import c.gl.gl, c.gl.glx;
private import std.loader;

/*
 * Constants
 */
/*
 * ARB Extensions
 */
// 5 - GLX_ARB_multisample
const GLuint GLX_SAMPLE_BUFFERS_ARB		= 100000;
const GLuint GLX_SAMPLES_ARB			= 100001;

// 39 - GLX_ARB_fbconfig_float
const GLuint GLX_RGBA_FLOAT_TYPE_ARB		= 0x20B9;
const GLuint GLX_RGBA_FLOAT_BIT_ARB		= 0x00000004;

/*
 * Non-ARB Extensions
 */
// 25 - GLX_SGIS_multisample
const GLuint GLX_SAMPLE_BUFFERS_SGIS		= 100000;
const GLuint GLX_SAMPLES_SGIS			= 100001;

// 28 - GLX_EXT_visual_info
const GLuint GLX_X_VISUAL_TYPE_EXT		= 0x22;
const GLuint GLX_TRANSPARENT_TYPE_EXT		= 0x23;
const GLuint GLX_TRANSPARENT_INDEX_VALUE_EXT	= 0x24;
const GLuint GLX_TRANSPARENT_RED_VALUE_EXT	= 0x25;
const GLuint GLX_TRANSPARENT_GREEN_VALUE_EXT	= 0x26;
const GLuint GLX_TRANSPARENT_BLUE_VALUE_EXT	= 0x27;
const GLuint GLX_TRANSPARENT_ALPHA_VALUE_EXT	= 0x28;
const GLuint GLX_NONE_EXT			= 0x8000;
const GLuint GLX_TRUE_COLOR_EXT			= 0x8002;
const GLuint GLX_DIRECT_COLOR_EXT		= 0x8003;
const GLuint GLX_PSEUDO_COLOR_EXT		= 0x8004;
const GLuint GLX_STATIC_COLOR_EXT		= 0x8005;
const GLuint GLX_GRAY_SCALE_EXT			= 0x8006;
const GLuint GLX_STATIC_GRAY_EXT		= 0x8007;
const GLuint GLX_TRANSPARENT_RGB_EXT		= 0x8008;
const GLuint GLX_TRANSPARENT_INDEX_EXT		= 0x8009;

// 44 - GLX_EXT_visual_rating
const GLuint GLX_VISUAL_CAVEAT_EXT		= 0x20;
const GLuint GLX_SLOW_VISUAL_EXT		= 0x8001;
const GLuint GLX_NON_CONFORMANT_VISUAL_EXT	= 0x800D;

// 47 - GLX_EXT_import_context
const GLuint GLX_SHARE_CONTEXT_EXT		= 0x800A;
const GLuint GLX_VISUAL_ID_EXT			= 0x800B;
const GLuint GLX_SCREEN_EXT			= 0x800C;

// 48 - GLX_SGIX_fbconfig
const GLuint GLX_WINDOW_BIT_SGIX		= 0x00000001;
const GLuint GLX_PIXMAP_BIT_SGIX		= 0x00000002;
const GLuint GLX_RGBA_BIT_SGIX			= 0x00000001;
const GLuint GLX_COLOR_INDEX_BIT_SGIX		= 0x00000002;
const GLuint GLX_DRAWABLE_TYPE_SGIX		= 0x8010;
const GLuint GLX_RENDER_TYPE_SGIX		= 0x8011;
const GLuint GLX_X_RENDERABLE_SGIX		= 0x8012;
const GLuint GLX_FBCONFIG_ID_SGIX		= 0x8013;
const GLuint GLX_RGBA_TYPE_SGIX			= 0x8014;
const GLuint GLX_COLOR_INDEX_TYPE_SGIX		= 0x8015;

// 50 - GLX_SGIX_pbuffer
const GLuint GLX_PBUFFER_BIT_SGIX		= 0x00000004;
const GLuint GLX_BUFFER_CLOBBER_MASK_SGIX	= 0x08000000;
const GLuint GLX_FRONT_LEFT_BUFFER_BIT_SGIX	= 0x00000001;
const GLuint GLX_FRONT_RIGHT_BUFFER_BIT_SGIX	= 0x00000002;
const GLuint GLX_BACK_LEFT_BUFFER_BIT_SGIX	= 0x00000004;
const GLuint GLX_BACK_RIGHT_BUFFER_BIT_SGIX	= 0x00000008;
const GLuint GLX_AUX_BUFFERS_BIT_SGIX		= 0x00000010;
const GLuint GLX_DEPTH_BUFFER_BIT_SGIX		= 0x00000020;
const GLuint GLX_STENCIL_BUFFER_BIT_SGIX	= 0x00000040;
const GLuint GLX_ACCUM_BUFFER_BIT_SGIX		= 0x00000080;
const GLuint GLX_SAMPLE_BUFFERS_BIT_SGIX	= 0x00000100;
const GLuint GLX_MAX_PBUFFER_WIDTH_SGIX		= 0x8016;
const GLuint GLX_MAX_PBUFFER_HEIGHT_SGIX	= 0x8017;
const GLuint GLX_MAX_PBUFFER_PIXELS_SGIX	= 0x8018;
const GLuint GLX_OPTIMAL_PBUFFER_WIDTH_SGIX	= 0x8019;
const GLuint GLX_OPTIMAL_PBUFFER_HEIGHT_SGIX	= 0x801A;
const GLuint GLX_PRESERVED_CONTENTS_SGIX	= 0x801B;
const GLuint GLX_LARGEST_PBUFFER_SGIX		= 0x801C;
const GLuint GLX_WIDTH_SGIX			= 0x801D;
const GLuint GLX_HEIGHT_SGIX			= 0x801E;
const GLuint GLX_EVENT_MASK_SGIX		= 0x801F;
const GLuint GLX_DAMAGED_SGIX			= 0x8020;
const GLuint GLX_SAVED_SGIX			= 0x8021;
const GLuint GLX_WINDOW_SGIX			= 0x8022;
const GLuint GLX_PBUFFER_SGIX			= 0x8023;

// 83 - GLX_SGIX_video_resize
const GLuint GLX_SYNC_FRAME_SGIX		= 0x00000000;
const GLuint GLX_SYNC_SWAP_SGIX			= 0x00000001;

// 142 - GLX_SGIS_blended_overlay
const GLuint GLX_BLENDED_RGBA_SGIS		= 0x8025;

// 207 - GLX_3DFX_multisample
const GLuint GLX_SAMPLE_BUFFERS_3DFX		= 0x8050;
const GLuint GLX_SAMPLES_3DFX			= 0x8051;

// 218 - GLX_MESA_set_3dfx_mode
const GLuint GLX_3DFX_WINDOW_MODE_MESA		= 0x1;
const GLuint GLX_3DFX_FULLSCREEN_MODE_MESA	= 0x2;

// 234 - GLX_SGIX_visual_select_group
const GLuint GLX_VISUAL_SELECT_GROUP_SGIX	= 0x8028;

// 237 - GLX_OML_swap_method
const GLuint GLX_SWAP_METHOD_OML		= 0x8060;
const GLuint GLX_SWAP_EXCHANGE_OML		= 0x8061;
const GLuint GLX_SWAP_COPY_OML			= 0x8062;
const GLuint GLX_SWAP_UNDEFINED_OML		= 0x8063;

// 307 - GLX_SGIX_hyperpipe
const GLuint GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX= 80;
const GLuint GLX_BAD_HYPERPIPE_CONFIG_SGIX	= 91;
const GLuint GLX_BAD_HYPERPIPE_SGIX		= 92;
const GLuint GLX_HYPERPIPE_DISPLAY_PIPE_SGIX	= 0x00000001;
const GLuint GLX_HYPERPIPE_RENDER_PIPE_SGIX	= 0x00000002;
const GLuint GLX_PIPE_RECT_SGIX			= 0x00000001;
const GLuint GLX_PIPE_RECT_LIMITS_SGIX		= 0x00000002;
const GLuint GLX_HYPERPIPE_STEREO_SGIX		= 0x00000003;
const GLuint GLX_HYPERPIPE_PIXEL_AVERAGE_SGIX	= 0x00000004;
const GLuint GLX_HYPERPIPE_ID_SGIX		= 0x8030;

/*
 * Structs and Classes
 */
// Non-ARB 307 - GLX_SGIX_hyperpipe
alias int GLXHyperpipeNetworkSGIX;
struct {
	char[GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX] pipeName;
	int networkId;
}
alias int GLXHyperpipeConfigSGIX;
struct {
	char[GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX] pipeName;
	int channel;
	uint participationType;
	int timeSlice;
}
alias int GLXPipeRect;
struct {
	char[GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX] pipeName;
	int srcXOrigin;
	int srcYOrigin;
	int srcWidth;
	int srcHeight;
	int destXOrigin;
	int destYOrigin;
	int destWidth;
	int destHeight;
}
alias int GLXPipeRectLimits;
struct {
	char[GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX] pipeName;
	int XOrigin;
	int YOrigin;
	int maxHeight;
	int maxWidth;
}

/*
 * Functions
 */
private HXModule glxextdrv;
private void* getProc(char[] procname) {
	void* symbol = ExeModule_GetSymbol(glxextdrv, procname);
	if (symbol is null) {
		printf ("Failed to load GLX extension proc address " ~ procname ~ ".\n");
	}
	return (symbol);
}

static this () {
	glxextdrv = ExeModule_Load("libGLX.so");
	glXGetProcAddressARB = cast(pfglXGetProcAddressARB)getProc("glXGetProcAddressARB");

	glXSwapIntervalSGI = cast(pfglXSwapIntervalSGI)getProc("glXSwapIntervalSGI");

	glXGetVideoSyncSGI = cast(pfglXGetVideoSyncSGI)getProc("glXGetVideoSyncSGI");
	glXWaitVideoSyncSGI = cast(pfglXWaitVideoSyncSGI)getProc("glXWaitVideoSyncSGI");

	glXMakeCurrentReadSGI = cast(pfglXMakeCurrentReadSGI)getProc("glXMakeCurrentReadSGI");
	glXGetCurrentReadDrawableSGI = cast(pfglXGetCurrentReadDrawableSGI)getProc("glXGetCurrentReadDrawableSGI");

	glXCreateGLXVideoSourceSGIX = cast(pfglXCreateGLXVideoSourceSGIX)getProc("glXCreateGLXVideoSourceSGIX");
	glXDestroyGLXVideoSourceSGIX = cast(pfglXDestroyGLXVideoSourceSGIX)getProc("glXDestroyGLXVideoSourceSGIX");

	glXGetCurrentDisplayEXT = cast(pfglXGetCurrentDisplayEXT)getProc("glXGetCurrentDisplayEXT");
	glXQueryContextInfoEXT = cast(pfglXQueryContextInfoEXT)getProc("glXQueryContextInfoEXT");
	glXGetContextIDEXT = cast(pfglXGetContextIDEXT)getProc("glXGetContextIDEXT");
	glXImportContextEXT = cast(pfglXImportContextEXT)getProc("glXImportContextEXT");
	glXFreeContextEXT = cast(pfglXFreeContextEXT)getProc("glXFreeContextEXT");

	glXGetFBConfigAttribSGIX = cast(pfglXGetFBConfigAttribSGIX)getProc("glXGetFBConfigAttribSGIX");
	glXChooseFBConfigSGIX = cast(pfglXChooseFBConfigSGIX)getProc("glXChooseFBConfigSGIX");
	glXCreateGLXPixmapWithConfigSGIX = cast(pfglXCreateGLXPixmapWithConfigSGIX)getProc("glXCreateGLXPixmapWithConfigSGIX");
	glXCreateContextWithConfigSGIX = cast(pfglXCreateContextWithConfigSGIX)getProc("glXCreateContextWithConfigSGIX");
	glXGetVisualFromFBConfigSGIX = cast(pfglXGetVisualFromFBConfigSGIX)getProc("glXGetVisualFromFBConfigSGIX");
	glXGetFBConfigFromVisualSGIX = cast(pfglXGetFBConfigFromVisualSGIX)getProc("glXGetFBConfigFromVisualSGIX");

	glXCreateGLXPbufferSGIX = cast(pfglXCreateGLXPbufferSGIX)getProc("glXCreateGLXPbufferSGIX");
	glXDestroyGLXPbufferSGIX = cast(pfglXDestroyGLXPbufferSGIX)getProc("glXDestroyGLXPbufferSGIX");
	glXQueryGLXPbufferSGIX = cast(pfglXQueryGLXPbufferSGIX)getProc("glXQueryGLXPbufferSGIX");
	glXSelectEventSGIX = cast(pfglXSelectEventSGIX)getProc("glXSelectEventSGIX");
	glXGetSelectedEventSGIX = cast(pfglXGetSelectedEventSGIX)getProc("glXGetSelectedEventSGIX");

	glXBindChannelToWindowSGIX = cast(pfglXBindChannelToWindowSGIX)getProc("glXBindChannelToWindowSGIX");
	glXChannelRectSGIX = cast(pfglXChannelRectSGIX)getProc("glXChannelRectSGIX");
	glXQueryChannelRectSGIX = cast(pfglXQueryChannelRectSGIX)getProc("glXQueryChannelRectSGIX");
	glXQueryChannelDeltasSGIX = cast(pfglXQueryChannelDeltasSGIX)getProc("glXQueryChannelDeltasSGIX");
	glXChannelRectSyncSGIX = cast(pfglXChannelRectSyncSGIX)getProc("glXChannelRectSyncSGIX");

	glXJoinSwapGroupSGIX = cast(pfglXJoinSwapGroupSGIX)getProc("glXJoinSwapGroupSGIX");

	glXBindSwapBarrierSGIX = cast(pfglXBindSwapBarrierSGIX)getProc("glXBindSwapBarrierSGIX");
	glXQueryMaxSwapBarriersSGIX = cast(pfglXQueryMaxSwapBarriersSGIX)getProc("glXQueryMaxSwapBarriersSGIX");

	glXGetTransparentIndexSUN = cast(pfglXGetTransparentIndexSUN)getProc("glXGetTransparentIndexSUN");

	glXCopySubBufferMESA = cast(pfglXCopySubBufferMESA)getProc("glXCopySubBufferMESA");

	glXCreateGLXPixmapMESA = cast(pfglXCreateGLXPixmapMESA)getProc("glXCreateGLXPixmapMESA");

	glXReleaseBuffersMESA = cast(pfglXReleaseBuffersMESA)getProc("glXReleaseBuffersMESA");

	glXSet3DfxModeMESA = cast(pfglXSet3DfxModeMESA)getProc("glXSet3DfxModeMESA");

	glXGetSyncValuesOML = cast(pfglXGetSyncValuesOML)getProc("glXGetSyncValuesOML");
	glXGetMscRateOML = cast(pfglXGetMscRateOML)getProc("glXGetMscRateOML");
	glXSwapBuffersMscOML = cast(pfglXSwapBuffersMscOML)getProc("glXSwapBuffersMscOML");
	glXWaitForMscOML = cast(pfglXWaitForMscOML)getProc("glXWaitForMscOML");
	glXWaitForSbcOML = cast(pfglXWaitForSbcOML)getProc("glXWaitForSbcOML");

	glXQueryHyperpipeNetworkSGIX = cast(pfglXQueryHyperpipeNetworkSGIX)getProc("glXQueryHyperpipeNetworkSGIX");
	glXHyperpipeConfigSGIX = cast(pfglXHyperpipeConfigSGIX)getProc("glXHyperpipeConfigSGIX");
	glXQueryHyperpipeConfigSGIX = cast(pfglXQueryHyperpipeConfigSGIX)getProc("glXQueryHyperpipeConfigSGIX");
	glXDestroyHyperpipeConfigSGIX = cast(pfglXDestroyHyperpipeConfigSGIX)getProc("glXDestroyHyperpipeConfigSGIX");
	glXBindHyperpipeSGIX = cast(pfglXBindHyperpipeSGIX)getProc("glXBindHyperpipeSGIX");
	glXQueryHyperpipeBestAttribSGIX = cast(pfglXQueryHyperpipeBestAttribSGIX)getProc("glXQueryHyperpipeBestAttribSGIX");
	glXHyperpipeAttribSGIX = cast(pfglXHyperpipeAttribSGIX)getProc("glXHyperpipeAttribSGIX");
	glXQueryHyperpipeAttribSGIX = cast(pfglXQueryHyperpipeAttribSGIX)getProc("glXQueryHyperpipeAttribSGIX");

	glXGetAGPOffsetMESA = cast(pfglXGetAGPOffsetMESA)getProc("glXGetAGPOffsetMESA");
}

static ~this () {
	ExeModule_Release(glxextdrv);
}

extern (C):
/*
 * ARB Extensions
 */
// 2 - ARB_get_proc_address
typedef GLvoid* function(GLchar*) pfiglXGetProcAddressARB;
pfiglXGetProcAddressARB iglXGetProcAddressARB;

/*
 * Non-ARB Extensions
 */
// 40 - GLX_SGI_swap_control
typedef GLint function(GLint) pfglXSwapIntervalSGI;
pfglXSwapIntervalSGI glXSwapIntervalSGI;

// 41 - GLX_SGI_video_sync
typedef GLint function(GLuint*) pfglXGetVideoSyncSGI;
typedef GLint function(GLint, GLint, GLint*) pfglXWaitVideoSyncSGI;
pfglXGetVideoSyncSGI glXGetVideoSyncSGI;
pfglXWaitVideoSyncSGI glXWaitVideoSyncSGI;

// 42 - GLX_SGI_make_read_current
typedef Bool function(Display*, GLXDrawable, GLXDrawable, GLXContext) pfglXMakeCurrentReadSGI;
typedef GLXDrawable function() pfglXGetCurrentReadDrawableSGI;
pfglXMakeCurrentReadSGI glXMakeCurrentReadSGI;
pfglXGetCurrentReadDrawableSGI glXGetCurrentReadDrawableSGI;

// 43 - GLX_SGIX_video_source
alias XID GLXVideoSourceSGIX;
typedef GLXVideoSourceSGIX function(Display*, GLint, VLServer, VLPath, GLint, VLNode) pfglXCreateGLXVideoSourceSGIX;
typedef GLvoid function(Display*, GLXVideoSourceSGIX) pfglXDestroyGLXVideoSourceSGIX;
pfglXCreateGLXVideoSourceSGIX glXCreateGLXVideoSourceSGIX;
pfglXDestroyGLXVideoSourceSGIX glXDestroyGLXVideoSourceSGIX;

// 47 - GLX_EXT_import_context
typedef Display* function() pfglXGetCurrentDisplayEXT;
typedef GLint function(Display*, GLXContext, GLint, GLint*) pfglXQueryContextInfoEXT;
typedef GLXContextID function(GLXContext) pfglXGetContextIDEXT;
typedef GLXContext function(Display*, GLXContextID) pfglXImportContextEXT;
typedef GLvoid function(Display*, GLXContext) pfglXFreeContextEXT;
pfglXGetCurrentDisplayEXT glXGetCurrentDisplayEXT;
pfglXQueryContextInfoEXT glXQueryContextInfoEXT;
pfglXGetContextIDEXT glXGetContextIDEXT;
pfglXImportContextEXT glXImportContextEXT;
pfglXFreeContextEXT glXFreeContextEXT;

// 49 - GLX_SGIX_fbconfig
typedef int function(Display*, GLXFBConfigSGIX, GLint, GLint*) pfglXGetFBConfigAttribSGIX;
typedef GLXFBConfigSGIX* function(Display*, GLint, GLint*, GLint*) pfglXChooseFBConfigSGIX;
typedef GLXPixmap function(Display*, GLXFBConfig, Pixmap) pfglXCreateGLXPixmapWithConfigSGIX;
typedef GLXContext function(Display*, GLXFBConfig, GLint, GLXContext, Bool) pfglXCreateContextWithConfigSGIX;
typedef XVisualInfo* function(Display*, GLXFBConfig) pfglXGetVisualFromFBConfigSGIX;
typedef GLXFBConfigSGIX function(Display*, XVisualInfo*) pfglXGetFBConfigFromVisualSGIX;
pfglXGetFBConfigAttribSGIX glXGetFBConfigAttribSGIX;
pfglXChooseFBConfigSGIX glXChooseFBConfigSGIX;
pfglXCreateGLXPixmapWithConfigSGIX glXCreateGLXPixmapWithConfigSGIX;
pfglXCreateContextWithConfigSGIX glXCreateContextWithConfigSGIX;
pfglXGetVisualFromFBConfigSGIX glXGetVisualFromFBConfigSGIX;
pfglXGetFBConfigFromVisualSGIX glXGetFBConfigFromVisualSGIX;

// 50 - GLX_SGIX_pbuffer
typedef GLXPbuffer function(Display*, GLXFBConfig, GLuint, GLuint, GLint*) pfglXCreateGLXPbufferSGIX;
typedef GLvoid function(Display*, GLXPbuffer) pfglXDestroyGLXPbufferSGIX;
typedef GLvoid function(Display*, GLXPbuffer, GLint, GLuint*) pfglXQueryGLXPbufferSGIX;
typedef GLvoid function(Display*, GLXDrawable, GLulong) pfglXSelectEventSGIX;
typedef GLvoid function(Display*, GLXDrawable, GLulong*) pfglXGetSelectedEventSGIX;
pfglXCreateGLXPbufferSGIX glXCreateGLXPbufferSGIX;
pfglXDestroyGLXPbufferSGIX glXDestroyGLXPbufferSGIX;
pfglXQueryGLXPbufferSGIX glXQueryGLXPbufferSGIX;
pfglXSelectEventSGIX glXSelectEventSGIX;
pfglXGetSelectedEventSGIX glXGetSelectedEventSGIX;

// 83 - GLX_SGIX_video_resize
typedef GLint function(Display*, GLint, GLint, Window) pfglXBindChannelToWindowSGIX;
typedef GLint function(Display*, GLint, GLint, GLint, GLint, GLint, GLint) pfglXChannelRectSGIX;
typedef GLint function(Display*, GLint, GLint, GLint*, GLint*, GLint*, GLint*) pfglXQueryChannelRectSGIX;
typedef GLint function(Display*, GLint, GLint, GLint*, GLint*, GLint*, GLint*) pfglXQueryChannelDeltasSGIX;
typedef GLint function(Display*, GLint, GLint, GLenum) pfglXChannelRectSyncSGIX;
pfglXBindChannelToWindowSGIX glXBindChannelToWindowSGIX;
pfglXChannelRectSGIX glXChannelRectSGIX;
pfglXQueryChannelRectSGIX glXQueryChannelRectSGIX;
pfglXQueryChannelDeltasSGIX glXQueryChannelDeltasSGIX;
pfglXChannelRectSyncSGIX glXChannelRectSyncSGIX;

// 91 - GLX_SGIX_swap_group
typedef GLvoid function(Display*, GLXDrawable, GLXDrawable) pfglXJoinSwapGroupSGIX;
pfglXJoinSwapGroupSGIX glXJoinSwapGroupSGIX;

// 92 - GLX_SGIX_swap_barrier
typedef GLvoid function(Display*, GLXDrawable, GLint) pfglXBindSwapBarrierSGIX;
typedef Bool function(Display*, GLint, GLint*) pfglXQueryMaxSwapBarriersSGIX;
pfglXBindSwapBarrierSGIX glXBindSwapBarrierSGIX;
pfglXQueryMaxSwapBarriersSGIX glXQueryMaxSwapBarriersSGIX;

// 183 - GLX_SUN_get_transparent_index
typedef Status function(Display*, Window, Window, GLulong*) pfglXGetTransparentIndexSUN;
pfglXGetTransparentIndexSUN glXGetTransparentIndexSUN;

// 215 - GLX_MESA_copy_sub_buffer
typedef GLvoid function(Display*, GLXDrawable, GLint, GLint, GLint, GLint) pfglXCopySubBufferMESA;
pfglXCopySubBufferMESA glXCopySubBufferMESA;

// 216 - GLX_MESA_pixmap_colormap
typedef GLXPixmap function(Display*, XVisualInfo*, Pixmap, Colormap) pfglXCreateGLXPixmapMESA;
pfglXCreateGLXPixmapMESA glXCreateGLXPixmapMESA;

// 217 - GLX_MESA_release_buffers
typedef Bool function(Display*, GLXDrawable) pfglXReleaseBuffersMESA;
pfglXReleaseBuffersMESA glXReleaseBuffersMESA;

// 218 - GLX_MESA_set_3dfx_mode
typedef GLboolean function(GLint) pfglXSet3DfxModeMESA;
pfglXSet3DfxModeMESA glXSet3DfxModeMESA;

// 238 - GLX_OML_sync_control
typedef Bool function(Display*, GLXDrawable, GLlong*, GLlong*, GLlong*) pfglXGetSyncValuesOML;
typedef Bool function(Display*, GLXDrawable, GLint*, GLint*) pfglXGetMscRateOML;
typedef GLlong function(Display*, GLXDrawable, GLlong, GLlong, GLlong) pfglXSwapBuffersMscOML;
typedef Bool function(Display*, GLXDrawable, GLlong, GLlong, GLlong, GLlong*, GLlong*, GLlong*) pfglXWaitForMscOML;
typedef Bool function(Display*, GLXDrawable, GLlong, GLlong*, GLlong*, GLlong*) pfglXWaitForSbcOML;
pfglXGetSyncValuesOML glXGetSyncValuesOML;
pfglXGetMscRateOML glXGetMscRateOML;
pfglXSwapBuffersMscOML glXSwapBuffersMscOML;
pfglXWaitForMscOML glXWaitForMscOML;
pfglXWaitForSbcOML glXWaitForSbcOML;

// 307 - GLX_SGIX_hyperpipe
typedef GLXHyperpipeNetworkSGIX* function(Display*, GLint*) pfglXQueryHyperpipeNetworkSGIX;
typedef GLint function(Display*, GLint, GLint, GLXHyperpipeConfigSGIX*, GLint*) pfglXHyperpipeConfigSGIX;
typedef GLXHyperpipeConfigSGIX* function(Display*, GLint, GLint*) pfglXQueryHyperpipeConfigSGIX;
typedef GLint function(Display*, GLint) pfglXDestroyHyperpipeConfigSGIX;
typedef GLint function(Display*, GLint) pfglXBindHyperpipeSGIX;
typedef GLint function(Display*, GLint, GLint, GLint, GLvoid*, GLvoid*) pfglXQueryHyperpipeBestAttribSGIX;
typedef GLint function(Display*, GLint, GLint, GLint, GLvoid*) pfglXHyperpipeAttribSGIX;
typedef GLint function(Display*, GLint, GLint, GLint, GLvoid*) pfglXQueryHyperpipeAttribSGIX;
pfglXQueryHyperpipeNetworkSGIX glXQueryHyperpipeNetworkSGIX;
pfglXHyperpipeConfigSGIX glXHyperpipeConfigSGIX;
pfglXQueryHyperpipeConfigSGIX glXQueryHyperpipeConfigSGIX;
pfglXDestroyHyperpipeConfigSGIX glXDestroyHyperpipeConfigSGIX;
pfglXBindHyperpipeSGIX glXBindHyperpipeSGIX;
pfglXQueryHyperpipeBestAttribSGIX glXQueryHyperpipeBestAttribSGIX;
pfglXHyperpipeAttribSGIX glXHyperpipeAttribSGIX;
pfglXQueryHyperpipeAttribSGIX glXQueryHyperpipeAttribSGIX;

// 308 - GLX_MESA_agp_offset
typedef GLuint function(GLvoid*) pfglXGetAGPOffsetMESA;
pfglXGetAGPOffsetMESA glXGetAGPOffsetMESA;
}
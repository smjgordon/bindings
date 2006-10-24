module c.gl.wglext;

version (Windows) {
private import c.gl.gl;
private import std.c.windows.windows, std.loader;

/*
 * Constants
 */
/*
 * ARB Extensions
 */
// 4 - WGL_ARB_buffer_region
const GLuint WGL_FRONT_COLOR_BUFFER_BIT_ARB		= 0x00000001;
const GLuint WGL_BACK_COLOR_BUFFER_BIT_ARB		= 0x00000002;
const GLuint WGL_DEPTH_BUFFER_BIT_ARB			= 0x00000004;
const GLuint WGL_STENCIL_BUFFER_BIT_ARB			= 0x00000008;

// 5 - WGL_ARB_multisample
const GLuint WGL_SAMPLE_BUFFERS_ARB			= 0x2041;
const GLuint WGL_SAMPLES_ARB				= 0x2042;

// 9 - WGL_ARB_pixel_format
const GLuint WGL_NUMBER_PIXEL_FORMATS_ARB		= 0x2000;
const GLuint WGL_DRAW_TO_WINDOW_ARB			= 0x2001;
const GLuint WGL_DRAW_TO_BITMAP_ARB			= 0x2002;
const GLuint WGL_ACCELERATION_ARB			= 0x2003;
const GLuint WGL_NEED_PALETTE_ARB			= 0x2004;
const GLuint WGL_NEED_SYSTEM_PALETTE_ARB		= 0x2005;
const GLuint WGL_SWAP_LAYER_BUFFERS_ARB			= 0x2006;
const GLuint WGL_SWAP_METHOD_ARB			= 0x2007;
const GLuint WGL_NUMBER_OVERLAYS_ARB			= 0x2008;
const GLuint WGL_NUMBER_UNDERLAYS_ARB			= 0x2009;
const GLuint WGL_TRANSPARENT_ARB			= 0x200A;
const GLuint WGL_TRANSPARENT_RED_VALUE_ARB		= 0x2037;
const GLuint WGL_TRANSPARENT_GREEN_VALUE_ARB		= 0x2038;
const GLuint WGL_TRANSPARENT_BLUE_VALUE_ARB		= 0x2039;
const GLuint WGL_TRANSPARENT_ALPHA_VALUE_ARB		= 0x203A;
const GLuint WGL_TRANSPARENT_INDEX_VALUE_ARB		= 0x203B;
const GLuint WGL_SHARE_DEPTH_ARB			= 0x200C;
const GLuint WGL_SHARE_STENCIL_ARB			= 0x200D;
const GLuint WGL_SHARE_ACCUM_ARB			= 0x200E;
const GLuint WGL_SUPPORT_GDI_ARB			= 0x200F;
const GLuint WGL_SUPPORT_OPENGL_ARB			= 0x2010;
const GLuint WGL_DOUBLE_BUFFER_ARB			= 0x2011;
const GLuint WGL_STEREO_ARB				= 0x2012;
const GLuint WGL_PIXEL_TYPE_ARB				= 0x2013;
const GLuint WGL_COLOR_BITS_ARB				= 0x2014;
const GLuint WGL_RED_BITS_ARB				= 0x2015;
const GLuint WGL_RED_SHIFT_ARB				= 0x2016;
const GLuint WGL_GREEN_BITS_ARB				= 0x2017;
const GLuint WGL_GREEN_SHIFT_ARB			= 0x2018;
const GLuint WGL_BLUE_BITS_ARB				= 0x2019;
const GLuint WGL_BLUE_SHIFT_ARB				= 0x201A;
const GLuint WGL_ALPHA_BITS_ARB				= 0x201B;
const GLuint WGL_ALPHA_SHIFT_ARB			= 0x201C;
const GLuint WGL_ACCUM_BITS_ARB				= 0x201D;
const GLuint WGL_ACCUM_RED_BITS_ARB			= 0x201E;
const GLuint WGL_ACCUM_GREEN_BITS_ARB			= 0x201F;
const GLuint WGL_ACCUM_BLUE_BITS_ARB			= 0x2020;
const GLuint WGL_ACCUM_ALPHA_BITS_ARB			= 0x2021;
const GLuint WGL_DEPTH_BITS_ARB				= 0x2022;
const GLuint GL_STENCIL_BITS_ARB			= 0x2023;
const GLuint WGL_AUX_BUFFERS_ARB			= 0x2024;

// 10 - WGL_ARB_make_current_read
const GLuint ERROR_INVALID_PIXEL_TYPE_ARB		= 0x2043;
const GLuint ERROR_INCOMPATIBLE_DEVICE_CONTEXTS_ARB	= 0x2054;

// 11 - WGL_ARB_pbuffer
const GLuint WGL_DRAW_TO_PBUFFER_ARB			= 0x202D;
const GLuint WGL_MAX_PBUFFER_PIXELS_ARB			= 0x202E;
const GLuint WGL_MAX_PBUFFER_WIDTH_ARB			= 0x202F;
const GLuint WGL_MAX_PBUFFER_HEIGHT_ARB			= 0x2030;
const GLuint WGL_PBUFFER_LARGEST_ARB			= 0x2033;
const GLuint WGL_PBUFFER_WIDTH_ARB			= 0x2034;
const GLuint WGL_PBUFFER_HEIGHT_ARB			= 0x2035;
const GLuint WGL_PBUFFER_LOST_ARB			= 0x2036;

// 20 - WGL_ARB_render_texture
const GLuint WGL_BIND_TO_TEXTURE_RGB_ARB		= 0x2070;
const GLuint WGL_BIND_TO_TEXTURE_RGBA_ARB		= 0x2071;
const GLuint WGL_TEXTURE_FORMAT_ARB			= 0x2072;
const GLuint WGL_TEXTURE_TARGET_ARB			= 0x2073;
const GLuint WGL_MIPMAP_TEXTURE_ARB			= 0x2074;
const GLuint WGL_TEXTURE_RGB_ARB			= 0x2075;
const GLuint WGL_TEXTURE_RGBA_ARB			= 0x2076;
const GLuint WGL_NO_TEXTURE_ARB				= 0x2077;
const GLuint WGL_TEXTURE_CUBE_MAP_ARB			= 0x2078;
const GLuint WGL_TEXTURE_1D_ARB				= 0x2079;
const GLuint WGL_TEXTURE_2D_ARB				= 0x207A;
const GLuint WGL_MIPMAP_LEVEL_ARB			= 0x207B;
const GLuint WGL_CUBE_MAP_FACE_ARB			= 0x207C;
const GLuint WGL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB	= 0x207D;
const GLuint WGL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB	= 0x207E;
const GLuint WGL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB	= 0x207F;
const GLuint WGL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB	= 0x2080;
const GLuint WGL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB	= 0x2081;
const GLuint WGL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB	= 0x2082;
const GLuint WGL_FRONT_LEFT_ARB				= 0x2083;
const GLuint WGL_FRONT_RIGHT_ARB			= 0x2084;
const GLuint WGL_BACK_LEFT_ARB				= 0x2085;
const GLuint WGL_BACK_RIGHT_ARB				= 0x2086;
const GLuint WGL_AUX0_ARB				= 0x2087;
const GLuint WGL_AUX1_ARB				= 0x2088;
const GLuint WGL_AUX2_ARB				= 0x2089;
const GLuint WGL_AUX3_ARB				= 0x208A;
const GLuint WGL_AUX4_ARB				= 0x208B;
const GLuint WGL_AUX5_ARB				= 0x208C;
const GLuint WGL_AUX6_ARB				= 0x208D;
const GLuint WGL_AUX7_ARB				= 0x208E;
const GLuint WGL_AUX8_ARB				= 0x208F;
const GLuint WGL_AUX9_ARB				= 0x2090;

// 39 - WGL_ARB_pixel_format_float
const GLuint WGL_TYPE_RBGA_FLOAT_ARB			= 0x21A0;

/*
 * Non-ARB Extensions
 */
// 169 - WGL_EXT_make_current_read
const GLuint ERROR_INVALID_PIXEL_TYPE_EXT		= 0x2043;

// 170 - WGL_EXT_pixel_format
const GLuint WGL_NUMBER_PIXEL_FORMATS_EXT		= 0x2000;
const GLuint WGL_DRAW_TO_WINDOW_EXT			= 0x2001;
const GLuint WGL_DRAW_TO_BITMAP_EXT			= 0x2002;
const GLuint WGL_ACCELERATION_EXT			= 0x2003;
const GLuint WGL_NEED_PALETTE_EXT			= 0x2004;
const GLuint WGL_NEED_SYSTEM_PALETTE_EXT		= 0x2005;
const GLuint WGL_SWAP_LAYER_BUFFERS_EXT			= 0x2006;
const GLuint WGL_SWAP_METHOD_EXT			= 0x2007;
const GLuint WGL_NUMBER_OVERLAYS_EXT			= 0x2008;
const GLuint WGL_NUMBER_UNDERLAYS_EXT			= 0x2009;
const GLuint WGL_TRANSPARENT_EXT			= 0x200A;
const GLuint WGL_TRANSPARENT_VALUE_EXT			= 0x200B;
const GLuint WGL_SHARE_DEPTH_EXT			= 0x200C;
const GLuint WGL_SHARE_STENCIL_EXT			= 0x200D;
const GLuint WGL_SHARE_ACCUM_EXT			= 0x200E;
const GLuint WGL_SUPPORT_GDI_EXT			= 0x200F;
const GLuint WGL_SUPPORT_OPENGL_EXT			= 0x2010;
const GLuint WGL_DOUBLE_BUFFER_EXT			= 0x2011;
const GLuint WGL_STEREO_EXT				= 0x2012;
const GLuint WGL_PIXEL_TYPE_EXT				= 0x2013;
const GLuint WGL_COLOR_BITS_EXT				= 0x2014;
const GLuint WGL_RED_BITS_EXT				= 0x2015;
const GLuint WGL_RED_SHIFT_EXT				= 0x2016;
const GLuint WGL_GREEN_BITS_EXT				= 0x2017;
const GLuint WGL_GREEN_SHIFT_EXT			= 0x2018;
const GLuint WGL_BLUE_BITS_EXT				= 0x2019;
const GLuint WGL_BLUE_SHIFT_EXT				= 0x201A;
const GLuint WGL_ALPHA_BITS_EXT				= 0x201B;
const GLuint WGL_ALPHA_SHIFT_EXT			= 0x201C;
const GLuint WGL_ACCUM_BITS_EXT				= 0x201D;
const GLuint WGL_ACCUM_RED_BITS_EXT			= 0x201E;
const GLuint WGL_ACCUM_GREEN_BITS_EXT			= 0x201F;
const GLuint WGL_ACCUM_BLUE_BITS_EXT			= 0x2020;
const GLuint WGL_ACCUM_ALPHA_BITS_EXT			= 0x2021;
const GLuint WGL_DEPTH_BITS_EXT				= 0x2022;
const GLuint WGL_STENCIL_BITS_EXT			= 0x2023;
const GLuint WGL_AUX_BUFFERS_EXT			= 0x2024;
const GLuint WGL_NO_ACCELERATION_EXT			= 0x2025;
const GLuint WGL_GENERIC_ACCELERATION_EXT		= 0x2026;
const GLuint WGL_FULL_ACCELERATION_EXT			= 0x2027;
const GLuint WGL_SWAP_EXCHANGE_EXT			= 0x2028;
const GLuint WGL_SWAP_COPY_EXT				= 0x2029;
const GLuint WGL_SWAP_UNDEFINED_EXT			= 0x202A;
const GLuint WGL_TYPE_RGBA_EXT				= 0x202B;
const GLuint WGL_TYPE_COLORINDEX_EXT			= 0x202C;

// 171 - WGL_EXT_pbuffer
const GLuint WGL_DRAW_TO_PBUFFER_EXT			= 0x202D;
const GLuint WGL_MAX_PBUFFER_PIXELS_EXT			= 0x202E;
const GLuint WGL_MAX_PBUFFER_WIDTH_EXT			= 0x202F;
const GLuint WGL_MAX_PBUFFER_HEIGHT_EXT			= 0x2030;
const GLuint WGL_OPTIMAL_PBUFFER_WIDTH_EXT		= 0x2031;
const GLuint WGL_OPTIMAL_PBUFFER_HEIGHT_EXT		= 0x2032;
const GLuint WGL_PBUFFER_LARGEST_EXT			= 0x2033;
const GLuint WGL_PBUFFER_WIDTH_EXT			= 0x2034;
const GLuint WGL_PBUFFER_HEIGHT_EXT			= 0x2035;

// 177 - WGL_EXT_depth_float
const GLuint	WGL_DEPTH_FLOAT_EXT			= 0x2040;

// 207 - WGL_3DFX_multisample
const GLuint WGL_SAMPLE_BUFFERS_3DFX			= 0x2060;
const GLuint WGL_SAMPLES_3DFX				= 0x2061;

// 209 - WGL_EXT_multisample
const GLuint WGL_SAMPLE_BUFFERS_EXT			= 0x2041;
const GLuint WGL_SAMPLES_EXT				= 0x2042;

// 250 - WGL_I3D_digital_video_control
const GLuint WGL_DIGITAL_VIDEO_CURSOR_ALPHA_FRAMEBUFFER_I3D= 0x2050;
const GLuint WGL_DIGITAL_VIDEO_CURSOR_ALPHA_VALUE_I3D	= 0x2051;
const GLuint WGL_DIGITAL_VIDEO_CURSOR_INCLUDED_I3D	= 0x2052;
const GLuint WGL_DIGITAL_VIDEO_GAMMA_CORRECTED_I3D	= 0x2053;

// 251 - WGL_I3D_gamma
const GLuint WGL_GAMMA_TABLE_SIZE_I3D			= 0x204E;
const GLuint WGL_GAMMA_EXCLUDE_DESKTOP_I3D		= 0x204F;

// 252 - WGL_I3D_genlock
const GLuint WGL_GENLOCK_SOURCE_MULTIVIEW_I3D		= 0x2044;
const GLuint WGL_GENLOCK_SOURCE_EXTENAL_SYNC_I3D	= 0x2045;
const GLuint WGL_GENLOCK_SOURCE_EXTENAL_FIELD_I3D	= 0x2046;
const GLuint WGL_GENLOCK_SOURCE_EXTENAL_TTL_I3D		= 0x2047;
const GLuint WGL_GENLOCK_SOURCE_DIGITAL_SYNC_I3D	= 0x2048;
const GLuint WGL_GENLOCK_SOURCE_DIGITAL_FIELD_I3D	= 0x2049;
const GLuint WGL_GENLOCK_SOURCE_EDGE_FALLING_I3D	= 0x204A;
const GLuint WGL_GENLOCK_SOURCE_EDGE_RISING_I3D		= 0x204B;
const GLuint WGL_GENLOCK_SOURCE_EDGE_BOTH_I3D		= 0x204C;

// 253 - WGL_I3D_image_buffer
const GLuint WGL_IMAGE_BUFFER_MIN_ACCESS_I3D		= 0x00000001;
const GLuint WGL_IMAGE_BUFFER_LOCK_I3D			= 0x00000002;

// 263 - WGL_NV_render_depth_texture
const GLuint WGL_BIND_TO_TEXTURE_DEPTH_NV		= 0x20A3;
const GLuint WGL_BIND_TO_TEXTURE_RECTANGLE_DEPTH_NV	= 0x20A4;
const GLuint WGL_DEPTH_TEXTURE_FORMAT_NV		= 0x20A5;
const GLuint WGL_TEXTURE_DEPTH_COMPONENT_NV		= 0x20A6;
const GLuint WGL_DEPTH_COMPONENT_NV			= 0x20A7;

// 264 - WGL_NV_render_texture_rectangle
const GLuint WGL_BIND_TO_TEXTURE_RECTANGLE_RGB_NV	= 0x20A0;
const GLuint WGL_BIND_TO_TEXTURE_RECTANGLE_RGBA_NV	= 0x20A1;
const GLuint WGL_TEXTURE_RECTANGLE_NV			= 0x20A2;

// 278 - WGL_ATI_pixel_format_float
const GLuint WGL_TYPE_RGBA_FLOAT_ATI			= 0x21A0;

// 281 - WGL_NV_float_buffer
const GLuint WGL_FLOAT_COMPONENTS_NV			= 0x20B0;
const GLuint WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_R_NV	= 0x20B1;
const GLuint WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RG_NV	= 0x20B2;
const GLuint WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RGB_NV	= 0x20B3;
const GLuint WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RGBA_NV= 0x20B4;
const GLuint WGL_TEXTURE_FLOAT_R_NV			= 0x20B5;
const GLuint WGL_TEXTURE_FLOAT_RG_NV			= 0x20B6;
const GLuint WGL_TEXTURE_FLOAT_RGB_NV			= 0x20B7;
const GLuint WGL_TEXTURE_FLOAT_RGBA_NV			= 0x20B8;

// 313 - WGL_3DL_stereo_control
const GLuint WGL_STEREO_EMITTER_ENABLE_3DL		= 0x2055;
const GLuint WGL_STEREO_EMITTER_DISABLE_3DL		= 0x2056;
const GLuint WGL_STEREO_POLARITY_NORMAL_3DL		= 0x2057;
const GLuint WGL_STEREO_POLARITY_INVERT_3DL		= 0x2058;

/*
 * Functions
 */
private HXModule wglextdrv;
private void* getProc(char[] procname) {
	void* symbol = ExeModule_GetSymbol(wglextdrv, procname);
	if (symbol is null) {
		printf ("Failed to load WGL extension proc address " ~ procname ~ ".\n");
	}
	return (symbol);
}

static this () {
	wglextdrv = ExeModule_Load("OpenGL32.dll");
	wglCreateBufferRegionARB = cast(pfwglCreateBufferRegionARB)getProc("wglCreateBufferRegionARB");
	wglDeleteBufferRegionARB = cast(pfwglDeleteBufferRegionARB)getProc("wglDeleteBufferRegionARB");
	wglSaveBufferRegionARB = cast(pfwglSaveBufferRegionARB)getProc("wglSaveBufferRegionARB");
	wglRestoreBufferRegionARB = cast(pfwglRestoreBufferRegionARB)getProc("wglRestoreBufferRegionARB");

	SampleCoverageARB = cast(pfSampleCoverageARB)getProc("SampleCoverageARB");

	wglGetExtensionsStringARB = cast(pfwglGetExtensionsStringARB)getProc("wglGetExtensionsStringARB");

	wglGetPixelFormatAttribivARB = cast(pfwglGetPixelFormatAttribivARB)getProc("wglGetPixelFormatAttribivARB");
	wglGetPixelFormatAttribfvARB = cast(pfwglGetPixelFormatAttribfvARB)getProc("wglGetPixelFormatAttribfvARB");
	wglChoosePixelFormatARB = cast(pfwglChoosePixelFormatARB)getProc("wglChoosePixelFormatARB");

	wglMakeContextCurrentARB = cast(pfwglMakeContextCurrentARB)getProc("wglMakeContextCurrentARB");
	wglGetCurrentReadDCARB = cast(pfwglGetCurrentReadDCARB)getProc("wglGetCurrentReadDCARB");

	wglCreatePbufferARB = cast(pfwglCreatePbufferARB)getProc("wglCreatePbufferARB");
	wglGetPbufferDCARB = cast(pfwglGetPbufferDCARB)getProc("wglGetPbufferDCARB");
	wglReleasePbufferDCARB = cast(pfwglReleasePbufferDCARB)getProc("wglReleasePbufferDCARB");
	wglDestroyPbufferARB = cast(pfwglDestroyPbufferARB)getProc("wglDestroyPbufferARB");
	wglQueryPbufferARB = cast(pfwglQueryPbufferARB)getProc("wglQueryPbufferARB");

	wglBindTexImageARB = cast(pfwglBindTexImageARB)getProc("wglBindTexImageARB");
	wglReleaseTexImageARB = cast(pfwglReleaseTexImageARB)getProc("wglReleaseTexImageARB");
	wglSetPbufferAttribARB = cast(pfwglSetPbufferAttribARB)getProc("wglSetPbufferAttribARB");

	wglGetExtensionsStringEXT = cast(pfwglGetExtensionsStringEXT)getProc("wglGetExtensionsStringEXT");

	wglMakeContextCurrentEXT = cast(pfwglMakeContextCurrentEXT)getProc("wglMakeContextCurrentEXT");
	wglGetCurrentReadDCEXT = cast(pfwglGetCurrentReadDCEXT)getProc("wglGetCurrentReadDCEXT");

	wglGetPixelFormatAttribivEXT = cast(pfwglGetPixelFormatAttribivEXT)getProc("wglGetPixelFormatAttribivEXT");
	wglGetPixelFormatAttribfvEXT = cast(pfwglGetPixelFormatAttribfvEXT)getProc("wglGetPixelFormatAttribfvEXT");
	wglChoosePixelFormatEXT = cast(pfwglChoosePixelFormatEXT)getProc("wglChoosePixelFormatEXT");

	wglCreatePbufferEXT = cast(pfwglCreatePbufferEXT)getProc("wglCreatePbufferEXT");
	wglGetPbufferDCEXT = cast(pfwglGetPbufferDCEXT)getProc("wglGetPbufferDCEXT");
	wglReleasePbufferDCEXT = cast(pfwglReleasePbufferDCEXT)getProc("wglReleasePbufferDCEXT");
	wglDestroyPbufferEXT = cast(pfwglDestroyPbufferEXT)getProc("wglDestroyPbufferEXT");
	wglQueryPbufferEXT = cast(pfwglQueryPbufferEXT)getProc("wglQueryPbufferEXT");

	wglSwapIntervalEXT = cast(pfwglSwapIntervalEXT)getProc("wglSwapIntervalEXT");
	wglGetSwapIntervalEXT = cast(pfwglGetSwapIntervalEXT)getProc("wglGetSwapIntervalEXT");

	SampleMaskEXT = cast(pfSampleMaskEXT)getProc("SampleMaskEXT");
	SamplePatternEXT = cast(pfSamplePatternEXT)getProc("SamplePatternEXT");

	wglGetSyncValuesOML = cast(pfwglGetSyncValuesOML)getProc("wglGetSyncValuesOML");
	wglGetMscRateOML = cast(pfwglGetMscRateOML)getProc("wglGetMscRateOML");
	wglSwapBuffersMscOML = cast(pfwglSwapBuffersMscOML)getProc("wglSwapBuffersMscOML");
	wglSwapLayerBuffersMscOML = cast(pfwglSwapLayerBuffersMscOML)getProc("wglSwapLayerBuffersMscOML");
	wglWaitForMscOML = cast(pfwglWaitForMscOML)getProc("wglWaitForMscOML");
	wglWaitForSbcOML = cast(pfwglWaitForSbcOML)getProc("wglWaitForSbcOML");

	wglGetDigitalVideoParametersI3D = cast(pfwglGetDigitalVideoParametersI3D)getProc("wglGetDigitalVideoParametersI3D");
	wglSetDigitalVideoParametersI3D = cast(pfwglSetDigitalVideoParametersI3D)getProc("wglSetDigitalVideoParametersI3D");

	wglGetGammaTableParametersI3D = cast(pfwglGetGammaTableParametersI3D)getProc("wglGetGammaTableParametersI3D");
	wglSetGammaTableParametersI3D = cast(pfwglSetGammaTableParametersI3D)getProc("wglSetGammaTableParametersI3D");
	wglGetGammaTableI3D = cast(pfwglGetGammaTableI3D)getProc("wglGetGammaTableI3D");
	wglSetGammaTableI3D = cast(pfwglSetGammaTableI3D)getProc("wglSetGammaTableI3D");

	wglEnableGenlockI3D = cast(pfwglEnableGenlockI3D)getProc("wglEnableGenlockI3D");
	wglDisableGenlockI3D = cast(pfwglDisableGenlockI3D)getProc("wglDisableGenlockI3D");
	wglIsEnabledGenlockI3D = cast(pfwglIsEnabledGenlockI3D)getProc("wglIsEnabledGenlockI3D");
	wglGenlockSourceI3D = cast(pfwglGenlockSourceI3D)getProc("wglGenlockSourceI3D");
	wglGetGenlockSourceI3D = cast(pfwglGetGenlockSourceI3D)getProc("wglGetGenlockSourceI3D");
	wglGenlockSourceEdgeI3D = cast(pfwglGenlockSourceEdgeI3D)getProc("wglGenlockSourceEdgeI3D");
	wglGetGenlockSourceEdgeI3D = cast(pfwglGetGenlockSourceEdgeI3D)getProc("wglGetGenlockSourceEdgeI3D");
	wglGenlockSampleRateI3D = cast(pfwglGenlockSampleRateI3D)getProc("wglGenlockSampleRateI3D");
	wglGetGenlockSampleRateI3D = cast(pfwglGetGenlockSampleRateI3D)getProc("wglGetGenlockSampleRateI3D");
	wglGenlockSourceDelayI3D = cast(pfwglGenlockSourceDelayI3D)getProc("wglGenlockSourceDelayI3D");
	wglGetGenlockSourceDelayI3D = cast(pfwglGetGenlockSourceDelayI3D)getProc("wglGetGenlockSourceDelayI3D");
	wglQueryGenlockMaxSourceDelayI3D = cast(pfwglQueryGenlockMaxSourceDelayI3D)getProc("wglQueryGenlockMaxSourceDelayI3D");

	wglCreateImageBufferI3D = cast(pfwglCreateImageBufferI3D)getProc("wglCreateImageBufferI3D");
	wglDestroyImageBufferI3D = cast(pfwglDestroyImageBufferI3D)getProc("wglDestroyImageBufferI3D");
	wglAssociateImageBufferEventsI3D = cast(pfwglAssociateImageBufferEventsI3D)getProc("wglAssociateImageBufferEventsI3D");
	wglReleaseImageBufferEventsI3D = cast(pfwglReleaseImageBufferEventsI3D)getProc("wglReleaseImageBufferEventsI3D");
	wglDisableFrameLockI3D = cast(pfwglDisableFrameLockI3D)getProc("wglDisableFrameLockI3D");
	wglIsEnabledFrameLockI3D = cast(pfwglIsEnabledFrameLockI3D)getProc("wglIsEnabledFrameLockI3D");
	wglQueryFrameLockMasterI3D = cast(pfwglQueryFrameLockMasterI3D)getProc("wglQueryFrameLockMasterI3D");

	wglGetFrameUsageI3D = cast(pfwglGetFrameUsageI3D)getProc("wglGetFrameUsageI3D");
	wglBeginFrameTrackingI3D = cast(pfwglBeginFrameTrackingI3D)getProc("wglBeginFrameTrackingI3D");
	wglEndFrameTrackingI3D = cast(pfwglEndFrameTrackingI3D)getProc("wglEndFrameTrackingI3D");
	wglQueryFrameTrackingI3D = cast(pfwglQueryFrameTrackingI3D)getProc("wglQueryFrameTrackingI3D");

	wglSetStereoEmitterState3DL = cast(pfwglSetStereoEmitterState3DL)getProc("wglSetStereoEmitterState3DL");
}

static ~this () {
	ExeModule_Release(wglextdrv);
}
extern (C):
/*
 * ARB Extensions
 */
// 4 - WGL_ARB_buffer_region
typedef HANDLE function(HDC, GLint, GLuint) pfwglCreateBufferRegionARB;
typedef GLvoid function(HANDLE) pfwglDeleteBufferRegionARB;
typedef BOOL function(HANDLE, GLint, GLint, GLint, GLint) pfwglSaveBufferRegionARB;
typedef BOOL function(HANDLE, GLint, GLint, GLint, GLint, GLint, GLint) pfwglRestoreBufferRegionARB;
pfwglCreateBufferRegionARB wglCreateBufferRegionARB;
pfwglDeleteBufferRegionARB wglDeleteBufferRegionARB;
pfwglSaveBufferRegionARB wglSaveBufferRegionARB;
pfwglRestoreBufferRegionARB wglRestoreBufferRegionARB;

// 5 - WGL_ARB_multisample
typedef GLvoid function(GLclampf, GLboolean) pfSampleCoverageARB;
pfSampleCoverageARB SampleCoverageARB;

// 8 - WGL_ARB_extensions_string
typedef GLchar* function(HDC) pfwglGetExtensionsStringARB;
pfwglGetExtensionsStringARB wglGetExtensionsStringARB;

// 9 - WGL_ARB_pixel_format
typedef BOOL function(HDC, GLint, GLint, GLuint, GLint*, GLint*) pfwglGetPixelFormatAttribivARB;
typedef BOOL function(HDC, GLint, GLint, GLuint, GLint*, FLOAT*) pfwglGetPixelFormatAttribfvARB;
typedef BOOL function(HDC, GLint*, FLOAT*, GLuint, GLint*, GLuint) pfwglChoosePixelFormatARB;
pfwglGetPixelFormatAttribivARB wglGetPixelFormatAttribivARB;
pfwglGetPixelFormatAttribfvARB wglGetPixelFormatAttribfvARB;
pfwglChoosePixelFormatARB wglChoosePixelFormatARB;

// 10 - WGL_ARB_make_current_read
typedef BOOL function(HDC, HDC, HGLRC) pfwglMakeContextCurrentARB;
typedef HDC function() pfwglGetCurrentReadDCARB;
pfwglMakeContextCurrentARB wglMakeContextCurrentARB;
pfwglGetCurrentReadDCARB wglGetCurrentReadDCARB;

// 11 - WGL_ARB_pbuffer
alias HANDLE HPBUFFERARB;
typedef HPBUFFERARB function(HDC, GLint, GLint, GLint, GLint*) pfwglCreatePbufferARB;
typedef HDC function(HPBUFFERARB) pfwglGetPbufferDCARB;
typedef GLint function(HPBUFFERARB, HDC) pfwglReleasePbufferDCARB;
typedef BOOL function(HPBUFFERARB) pfwglDestroyPbufferARB;
typedef BOOL function(HPBUFFERARB, GLint, GLint*) pfwglQueryPbufferARB;
pfwglCreatePbufferARB wglCreatePbufferARB;
pfwglGetPbufferDCARB wglGetPbufferDCARB;
pfwglReleasePbufferDCARB wglReleasePbufferDCARB;
pfwglDestroyPbufferARB wglDestroyPbufferARB;
pfwglQueryPbufferARB wglQueryPbufferARB;

// 20 - WGL_ARB_render_texture
typedef BOOL function(HPBUFFERARB, GLint) pfwglBindTexImageARB;
typedef BOOL function(HPBUFFERARB, GLint) pfwglReleaseTexImageARB;
typedef BOOL function(HPBUFFERARB, GLint*) pfwglSetPbufferAttribARB;
pfwglBindTexImageARB wglBindTexImageARB;
pfwglReleaseTexImageARB wglReleaseTexImageARB;
pfwglSetPbufferAttribARB wglSetPbufferAttribARB;

/*
 * Non-ARB Extensions
 */
// 168 - WGL_EXT_extensions_string
typedef GLchar* function() pfwglGetExtensionsStringEXT;
pfwglGetExtensionsStringEXT wglGetExtensionsStringEXT;

// 169 - WGL_EXT_make_current_read
typedef BOOL function(HDC, HDC, HGLRC) pfwglMakeContextCurrentEXT;
typedef HDC function() pfwglGetCurrentReadDCEXT;
pfwglMakeContextCurrentEXT wglMakeContextCurrentEXT;
pfwglGetCurrentReadDCEXT wglGetCurrentReadDCEXT;

// 170 - WGL_EXT_pixel_format
typedef BOOL function(HDC, GLint, GLint, GLuint, GLint*, GLint) pfwglGetPixelFormatAttribivEXT;
typedef BOOL function(HDC, GLint, GLint, GLuint, GLint*, FLOAT*) pfwglGetPixelFormatAttribfvEXT;
typedef BOOL function(HDC, GLint*, FLOAT*, GLuint, GLint*, GLuint*) pfwglChoosePixelFormatEXT;
pfwglGetPixelFormatAttribivEXT wglGetPixelFormatAttribivEXT;
pfwglGetPixelFormatAttribfvEXT wglGetPixelFormatAttribfvEXT;
pfwglChoosePixelFormatEXT wglChoosePixelFormatEXT;

// 171 - WGL_EXT_pbuffer
alias HANDLE HPBUFFEREXT;
typedef HPBUFFEREXT function(HDC, GLint, GLint, GLint, GLint*) pfwglCreatePbufferEXT;
typedef HDC function(HPBUFFEREXT) pfwglGetPbufferDCEXT;
typedef GLint function(HPBUFFEREXT, HDC) pfwglReleasePbufferDCEXT;
typedef BOOL function(HPBUFFEREXT) pfwglDestroyPbufferEXT;
typedef BOOL function(HPBUFFEREXT, GLint, GLint*) pfwglQueryPbufferEXT;
pfwglCreatePbufferEXT wglCreatePbufferEXT;
pfwglGetPbufferDCEXT wglGetPbufferDCEXT;
pfwglReleasePbufferDCEXT wglReleasePbufferDCEXT;
pfwglDestroyPbufferEXT wglDestroyPbufferEXT;
pfwglQueryPbufferEXT wglQueryPbufferEXT;

// 172 - WGL_EXT_swap_control
typedef BOOL function(GLint) pfwglSwapIntervalEXT;
typedef GLint function() pfwglGetSwapIntervalEXT;
pfwglSwapIntervalEXT wglSwapIntervalEXT;
pfwglGetSwapIntervalEXT wglGetSwapIntervalEXT;

// 207 - WGL_3DFX_multisample
typedef GLvoid function(GLclampf, GLboolean) pfSampleMaskEXT;
typedef GLvoid function(GLenum) pfSamplePatternEXT;
pfSampleMaskEXT SampleMaskEXT;
pfSamplePatternEXT SamplePatternEXT;

// 242 - WGL_OML_sync_control
typedef BOOL function(HDC, long*, long*, long*) pfwglGetSyncValuesOML;
typedef BOOL function(HDC, GLint*, GLint*) pfwglGetMscRateOML;
typedef long function(HDC, long, long, long) pfwglSwapBuffersMscOML;
typedef long function(HDC, GLint, long, long, long) pfwglSwapLayerBuffersMscOML;
typedef BOOL function(HDC, long, long, long, long*, long*, long*) pfwglWaitForMscOML;
typedef BOOL function(HDC, long, long*, long*, long*) pfwglWaitForSbcOML;
pfwglGetSyncValuesOML wglGetSyncValuesOML;
pfwglGetMscRateOML wglGetMscRateOML;
pfwglSwapBuffersMscOML wglSwapBuffersMscOML;
pfwglSwapLayerBuffersMscOML wglSwapLayerBuffersMscOML;
pfwglWaitForMscOML wglWaitForMscOML;
pfwglWaitForSbcOML wglWaitForSbcOML;

// 250 - WGL_I3D_digital_video_control
typedef BOOL function(HDC, GLint, GLint*) pfwglGetDigitalVideoParametersI3D;
typedef BOOL function(HDC, GLint, GLint*) pfwglSetDigitalVideoParametersI3D;
pfwglGetDigitalVideoParametersI3D wglGetDigitalVideoParametersI3D;
pfwglSetDigitalVideoParametersI3D wglSetDigitalVideoParametersI3D;

// 251 - WGL_I3D_gamma
typedef BOOL function(HDC, GLint, GLint*) pfwglGetGammaTableParametersI3D;
typedef BOOL function(HDC, GLint, GLint*) pfwglSetGammaTableParametersI3D;
typedef BOOL function(HDC, GLint, USHORT*, USHORT*, USHORT*) pfwglGetGammaTableI3D;
typedef BOOL function(HDC, GLint, USHORT*, USHORT*, USHORT*) pfwglSetGammaTableI3D;
pfwglGetGammaTableParametersI3D wglGetGammaTableParametersI3D;
pfwglSetGammaTableParametersI3D wglSetGammaTableParametersI3D;
pfwglGetGammaTableI3D wglGetGammaTableI3D;
pfwglSetGammaTableI3D wglSetGammaTableI3D;

// 252 - WGL_I3D_genlock
typedef BOOL function(HDC) pfwglEnableGenlockI3D;
typedef BOOL function(HDC) pfwglDisableGenlockI3D;
typedef BOOL function(HDC, BOOL*) pfwglIsEnabledGenlockI3D;
typedef BOOL function(HDC, GLuint) pfwglGenlockSourceI3D;
typedef BOOL function(HDC, GLuint*) pfwglGetGenlockSourceI3D;
typedef BOOL function(HDC, GLuint) pfwglGenlockSourceEdgeI3D;
typedef BOOL function(HDC, GLuint*) pfwglGetGenlockSourceEdgeI3D;
typedef BOOL function(HDC, GLuint) pfwglGenlockSampleRateI3D;
typedef BOOL function(HDC, GLuint*) pfwglGetGenlockSampleRateI3D;
typedef BOOL function(HDC, GLuint) pfwglGenlockSourceDelayI3D;
typedef BOOL function(HDC, GLuint*) pfwglGetGenlockSourceDelayI3D;
typedef BOOL function(HDC, GLuint*, GLuint*) pfwglQueryGenlockMaxSourceDelayI3D;
pfwglEnableGenlockI3D wglEnableGenlockI3D;
pfwglDisableGenlockI3D wglDisableGenlockI3D;
pfwglIsEnabledGenlockI3D wglIsEnabledGenlockI3D;
pfwglGenlockSourceI3D wglGenlockSourceI3D;
pfwglGetGenlockSourceI3D wglGetGenlockSourceI3D;
pfwglGenlockSourceEdgeI3D wglGenlockSourceEdgeI3D;
pfwglGetGenlockSourceEdgeI3D wglGetGenlockSourceEdgeI3D;
pfwglGenlockSampleRateI3D wglGenlockSampleRateI3D;
pfwglGetGenlockSampleRateI3D wglGetGenlockSampleRateI3D;
pfwglGenlockSourceDelayI3D wglGenlockSourceDelayI3D;
pfwglGetGenlockSourceDelayI3D wglGetGenlockSourceDelayI3D;
pfwglQueryGenlockMaxSourceDelayI3D wglQueryGenlockMaxSourceDelayI3D;

// 253 - WGL_I3D_image_buffer
typedef LPVOID function(HDC, DWORD, GLuint) pfwglCreateImageBufferI3D;
typedef BOOL function(HDC, LPVOID) pfwglDestroyImageBufferI3D;
typedef BOOL function(HDC, HANDLE*, LPVOID*, DWORD*, GLuint) pfwglAssociateImageBufferEventsI3D;
typedef BOOL function(HDC, LPVOID*, GLuint) pfwglReleaseImageBufferEventsI3D;
pfwglCreateImageBufferI3D wglCreateImageBufferI3D;
pfwglDestroyImageBufferI3D wglDestroyImageBufferI3D;
pfwglAssociateImageBufferEventsI3D wglAssociateImageBufferEventsI3D;
pfwglReleaseImageBufferEventsI3D wglReleaseImageBufferEventsI3D;

// 254 - WGL_I3D_swap_frame_lock
typedef BOOL function() pfwglEnableFrameLockI3D;
typedef BOOL function() pfwglDisableFrameLockI3D;
typedef BOOL function(BOOL*) pfwglIsEnabledFrameLockI3D;
typedef BOOL function(BOOL*) pfwglQueryFrameLockMasterI3D;
pfwglEnableFrameLockI3D wglEnableFrameLockI3D;
pfwglDisableFrameLockI3D wglDisableFrameLockI3D;
pfwglIsEnabledFrameLockI3D wglIsEnabledFrameLockI3D;
pfwglQueryFrameLockMasterI3D wglQueryFrameLockMasterI3D;

// 255 - WGL_I3D_swap_frame_usage
typedef BOOL function(GLfloat*) pfwglGetFrameUsageI3D;
typedef BOOL function() pfwglBeginFrameTrackingI3D;
typedef BOOL function() pfwglEndFrameTrackingI3D;
typedef BOOL function(DWORD*, DWORD*, GLfloat*) pfwglQueryFrameTrackingI3D;
pfwglGetFrameUsageI3D wglGetFrameUsageI3D;
pfwglBeginFrameTrackingI3D wglBeginFrameTrackingI3D;
pfwglEndFrameTrackingI3D wglEndFrameTrackingI3D;
pfwglQueryFrameTrackingI3D wglQueryFrameTrackingI3D;

// 313 - WGL_3DL_stereo_control
typedef BOOL function(HDC, GLuint) pfwglSetStereoEmitterState3DL;
pfwglSetStereoEmitterState3DL wglSetStereoEmitterState3DL;
}
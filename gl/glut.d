module c.gl.glut;

/*
 * Copyright (c) 1999-2000 Pawel W. Olszta. All Rights Reserved.
 * Written by Pawel W. Olszta, <olszta@sourceforge.net>
 * Creation date: Thu Dec 2 1999
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
 * PAWEL W. OLSZTA BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/*
 *Uncomment the following line to enable new freeglut features
 */
//version = FREEGLUT_EXTRAS;

import c.gl._glextern;
private import c.gl.gl;
private import std.loader;

/*
 * The freeglut and GLUT API versions
 */
const GLuint FREEGLUT				= 1;
const GLuint GLUT_API_VERSION			= 4;
const GLuint FREEGLUT_VERSION_2_0		= 1;
const GLuint GLUT_XLIB_IMPLEMENTATION		= 13;

/*
 * GLUT API macro definitions -- the special key codes:
 */
const GLuint GLUT_KEY_F1			= 0x0001;
const GLuint GLUT_KEY_F2			= 0x0002;
const GLuint GLUT_KEY_F3			= 0x0003;
const GLuint GLUT_KEY_F4			= 0x0004;
const GLuint GLUT_KEY_F5			= 0x0005;
const GLuint GLUT_KEY_F6			= 0x0006;
const GLuint GLUT_KEY_F7			= 0x0007;
const GLuint GLUT_KEY_F8			= 0x0008;
const GLuint GLUT_KEY_F9			= 0x0009;
const GLuint GLUT_KEY_F10			= 0x000A;
const GLuint GLUT_KEY_F11			= 0x000B;
const GLuint GLUT_KEY_F12			= 0x000C;
const GLuint GLUT_KEY_LEFT			= 0x0064;
const GLuint GLUT_KEY_UP			= 0x0065;
const GLuint GLUT_KEY_RIGHT			= 0x0066;
const GLuint GLUT_KEY_DOWN			= 0x0067;
const GLuint GLUT_KEY_PAGE_UP			= 0x0068;
const GLuint GLUT_KEY_PAGE_DOWN			= 0x0069;
const GLuint GLUT_KEY_HOME			= 0x006A;
const GLuint GLUT_KEY_END			= 0x006B;
const GLuint GLUT_KEY_INSERT			= 0x006C;

/*
 * GLUT API macro definitions -- mouse state definitions
 */
const GLuint GLUT_LEFT_BUTTON			= 0x0000;
const GLuint GLUT_MIDDLE_BUTTON			= 0x0001;
const GLuint GLUT_RIGHT_BUTTON			= 0x0002;
const GLuint GLUT_DOWN				= 0x0000;
const GLuint GLUT_UP				= 0x0001;
const GLuint GLUT_LEFT				= 0x0000;
const GLuint GLUT_ENTERED			= 0x0001;

/*
 * GLUT API macro definitions -- the display mode definitions
 */
const GLuint GLUT_RGB				= 0x0000;
const GLuint GLUT_RGBA				= 0x0000;
const GLuint GLUT_INDEX				= 0x0001;
const GLuint GLUT_SINGLE			= 0x0000;
const GLuint GLUT_DOUBLE			= 0x0002;
const GLuint GLUT_ACCUM				= 0x0004;
const GLuint GLUT_ALPHA				= 0x0008;
const GLuint GLUT_DEPTH				= 0x0010;
const GLuint GLUT_STENCIL			= 0x0020;
const GLuint GLUT_MULTISAMPLE			= 0x0080;
const GLuint GLUT_STEREO			= 0x0100;
const GLuint GLUT_LUMINANCE			= 0x0200;

/*
 * GLUT API macro definitions -- windows and menu related definitions
 */
const GLuint GLUT_MENU_NOT_IN_USE		= 0x0000;
const GLuint GLUT_MENU_IN_USE			= 0x0001;
const GLuint GLUT_NOT_VISIBLE			= 0x0000;
const GLuint GLUT_VISIBLE			= 0x0001;
const GLuint GLUT_HIDDEN			= 0x0000;
const GLuint GLUT_FULLY_RETAINED		= 0x0001;
const GLuint GLUT_PARTIALLY_RETAINED		= 0x0002;
const GLuint GLUT_FULLY_COVERED			= 0x0003;

/*
 * GLUT API macro definitions
 * Steve Baker suggested to make it binary compatible with GLUT:
 */
version (Windows) {
	const GLvoid* GLUT_STROKE_ROMAN		= cast(GLvoid*)0x0000;
	const GLvoid* GLUT_STROKE_MONO_ROMAN	= cast(GLvoid*)0x0001;
	const GLvoid* GLUT_BITMAP_9_BY_15	= cast(GLvoid*)0x0002;
	const GLvoid* GLUT_BITMAP_8_BY_13	= cast(GLvoid*)0x0003;
	const GLvoid* GLUT_BITMAP_TIMES_ROMAN_10= cast(GLvoid*)0x0004;
	const GLvoid* GLUT_BITMAP_TIMES_ROMAN_24= cast(GLvoid*)0x0005;
	const GLvoid* GLUT_BITMAP_HELVETICA_10	= cast(GLvoid*)0x0006;
	const GLvoid* GLUT_BITMAP_HELVETICA_12	= cast(GLvoid*)0x0007;
	const GLvoid* GLUT_BITMAP_HELVETICA_18	= cast(GLvoid*)0x0008;
} else {
	// Those pointers will be used by following definitions:
	const GLvoid* GLUT_STROKE_ROMAN		= cast(GLvoid*)&glutStrokeRoman;
	const GLvoid* GLUT_STROKE_MONO_ROMAN	= cast(GLvoid*)&glutStrokeMonoRoman;
	const GLvoid* GLUT_BITMAP_9_BY_15	= cast(GLvoid*)&glutBitmap9By15;
	const GLvoid* GLUT_BITMAP_8_BY_13	= cast(GLvoid*)&glutBitmap8By13;
	const GLvoid* GLUT_BITMAP_TIMES_ROMAN_10= cast(GLvoid*)&glutBitmapTimesRoman10;
	const GLvoid* GLUT_BITMAP_TIMES_ROMAN_24= cast(GLvoid*)&glutBitmapTimesRoman24;
	const GLvoid* GLUT_BITMAP_HELVETICA_10	= cast(GLvoid*)&glutBitmapHelvetica10;
	const GLvoid* GLUT_BITMAP_HELVETICA_12	= cast(GLvoid*)&glutBitmapHelvetica12;
	const GLvoid* GLUT_BITMAP_HELVETICA_18	= cast(GLvoid*)&glutBitmapHelvetica18;
}

// GLUT API macro definitions -- the glutGet parameters
const GLuint GLUT_WINDOW_X			= 0x0064;
const GLuint GLUT_WINDOW_Y			= 0x0065;
const GLuint GLUT_WINDOW_WIDTH			= 0x0066;
const GLuint GLUT_WINDOW_HEIGHT			= 0x0067;
const GLuint GLUT_WINDOW_BUFFER_SIZE		= 0x0068;
const GLuint GLUT_WINDOW_STENCIL_SIZE		= 0x0069;
const GLuint GLUT_WINDOW_DEPTH_SIZE		= 0x006A;
const GLuint GLUT_WINDOW_RED_SIZE		= 0x006B;
const GLuint GLUT_WINDOW_GREEN_SIZE		= 0x006C;
const GLuint GLUT_WINDOW_BLUE_SIZE		= 0x006D;
const GLuint GLUT_WINDOW_ALPHA_SIZE		= 0x006E;
const GLuint GLUT_WINDOW_ACCUM_RED_SIZE		= 0x006F;
const GLuint GLUT_WINDOW_ACCUM_GREEN_SIZE	= 0x0070;
const GLuint GLUT_WINDOW_ACCUM_BLUE_SIZE	= 0x0071;
const GLuint GLUT_WINDOW_ACCUM_ALPHA_SIZE	= 0x0072;
const GLuint GLUT_WINDOW_DOUBLEBUFFER		= 0x0073;
const GLuint GLUT_WINDOW_RGBA			= 0x0074;
const GLuint GLUT_WINDOW_PARENT			= 0x0075;
const GLuint GLUT_WINDOW_NUM_CHILDREN		= 0x0076;
const GLuint GLUT_WINDOW_COLORMAP_SIZE		= 0x0077;
const GLuint GLUT_WINDOW_NUM_SAMPLES		= 0x0078;
const GLuint GLUT_WINDOW_STEREO			= 0x0079;
const GLuint GLUT_WINDOW_CURSOR			= 0x007A;

const GLuint GLUT_SCREEN_WIDTH			= 0x00C8;
const GLuint GLUT_SCREEN_HEIGHT			= 0x00C9;
const GLuint GLUT_SCREEN_WIDTH_MM		= 0x00CA;
const GLuint GLUT_SCREEN_HEIGHT_MM		= 0x00CB;
const GLuint GLUT_MENU_NUM_ITEMS		= 0x012C;
const GLuint GLUT_DISPLAY_MODE_POSSIBLE		= 0x0190;
const GLuint GLUT_INIT_WINDOW_X			= 0x01F4;
const GLuint GLUT_INIT_WINDOW_Y			= 0x01F5;
const GLuint GLUT_INIT_WINDOW_WIDTH		= 0x01F6;
const GLuint GLUT_INIT_WINDOW_HEIGHT		= 0x01F7;
const GLuint GLUT_INIT_DISPLAY_MODE		= 0x01F8;
const GLuint GLUT_ELAPSED_TIME			= 0x02BC;
const GLuint GLUT_WINDOW_FORMAT_ID		= 0x007B;
const GLuint GLUT_INIT_STATE			= 0x007C;

// GLUT API macro definitions -- the glutDeviceGet parameters
const GLuint GLUT_HAS_KEYBOARD			= 0x0258;
const GLuint GLUT_HAS_MOUSE			= 0x0259;
const GLuint GLUT_HAS_SPACEBALL			= 0x025A;
const GLuint GLUT_HAS_DIAL_AND_BUTTON_BOX	= 0x025B;
const GLuint GLUT_HAS_TABLET			= 0x025C;
const GLuint GLUT_NUM_MOUSE_BUTTONS		= 0x025D;
const GLuint GLUT_NUM_SPACEBALL_BUTTONS		= 0x025E;
const GLuint GLUT_NUM_BUTTON_BOX_BUTTONS	= 0x025F;
const GLuint GLUT_NUM_DIALS			= 0x0260;
const GLuint GLUT_NUM_TABLET_BUTTONS		= 0x0261;
const GLuint GLUT_DEVICE_IGNORE_KEY_REPEAT	= 0x0262;
const GLuint GLUT_DEVICE_KEY_REPEAT		= 0x0263;
const GLuint GLUT_HAS_JOYSTICK			= 0x0264;
const GLuint GLUT_OWNS_JOYSTICK			= 0x0265;
const GLuint GLUT_JOYSTICK_BUTTONS		= 0x0266;
const GLuint GLUT_JOYSTICK_AXES			= 0x0267;
const GLuint GLUT_JOYSTICK_POLL_RATE		= 0x0268;

// GLUT API macro definitions -- the glutLayerGet parameters
const GLuint GLUT_OVERLAY_POSSIBLE		= 0x0320;
const GLuint GLUT_LAYER_IN_USE			= 0x0321;
const GLuint GLUT_HAS_OVERLAY			= 0x0322;
const GLuint GLUT_TRANSPARENT_INDEX		= 0x0323;
const GLuint GLUT_NORMAL_DAMAGED		= 0x0324;
const GLuint GLUT_OVERLAY_DAMAGED		= 0x0325;

// GLUT API macro definitions -- the glutVideoResizeGet parameters
const GLuint GLUT_VIDEO_RESIZE_POSSIBLE		= 0x0384;
const GLuint GLUT_VIDEO_RESIZE_IN_USE		= 0x0385;
const GLuint GLUT_VIDEO_RESIZE_X_DELTA		= 0x0386;
const GLuint GLUT_VIDEO_RESIZE_Y_DELTA		= 0x0387;
const GLuint GLUT_VIDEO_RESIZE_WIDTH_DELTA	= 0x0388;
const GLuint GLUT_VIDEO_RESIZE_HEIGHT_DELTA	= 0x0389;
const GLuint GLUT_VIDEO_RESIZE_X		= 0x038A;
const GLuint GLUT_VIDEO_RESIZE_Y		= 0x038B;
const GLuint GLUT_VIDEO_RESIZE_WIDTH		= 0x038C;
const GLuint GLUT_VIDEO_RESIZE_HEIGHT		= 0x038D;

// GLUT API macro definitions -- the glutUseLayer parameters
const GLuint GLUT_NORMAL			= 0x0000;
const GLuint GLUT_OVERLAY			= 0x0001;

// GLUT API macro definitions -- the glutGetModifiers parameters
const GLuint GLUT_ACTIVE_SHIFT			= 0x0001;
const GLuint GLUT_ACTIVE_CTRL			= 0x0002;
const GLuint GLUT_ACTIVE_ALT			= 0x0004;

// GLUT API macro definitions -- the glutSetCursor parameters
const GLuint GLUT_CURSOR_RIGHT_ARROW		= 0x0000;
const GLuint GLUT_CURSOR_LEFT_ARROW		= 0x0001;
const GLuint GLUT_CURSOR_INFO			= 0x0002;
const GLuint GLUT_CURSOR_DESTROY		= 0x0003;
const GLuint GLUT_CURSOR_HELP			= 0x0004;
const GLuint GLUT_CURSOR_CYCLE			= 0x0005;
const GLuint GLUT_CURSOR_SPRAY			= 0x0006;
const GLuint GLUT_CURSOR_WAIT			= 0x0007;
const GLuint GLUT_CURSOR_TEXT			= 0x0008;
const GLuint GLUT_CURSOR_CROSSHAIR		= 0x0009;
const GLuint GLUT_CURSOR_UP_DOWN		= 0x000A;
const GLuint GLUT_CURSOR_LEFT_RIGHT		= 0x000B;
const GLuint GLUT_CURSOR_TOP_SIDE		= 0x000C;
const GLuint GLUT_CURSOR_BOTTOM_SIDE		= 0x000D;
const GLuint GLUT_CURSOR_LEFT_SIDE		= 0x000E;
const GLuint GLUT_CURSOR_RIGHT_SIDE		= 0x000F;
const GLuint GLUT_CURSOR_TOP_LEFT_CORNER	= 0x0010;
const GLuint GLUT_CURSOR_TOP_RIGHT_CORNER	= 0x0011;
const GLuint GLUT_CURSOR_BOTTOM_RIGHT_CORNER	= 0x0012;
const GLuint GLUT_CURSOR_BOTTOM_LEFT_CORNER	= 0x0013;
const GLuint GLUT_CURSOR_INHERIT		= 0x0064;
const GLuint GLUT_CURSOR_NONE			= 0x0065;
const GLuint GLUT_CURSOR_FULL_CROSSHAIR		= 0x0066;

// GLUT API macro definitions -- RGB color component specification definitions
const GLuint GLUT_RED				= 0x0000;
const GLuint GLUT_GREEN				= 0x0001;
const GLuint GLUT_BLUE				= 0x0002;

// GLUT API macro definitions -- additional keyboard and joystick definitions
const GLuint GLUT_KEY_REPEAT_OFF		= 0x0000;
const GLuint GLUT_KEY_REPEAT_ON			= 0x0001;
const GLuint GLUT_KEY_REPEAT_DEFAULT		= 0x0002;

const GLuint GLUT_JOYSTICK_BUTTON_A		= 0x0001;
const GLuint GLUT_JOYSTICK_BUTTON_B		= 0x0002;
const GLuint GLUT_JOYSTICK_BUTTON_C		= 0x0004;
const GLuint GLUT_JOYSTICK_BUTTON_D		= 0x0008;

// GLUT API macro definitions -- game mode definitions
const GLuint GLUT_GAME_MODE_ACTIVE		= 0x0000;
const GLuint GLUT_GAME_MODE_POSSIBLE		= 0x0001;
const GLuint GLUT_GAME_MODE_WIDTH		= 0x0002;
const GLuint GLUT_GAME_MODE_HEIGHT		= 0x0003;
const GLuint GLUT_GAME_MODE_PIXEL_DEPTH		= 0x0004;
const GLuint GLUT_GAME_MODE_REFRESH_RATE	= 0x0005;
const GLuint GLUT_GAME_MODE_DISPLAY_CHANGED	= 0x0006;

// FreeGlut extra definitions
version (FREEGLUT_EXTRAS) {
	/*
	 * GLUT API Extension macro definitions -- behaviour when the user clicks on an "x" to close a window
	 */
	const GLuint GLUT_ACTION_EXIT		= 0;
	const GLuint GLUT_ACTION_GLUTMAINLOOP_RETURNS= 1;
	const GLuint GLUT_ACTION_CONTINUE_EXECUTION= 2;

	/*
	 * Create a new rendering context when the user opens a new window?
	 */
	const GLuint GLUT_CREATE_NEW_CONTEXT	= 0;
	const GLuint GLUT_USE_CURRENT_CONTEXT	= 1;

	/*
	 * Direct/Indirect rendering context options (has meaning only in Unix/X11)
	 */
	const GLuint GLUT_FORCE_INDIRECT_CONTEXT= 0;
	const GLuint GLUT_ALLOW_DIRECT_CONTEXT	= 1;
	const GLuint GLUT_TRY_DIRECT_CONTEXT	= 2;
	const GLuint GLUT_FORCE_DIRECT_CONTEXT	= 3;

	/*
	 * GLUT API Extension macro definitions -- the glutGet parameters
	 */
	const GLuint GLUT_ACTION_ON_WINDOW_CLOSE= 0x01F9;
	const GLuint GLUT_WINDOW_BORDER_WIDTH	= 0x01FA;
	const GLuint GLUT_WINDOW_HEADER_HEIGHT	= 0x01FB;
	const GLuint GLUT_VERSION		= 0x01FC;
	const GLuint GLUT_RENDERING_CONTEXT	= 0x01FD;
	const GLuint GLUT_DIRECT_RENDERING	= 0x01FE;

	/*
	 * New tokens for glutInitDisplayMode.
	 * Only one GLUT_AUXn bit may be used at a time.
	 * Value 0x0400 is defined in OpenGLUT.
	 */
	const GLuint GLUT_AUX1			= 0x1000;
	const GLuint GLUT_AUX2			= 0x2000;
	const GLuint GLUT_AUX3			= 0x4000;
	const GLuint GLUT_AUX4			= 0x8000;
}

/*
 * Functions
 */
private HXModule glutdrv;

private void* getProc (char[] procname) {
	void* symbol = ExeModule_GetSymbol(glutdrv, procname);
	if (symbol is null) {
		printf ("Failed to load GLUT proc address " ~ procname ~ ".\n");
	}
	return symbol;
}

static this() {
	version (Windows) {
		glutdrv = ExeModule_Load("glut32.dll");
	} else version (linux) {
		glutdrv = ExeModule_Load("libglut.so");
	} else version (darwin) {
		glutdrv = ExeModule_Load("/System/Library/Frameworks/GLUT.framework");
	}
	glutInit = cast(pfglutInit)getProc("glutInit");
	glutInitWindowPosition = cast(pfglutInitWindowPosition)getProc("glutInitWindowPosition");
	glutInitWindowSize = cast(pfglutInitWindowSize)getProc("glutInitWindowSize");
	glutInitDisplayMode = cast(pfglutInitDisplayMode)getProc("glutInitDisplayMode");
	glutInitDisplayString = cast(pfglutInitDisplayString)getProc("glutInitDisplayString");
	glutMainLoop = cast(pfglutMainLoop)getProc("glutMainLoop");
	glutCreateWindow = cast(pfglutCreateWindow)getProc("glutCreateWindow");
	glutCreateSubWindow = cast(pfglutCreateSubWindow)getProc("glutCreateSubWindow");
	glutDestroyWindow = cast(pfglutDestroyWindow)getProc("glutDestroyWindow");
	glutSetWindow = cast(pfglutSetWindow)getProc("glutSetWindow");
	glutGetWindow = cast(pfglutGetWindow)getProc("glutGetWindow");
	glutSetWindowTitle = cast(pfglutSetWindowTitle)getProc("glutSetWindowTitle");
	glutSetIconTitle = cast(pfglutSetIconTitle)getProc("glutSetIconTitle");
	glutReshapeWindow = cast(pfglutReshapeWindow)getProc("glutReshapeWindow");
	glutPositionWindow = cast(pfglutPositionWindow)getProc("glutPositionWindow");
	glutShowWindow = cast(pfglutShowWindow)getProc("glutShowWindow");
	glutHideWindow = cast(pfglutHideWindow)getProc("glutHideWindow");
	glutIconifyWindow = cast(pfglutIconifyWindow)getProc("glutIconifyWindow");
	glutPushWindow = cast(pfglutPushWindow)getProc("glutPushWindow");
	glutPopWindow = cast(pfglutPopWindow)getProc("glutPopWindow");
	glutFullScreen = cast(pfglutFullScreen)getProc("glutFullScreen");
	glutPostWindowRedisplay = cast(pfglutPostWindowRedisplay)getProc("glutPostWindowRedisplay");
	glutPostRedisplay = cast(pfglutPostRedisplay)getProc("glutPostRedisplay");
	glutSwapBuffers = cast(pfglutSwapBuffers)getProc("glutSwapBuffers");
	glutWarpPointer = cast(pfglutWarpPointer)getProc("glutWarpPointer");
	glutSetCursor = cast(pfglutSetCursor)getProc("glutSetCursor");
	glutEstablishOverlay = cast(pfglutEstablishOverlay)getProc("glutEstablishOverlay");
	glutRemoveOverlay = cast(pfglutRemoveOverlay)getProc("glutRemoveOverlay");
	glutUseLayer = cast(pfglutUseLayer)getProc("glutUseLayer");
	glutPostOverlayRedisplay = cast(pfglutPostOverlayRedisplay)getProc("glutPostOverlayRedisplay");
	glutPostWindowOverlayRedisplay = cast(pfglutPostWindowOverlayRedisplay)getProc("glutPostWindowOverlayRedisplay");
	glutHideOverlay = cast(pfglutHideOverlay)getProc("glutHideOverlay");
	glutCreateMenu = cast(pfglutCreateMenu)getProc("glutCreateMenu");
	glutDestroyMenu = cast(pfglutDestroyMenu)getProc("glutDestroyMenu");
	glutGetMenu = cast(pfglutGetMenu)getProc("glutGetMenu");
	glutSetMenu = cast(pfglutSetMenu)getProc("glutSetMenu");
	glutAddMenuEntry = cast(pfglutAddMenuEntry)getProc("glutAddMenuEntry");
	glutAddSubMenu = cast(pfglutAddSubMenu)getProc("glutAddSubMenu");
	glutChangeToMenuEntry = cast(pfglutChangeToMenuEntry)getProc("glutChangeToMenuEntry");
	glutChangeToSubMenu = cast(pfglutChangeToSubMenu)getProc("glutChangeToSubMenu");
	glutRemoveMenuItem = cast(pfglutRemoveMenuItem)getProc("glutRemoveMenuItem");
	glutAttachMenu = cast(pfglutAttachMenu)getProc("glutAttachMenu");
	glutDetachMenu = cast(pfglutDetachMenu)getProc("glutDetachMenu");
	glutTimerFunc = cast(pfglutTimerFunc)getProc("glutTimerFunc");
	glutIdleFunc = cast(pfglutIdleFunc)getProc("glutIdleFunc");
	glutKeyboardFunc = cast(pfglutKeyboardFunc)getProc("glutKeyboardFunc");
	glutSpecialFunc = cast(pfglutSpecialFunc)getProc("glutSpecialFunc");
	glutReshapeFunc = cast(pfglutReshapeFunc)getProc("glutReshapeFunc");
	glutVisibilityFunc = cast(pfglutVisibilityFunc)getProc("glutVisibilityFunc");
	glutDisplayFunc = cast(pfglutDisplayFunc)getProc("glutDisplayFunc");
	glutMouseFunc = cast(pfglutMouseFunc)getProc("glutMouseFunc");
	glutMotionFunc = cast(pfglutMotionFunc)getProc("glutMotionFunc");
	glutPassiveMotionFunc = cast(pfglutPassiveMotionFunc)getProc("glutPassiveMotionFunc");
	glutEntryFunc = cast(pfglutEntryFunc)getProc("glutEntryFunc");
	glutKeyboardUpFunc = cast(pfglutKeyboardUpFunc)getProc("glutKeyboardUpFunc");
	glutSpecialUpFunc = cast(pfglutSpecialUpFunc)getProc("glutSpecialUpFunc");
	glutJoystickFunc = cast(pfglutJoystickFunc)getProc("glutJoystickFunc");
	glutMenuStateFunc = cast(pfglutMenuStateFunc)getProc("glutMenuStateFunc");
	glutMenuStatusFunc = cast(pfglutMenuStatusFunc)getProc("glutMenuStatusFunc");
	glutOverlayDisplayFunc = cast(pfglutOverlayDisplayFunc)getProc("glutOverlayDisplayFunc");
	glutWindowStatusFunc = cast(pfglutWindowStatusFunc)getProc("glutWindowStatusFunc");
	glutSpaceballMotionFunc = cast(pfglutSpaceballMotionFunc)getProc("glutSpaceballMotionFunc");
	glutSpaceballRotateFunc = cast(pfglutSpaceballRotateFunc)getProc("glutSpaceballRotateFunc");
	glutSpaceballButtonFunc = cast(pfglutSpaceballButtonFunc)getProc("glutSpaceballButtonFunc");
	glutButtonBoxFunc = cast(pfglutButtonBoxFunc)getProc("glutButtonBoxFunc");
	glutDialsFunc = cast(pfglutDialsFunc)getProc("glutDialsFunc");
	glutTabletMotionFunc = cast(pfglutTabletMotionFunc)getProc("glutTabletMotionFunc");
	glutTabletButtonFunc = cast(pfglutTabletButtonFunc)getProc("glutTabletButtonFunc");
	glutGet = cast(pfglutGet)getProc("glutGet");
	glutDeviceGet = cast(pfglutDeviceGet)getProc("glutDeviceGet");
	glutGetModifiers = cast(pfglutGetModifiers)getProc("glutGetModifiers");
	glutLayerGet = cast(pfglutLayerGet)getProc("glutLayerGet");
	glutBitmapCharacter = cast(pfglutBitmapCharacter)getProc("glutBitmapCharacter");
	glutBitmapWidth = cast(pfglutBitmapWidth)getProc("glutBitmapWidth");
	glutStrokeCharacter = cast(pfglutStrokeCharacter)getProc("glutStrokeCharacter");
	glutStrokeWidth = cast(pfglutStrokeWidth)getProc("glutStrokeWidth");
	glutBitmapLength = cast(pfglutBitmapLength)getProc("glutBitmapLength");
	glutStrokeLength = cast(pfglutStrokeLength)getProc("glutStrokeLength");
	glutWireCube = cast(pfglutWireCube)getProc("glutWireCube");
	glutSolidCube = cast(pfglutSolidCube)getProc("glutSolidCube");
	glutWireSphere = cast(pfglutWireSphere)getProc("glutWireSphere");
	glutSolidSphere = cast(pfglutSolidSphere)getProc("glutSolidSphere");
	glutWireCone = cast(pfglutWireCone)getProc("glutWireCone");
	glutSolidCone = cast(pfglutSolidCone)getProc("glutSolidCone");
	glutWireTorus = cast(pfglutWireTorus)getProc("glutWireTorus");
	glutSolidTorus = cast(pfglutSolidTorus)getProc("glutSolidTorus");
	glutWireDodecahedron = cast(pfglutWireDodecahedron)getProc("glutWireDodecahedron");
	glutSolidDodecahedron = cast(pfglutSolidDodecahedron)getProc("glutSolidDodecahedron");
	glutWireOctahedron = cast(pfglutWireOctahedron)getProc("glutWireOctahedron");
	glutSolidOctahedron = cast(pfglutSolidOctahedron)getProc("glutSolidOctahedron");
	glutWireTetrahedron = cast(pfglutWireTetrahedron)getProc("glutWireTetrahedron");
	glutSolidTetrahedron = cast(pfglutSolidTetrahedron)getProc("glutSolidTetrahedron");
	glutWireIcosahedron = cast(pfglutWireIcosahedron)getProc("glutWireIcosahedron");
	glutSolidIcosahedron = cast(pfglutSolidIcosahedron)getProc("glutSolidIcosahedron");
	glutWireTeapot = cast(pfglutWireTeapot)getProc("glutWireTeapot");
	glutSolidTeapot = cast(pfglutSolidTeapot)getProc("glutSolidTeapot");
	glutGameModeString = cast(pfglutGameModeString)getProc("glutGameModeString");
	glutEnterGameMode = cast(pfglutEnterGameMode)getProc("glutEnterGameMode");
	glutLeaveGameMode = cast(pfglutLeaveGameMode)getProc("glutLeaveGameMode");
	glutGameModeGet = cast(pfglutGameModeGet)getProc("glutGameModeGet");
	glutVideoResizeGet = cast(pfglutVideoResizeGet)getProc("glutVideoResizeGet");
	glutSetupVideoResizing = cast(pfglutSetupVideoResizing)getProc("glutSetupVideoResizing");
	glutStopVideoResizing = cast(pfglutStopVideoResizing)getProc("glutStopVideoResizing");
	glutVideoResize = cast(pfglutVideoResize)getProc("glutVideoResize");
	glutVideoPan = cast(pfglutVideoPan)getProc("glutVideoPan");
	glutSetColor = cast(pfglutSetColor)getProc("glutSetColor");
	glutGetColor = cast(pfglutGetColor)getProc("glutGetColor");
	glutCopyColormap = cast(pfglutCopyColormap)getProc("glutCopyColormap");
	glutIgnoreKeyRepeat = cast(pfglutIgnoreKeyRepeat)getProc("glutIgnoreKeyRepeat");
	glutSetKeyRepeat = cast(pfglutSetKeyRepeat)getProc("glutSetKeyRepeat");
	glutForceJoystickFunc = cast(pfglutForceJoystickFunc)getProc("glutForceJoystickFunc");
	glutExtensionSupported = cast(pfglutExtensionSupported)getProc("glutExtensionSupported");
	glutReportErrors = cast(pfglutReportErrors)getProc("glutReportErrors");

	version (FREEGLUT_EXTRAS) {
		glutMainLoopEvent = cast(pfglutMainLoopEvent)getProc("glutMainLoopEvent");
		glutLeaveMainLoop = cast(pfglutLeaveMainLoop)getProc("glutLeaveMainLoop");
		glutMouseWheelFunc = cast(pfglutMouseWheelFunc)getProc("glutMouseWheelFunc");
		glutCloseFunc = cast(pfglutCloseFunc)getProc("glutCloseFunc");
		glutWMCloseFunc = cast(pfglutWMCloseFunc)getProc("glutWMCloseFunc");
		glutMenuDestroyFunc = cast(pfglutMenuDestroyFunc)getProc("glutMenuDestroyFunc");
		glutSetOption = cast(pfglutSetOption)getProc("glutSetOption");
		glutGetWindowData = cast(pfglutGetWindowData)getProc("glutGetWindowData");
		glutSetWindowData = cast(pfglutSetWindowData)getProc("glutSetWindowData");
		glutGetMenuData = cast(pfglutGetMenuData)getProc("glutGetMenuData");
		glutSetMenuData = cast(pfglutSetMenuData)getProc("glutSetMenuData");
		glutBitmapHeight = cast(pfglutBitmapHeight)getProc("glutBitmapHeight");
		glutStrokeHeight = cast(pfglutStrokeHeight)getProc("glutStrokeHeight");
		glutBitmapString = cast(pfglutBitmapString)getProc("glutBitmapString");
		glutStrokeString = cast(pfglutStrokeString)getProc("glutStrokeString");
		glutWireRhombicDodecahedron = cast(pfglutWireRhombicDodecahedron)getProc("glutWireRhombicDodecahedron");
		glutSolidRhombicDodecahedron = cast(pfglutSolidRhombicDodecahedron)getProc("glutSolidRhombicDodecahedron");
		glutWireSierpinskiSponge = cast(pfglutWireSierpinskiSponge)getProc("glutWireSierpinskiSponge");
		glutSolidSierpinskiSponge = cast(pfglutSolidSierpinskiSponge)getProc("glutSolidSierpinskiSponge");
		glutWireCylinder = cast(pfglutWireCylinder)getProc("glutWireCylinder");
		glutSolidCylinder = cast(pfglutSolidCylinder)getProc("glutSolidCylinder");
		glutGetProcAddress = cast(pfglutGetProcAddress)getProc("glutGetProcAddress");
	}
}

static ~this() {
	ExeModule_Release(glutdrv);
}

typedef GLvoid function(GLchar, GLint, GLint) KB_callback;
typedef GLvoid function() Display_callback;
typedef GLvoid function() GLUTproc;

private alias GLvoid function() fn_V;
private alias GLvoid function(GLubyte, GLint, GLint) fn_VuBII;
private alias GLvoid function(GLint) fn_VI;
private alias GLvoid function(GLint, GLint) fn_VII;
private alias GLvoid function(GLint, GLint, GLint) fn_VIII;
private alias GLvoid function(GLint, GLint, GLint, GLint) fn_VIIII;
private alias GLvoid function(GLuint, GLint, GLint, GLint) fn_VuIIII;

version (Windows) {
	extern (Windows):
} else {
	extern (C):
}
typedef GLvoid function(GLint*, GLchar**) pfglutInit;
typedef GLvoid function(GLint, GLint) pfglutInitWindowPosition;
typedef GLvoid function(GLint, GLint) pfglutInitWindowSize;
typedef GLvoid function(GLuint) pfglutInitDisplayMode;
typedef GLvoid function(GLchar*) pfglutInitDisplayString;
typedef GLvoid function() pfglutMainLoop;
typedef GLint function(GLchar*) pfglutCreateWindow;
typedef GLint function(GLint, GLint, GLint, GLint, GLint) pfglutCreateSubWindow;
typedef GLvoid function(GLint) pfglutDestroyWindow;
typedef GLvoid function(GLint) pfglutSetWindow;
typedef GLint function() pfglutGetWindow;
typedef GLvoid function(GLchar*) pfglutSetWindowTitle;
typedef GLvoid function(GLchar*) pfglutSetIconTitle;
typedef GLvoid function(GLint, GLint) pfglutReshapeWindow;
typedef GLvoid function(GLint, GLint) pfglutPositionWindow;
typedef GLvoid function() pfglutShowWindow;
typedef GLvoid function() pfglutHideWindow;
typedef GLvoid function() pfglutIconifyWindow;
typedef GLvoid function() pfglutPushWindow;
typedef GLvoid function() pfglutPopWindow;
typedef GLvoid function() pfglutFullScreen;
typedef GLvoid function(GLint) pfglutPostWindowRedisplay;
typedef GLvoid function() pfglutPostRedisplay;
typedef GLvoid function() pfglutSwapBuffers;
typedef GLvoid function(GLint, GLint) pfglutWarpPointer;
typedef GLvoid function(GLint) pfglutSetCursor;
typedef GLvoid function() pfglutEstablishOverlay;
typedef GLvoid function() pfglutRemoveOverlay;
typedef GLvoid function(GLenum) pfglutUseLayer;
typedef GLvoid function() pfglutPostOverlayRedisplay;
typedef GLvoid function(GLint) pfglutPostWindowOverlayRedisplay;
typedef GLvoid function() pfglutShowOverlay;
typedef GLvoid function() pfglutHideOverlay;
typedef GLint function(fn_VI) pfglutCreateMenu;
typedef GLvoid function(GLint) pfglutDestroyMenu;
typedef GLint function() pfglutGetMenu;
typedef GLvoid function(GLint) pfglutSetMenu;
typedef GLvoid function(GLchar*, GLint) pfglutAddMenuEntry;
typedef GLvoid function(GLchar*, GLint) pfglutAddSubMenu;
typedef GLvoid function(GLint, GLchar*, GLint) pfglutChangeToMenuEntry;
typedef GLvoid function(GLint, GLchar*, GLint) pfglutChangeToSubMenu;
typedef GLvoid function(GLint) pfglutRemoveMenuItem;
typedef GLvoid function(GLint) pfglutAttachMenu;
typedef GLvoid function(GLint) pfglutDetachMenu;
typedef GLvoid function(GLuint, fn_VI, GLint) pfglutTimerFunc;
typedef GLvoid function(fn_V) pfglutIdleFunc;
typedef GLvoid function(KB_callback) pfglutKeyboardFunc;
typedef GLvoid function(fn_VIII) pfglutSpecialFunc;
typedef GLvoid function(fn_VII) pfglutReshapeFunc;
typedef GLvoid function(fn_VI) pfglutVisibilityFunc;
typedef GLvoid function(Display_callback) pfglutDisplayFunc;
typedef GLvoid function(fn_VIIII) pfglutMouseFunc;
typedef GLvoid function(fn_VII) pfglutMotionFunc;
typedef GLvoid function(fn_VII) pfglutPassiveMotionFunc;
typedef GLvoid function(fn_VI) pfglutEntryFunc;
typedef GLvoid function(fn_VuBII) pfglutKeyboardUpFunc;
typedef GLvoid function(KB_callback) pfglutSpecialUpFunc;
typedef GLvoid function(fn_VuIIII, GLint) pfglutJoystickFunc;
typedef GLvoid function(fn_VI) pfglutMenuStateFunc;
typedef GLvoid function(fn_VIII) pfglutMenuStatusFunc;
typedef GLvoid function(Display_callback) pfglutOverlayDisplayFunc;
typedef GLvoid function(fn_VI) pfglutWindowStatusFunc;
typedef GLvoid function(fn_VIII) pfglutSpaceballMotionFunc;
typedef GLvoid function(fn_VIII) pfglutSpaceballRotateFunc;
typedef GLvoid function(fn_VII) pfglutSpaceballButtonFunc;
typedef GLvoid function(fn_VII) pfglutButtonBoxFunc;
typedef GLvoid function(fn_VII) pfglutDialsFunc;
typedef GLvoid function(fn_VII) pfglutTabletMotionFunc;
typedef GLvoid function(fn_VIIII) pfglutTabletButtonFunc;
typedef GLint function(GLenum) pfglutGet;
typedef GLint function(GLenum) pfglutDeviceGet;
typedef GLint function() pfglutGetModifiers;
typedef GLint function(GLenum) pfglutLayerGet;
typedef GLvoid function(GLvoid*, GLint) pfglutBitmapCharacter;
typedef GLint function(GLvoid*, GLint) pfglutBitmapWidth;
typedef GLvoid function(GLvoid*, GLint) pfglutStrokeCharacter;
typedef GLint function(GLvoid*, GLint) pfglutStrokeWidth;
typedef GLint function(GLvoid*, GLubyte*) pfglutBitmapLength;
typedef GLint function(GLvoid*, GLubyte*) pfglutStrokeLength;
typedef GLvoid function(GLdouble) pfglutWireCube;
typedef GLvoid function(GLdouble) pfglutSolidCube;
typedef GLvoid function(GLdouble, GLint, GLint) pfglutWireSphere;
typedef GLvoid function(GLdouble, GLint, GLint) pfglutSolidSphere;
typedef GLvoid function(GLdouble, GLdouble, GLint, GLint) pfglutWireCone;
typedef GLvoid function(GLdouble, GLdouble, GLint, GLint) pfglutSolidCone;
typedef GLvoid function(GLdouble, GLdouble, GLint, GLint) pfglutWireTorus;
typedef GLvoid function(GLdouble, GLdouble, GLint, GLint) pfglutSolidTorus;
typedef GLvoid function() pfglutWireDodecahedron;
typedef GLvoid function() pfglutSolidDodecahedron;
typedef GLvoid function() pfglutWireOctahedron;
typedef GLvoid function() pfglutSolidOctahedron;
typedef GLvoid function() pfglutWireTetrahedron;
typedef GLvoid function() pfglutSolidTetrahedron;
typedef GLvoid function() pfglutWireIcosahedron;
typedef GLvoid function() pfglutSolidIcosahedron;
typedef GLvoid function(GLdouble) pfglutWireTeapot;
typedef GLvoid function(GLdouble) pfglutSolidTeapot;
typedef GLvoid function(GLchar*) pfglutGameModeString;
typedef GLint function() pfglutEnterGameMode;
typedef GLvoid function() pfglutLeaveGameMode;
typedef GLint function(GLenum) pfglutGameModeGet;
typedef GLint function(GLenum) pfglutVideoResizeGet;
typedef GLvoid function() pfglutSetupVideoResizing;
typedef GLvoid function() pfglutStopVideoResizing;
typedef GLvoid function(GLint, GLint, GLint, GLint) pfglutVideoResize;
typedef GLvoid function(GLint, GLint, GLint, GLint) pfglutVideoPan;
typedef GLvoid function(GLint, GLfloat, GLfloat, GLfloat) pfglutSetColor;
typedef GLfloat function(GLint, GLint) pfglutGetColor;
typedef GLvoid function(GLint) pfglutCopyColormap;
typedef GLvoid function(GLint) pfglutIgnoreKeyRepeat;
typedef GLvoid function(GLint) pfglutSetKeyRepeat;
typedef GLvoid function() pfglutForceJoystickFunc;
typedef GLint function(GLchar*) pfglutExtensionSupported;
typedef GLvoid function() pfglutReportErrors;

pfglutInit			glutInit;
pfglutInitWindowPosition	glutInitWindowPosition;
pfglutInitWindowSize		glutInitWindowSize;
pfglutInitDisplayMode		glutInitDisplayMode;
pfglutInitDisplayString		glutInitDisplayString;
pfglutMainLoop			glutMainLoop;
pfglutCreateWindow		glutCreateWindow;
pfglutCreateSubWindow		glutCreateSubWindow;
pfglutDestroyWindow		glutDestroyWindow;
pfglutSetWindow			glutSetWindow;
pfglutGetWindow			glutGetWindow;
pfglutSetWindowTitle		glutSetWindowTitle;
pfglutSetIconTitle		glutSetIconTitle;
pfglutReshapeWindow		glutReshapeWindow;
pfglutPositionWindow		glutPositionWindow;
pfglutShowWindow		glutShowWindow;
pfglutHideWindow		glutHideWindow;
pfglutIconifyWindow		glutIconifyWindow;
pfglutPushWindow		glutPushWindow;
pfglutPopWindow			glutPopWindow;
pfglutFullScreen		glutFullScreen;
pfglutPostWindowRedisplay	glutPostWindowRedisplay;
pfglutPostRedisplay		glutPostRedisplay;
pfglutSwapBuffers		glutSwapBuffers;
pfglutWarpPointer		glutWarpPointer;
pfglutSetCursor			glutSetCursor;
pfglutEstablishOverlay		glutEstablishOverlay;
pfglutRemoveOverlay		glutRemoveOverlay;
pfglutUseLayer			glutUseLayer;
pfglutPostOverlayRedisplay	glutPostOverlayRedisplay;
pfglutPostWindowOverlayRedisplay glutPostWindowOverlayRedisplay;
pfglutShowOverlay		glutShowOverlay;
pfglutHideOverlay		glutHideOverlay;
pfglutCreateMenu		glutCreateMenu;
pfglutDestroyMenu		glutDestroyMenu;
pfglutGetMenu			glutGetMenu;
pfglutSetMenu			glutSetMenu;
pfglutAddMenuEntry		glutAddMenuEntry;
pfglutAddSubMenu		glutAddSubMenu;
pfglutChangeToMenuEntry		glutChangeToMenuEntry;
pfglutChangeToSubMenu		glutChangeToSubMenu;
pfglutRemoveMenuItem		glutRemoveMenuItem;
pfglutAttachMenu		glutAttachMenu;
pfglutDetachMenu		glutDetachMenu;
pfglutTimerFunc			glutTimerFunc;
pfglutIdleFunc			glutIdleFunc;
pfglutKeyboardFunc		glutKeyboardFunc;
pfglutSpecialFunc		glutSpecialFunc;
pfglutReshapeFunc		glutReshapeFunc;
pfglutVisibilityFunc		glutVisibilityFunc;
pfglutDisplayFunc		glutDisplayFunc;
pfglutMouseFunc			glutMouseFunc;
pfglutMotionFunc		glutMotionFunc;
pfglutPassiveMotionFunc		glutPassiveMotionFunc;
pfglutEntryFunc			glutEntryFunc;
pfglutKeyboardUpFunc		glutKeyboardUpFunc;
pfglutSpecialUpFunc		glutSpecialUpFunc;
pfglutJoystickFunc		glutJoystickFunc;
pfglutMenuStateFunc		glutMenuStateFunc;
pfglutMenuStatusFunc		glutMenuStatusFunc;
pfglutOverlayDisplayFunc	glutOverlayDisplayFunc;
pfglutWindowStatusFunc		glutWindowStatusFunc;
pfglutSpaceballMotionFunc	glutSpaceballMotionFunc;
pfglutSpaceballRotateFunc	glutSpaceballRotateFunc;
pfglutSpaceballButtonFunc	glutSpaceballButtonFunc;
pfglutButtonBoxFunc		glutButtonBoxFunc;
pfglutDialsFunc			glutDialsFunc;
pfglutTabletMotionFunc		glutTabletMotionFunc;
pfglutTabletButtonFunc		glutTabletButtonFunc;
pfglutGet			glutGet;
pfglutDeviceGet			glutDeviceGet;
pfglutGetModifiers		glutGetModifiers;
pfglutLayerGet			glutLayerGet;
pfglutBitmapCharacter		glutBitmapCharacter;
pfglutBitmapWidth		glutBitmapWidth;
pfglutStrokeCharacter		glutStrokeCharacter;
pfglutStrokeWidth		glutStrokeWidth;
pfglutBitmapLength		glutBitmapLength;
pfglutStrokeLength		glutStrokeLength;
pfglutWireCube			glutWireCube;
pfglutSolidCube			glutSolidCube;
pfglutWireSphere		glutWireSphere;
pfglutSolidSphere		glutSolidSphere;
pfglutWireCone			glutWireCone;
pfglutSolidCone			glutSolidCone;
pfglutWireTorus			glutWireTorus;
pfglutSolidTorus		glutSolidTorus;
pfglutWireDodecahedron		glutWireDodecahedron;
pfglutSolidDodecahedron		glutSolidDodecahedron;
pfglutWireOctahedron		glutWireOctahedron;
pfglutSolidOctahedron		glutSolidOctahedron;
pfglutWireTetrahedron		glutWireTetrahedron;
pfglutSolidTetrahedron		glutSolidTetrahedron;
pfglutWireIcosahedron		glutWireIcosahedron;
pfglutSolidIcosahedron		glutSolidIcosahedron;
pfglutWireTeapot		glutWireTeapot;
pfglutSolidTeapot		glutSolidTeapot;
pfglutGameModeString		glutGameModeString;
pfglutEnterGameMode		glutEnterGameMode;
pfglutLeaveGameMode		glutLeaveGameMode;
pfglutGameModeGet		glutGameModeGet;
pfglutVideoResizeGet		glutVideoResizeGet;
pfglutSetupVideoResizing	glutSetupVideoResizing;
pfglutStopVideoResizing		glutStopVideoResizing;
pfglutVideoResize		glutVideoResize;
pfglutVideoPan			glutVideoPan;
pfglutSetColor			glutSetColor;
pfglutGetColor			glutGetColor;
pfglutCopyColormap		glutCopyColormap;
pfglutIgnoreKeyRepeat		glutIgnoreKeyRepeat;
pfglutSetKeyRepeat		glutSetKeyRepeat;
pfglutForceJoystickFunc		glutForceJoystickFunc;
pfglutExtensionSupported	glutExtensionSupported;
pfglutReportErrors		glutReportErrors;

/*
 * FreeGlut extra functions
 */
version (FREEGLUT_EXTRAS) {
	typedef GLvoid function() pfglutMainLoopEvent;
	typedef	GLvoid function() pfglutLeaveMainLoop;
	typedef	GLvoid function(fn_VIIII) pfglutMouseWheelFunc;
	typedef	GLvoid function(fn_V) pfglutCloseFunc;
	typedef	GLvoid function(fn_V) pfglutWMCloseFunc;
	typedef	GLvoid function(fn_V) pfglutMenuDestroyFunc;
	typedef	GLvoid function(GLenum, GLint) pfglutSetOption;
	typedef	GLvoid* function() pfglutGetWindowData;
	typedef	GLvoid function(GLvoid*) pfglutSetWindowData;
	typedef	GLvoid* function() pfglutGetMenuData;
	typedef	GLvoid function(GLvoid*) pfglutSetMenuData;
	typedef	GLint function(GLvoid*) pfglutBitmapHeight;
	typedef	GLfloat function(GLvoid*) pfglutStrokeHeight;
	typedef	GLvoid function(GLvoid*, GLchar*) pfglutBitmapString;
	typedef	GLvoid function(GLvoid*, GLchar*) pfglutStrokeString;
	typedef	GLvoid function() pfglutWireRhombicDodecahedron;
	typedef	GLvoid function() pfglutSolidRhombicDodecahedron;
	typedef	GLvoid function(GLint, GLdouble[3], GLdouble) pfglutWireSierpinskiSponge;
	typedef	GLvoid function(GLint, GLdouble[3], GLdouble) pfglutSolidSierpinskiSponge;
	typedef	GLvoid function(GLdouble, GLdouble, GLint, GLint) pfglutWireCylinder;
	typedef	GLvoid function(GLdouble, GLdouble, GLint, GLint) pfglutSolidCylinder;
	typedef	GLUTproc function(GLchar*) pfglutGetProcAddress;

	pfglutMainLoopEvent		glutMainLoopEvent;
	pfglutLeaveMainLoop		glutLeaveMainLoop;
	pfglutMouseWheelFunc		glutMouseWheelFunc;
	pfglutCloseFunc			glutCloseFunc;
	pfglutWMCloseFunc		glutWMCloseFunc;
	pfglutMenuDestroyFunc		glutMenuDestroyFunc;
	pfglutSetOption			glutSetOption;
	pfglutGetWindowData		glutGetWindowData;
	pfglutSetWindowData		glutSetWindowData;
	pfglutGetMenuData		glutGetMenuData;
	pfglutSetMenuData		glutSetMenuData;
	pfglutBitmapHeight		glutBitmapHeight;
	pfglutStrokeHeight		glutStrokeHeight;
	pfglutBitmapString		glutBitmapString;
	pfglutStrokeString		glutStrokeString;
	pfglutWireRhombicDodecahedron	glutWireRhombicDodecahedron;
	pfglutSolidRhombicDodecahedron	glutSolidRhombicDodecahedron;
	pfglutWireSierpinskiSponge	glutWireSierpinskiSponge;
	pfglutSolidSierpinskiSponge	glutSolidSierpinskiSponge;
	pfglutWireCylinder		glutWireCylinder;
	pfglutSolidCylinder		glutSolidCylinder;
	pfglutGetProcAddress		glutGetProcAddress;
}
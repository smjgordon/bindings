module c.gl._glextern;

/*
 * Semi-necessary hack.  Don't directly import this file.
 */

version (Windows) {
} else {
	// I don't really know if it's a good idea... But here it goes:
	extern (C) GLvoid* glutStrokeRoman;
	extern (C) GLvoid* glutStrokeMonoRoman;
	extern (C) GLvoid* glutBitmap9By15;
	extern (C) GLvoid* glutBitmap8By13;
	extern (C) GLvoid* glutBitmapTimesRoman10;
	extern (C) GLvoid* glutBitmapTimesRoman24;
	extern (C) GLvoid* glutBitmapHelvetica10;
	extern (C) GLvoid* glutBitmapHelvetica12;
	extern (C) GLvoid* glutBitmapHelvetica18;
}
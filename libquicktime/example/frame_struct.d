/*  frame_struct.d
 *  
 *  C++ version:
 *  Copyright (C) 2005 Richard Spindler <richard.spindler AT gmail.com>
 *
 *  D version:
 *  Copyright (C) 2008 Jonas Kivi <satelliittipupu AT yahoo.co.uk>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

module frame_struct;

import tango.io.Stdout;
//import stringz = tango.stdc.stringz;

import globals;

enum render_strategy_t
{
	RENDER_FIT = 0,
	RENDER_CROP,
	RENDER_STRETCH,
	RENDER_DEFAULT
}

/*
//Was:
enum interlace_state
{
	INTERLACE_PROGRESSIVE = 0,
	INTERLACE_TOP_FIELD_FIRST = 1,
	INTERLACE_BOTTOM_FIELD_FIRST = 2,
	INTERLACE_DEVIDED_FIELDS = 3 // Top Frame is first
}
*/

enum InterlaceType
{
	PROGRESSIVE = 0,
	TOP_FIELD_FIRST = 1,
	BOTTOM_FIELD_FIRST = 2,
	DEVIDED_FIELDS = 3 // Top Frame is first
}

struct frame_struct
{
	int x, y, w, h;
	ubyte* RGB;
	ubyte* YUV;
	ubyte*[] rows;
	int64_t nr;
	float alpha;
	bool has_alpha_channel;
	bool cacheable;
	render_strategy_t render_strategy;
	float pixel_aspect_ratio;
	int pixel_w;
	int pixel_h;
	InterlaceType interlace_mode;//Was int
	bool first_field; // should be true if first field is to be displayed
	int scale_x;
	int scale_y;
	int crop_left;
	int crop_right;
	int crop_top;
	int crop_bottom;
	int tilt_x;
	int tilt_y;
	bool dirty;
}





/* Converted to D from colormodels.h by htod */
module lqt.colormodels;
/*******************************************************************************
 colormodels.h

 libquicktime - A library for reading and writing quicktime/avi/mp4 files.
 http://libquicktime.sourceforge.net

 Copyright (C) 2002 Heroine Virtual Ltd.
 Copyright (C) 2002-2007 Members of the libquicktime project.

 This library is free software; you can redistribute it and/or modify it under
 the terms of the GNU Lesser General Public License as published by the Free
 Software Foundation; either version 2.1 of the License, or (at your option)
 any later version.

 This library is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 details.

 You should have received a copy of the GNU Lesser General Public License along
 with this library; if not, write to the Free Software Foundation, Inc., 51
 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
*******************************************************************************/
 
 
//C     #ifndef COLORMODELS_H
//C     #define COLORMODELS_H

/** \defgroup color Color handling

   Libquicktime has a built in colormodel converter, which can do implicit colormodel
   conversions while en-/decoding. It is, however, far from perfect: It is incomplete
   (i.e. not all conversions are present), slow and sometimes inaccurate. Therefore,
   there is a possibility to bypass internal colormodel conversions.
*/

// Colormodels
//C     #define BC_COMPRESSED   1

const BC_COMPRESSED = 1;
/** \ingroup color

    16 bit RGB. Each pixel is a unsigned short in native byte order. Color masks are:
    for red: 0xf800, for green: 0x07e0, for blue: 0x001f
*/

//C     #define BC_RGB565       2

const BC_RGB565 = 2;
/** \ingroup color

    16 bit BGR. Each pixel is a unsigned short in native byte order. Color masks are:
    for red: 0x001f, for green: 0x07e0, for blue: 0xf800
*/

//C     #define BC_BGR565       3

const BC_BGR565 = 3;
/** \ingroup color

    24 bit BGR. Each color is an unsigned char. Color order is BGR
*/

//C     #define BC_BGR888       4

const BC_BGR888 = 4;
/** \ingroup color

 32 bit BGR. Each color is an unsigned char. Color order is BGRXBGRX, where X is unused
*/

//C     #define BC_BGR8888      5

const BC_BGR8888 = 5;
/** \ingroup color

    24 bit RGB. Each color is an unsigned char. Color order is RGB
*/


//C     #define BC_RGB888       6

const BC_RGB888 = 6;
/** \ingroup color

    32 bit RGBA. Each color is an unsigned char. Color order is RGBARGBA
*/

//C     #define BC_RGBA8888     7

const BC_RGBA8888 = 7;
/** \ingroup color

    48 bit RGB. Each color is an unsigned short in native byte order. Color order is RGB
*/

//C     #define BC_RGB161616    8

const BC_RGB161616 = 8;
/** \ingroup color

    64 bit RGBA. Each color is an unsigned short in native byte order. Color order is RGBA
*/

//C     #define BC_RGBA16161616 9

const BC_RGBA16161616 = 9;
/** \ingroup color

    Packed YCbCrA 4:4:4:4. Each component is an unsigned char. Component order is YUVA
*/

//C     #define BC_YUVA8888     10

const BC_YUVA8888 = 10;
/** \ingroup color

    Packed YCbCr 4:2:2. Each component is an unsigned char. Component order is Y1 U1 Y2 V1
*/

//C     #define BC_YUV422       13
// Planar
const BC_YUV422 = 13;

/** \ingroup color

    Planar YCbCr 4:2:0. Each component is an unsigned char. Chroma placement is defined by
    \ref lqt_chroma_placement_t
*/

//C     #define BC_YUV420P      14

const BC_YUV420P = 14;
/** \ingroup color

    Planar YCbCr 4:2:2. Each component is an unsigned char
*/

//C     #define BC_YUV422P      15

const BC_YUV422P = 15;
/** \ingroup color

    Planar YCbCr 4:4:4. Each component is an unsigned char
*/

//C     #define BC_YUV444P      16

const BC_YUV444P = 16;
/** \ingroup color

    Planar YCbCr 4:1:1. Each component is an unsigned char
*/

//C     #define BC_YUV411P      17
/* JPEG scaled colormodels */
const BC_YUV411P = 17;

/** \ingroup color

    Planar YCbCr 4:2:0. Each component is an unsigned char, luma and chroma values are full range (0x00 .. 0xff)
*/

//C     #define BC_YUVJ420P     18

const BC_YUVJ420P = 18;
/** \ingroup color

    Planar YCbCr 4:2:2. Each component is an unsigned char, luma and chroma values are full range (0x00 .. 0xff)
*/

//C     #define BC_YUVJ422P     19

const BC_YUVJ422P = 19;
/** \ingroup color

    Planar YCbCr 4:4:4. Each component is an unsigned char, luma and chroma values are full range (0x00 .. 0xff)
*/

//C     #define BC_YUVJ444P     20
/* 16 bit per component planar formats */
const BC_YUVJ444P = 20;

/** \ingroup color

    16 bit Planar YCbCr 4:2:2. Each component is an unsigned short in native byte order.
*/

//C     #define BC_YUV422P16    21

const BC_YUV422P16 = 21;
/** \ingroup color

    16 bit Planar YCbCr 4:4:4. Each component is an unsigned short in native byte order.
*/

//C     #define BC_YUV444P16    22

const BC_YUV444P16 = 22;
// Colormodels purely used by Quicktime are done in Quicktime.

// For communication with the X Server
//C     #define FOURCC_YV12 0x32315659  /* YV12   YUV420P */
//C     #define FOURCC_YUV2 0x32595559  /* YUV2   YUV422 */
const FOURCC_YV12 = 0x32315659;
//C     #define FOURCC_I420 0x30323449  /* I420   Intel Indeo 4 */
const FOURCC_YUV2 = 0x32595559;

const FOURCC_I420 = 0x30323449;
// #undef RECLIP
// #define RECLIP(x, y, z) ((x) = ((x) < (y) ? (y) : ((x) > (z) ? (z) : (x))))

//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif

//C     int cmodel_calculate_pixelsize(int colormodel);
extern (C):
int  cmodel_calculate_pixelsize(int colormodel);
//C     int cmodel_calculate_datasize(int w, int h, int bytes_per_line, int color_model);
int  cmodel_calculate_datasize(int w, int h, int bytes_per_line, int color_model);
//C     int cmodel_calculate_max(int colormodel);
int  cmodel_calculate_max(int colormodel);
//C     int cmodel_components(int colormodel);
int  cmodel_components(int colormodel);
//C     int cmodel_is_yuv(int colormodel);
int  cmodel_is_yuv(int colormodel);

//C     void cmodel_transfer(unsigned char **output_rows, /* Leave NULL if non existent */
//C     	unsigned char **input_rows,
//C     	int in_x,        /* Dimensions to capture from input frame */
//C     	int in_y, 
//C     	int in_w, 
//C     	int in_h,
//C     	int out_w, 
//C     	int out_h,
//C     	int in_colormodel, 
//C     	int out_colormodel,
//C     	int in_rowspan,       /* For planar use the luma rowspan */
//C             int out_rowspan,      /* For planar use the luma rowspan */
//C             int in_rowspan_uv,    /* Chroma rowspan */
//C             int out_rowspan_uv    /* Chroma rowspan */);     
void  cmodel_transfer(ubyte **output_rows, ubyte **input_rows, int in_x, int in_y, int in_w, int in_h, int out_w, int out_h, int in_colormodel, int out_colormodel, int in_rowspan, int out_rowspan, int in_rowspan_uv, int out_rowspan_uv);

//C     int cmodel_bc_to_x(int color_model);
int  cmodel_bc_to_x(int color_model);
// Tell when to use plane arguments or row pointer arguments to functions
//C     int cmodel_is_planar(int color_model);
int  cmodel_is_planar(int color_model);





//C     #ifdef __cplusplus
//C     }
//C     #endif

//C     #endif

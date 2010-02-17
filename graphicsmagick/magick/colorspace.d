/* Converted to D from ./magick/colorspace.h by htod */
module colorspace;

align(1):

/*
  Copyright (C) 2003 GraphicsMagick Group
  Copyright (C) 2002 ImageMagick Studio
  Copyright 1991-1999 E. I. du Pont de Nemours and Company
 
  This program is covered by multiple licenses, which are described in
  Copyright.txt. You should have received a copy of Copyright.txt with this
  package; otherwise see http://www.graphicsmagick.org/www/Copyright.html.
 
  GraphicsMagick Colorspace Methods. 
*/
//C     #ifndef _MAGICK_COLORSPACE_H
//C     #define _MAGICK_COLORSPACE_H
//C     #if defined(__cplusplus) || defined(c_plusplus)
//C     extern "C" {
//C     #endif


//C     #if (QuantumDepth == 8) || (QuantumDepth == 16)
  /*
    intensity=0.299*red+0.587*green+0.114*blue.
    Premultiply by 1024 to obtain integral values, and then divide
    result by 1024 by shifting to the right by 10 bits.
  */
//C     #define PixelIntensityRec601(pixel)   ((unsigned int)    (((unsigned int) (pixel)->red*306U+      (unsigned int) (pixel)->green*601U+      (unsigned int) (pixel)->blue*117U)     >> 10U))
//C     #elif (QuantumDepth == 32)
  /*
    intensity=0.299*red+0.587*green+0.114*blue.
  */
//C     #define PixelIntensityRec601(pixel)   ((unsigned int)    (((double)306.0*(pixel)->red+      (double)601.0*(pixel)->green+      (double)117.0*(pixel)->blue)     / 1024.0))
//C     #endif

  /*
    intensity=0.2126*red+0.7152*green+0.0722*blue
  */
//C     #define PixelIntensityRec709(pixel)   ((unsigned int)    (0.2126*(pixel)->red+     0.7152*(pixel)->green+     0.0722*(pixel)->blue))

//C     #define PixelIntensity(pixel) PixelIntensityRec601(pixel)
//C     #define PixelIntensityToDouble(pixel) ((double)PixelIntensity(pixel))
//C     #define PixelIntensityToQuantum(pixel) ((Quantum)PixelIntensity(pixel))
//C     #define IsCMYKColorspace(colorspace)   (     (colorspace == CMYKColorspace)   )
//C     #define IsGrayColorspace(colorspace)   (     (colorspace == GRAYColorspace) ||     (colorspace == Rec601LumaColorspace) ||     (colorspace == Rec709LumaColorspace)   )
//C     #define IsRGBColorspace(colorspace)   (     (IsGrayColorspace(colorspace)) ||     (colorspace == RGBColorspace) ||     (colorspace == TransparentColorspace)   )
//C     #define IsYCbCrColorspace(colorspace)   (     (colorspace == YCbCrColorspace) ||     (colorspace == Rec601YCbCrColorspace) ||     (colorspace == Rec709YCbCrColorspace)   )

//C     #define YCbCrColorspace Rec601YCbCrColorspace
//C     typedef enum
/////////Moved below enum: alias Rec601YCbCrColorspace YCbCrColorspace;
//C     {
//C       UndefinedColorspace,
//C       RGBColorspace,         /* Plain old RGB colorspace */
//C       GRAYColorspace,        /* Plain old full-range grayscale */
//C       TransparentColorspace, /* RGB but preserve matte channel during quantize */
//C       OHTAColorspace,
//C       XYZColorspace,         /* CIE XYZ */
//C       YCCColorspace,         /* Kodak PhotoCD PhotoYCC */
//C       YIQColorspace,
//C       YPbPrColorspace,
//C       YUVColorspace,
//C       CMYKColorspace,        /* Cyan, magenta, yellow, black, alpha */
//C       sRGBColorspace,        /* Kodak PhotoCD sRGB */
//C       HSLColorspace,         /* Hue, saturation, luminosity */
//C       HWBColorspace,         /* Hue, whiteness, blackness */
//C       LABColorspace,         /* LAB colorspace not supported yet other than via lcms */
//C       CineonLogRGBColorspace,/* RGB data with Cineon Log scaling, 2.048 density range */
//C       Rec601LumaColorspace,  /* Luma (Y) according to ITU-R 601 */
//C       Rec601YCbCrColorspace, /* YCbCr according to ITU-R 601 */
//C       Rec709LumaColorspace,  /* Luma (Y) according to ITU-R 709 */
//C       Rec709YCbCrColorspace  /* YCbCr according to ITU-R 709 */
//C     } ColorspaceType;
enum
{
    UndefinedColorspace,
    RGBColorspace,
    GRAYColorspace,
    TransparentColorspace,
    OHTAColorspace,
    XYZColorspace,
    YCCColorspace,
    YIQColorspace,
    YPbPrColorspace,
    YUVColorspace,
    CMYKColorspace,
    sRGBColorspace,
    HSLColorspace,
    HWBColorspace,
    LABColorspace,
    CineonLogRGBColorspace,
    Rec601LumaColorspace,
    Rec601YCbCrColorspace,
    Rec709LumaColorspace,
    Rec709YCbCrColorspace,
}

alias Rec601YCbCrColorspace YCbCrColorspace;

extern (C):
alias int ColorspaceType;

//extern unsigned int
//  RGBTransformImage(ImagePtr,const ColorspaceType),
//  TransformColorspace(ImagePtr,const ColorspaceType),
//  TransformRGBImage(ImagePtr,const ColorspaceType);

//C     #if defined(__cplusplus) || defined(c_plusplus)
//C     }
//C     #endif

//C     #endif /* _MAGICK_COLORSPACE_H */

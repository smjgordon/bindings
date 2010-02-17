/* Converted to D from ./magick/image.h by htod */
module magick.image;

import tango.stdc.stdio;

/*
  Copyright (C) 2003 - 2008 GraphicsMagick Group
  Copyright (C) 2002 ImageMagick Studio
  Copyright 1991-1999 E. I. du Pont de Nemours and Company
 
  This program is covered by multiple licenses, which are described in
  Copyright.txt. You should have received a copy of Copyright.txt with this
  package; otherwise see http://www.graphicsmagick.org/www/Copyright.html.
 
  GraphicsMagick Image Methods.
*/
//C     #ifndef _MAGICK_IMAGE_H
//C     #define _MAGICK_IMAGE_H

//C     #if defined(__cplusplus) || defined(c_plusplus)
//C     extern "C" {
//C     #endif

/*
  Include declarations.
*/
//C     #include "magick/forward.h"
////////////////JONAS import magick.forward;
//C     #include "magick/colorspace.h"
import magick.colorspace;
//C     #include "magick/error.h"
import magick.error;
//C     #include "magick/timer.h"
import magick.timer;
public import magick.globals;


align(1):

/*
  Define declarations.
*/
//C     #if !defined(QuantumDepth)
//C     #  define QuantumDepth  16
//C     #endif
const QuantumDepth = 16;

/*
  Maximum unsigned RGB value which fits in the specified bits
*/
//C     #define MaxValueGivenBits(bits) ((unsigned long) (0x01UL << (bits-1)) +((0x01UL << (bits-1))-1))

//C     #if (QuantumDepth == 8)
//C     #  define MaxColormapSize  256U
//C     #  define MaxMap  255U
//C     #  define MaxMapFloat 255.0f
//C     #  define MaxMapDouble 255.0
//C     #  define MaxRGB  255U
//C     #  define MaxRGBFloat 255.0f
//C     #  define MaxRGBDouble 255.0
//C     #  define ScaleCharToMap(value)        ((unsigned char) (value))
//C     #  define ScaleCharToQuantum(value)    ((Quantum) (value))
//C     #  define ScaleLongToQuantum(value)    ((Quantum) ((value)/16843009UL))
//C     #  define ScaleMapToChar(value)        ((unsigned int) (value))
//C     #  define ScaleMapToQuantum(value)     ((Quantum) (value))
//C     #  define ScaleQuantum(quantum)        ((unsigned long) (quantum))
//C     #  define ScaleQuantumToChar(quantum)  ((unsigned char) (quantum))
//C     #  define ScaleQuantumToLong(quantum)  ((unsigned long) (16843009UL*(quantum)))
//C     #  define ScaleQuantumToMap(quantum)   ((unsigned char) (quantum))
//C     #  define ScaleQuantumToShort(quantum) ((unsigned short) (257U*(quantum)))
//C     #  define ScaleShortToQuantum(value)   ((Quantum) ((value)/257U))
//C     #  define ScaleToQuantum(value)        ((unsigned long) (value))
//C     #  define ScaleQuantumToIndex(value)   ((unsigned char) (value))
//C        typedef unsigned char Quantum;
//C     #elif (QuantumDepth == 16)
//C     #  define MaxColormapSize  65536U
//C     #  define MaxMap 65535U
const MaxColormapSize = 65536U;
//C     #  define MaxMapFloat 65535.0f
const MaxMap = 65535U;
//C     #  define MaxMapDouble 65535.0
const MaxMapFloat = 65535.0f;
//C     #  define MaxRGB  65535U
const MaxMapDouble = 65535.0;
//C     #  define MaxRGBFloat 65535.0f
const MaxRGB = 65535U;
//C     #  define MaxRGBDouble 65535.0
const MaxRGBFloat = 65535.0f;
//C     #  define ScaleCharToMap(value)        ((unsigned short) (257U*(value)))
const MaxRGBDouble = 65535.0;
//C     #  define ScaleCharToQuantum(value)    ((Quantum) (257U*(value)))
//C     #  define ScaleLongToQuantum(value)    ((Quantum) ((value)/65537UL))
//C     #  define ScaleMapToChar(value)        ((unsigned int) ((value)/257U))
//C     #  define ScaleMapToQuantum(value)     ((Quantum) (value))
//C     #  define ScaleQuantum(quantum)        ((unsigned long) ((quantum)/257UL))
//C     #  define ScaleQuantumToChar(quantum)  ((unsigned char) ((quantum)/257U))
//C     #  define ScaleQuantumToLong(quantum)  ((unsigned long) (65537UL*(quantum)))
//C     #  define ScaleQuantumToMap(quantum)   ((unsigned short) (quantum))
//C     #  define ScaleQuantumToShort(quantum) ((unsigned short) (quantum))
//C     #  define ScaleShortToQuantum(value)   ((Quantum) (value))
//C     #  define ScaleToQuantum(value)        ((unsigned long) (257UL*(value)))
//C     #  define ScaleQuantumToIndex(value)   ((unsigned short) (value))
//C        typedef unsigned short Quantum;
extern (C):
alias ubyte Quantum;
//C     #elif (QuantumDepth == 32)
//C     #  define MaxColormapSize  65536U
//C     #  define MaxRGB  4294967295U
//C     #  define MaxRGBFloat 4294967295.0f
//C     #  define MaxRGBDouble 4294967295.0
//C     #  define ScaleCharToQuantum(value)    ((Quantum) (16843009U*(value)))
//C     #  define ScaleLongToQuantum(value)    ((Quantum) ((value)))
//C     #  define ScaleQuantum(quantum)        ((unsigned long) ((quantum)/16843009UL))
//C     #  define ScaleQuantumToChar(quantum)  ((unsigned char) ((quantum)/16843009U))
//C     #  define ScaleQuantumToLong(quantum)  ((unsigned long) (quantum))
//C     #  define ScaleQuantumToShort(quantum) ((unsigned short) ((quantum)/65537U))
//C     #  define ScaleShortToQuantum(value)   ((Quantum) (65537U*(value)))
//C     #  define ScaleToQuantum(value)        ((unsigned long) (16843009UL*(value)))
//C     #  define ScaleQuantumToIndex(value)   ((unsigned short) ((value)/65537U))

/*
  MaxMap defines the maximum index value for algorithms which depend
  on lookup tables (e.g. colorspace transformations and
  normalization). When MaxMap is less than MaxRGB it is necessary to
  downscale samples to fit the range of MaxMap. The number of bits
  which are effectively preserved depends on the size of MaxMap.
  MaxMap should be a multiple of 255 and no larger than MaxRGB.  Note
  that tables can become quite large and as the tables grow larger it
  may take more time to compute the table than to process the image.
*/
//C     #define MaxMap 65535U
//C     #define MaxMapFloat 65535.0f
//C     #define MaxMapDouble 65535.0
//C     #if MaxMap == 65535U
//C     #  define ScaleCharToMap(value)        ((unsigned short) (257U*(value)))
//C     #  define ScaleMapToChar(value)        ((unsigned int) ((value)/257U))
//C     #  define ScaleMapToQuantum(value)     ((Quantum) (65537U*(value)))
//C     #  define ScaleQuantumToMap(quantum)   ((unsigned short) ((quantum)/65537U))
//C     #else
//C     #  define ScaleCharToMap(value)        ((unsigned short) ((MaxMap/255U)*(value)))
//C     #  define ScaleMapToChar(value)        ((unsigned int) ((value)/(MaxMap/255U)))
//C     #  define ScaleMapToQuantum(value)     ((Quantum) ((MaxRGB/MaxMap)*(value)))
//C     #  define ScaleQuantumToMap(quantum)   ((unsigned short) ((quantum)/(MaxRGB/MaxMap)))
//C     #endif
//C     typedef unsigned int Quantum;
//C     #else
//C     #  ifndef _CH_
//C     #    error "Specified value of QuantumDepth is not supported"
//C     #  endif
//C     #endif

//C     #define OpaqueOpacity  0UL
//C     #define TransparentOpacity  MaxRGB
const OpaqueOpacity = 0U;
//C     #define RoundDoubleToQuantum(value) ((Quantum) (value < 0.0 ? 0U :   (value > MaxRGBDouble) ? MaxRGB : value + 0.5))
alias MaxRGB TransparentOpacity;
//C     #define RoundFloatToQuantum(value) ((Quantum) (value < 0.0f ? 0U :   (value > MaxRGBFloat) ? MaxRGB : value + 0.5f))
//C     #define ConstrainToRange(min,max,value) (value < min ? min :   (value > max) ? max : value)
//C     #define ConstrainToQuantum(value) ConstrainToRange(0,MaxRGB,value)
//C     #define ScaleAnyToQuantum(x,max_value)   ((Quantum) (((double) MaxRGBDouble*x)/max_value+0.5))
//C     #define unsigned intToString(value) (value != MagickFalse ? "True" : "False")

/*
  Return MagickTrue if channel is enabled in channels.  Allows using
  code to adapt if ChannelType enumeration is changed to bit masks.
*/
//C     #define MagickChannelEnabled(channels,channel) ((channels == AllChannels) || (channels == channel))

/*
  Deprecated defines.
*/
//C     #define RunlengthEncodedCompression RLECompression
//C     #define RoundSignedToQuantum(value) RoundDoubleToQuantum(value)
/////////Moved lower: alias RLECompression RunlengthEncodedCompression;
//C     #define RoundToQuantum(value) RoundDoubleToQuantum(value)

/*
  Enum declarations.
*/
//C     typedef enum
//C     {
//C       UnspecifiedAlpha,
//C       AssociatedAlpha,
//C       UnassociatedAlpha
//C     } AlphaType;
enum
{
    UnspecifiedAlpha,
    AssociatedAlpha,
    UnassociatedAlpha,
}
alias int AlphaType;

//C     typedef enum
//C     {
//C       UndefinedChannel,
//C       RedChannel,     /* RGB Red channel */
//C       CyanChannel,    /* CMYK Cyan channel */
//C       GreenChannel,   /* RGB Green channel */
//C       MagentaChannel, /* CMYK Magenta channel */
//C       BlueChannel,    /* RGB Blue channel */
//C       YellowChannel,  /* CMYK Yellow channel */
//C       OpacityChannel, /* Opacity channel */
//C       BlackChannel,   /* CMYK Black (K) channel */
//C       MatteChannel,   /* Same as Opacity channel (deprecated) */
//C       AllChannels,    /* Color channels */
//C       GrayChannel     /* Color channels represent an intensity. */
//C     } ChannelType;
enum
{
    UndefinedChannel,
    RedChannel,
    CyanChannel,
    GreenChannel,
    MagentaChannel,
    BlueChannel,
    YellowChannel,
    OpacityChannel,
    BlackChannel,
    MatteChannel,
    AllChannels,
    GrayChannel,
}
alias int ChannelType;

//C     typedef enum
//C     {
//C       UndefinedClass,
//C       DirectClass,
//C       PseudoClass
//C     } ClassType;
enum
{
    UndefinedClass,
    DirectClass,
    PseudoClass,
}
alias int ClassType;

//C     typedef enum
//C     {
//C       UndefinedCompliance = 0x0000,
//C       NoCompliance = 0x0000,
//C       SVGCompliance = 0x0001,
//C       X11Compliance = 0x0002,
//C       XPMCompliance = 0x0004,
//C       AllCompliance = 0xffff
//C     } ComplianceType;
enum
{
    UndefinedCompliance,
    NoCompliance = 0,
    SVGCompliance,
    X11Compliance,
    XPMCompliance = 4,
    AllCompliance = 65535,
}
alias int ComplianceType;

//C     typedef enum
//C     {
//C       UndefinedCompositeOp = 0,
//C       OverCompositeOp,
//C       InCompositeOp,
//C       OutCompositeOp,
//C       AtopCompositeOp,
//C       XorCompositeOp,
//C       PlusCompositeOp,
//C       MinusCompositeOp,
//C       AddCompositeOp,
//C       SubtractCompositeOp,
//C       DifferenceCompositeOp,
//C       MultiplyCompositeOp,
//C       BumpmapCompositeOp,
//C       CopyCompositeOp,
//C       CopyRedCompositeOp,
//C       CopyGreenCompositeOp,
//C       CopyBlueCompositeOp,
//C       CopyOpacityCompositeOp,
//C       ClearCompositeOp,
//C       DissolveCompositeOp,
//C       DisplaceCompositeOp,
//C       ModulateCompositeOp,
//C       ThresholdCompositeOp,
//C       NoCompositeOp,
//C       DarkenCompositeOp,
//C       LightenCompositeOp,
//C       HueCompositeOp,
//C       SaturateCompositeOp,
//C       ColorizeCompositeOp,
//C       LuminizeCompositeOp,
//C       ScreenCompositeOp, /* Not yet implemented */
//C       OverlayCompositeOp,  /* Not yet implemented */
//C       CopyCyanCompositeOp,
//C       CopyMagentaCompositeOp,
//C       CopyYellowCompositeOp,
//C       CopyBlackCompositeOp,
//C       DivideCompositeOp
//C     } CompositeOperator;
enum
{
    UndefinedCompositeOp,
    OverCompositeOp,
    InCompositeOp,
    OutCompositeOp,
    AtopCompositeOp,
    XorCompositeOp,
    PlusCompositeOp,
    MinusCompositeOp,
    AddCompositeOp,
    SubtractCompositeOp,
    DifferenceCompositeOp,
    MultiplyCompositeOp,
    BumpmapCompositeOp,
    CopyCompositeOp,
    CopyRedCompositeOp,
    CopyGreenCompositeOp,
    CopyBlueCompositeOp,
    CopyOpacityCompositeOp,
    ClearCompositeOp,
    DissolveCompositeOp,
    DisplaceCompositeOp,
    ModulateCompositeOp,
    ThresholdCompositeOp,
    NoCompositeOp,
    DarkenCompositeOp,
    LightenCompositeOp,
    HueCompositeOp,
    SaturateCompositeOp,
    ColorizeCompositeOp,
    LuminizeCompositeOp,
    ScreenCompositeOp,
    OverlayCompositeOp,
    CopyCyanCompositeOp,
    CopyMagentaCompositeOp,
    CopyYellowCompositeOp,
    CopyBlackCompositeOp,
    DivideCompositeOp,
}
alias int CompositeOperator;

//C     typedef enum
//C     {
//C       UndefinedCompression,
//C       NoCompression,
//C       BZipCompression,
//C       FaxCompression,
//C       Group4Compression,
//C       JPEGCompression,
//C       LosslessJPEGCompression,
//C       LZWCompression,
//C       RLECompression,
//C       ZipCompression
//C     } CompressionType;
enum
{
    UndefinedCompression,
    NoCompression,
    BZipCompression,
    FaxCompression,
    Group4Compression,
    JPEGCompression,
    LosslessJPEGCompression,
    LZWCompression,
    RLECompression,
    ZipCompression,
}
alias int CompressionType;

alias RLECompression RunlengthEncodedCompression;

//C     typedef enum
//C     {
//C       UndefinedDispose,
//C       NoneDispose,
//C       BackgroundDispose,
//C       PreviousDispose
//C     } DisposeType;
enum
{
    UndefinedDispose,
    NoneDispose,
    BackgroundDispose,
    PreviousDispose,
}
alias int DisposeType;

//C     typedef enum
//C     {
//C       UndefinedEndian,
//C       LSBEndian,            /* "little" endian */
//C       MSBEndian,            /* "big" endian */
//C       NativeEndian          /* native endian */
//C     } EndianType;
enum
{
    UndefinedEndian,
    LSBEndian,
    MSBEndian,
    NativeEndian,
}
alias int EndianType;

//C     typedef enum
//C     {
//C       UndefinedFilter,
//C       PointFilter,
//C       BoxFilter,
//C       TriangleFilter,
//C       HermiteFilter,
//C       HanningFilter,
//C       HammingFilter,
//C       BlackmanFilter,
//C       GaussianFilter,
//C       QuadraticFilter,
//C       CubicFilter,
//C       CatromFilter,
//C       MitchellFilter,
//C       LanczosFilter,
//C       BesselFilter,
//C       SincFilter
//C     } FilterTypes;
enum
{
    UndefinedFilter,
    PointFilter,
    BoxFilter,
    TriangleFilter,
    HermiteFilter,
    HanningFilter,
    HammingFilter,
    BlackmanFilter,
    GaussianFilter,
    QuadraticFilter,
    CubicFilter,
    CatromFilter,
    MitchellFilter,
    LanczosFilter,
    BesselFilter,
    SincFilter,
}
alias int FilterTypes;

//C     typedef enum
//C     {
//C     #undef NoValue
//C       NoValue = 0x0000,
//C     #undef XValue
//C       XValue = 0x0001,
//C     #undef YValue
//C       YValue = 0x0002,
//C     #undef WidthValue
//C       WidthValue = 0x0004,
//C     #undef HeightValue
//C       HeightValue = 0x0008,
//C     #undef AllValues
//C       AllValues = 0x000F,
//C     #undef XNegative
//C       XNegative = 0x0010,
//C     #undef YNegative
//C       YNegative = 0x0020,
//C       PercentValue = 0x1000,
//C       AspectValue = 0x2000,
//C       LessValue = 0x4000,
//C       GreaterValue = 0x8000,
//C       AreaValue = 0x10000
//C     } GeometryFlags;
enum
{
    NoValue,
    XValue,
    YValue,
    WidthValue = 4,
    HeightValue = 8,
    AllValues = 15,
    XNegative,
    YNegative = 32,
    PercentValue = 4096,
    AspectValue = 8192,
    LessValue = 16384,
    GreaterValue = 32768,
    AreaValue = 65536,
}
alias int GeometryFlags;

//C     typedef enum
//C     {
//C     #undef ForgetGravity
//C       ForgetGravity,
//C     #undef NorthWestGravity
//C       NorthWestGravity,
//C     #undef NorthGravity
//C       NorthGravity,
//C     #undef NorthEastGravity
//C       NorthEastGravity,
//C     #undef WestGravity
//C       WestGravity,
//C     #undef CenterGravity
//C       CenterGravity,
//C     #undef EastGravity
//C       EastGravity,
//C     #undef SouthWestGravity
//C       SouthWestGravity,
//C     #undef SouthGravity
//C       SouthGravity,
//C     #undef SouthEastGravity
//C       SouthEastGravity,
//C     #undef StaticGravity
//C       StaticGravity
//C     } GravityType;
enum
{
    ForgetGravity,
    NorthWestGravity,
    NorthGravity,
    NorthEastGravity,
    WestGravity,
    CenterGravity,
    EastGravity,
    SouthWestGravity,
    SouthGravity,
    SouthEastGravity,
    StaticGravity,
}
alias int GravityType;

//C     typedef enum
//C     {
//C       UndefinedType,
//C       BilevelType,
//C       GrayscaleType,
//C       GrayscaleMatteType,
//C       PaletteType,
//C       PaletteMatteType,
//C       TrueColorType,
//C       TrueColorMatteType,
//C       ColorSeparationType,
//C       ColorSeparationMatteType,
//C       OptimizeType
//C     } ImageType;
enum
{
    UndefinedType,
    BilevelType,
    GrayscaleType,
    GrayscaleMatteType,
    PaletteType,
    PaletteMatteType,
    TrueColorType,
    TrueColorMatteType,
    ColorSeparationType,
    ColorSeparationMatteType,
    OptimizeType,
}
alias int ImageType;

//C     typedef enum
//C     {
//C       UndefinedInterlace,
//C       NoInterlace,
//C       LineInterlace,
//C       PlaneInterlace,
//C       PartitionInterlace
//C     } InterlaceType;
enum
{
    UndefinedInterlace,
    NoInterlace,
    LineInterlace,
    PlaneInterlace,
    PartitionInterlace,
}
alias int InterlaceType;

//C     typedef enum
//C     {
//C       UndefinedMode,
//C       FrameMode,
//C       UnframeMode,
//C       ConcatenateMode
//C     } MontageMode;
enum
{
    UndefinedMode,
    FrameMode,
    UnframeMode,
    ConcatenateMode,
}
alias int MontageMode;

//C     typedef enum
//C     {
//C       UniformNoise,
//C       GaussianNoise,
//C       MultiplicativeGaussianNoise,
//C       ImpulseNoise,
//C       LaplacianNoise,
//C       PoissonNoise
//C     } NoiseType;
enum
{
    UniformNoise,
    GaussianNoise,
    MultiplicativeGaussianNoise,
    ImpulseNoise,
    LaplacianNoise,
    PoissonNoise,
}
alias int NoiseType;

/*
  Image orientation.  Based on TIFF standard values.
*/
//C     typedef enum               /* Line direction / Frame Direction */
//C     {                          /* -------------- / --------------- */
//C       UndefinedOrientation,    /* Unknown        / Unknown         */
//C       TopLeftOrientation,      /* Left to right  / Top to bottom   */
//C       TopRightOrientation,     /* Right to left  / Top to bottom   */
//C       BottomRightOrientation,  /* Right to left  / Bottom to top   */
//C       BottomLeftOrientation,   /* Left to right  / Bottom to top   */
//C       LeftTopOrientation,      /* Top to bottom  / Left to right   */
//C       RightTopOrientation,     /* Top to bottom  / Right to left   */
//C       RightBottomOrientation,  /* Bottom to top  / Right to left   */
//C       LeftBottomOrientation    /* Bottom to top  / Left to right   */
//C     } OrientationType;
enum
{
    UndefinedOrientation,
    TopLeftOrientation,
    TopRightOrientation,
    BottomRightOrientation,
    BottomLeftOrientation,
    LeftTopOrientation,
    RightTopOrientation,
    RightBottomOrientation,
    LeftBottomOrientation,
}
alias int OrientationType;

//C     typedef enum
//C     {
//C       UndefinedPreview = 0,
//C       RotatePreview,
//C       ShearPreview,
//C       RollPreview,
//C       HuePreview,
//C       SaturationPreview,
//C       BrightnessPreview,
//C       GammaPreview,
//C       SpiffPreview,
//C       DullPreview,
//C       GrayscalePreview,
//C       QuantizePreview,
//C       DespecklePreview,
//C       ReduceNoisePreview,
//C       AddNoisePreview,
//C       SharpenPreview,
//C       BlurPreview,
//C       ThresholdPreview,
//C       EdgeDetectPreview,
//C       SpreadPreview,
//C       SolarizePreview,
//C       ShadePreview,
//C       RaisePreview,
//C       SegmentPreview,
//C       SwirlPreview,
//C       ImplodePreview,
//C       WavePreview,
//C       OilPaintPreview,
//C       CharcoalDrawingPreview,
//C       JPEGPreview
//C     } PreviewType;
enum
{
    UndefinedPreview,
    RotatePreview,
    ShearPreview,
    RollPreview,
    HuePreview,
    SaturationPreview,
    BrightnessPreview,
    GammaPreview,
    SpiffPreview,
    DullPreview,
    GrayscalePreview,
    QuantizePreview,
    DespecklePreview,
    ReduceNoisePreview,
    AddNoisePreview,
    SharpenPreview,
    BlurPreview,
    ThresholdPreview,
    EdgeDetectPreview,
    SpreadPreview,
    SolarizePreview,
    ShadePreview,
    RaisePreview,
    SegmentPreview,
    SwirlPreview,
    ImplodePreview,
    WavePreview,
    OilPaintPreview,
    CharcoalDrawingPreview,
    JPEGPreview,
}
alias int PreviewType;

//C     typedef enum
//C     {
//C       UndefinedIntent,
//C       SaturationIntent,
//C       PerceptualIntent,
//C       AbsoluteIntent,
//C       RelativeIntent
//C     } RenderingIntent;
enum
{
    UndefinedIntent,
    SaturationIntent,
    PerceptualIntent,
    AbsoluteIntent,
    RelativeIntent,
}
alias int RenderingIntent;

//C     typedef enum
//C     {
//C       UndefinedResolution,
//C       PixelsPerInchResolution,
//C       PixelsPerCentimeterResolution
//C     } ResolutionType;
enum
{
    UndefinedResolution,
    PixelsPerInchResolution,
    PixelsPerCentimeterResolution,
}
alias int ResolutionType;

/*
  Typedef declarations.
*/
//C     typedef struct _AffineMatrix
//C     {
//C       double
//C         sx,
//C         rx,
//C         ry,
//C         sy,
//C         tx,
//C         ty;
//C     } AffineMatrix;
struct _AffineMatrix
{
    double sx;
    double rx;
    double ry;
    double sy;
    double tx;
    double ty;
}
alias _AffineMatrix AffineMatrix;

//C     typedef struct _PrimaryInfo
//C     {
//C       double
//C         x,
//C         y,
//C         z;
//C     } PrimaryInfo;
struct _PrimaryInfo
{
    double x;
    double y;
    double z;
}
alias _PrimaryInfo PrimaryInfo;

//C     typedef struct _ChromaticityInfo
//C     {
//C       PrimaryInfo
//C         red_primary,
//C         green_primary,
//C         blue_primary,
//C         white_point;
//C     } ChromaticityInfo;
struct _ChromaticityInfo
{
    PrimaryInfo red_primary;
    PrimaryInfo green_primary;
    PrimaryInfo blue_primary;
    PrimaryInfo white_point;
}
alias _ChromaticityInfo ChromaticityInfo;

//C     #if defined(MAGICK_IMPLEMENTATION)
/*
  Useful macros for accessing PixelPacket members in a generic way.
*/
//C     # define GetRedSample(p) ((p)->red)
//C     # define GetGreenSample(p) ((p)->green)
//C     # define GetBlueSample(p) ((p)->blue)
//C     # define GetOpacitySample(p) ((p)->opacity)

//C     # define SetRedSample(q,value) ((q)->red=(value))
//C     # define SetGreenSample(q,value) ((q)->green=(value))
//C     # define SetBlueSample(q,value) ((q)->blue=(value))
//C     # define SetOpacitySample(q,value) ((q)->opacity=(value))

//C     # define GetGraySample(p) ((p)->red)
//C     # define SetGraySample(q,value) ((q)->red=(q)->green=(q)->blue=(value))

//C     # define GetYSample(p) ((p)->red)
//C     # define GetCbSample(p) ((p)->green)
//C     # define GetCrSample(p) ((p)->blue)

//C     # define SetYSample(q,value) ((q)->red=(value))
//C     # define SetCbSample(q,value) ((q)->green=(value))
//C     # define SetCrSample(q,value) ((q)->blue=(value))

//C     # define GetCyanSample(p) ((p)->red)
//C     # define GetMagentaSample(p) ((p)->green)
//C     # define GetYellowSample(p) ((p)->blue)
//C     # define GetBlackSample(p) ((p)->opacity)

//C     # define SetCyanSample(q,value) ((q)->red=(value))
//C     # define SetMagentaSample(q,value) ((q)->green=(value))
//C     # define SetYellowSample(q,value) ((q)->blue=(value))
//C     # define SetBlackSample(q,value) ((q)->opacity=(value))

//C     #endif /* defined(MAGICK_IMPLEMENTATION) */

//C     typedef struct _PixelPacket
//C     {
//C     #if defined(WORDS_BIGENDIAN)
  /* RGBA */
//C     #define MAGICK_PIXELS_RGBA 1
//C       Quantum
//C         red,
//C         green,
//C         blue,
//C         opacity;
//C     #else
  /* BGRA (as used by Microsoft Windows DIB) */
//C     #define MAGICK_PIXELS_BGRA 1
//C       Quantum
const MAGICK_PIXELS_BGRA = 1;
//C         blue,
//C         green,
//C         red,
//C         opacity;
//C     #endif
//C     } PixelPacket;
struct _PixelPacket
{
    Quantum blue;
    Quantum green;
    Quantum red;
    Quantum opacity;
}
alias _PixelPacket PixelPacket;

/*
typedef struct _ColorInfo
{
  char *path;
  char *name;

  ComplianceType compliance;

  PixelPacket color;

  unsigned int stealth;

  unsigned long signature;//unsigned long in C

  struct _ColorInfo* previous;
  struct _ColorInfo* next;
} ColorInfo;
*/

//C     typedef struct _DoublePixelPacket
//C     {
//C       double
//C         red,
//C         green,
//C         blue,
//C         opacity;
//C     } DoublePixelPacket;
struct _DoublePixelPacket
{
    double red;
    double green;
    double blue;
    double opacity;
}
alias _DoublePixelPacket DoublePixelPacket;

/*
  ErrorInfo is used to record statistical difference (error)
  information based on computed Euclidean distance in RGB space.
*/
//C     typedef struct _ErrorInfo
//C     {
//C       double
//C         mean_error_per_pixel,     /* Average error per pixel (absolute range) */
//C         normalized_mean_error,    /* Average error per pixel (normalized to 1.0) */
//C         normalized_maximum_error; /* Maximum error encountered (normalized to 1.0) */
//C     } ErrorInfo;
struct _ErrorInfo
{
    double mean_error_per_pixel;
    double normalized_mean_error;
    double normalized_maximum_error;
}
alias _ErrorInfo ErrorInfo;
/*
typedef struct _FrameInfo
{
  unsigned long width;
  unsigned long height;

  long
    x,
    y,
    inner_bevel,
    outer_bevel;
} FrameInfo;
*/
//C     typedef Quantum IndexPacket;
alias Quantum IndexPacket;
/*
typedef struct _LongPixelPacket
{
  unsigned long
    red,
    green,
    blue,
    opacity;
} LongPixelPacket;
*/

/*
typedef struct _MontageInfo
{
  char
    *geometry,
    *tile,
    *title,
    *frame,
    *texture,
    *font;

  double
    pointsize;

  unsigned long
    border_width;

  unsigned int
    shadow;

  PixelPacket
    fill,
    stroke,
    background_color,
    border_color,
    matte_color;

  GravityType
    gravity;

  char
    filename[MaxTextExtent];

  unsigned long
    signature;
} MontageInfo;
*/

 
//C     typedef struct _ProfileInfo
//C     {
//C       size_t
//C         length;

//C       char
//C         *name;

//C       unsigned char
//C         *info;
//C     } ProfileInfo;
struct _ProfileInfo
{
    size_t length;//maybe int?
    char* name;
    ubyte* info;//maybe char*?
}
alias _ProfileInfo ProfileInfo;

//C     typedef struct _RectangleInfo
//C     {
//C       unsigned long
//C         width,
//C         height;

//C       long
//C         x,
//C         y;
//C     } RectangleInfo;
struct _RectangleInfo
{
    uint width;
		uint height;
    int x;
    int y;
}
alias _RectangleInfo RectangleInfo;

//C     typedef struct _SegmentInfo
//C     {
//C       double
//C         x1,
//C         y1,
//C         x2,
//C         y2;
//C     } SegmentInfo;
struct _SegmentInfo
{
    double x1;
    double y1;
    double x2;
    double y2;
}
alias _SegmentInfo SegmentInfo;

//C     typedef struct _ImageChannelStatistics
//C      {
   /* Minimum value observed */
//C        double maximum;
   /* Maximum value observed */
//C        double minimum;
   /* Average (mean) value observed */
//C        double mean;
   /* Standard deviation, sqrt(variance) */
//C        double standard_deviation;
   /* Variance */
//C        double variance;
//C      } ImageChannelStatistics;
struct _ImageChannelStatistics
{
    double maximum;
    double minimum;
    double mean;
    double standard_deviation;
    double variance;
}
alias _ImageChannelStatistics ImageChannelStatistics;

//C     typedef struct _ImageStatistics
//C      {
//C        ImageChannelStatistics red;
//C        ImageChannelStatistics green;
//C        ImageChannelStatistics blue;
//C        ImageChannelStatistics opacity;
//C      } ImageStatistics;
struct _ImageStatistics
{
    ImageChannelStatistics red;
    ImageChannelStatistics green;
    ImageChannelStatistics blue;
    ImageChannelStatistics opacity;
}
alias _ImageStatistics ImageStatistics;

//C     typedef struct _ImageCharacteristics
//C     {
//C       unsigned int
//C         cmyk,               /* CMYK(A) image */
//C         grayscale,          /* Grayscale image */
//C         monochrome,         /* Black/white image */
//C         opaque,             /* Opaque image */
//C         palette;            /* Colormapped image */
//C     } ImageCharacteristics;
struct _ImageCharacteristics
{
    uint cmyk;
		uint grayscale;
		uint monochrome;
		uint opaque;
		uint palette;
}
alias _ImageCharacteristics ImageCharacteristics;

//C     typedef struct _Image
//C     {
//C       ClassType
//C         storage_class;      /* DirectClass (TrueColor) or PseudoClass (colormapped) */

//C       ColorspaceType
//C         colorspace;         /* Current image colorspace/model */

//C       CompressionType
//C         compression;        /* Compression algorithm to use when encoding image */

//C       unsigned int

struct _Image
{
  ClassType storage_class;      /* DirectClass (TrueColor) or PseudoClass (colormapped) */

  ColorspaceType colorspace;         /* Current image colorspace/model */

  CompressionType compression;        /* Compression algorithm to use when encoding image */

	//MagickBool or unsigned int
	//bool 
	uint dither;             /* True if image is to be dithered */
	//bool
	uint matte;              /* True if image has an opacity (alpha) channel */ 

  //unsigned long
	uint columns;            /* Number of image columns */
	uint rows;               /* Number of image rows */

  //unsigned int
	uint colors;             /* Current number of colors in PseudoClass colormap */
	uint depth;              /* Bits of precision to preserve in color quantum */

  PixelPacket* colormap;          /* Pseudoclass colormap array */

  PixelPacket background_color;   /* Background color */
  PixelPacket border_color;       /* Border color */
  PixelPacket matte_color;        /* Matte (transparent) color */

  double gamma;              /* Image gamma (e.g. 0.45) */

  ChromaticityInfo chromaticity;       /* Red, green, blue, and white chromaticity values */

  OrientationType orientation;        /* Image orientation */

  RenderingIntent rendering_intent;   /* Rendering intent */

  ResolutionType units;              /* Units of image resolution (density) */

  char* montage;           /* Tile size and offset within an image montage */
  char* directory;         /* Tile names from within an image montage */
  char* geometry;          /* Composite/Crop options */

  //long
	int offset;             /* Offset to start of image data */

  double x_resolution;       /* Horizontal resolution (also see units) */
	double y_resolution;       /* Vertical resolution (also see units) */

  RectangleInfo page;               /* Offset to apply when placing image */
	RectangleInfo tile_info;          /* Subregion tile dimensions and offset */

  double blur;               /* Amount of blur to apply when zooming image */
	double fuzz;               /* Colors within this distance match target color */

  FilterTypes filter;             /* Filter to use when zooming image */

  InterlaceType interlace;          /* Interlace pattern to use when writing image */

  EndianType endian;             /* Byte order to use when writing image */

  GravityType gravity;            /* Image placement gravity */

  CompositeOperator compose;            /* Image placement composition */

  DisposeType dispose;            /* GIF disposal option */

  //unsigned long
	uint scene;              /* Animation frame scene number */
	uint delay;              /* Animation frame scene delay */
	uint iterations;         /* Animation iterations */
	uint total_colors;       /* Number of unique colors. See GetNumberColors() */

  //long
	int start_loop;         /* Animation frame number to start looping at */

  ErrorInfo error;              /* Computed image comparison or quantization error */

  TimerInfo timer;              /* Operation micro-timer */

  void* client_data;       /* User specified opaque data pointer */

	/*
	uint AARGH01;
	uint AARGH02;
	uint AARGH03;
	uint AARGH04;
	*/

	/*
    Output file name.

    A colon delimited format identifier may be prepended to the file
    name in order to force a particular output format. Otherwise the
    file extension is used. If no format prefix or file extension is
    present, then the output format is determined by the 'magick'
    field.
  */
  char[MaxTextExtent] filename;

  /*
    Original file name (name of input image file)
  */
  char[MaxTextExtent] magick_filename;

  /*
    File format of the input file, and the default output format.

    The precedence when selecting the output format is:
      1) magick prefix to file name (e.g. "jpeg:foo).
      2) file name extension. (e.g. "foo.jpg")
      3) content of this magick field.

  */
  char[MaxTextExtent] magick;

  /*
    Original image width (before transformations)
  */
  //unsigned long
	uint magick_columns;

  /*
    Original image height (before transformations)
  */
  //unsigned long
	uint magick_rows;

  ExceptionInfo exception;          /* Any error associated with this image frame */

  _Image* previous;          /* Pointer to previous frame */
	_Image* next;              /* Pointer to next frame */

  /*
    Only private members appear past this point
  */

                    /* Private, Embedded profiles */
	void* profiles;

  //unsigned int
	uint is_monochrome;      /* Private, True if image is known to be monochrome */
	uint is_grayscale;       /* Private, True if image is known to be grayscale */
	uint taint;              /* Private, True if image has not been modifed */

  _Image* clip_mask;         /* Private, Clipping mask to apply when updating pixels */

  //unsigned int
	uint ping;               /* Private, if true, pixels are undefined */

  void* cache;//_CacheInfoPtr_ cache;              /* Private, image pixel cache */

  void* default_views;//_ThreadViewSetPtr_ default_views;      /* Private, default cache views */

  //_ImageAttributePtr_ attributes;         /* Private, Image attribute list */
	void* attributes;

  //_Ascii85InfoPtr_ ascii85;            /* Private, supports huffman encoding */
	void* ascii85;

  //_BlobInfoPtr_ blob;               /* Private, file I/O object */
	void* blob;

  //long
	int reference_count;    /* Private, Image reference count */

  //_SemaphoreInfoPtr_ semaphore;          /* Private, Per image lock (for reference count) */
	void* semaphore;

  //unsigned int
	uint logging;            /* Private, True if logging is enabled */

  _Image* list;              /* Private, used only by display */

  //unsigned long
	uint signature;          /* Private, Unique code to validate structure */
}
alias _Image Image;

struct _ImageInfo
{
  CompressionType compression;             /* Image compression to use while decoding */

  //MagickBool
	uint temporary;               /* Remove file "filename" once it has been read. */
	//bool
	uint adjoin;                  /* If True, join multiple frames into one file */
	//bool
	uint antialias;               /* If True, antialias while rendering */

  //unsigned long
	uint subimage;                /* Starting image scene ID to select */
	uint subrange;                /* Span of image scene IDs (from starting scene) to select */
	uint depth;                   /* Number of quantum bits to preserve while encoding */
	
  
	char* size;                   /* Desired/known dimensions to use when decoding image */
	char* tile;                   /* Deprecated, name of image to tile on background */
	char* page;                   /* Output page size & offset */

  InterlaceType interlace;               /* Interlace scheme to use when decoding image */

  EndianType endian;                  /* Select MSB/LSB endian output for TIFF format */

  ResolutionType units;                   /* Units to apply when evaluating the density option */

  //unsigned long
	uint quality;                 /* Compression quality factor (format specific) */

	char* sampling_factor;        /* JPEG, MPEG, and YUV chroma downsample factor */
	char* server_name;            /* X11 server display specification */
	char* font;                   /* Font name to use for text annotations */
	char* texture;                /* Name of texture image to use for background fills */
	char* density;                /* Image resolution (also see units) */

  double pointsize;               /* Font pointsize */

  double fuzz;                    /* Colors within this distance are a match */

	PixelPacket pen;                     /* Stroke or fill color while drawing */
	PixelPacket background_color;        /* Background color */
	PixelPacket border_color;            /* Border color (color surrounding frame) */
	PixelPacket matte_color;             /* Matte color (frame color) */

  //MagickBool
	//bool
	uint dither;                  /* If true, dither image while writing */
	//bool
	uint monochrome;              /* If true, use monochrome format */
	//bool
	uint progress;                /* If true, show progress indication */

  ColorspaceType colorspace;              /* Colorspace representations of image pixels */

  ImageType type;                    /* Desired image type (used while reading or writing) */

	//long
  int group;                   /* X11 window group ID */

  //unsigned int 
	uint verbose;                 /* If non-zero, display high-level processing */

	char* view;                   /* FlashPIX view specification */
	char* authenticate;           /* Password used to decrypt file */

  void* client_data;            /* User-specified data to pass to coder */

  //FILE*
	FILE* file;                   /* If not null, stdio FILE to read image from */

	/*
	uint AARGH01;
	uint AARGH02;
	uint AARGH03;
	uint AARGH04;
	*/

  char[MaxTextExtent] magick;   /* File format to read. Overrides file extension */
	char[MaxTextExtent] filename; /* File name to read */

  /*
    Only private members appear past this point
  */

  //_CacheInfoPtr_
	void* cache;                  /* Private. Used to pass image via open cache */

  void* definitions;            /* Private. Map of coder specific options passed by user.
                                Use AddDefinitions, RemoveDefinitions, & AccessDefinition
                                to access and manipulate this data. */

  Image* attributes;             /* Private. Image attribute list */

  //MagickBool
	//bool 
	uint ping;                    /* Private, if true, read file header only */

  PreviewType preview_type;            /* Private, used by PreviewImage */

  //MagickBool
	//bool 
	uint affirm;                  /* Private, when true do not intuit image format */

  //_BlobInfoPtr_
	void* blob;                    /* Private, used to pass in open blob */

  size_t length;                  /* Private, used to pass in open blob length */

  char[MaxTextExtent] unique;   /* Private, passes temporary filename to TranslateText */
	char[MaxTextExtent] zero;     /* Private, passes temporary filename to TranslateText */

  //unsigned long
	uint signature;               /* Private, used to validate structure */
}
alias _ImageInfo ImageInfo;


/*
  Image utilities methods.
*/


//TODO extern MagickExport ExceptionType
//  CatchImageException(Image *);

/*TODO
Image* AllocateImage(ImageInfo*);
Image* AppendImages(const Image *,const unsigned int,ExceptionInfo *),
Image* AverageImages(const Image *,ExceptionInfo *),
Image* CloneImage(const Image *,const unsigned long,const unsigned long,
   const unsigned int,ExceptionInfo *),
Image* GetImageClipMask(const Image *,ExceptionInfo *),
Image* ReferenceImage(Image *);
*/

ImageInfo* CloneImageInfo(ImageInfo*);


/+
//TODO
extern MagickExport ImageType
  GetImageType(const Image *,ExceptionInfo *);

extern MagickExport const char
  *AccessDefinition(const ImageInfo *image_info,const char *magick,
     const char *key);

extern MagickExport int
  GetImageGeometry(const Image *,const char *,const unsigned int,
  RectangleInfo *);

extern MagickExport RectangleInfo
  GetImageBoundingBox(const Image *,ExceptionInfo *exception);

/* Functions which return unsigned int as a True/False boolean value */
extern MagickExport MagickBool
  IsTaintImage(const Image *),
  IsSubimage(const char *,const unsigned int);

/* Functions which return unsigned int to indicate operation pass/fail */
extern MagickExport MagickPassFail
  AddDefinitions(ImageInfo *image_info,const char *options,
    ExceptionInfo *exception),
  AllocateImageColormap(Image *,const unsigned long),
  AnimateImages(const ImageInfo *image_info,Image *image),
  ClipImage(Image *),
  ClipPathImage(Image *image,const char *pathname,const MagickBool inside),
  CycleColormapImage(Image *image,const int amount),
  DescribeImage(Image *image,FILE *file,const unsigned int verbose),
  DisplayImages(const ImageInfo *image_info,Image *image),
  GetImageCharacteristics(const Image *image,ImageCharacteristics *characteristics,
    const MagickBool optimize,ExceptionInfo *exception),
  GetImageStatistics(const Image *image,ImageStatistics *statistics,
    ExceptionInfo *exception),
  GradientImage(Image *,const PixelPacket *,const PixelPacket *),
  PlasmaImage(Image *,const SegmentInfo *,unsigned long,unsigned long),
  RemoveDefinitions(const ImageInfo *image_info,const char *options),
  ReplaceImageColormap(Image *image,const PixelPacket *colormap,
    const unsigned int colors),
  SetImage(Image *,const Quantum),
  SetImageClipMask(Image *image,const Image *clip_mask),
  SetImageDepth(Image *,const unsigned long),
  SetImageInfo(ImageInfo *,const MagickBool,ExceptionInfo *),
  SetImageType(Image *,const ImageType),
  SortColormapByIntensity(Image *),
  SyncImage(Image *),
  TextureImage(Image *,const Image *);

extern MagickExport unsigned long
  GetImageDepth(const Image *,ExceptionInfo *);

extern MagickExport void
  AllocateNextImage(const ImageInfo *,Image *),
+/

void DestroyImage(Image*);
void DestroyImageInfo(ImageInfo*);


/+
  GetImageException(Image *,ExceptionInfo *),
  GetImageInfo(ImageInfo *),
  ModifyImage(Image **,ExceptionInfo *),
  SetImageOpacity(Image *,const unsigned int);

+/


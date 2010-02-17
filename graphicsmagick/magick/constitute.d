module magick.constitute;

import magick.image;
import magick.error;

align(1):

/*
  Quantum import/export types as used by ImportImagePixelArea() and
  ExportImagePixelArea(). Values are imported or exported in network
  byte order ("big endian") by default, but little endian may be
  selected via the 'endian' option in ExportPixelAreaOptions and
  ImportPixelAreaOptions.
*/
enum
{
  UndefinedQuantum,  /* Not specified */
  IndexQuantum,      /* Colormap indexes */
  GrayQuantum,       /* Grayscale values (minimum value is black) */
  IndexAlphaQuantum, /* Colormap indexes with transparency */
  GrayAlphaQuantum,  /* Grayscale values with transparency */
  RedQuantum,        /* Red values only (RGBA) */
  CyanQuantum,       /* Cyan values only (CMYKA) */
  GreenQuantum,      /* Green values only (RGBA) */
  YellowQuantum,     /* Yellow values only (CMYKA) */
  BlueQuantum,       /* Blue values only (RGBA) */
  MagentaQuantum,    /* Magenta values only (CMYKA) */
  AlphaQuantum,      /* Transparency values (RGBA or CMYKA) */
  BlackQuantum,      /* Black values only (CMYKA) */
  RGBQuantum,        /* Red, green, and blue values */
  RGBAQuantum,       /* Red, green, blue, and transparency values */
  CMYKQuantum,       /* Cyan, magenta, yellow, and black values */
  CMYKAQuantum,      /* Cyan, magenta, yellow, black, and transparency values */
  CIEYQuantum,       /* CIE Y values, based on CCIR-709 primaries */
  CIEXYZQuantum      /* CIE XYZ values, based on CCIR-709 primaries */
}
alias int QuantumType;

/*
  Quantum sample type for when exporting/importing a pixel area.
*/
enum
{
  UndefinedQuantumSampleType, /* Not specified */
  UnsignedQuantumSampleType,  /* Unsigned integral type (1 to 32 bits) */
  FloatQuantumSampleType      /* Floating point type (16, 24, 32, or 64 bit) */
}
alias int QuantumSampleType;

/*
  Quantum size types as used by ConstituteImage() and DispatchImage()/
*/
enum
{
  CharPixel,         /* Unsigned 8 bit 'unsigned char' */
  ShortPixel,        /* Unsigned 16 bit 'unsigned short int' */
  IntegerPixel,      /* Unsigned 32 bit 'unsigned int' */
  LongPixel,         /* Unsigned 32 or 64 bit (CPU dependent) 'unsigned long' */
  FloatPixel,        /* Floating point 32-bit 'float' */
  DoublePixel        /* Floating point 64-bit 'double' */
}
alias int StorageType;

/*
  Additional options for ExportImagePixelArea()
*/
struct _ExportPixelAreaOptions
{
  QuantumSampleType
    sample_type;          /* Quantum sample type */

  double
    double_minvalue,      /* Minimum value (default 0.0) for linear floating point samples */
    double_maxvalue;      /* Maximum value (default 1.0) for linear floating point samples */

  //MagickBool
  uint grayscale_miniswhite; /* Grayscale minimum value is white rather than black */

  //unsigned long
	uint pad_bytes;            /* Number of pad bytes to output after pixel data */

  //unsigned char
	ubyte pad_value;            /* Value to use when padding end of pixel data */

  EndianType endian;               /* Endian orientation for 16/32/64 bit types (default MSBEndian) */

  //unsigned long
	uint signature;
}
alias _ExportPixelAreaOptions ExportPixelAreaOptions;

/*
  Optional results info for ExportImagePixelArea()
*/
struct _ExportPixelAreaInfo
{
  size_t bytes_exported;       /* Number of bytes which were exported */
}
alias _ExportPixelAreaInfo ExportPixelAreaInfo;

/*
  Additional options for ImportImagePixelArea()
*/
struct _ImportPixelAreaOptions
{
  QuantumSampleType sample_type;          /* Quantum sample type */

  double double_minvalue;      /* Minimum value (default 0.0) for linear floating point samples */
	double double_maxvalue;      /* Maximum value (default 1.0) for linear floating point samples */

  //MagickBool
	uint grayscale_miniswhite; /* Grayscale minimum value is white rather than black */

  EndianType endian;               /* Endian orientation for 16/32/64 bit types (default MSBEndian) */

  //unsigned long
	uint signature;
}
alias _ImportPixelAreaOptions ImportPixelAreaOptions;

/*
  Optional results info for ImportImagePixelArea()
*/
struct _ImportPixelAreaInfo
{
  size_t bytes_imported;       /* Number of bytes which were imported */
}
alias _ImportPixelAreaInfo ImportPixelAreaInfo;


extern (C)
{
char* StorageTypeToString(StorageType storage_type);
char* QuantumSampleTypeToString(QuantumSampleType sample_type);
char* QuantumTypeToString(QuantumType quantum_type);
	
Image* ConstituteImage(uint width, uint height,
     char* map, StorageType type, void* pixels,
     ExceptionInfo* exception);
		 
Image* ConstituteTextureImage(uint columns, uint rows,
     Image* texture, ExceptionInfo* exception);
		 
Image* PingImage(ImageInfo* image_info, ExceptionInfo* exception);
Image* ReadImage(ImageInfo* image_info, ExceptionInfo* exception);
Image* ReadInlineImage(ImageInfo* image_info, char* content,
     ExceptionInfo* exception);
		 
MagickPassFail DispatchImage(Image* image, int x_offset, int y_offset,
    uint columns, uint rows, char* map,
    StorageType type, void* pixels, ExceptionInfo* exception);
MagickPassFail ExportImagePixelArea(Image* image, QuantumType quantum_type,
    uint quantum_size, ubyte* destination,
    ExportPixelAreaOptions* options, ExportPixelAreaInfo* export_info);

//TODO I can't find ViewInfo from anywhere???
//MagickPassFail ExportViewPixelArea(ViewInfo* view, QuantumType quantum_type,
//    uint quantum_size, ubyte* destination,
//    ExportPixelAreaOptions* options, ExportPixelAreaInfo* export_info);
		 
//
Image* WriteImage( ImageInfo* image_info, Image* image );
//
}


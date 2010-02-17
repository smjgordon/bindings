module magick.resize;

import magick.image;
import magick.error;

align(1):

extern (C)
{
//alias LanczosFilter DefaultResizeFilter;

Image* MagnifyImage(Image*, ExceptionInfo* );
Image* MinifyImage(Image*, ExceptionInfo* );
Image* ResizeImage(Image*, uint, uint, FilterTypes, double, ExceptionInfo* );
Image* SampleImage(Image*, uint, uint, ExceptionInfo* );
Image* ScaleImage(Image*, uint, uint, ExceptionInfo* );
Image* ThumbnailImage(Image*, uint, uint, ExceptionInfo * );
Image* ZoomImage(Image*, uint, uint, ExceptionInfo* );

}


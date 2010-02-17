module magick.pixel_cache;

import magick.image;
import magick.error;

align(1):

/*
    Enum declaractions.
  */

  enum
	{
		UndefinedVirtualPixelMethod,
		ConstantVirtualPixelMethod,
		EdgeVirtualPixelMethod,
		MirrorVirtualPixelMethod,
		TileVirtualPixelMethod
	} 
	alias int VirtualPixelMethod;

extern (C)
{
	/*****
   *
   * Default View interfaces
   *
   *****/

  /*
    Read only access to a rectangular pixel region.
  */
  PixelPacket* AcquireImagePixels(Image* image, int x, int y,
                      uint columns,
                      uint rows, ExceptionInfo* exception);
}


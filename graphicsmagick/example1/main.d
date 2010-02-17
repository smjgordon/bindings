module main;

import tango.io.FilePath;

import Path = tango.io.Path;

import tango.util.log.Trace;

import tango.stdc.string;//strcpy
import stringz = tango.stdc.stringz;

import Mag = magick.api;

void main(char[][] args)
{

	Mag.Image* image;
	Mag.Image* resize_image;
	Mag.ImageInfo* image_info;
	Mag.ExceptionInfo exception;
	
	Mag.InitializeMagick(args);
	Mag.GetExceptionInfo(&exception);
	image_info = Mag.CloneImageInfo( null );
	
	char[] filename = "image.png";
	
	//image_info.filename[] = "image.png";
	strcpy( &image_info.filename[0], stringz.toStringz(filename));
	Trace.formatln("filename after: {}", image_info.filename );
	image = Mag.ReadImage(image_info,&exception);
	if (exception.severity != Mag.UndefinedException)
        Mag.CatchException(&exception);
	
	if( image is null )
	{
		Trace.formatln("Image is null after opening. filename: {}", filename );
		return;
	}
	
	/*
	PixelPacket* AcquireImagePixels(Image* image, int x,const int y,
                      uint columns,
                      uint rows, ExceptionInfo* exception);
	*/
	
	uint[20] darray;
	
	for( uint i = 0; i < 20; i++ )
	{
		darray[i] = i;
	}
	
	uint* carray = &darray[0];
	
	for( uint i = 0; i < 20; i++ )
	{
		Trace.formatln( "i:{} value: {}", i, carray[i] );
	}
	
	//assert(0);
	
	
	//Here's how to go through the image pixels:
	uint x1 = 0;
	uint y1 = 0;
	uint x2 = image.columns;
	uint y2 = 1;
	
	for( ; y1 < image.rows; )
	{
		Mag.PixelPacket* pixels = Mag.AcquireImagePixels(image, x1, y1, x2, y2, &exception);
		if (exception.severity != Mag.UndefinedException)
				Mag.CatchException(&exception);
			
		for( uint i = 0; i < image.columns; i++ )
		{
			//if( pixels[i].red != 0 || pixels[i].green != 0 || pixels[i].blue != 0 ) //Don't print it if it's black.
			//	Trace.format( "| y1:{} i {} r:{}, g:{}, b:{} ", y1, i, pixels[i].red, pixels[i].green, pixels[i].blue );
		}
		
		y1++;
	}
	
	//Here's how to use some of the GraphicsMagick methods:
	strcpy( &image.filename[0], stringz.toStringz("writtenimage.png") );
	Mag.WriteImage(image_info, image);
	Trace.formatln("written filename 1: {}", image.filename );
	
	resize_image = Mag.ResizeImage(image,106,80, Mag.LanczosFilter,1.0,&exception);
	if (exception.severity != Mag.UndefinedException)
        Mag.CatchException(&exception);
	strcpy( &resize_image.filename[0], stringz.toStringz("thumbnail.png") );
	Mag.WriteImage(image_info, resize_image);
	
	Trace.formatln("written filename 2: {}", resize_image.filename );
	
	Mag.DestroyImage(image);
		Mag.DestroyImageInfo(image_info);
		Mag.DestroyExceptionInfo(&exception);
		Mag.DestroyMagick();
}


/+
//Here's an example of a rough (and slow) image loading function from Rae.Image.

	bool load(char[] filename)
	{
		//uses GraphicsMagick to load image files.
		if( doesFileExist(filename) == false )
		{
			Trace.formatln("Image.load() failed. File doesn't exist: {}", filename );
			return false;
		}
	
		Mag.Image* image;
		Mag.Image* resize_image;
		Mag.ImageInfo* image_info;
		Mag.ExceptionInfo exception;
		
		Mag.GetExceptionInfo(&exception);
		
		image_info = Mag.CloneImageInfo( null );
		
		strcpy( &image_info.filename[0], stringz.toStringz(filename));
	//Trace.formatln("filename after: {}", image_info.filename );
	image = Mag.ReadImage(image_info,&exception);
	if (exception.severity != Mag.UndefinedException)
        Mag.CatchException(&exception);
	
	if( image is null )
	{
		Trace.formatln("Unsupported image type.");
		return false;
	}
	
	bool need_realloc = false;
	
	uint tempwidth = image.columns;
	uint tempheight = image.rows;
	uint tempchannels = 4;
	
		if( tempwidth != width || tempheight != height || tempchannels != channels )
			need_realloc = true;
		
		width = tempwidth;
		height = tempheight;
		channels = tempchannels;
		
		if( imageData is null )
		{
			imageData = new ubyte[(width*height)*channels];
			createGLTexture();
		}
		else if( need_realloc == true )
		{
			delete imageData;
			imageData = new ubyte[(width*height)*channels];
		}	
	/*
	PixelPacket* AcquireImagePixels(Image* image, int x,const int y,
                      uint columns,
                      uint rows, ExceptionInfo* exception);
	*/
	
	uint x1 = 0;
	uint y1 = 0;
	uint x2 = image.columns;
	uint y2 = 1;
	
	for( ; y1 < image.rows; )
	{
		Mag.PixelPacket* pixels = Mag.AcquireImagePixels(image, x1, y1, x2, y2, &exception);
		if (exception.severity != Mag.UndefinedException)
				Mag.CatchException(&exception);
			
		for( uint i = 0; i < image.columns; i++ )
		{
			//if( pixels[i].red != 0 || pixels[i].green != 0 || pixels[i].blue != 0 )
			//	Trace.format( "| y1:{} i {} r:{}, g:{}, b:{} ", y1, i, pixels[i].red, pixels[i].green, pixels[i].blue );
			
			imageData[(y1*width*channels) + (i*channels)] = pixels[i].red;
			imageData[(y1*width*channels) + (i*channels) + 1] = pixels[i].green;
			imageData[(y1*width*channels) + (i*channels) + 2] = pixels[i].blue;
			imageData[(y1*width*channels) + (i*channels) + 3] = pixels[i].opacity;
		}
		
		y1++;
		//y2++;
	}
		
		if( width > 2048 || height > 2048 )
		{
			if( width >= height )
			{
				float aspectrat = cast(float)height / cast(float)width;
				resize( 2048, cast(uint)(2048.0f * aspectrat) );
			}
			else
			{
				float aspectrat = cast(float)width / cast(float)height;
				resize( cast(uint)(2048.0f * aspectrat), 2048 );
			}
		}
		
		bool isPowerOfTwo( int val )
		{
			return ((val&(val-1))==0);
		}
		
		if( isPowerOfTwo(width) && isPowerOfTwo(height) )
		{
			glTextureType = GL_TEXTURE_2D;
			///////////minFilter = GL_LINEAR_MIPMAP_LINEAR;
			///////////magFilter = GL_NEAREST;
		}
		else
		{
			glTextureType = GL_TEXTURE_RECTANGLE_ARB;
			//////////minFilter = GL_LINEAR;//GL_NEAREST;
			//////////magFilter = GL_LINEAR;//GL_NEAREST;
		}
		
		dataType = GL_UNSIGNED_BYTE;
		texEnvMode = GL_REPLACE;
		//dstImage.glTextureType = GL_TEXTURE_2D;
		isBlending = false;
		isMipmapping = false;
		
		setColourFormatFromChannels();
		updateGLTexture();
		
		Mag.DestroyImage(image);
		Mag.DestroyImageInfo(image_info);
		Mag.DestroyExceptionInfo(&exception);
		
		return true;
	}
+/


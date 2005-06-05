// converted to D by clayasaurus

/* 

   SDL_rotozoom - test program 

   Copyright (C) A. Schiffler, July 2001

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

*/

import derelict.sdl.sdl; 

import std.c.stdlib;
import std.stdio;
import std.string;

import rotozoom;

void HandleEvent ()
{
SDL_Event event;

/* Check for events */
while (SDL_PollEvent (&event))
   {
      switch (event.type)
      {
         case SDL_KEYDOWN:
         case SDL_QUIT:
         exit (0);
         break;
         default:
         break; 
      }
   }
}

void
ClearScreen (SDL_Surface * screen)
{
int i;
/* Set the screen to black */
if (SDL_LockSurface (screen) == 0)
   {
      Uint32 black;
      Uint8 *pixels;
      black = SDL_MapRGB (screen.format, 0, 0, 0);
      pixels = cast(Uint8 *) screen.pixels;
      for (i = 0; i < screen.h; ++i)
   {
   memset (pixels, black, screen.w * screen.format.BytesPerPixel);
   pixels += screen.pitch;
   }
      SDL_UnlockSurface (screen);
   }
}

void
RotatePicture (SDL_Surface * screen, SDL_Surface * picture, int rotate,
         int smooth)
{
   SDL_Surface *rotozoom_picture;
   SDL_Rect dest;
   int framecount, framemax, frameinc;
   float zoomf;
   
   /* Rotate and display the picture */
   framemax = 4 * 360;
   frameinc = 1;
   for (framecount = 360; framecount < framemax; framecount += frameinc)
      {
         if ((framecount % 360) == 0)
      frameinc++;
         HandleEvent ();
         ClearScreen (screen);
         zoomf = cast(float) framecount / cast(float) framemax;
         zoomf = 1.5 * zoomf * zoomf;
         if ((rotozoom_picture =
         rotozoomSurface (picture, framecount * rotate, zoomf,
               smooth)) != null)
      {
      dest.x = (screen.w - rotozoom_picture.w) / 2;;
      dest.y = (screen.h - rotozoom_picture.h) / 2;
      dest.w = rotozoom_picture.w;
      dest.h = rotozoom_picture.h;
      if (SDL_BlitSurface (rotozoom_picture, null, screen, &dest) < 0)
         {
            writef ( "Blit failed: %s\n", SDL_GetError ());
            break;
         }
      SDL_FreeSurface (rotozoom_picture);
      }
   
         /* Display by flipping screens */
         SDL_UpdateRect (screen, 0, 0, 0, 0);
      }
   
   if (rotate)
      {
         /* Final display with angle=0 */
         HandleEvent ();
         ClearScreen (screen);
         if ((rotozoom_picture =
         rotozoomSurface (picture, 0.01, zoomf, smooth)) != null)
      {
      dest.x = (screen.w - rotozoom_picture.w) / 2;;
      dest.y = (screen.h - rotozoom_picture.h) / 2;
      dest.w = rotozoom_picture.w;
      dest.h = rotozoom_picture.h;
      if (SDL_BlitSurface (rotozoom_picture, null, screen, &dest) < 0)
         {
            writef ( "Blit failed: %s\n", SDL_GetError ());
            return;
         }
      SDL_FreeSurface (rotozoom_picture);
      }
   
         /* Display by flipping screens */
         SDL_UpdateRect (screen, 0, 0, 0, 0);
      }
   
   /* Pause for a sec */
   SDL_Delay (1000);
}

void
ZoomPicture (SDL_Surface * screen, SDL_Surface * picture, int smooth)
   {
   SDL_Surface *rotozoom_picture;
   SDL_Rect dest;
   int framecount, framemax, frameinc;
   float zoomxf, zoomyf;
   
   /* Zoom and display the picture */
   framemax = 4 * 360;
   frameinc = 1;
   for (framecount = 360; framecount < framemax; framecount += frameinc)
      {
         if ((framecount % 360) == 0)
      frameinc++;
         HandleEvent ();
         ClearScreen (screen);
         zoomxf = cast(float) framecount / cast(float) framemax;
         zoomxf = 1.5 * zoomxf * zoomxf;
         zoomyf = 0.5 + fabs (1.0 * sin (cast(double) framecount / 80.0));
         if ((rotozoom_picture =
         zoomSurface (picture, zoomxf, zoomyf, smooth)) != null)
      {
      dest.x = (screen.w - rotozoom_picture.w) / 2;;
      dest.y = (screen.h - rotozoom_picture.h) / 2;
      dest.w = rotozoom_picture.w;
      dest.h = rotozoom_picture.h;
      if (SDL_BlitSurface (rotozoom_picture, null, screen, &dest) < 0)
         {
            writef ( "Blit failed: %s\n", SDL_GetError ());
            break;
         }
      SDL_FreeSurface (rotozoom_picture);
      }
   
         /* Display by flipping screens */
         SDL_UpdateRect (screen, 0, 0, 0, 0);
      }
   
   /* Pause for a sec */
   SDL_Delay (1000);
}

void
Draw (SDL_Surface * screen)
   {
   SDL_Surface *picture, picture_again;
   char *bmpfile;
   
   /* --------- 8 bit test -------- */
   
   /* Message */
   writef ( "Loading 8bit image\n");
   
   /* Load the image into a surface */
   bmpfile = "sample8.bmp";
   writef ( "Loading picture: %s\n", bmpfile);
   picture = SDL_LoadBMP (bmpfile);
   if (picture is null)
      {
         writef ( "Couldn't load %s: %s\n", bmpfile, SDL_GetError ());
         return;
      }
   
   writef ( "rotozoom: Rotating and zooming\n");
   RotatePicture (screen, picture, 1, SMOOTHING_OFF);
   
   writef ( "rotozoom: Just zooming (angle=0)\n");
   RotatePicture (screen, picture, 0, SMOOTHING_OFF);
   
   writef ( "zoom: Just zooming\n");
   ZoomPicture (screen, picture, SMOOTHING_OFF);
   
   
   writef (
         "rotozoom: Rotating and zooming, interpolation on but unused\n");
   RotatePicture (screen, picture, 1, SMOOTHING_ON);
   
   writef (
         "rotozoom: Just zooming (angle=0), interpolation on but unused\n");
   RotatePicture (screen, picture, 0, SMOOTHING_ON);
   
   writef ( "zoom: Just zooming, interpolation on but unused\n");
   ZoomPicture (screen, picture, SMOOTHING_ON);
   
   /* Free the picture */
   SDL_FreeSurface (picture);
   
   /* -------- 24 bit test --------- */
   
   /* Message */
   writef ( "Loading 24bit image\n");
   /* Load the image into a surface */
   bmpfile = "sample24.bmp";
   writef ( "Loading picture: %s\n", bmpfile);
   picture = SDL_LoadBMP (bmpfile);
   if (picture is null)
      {
         writef ( "Couldn't load %s: %s\n", bmpfile, SDL_GetError ());
         return;
      }
   
   writef ( "rotozoom: Rotating and zooming, no interpolation\n");
   RotatePicture (screen, picture, 1, SMOOTHING_OFF);
   
   writef ( "rotozoom: Just zooming (angle=0), no interpolation\n");
   RotatePicture (screen, picture, 0, SMOOTHING_OFF);
   
   writef ( "zoom: Just zooming, no interpolation\n");
   ZoomPicture (screen, picture, SMOOTHING_OFF);
   
   
   writef ( "rotozoom: Rotating and zooming, with interpolation\n");
   RotatePicture (screen, picture, 1, SMOOTHING_ON);
   
   writef ( "rotozoom: Just zooming (angle=0), with interpolation\n");
   RotatePicture (screen, picture, 0, SMOOTHING_ON);
   
   writef ( "zoom: Just zooming, with interpolation\n");
   ZoomPicture (screen, picture, SMOOTHING_ON);
   
   
   /* New source surface is 32bit with defined RGBA ordering */
   /* Much faster to do this once rather than the routine on the fly */
   writef ( "Converting 24bit image into 32bit RGBA surface ...\n");
   picture_again =
      SDL_CreateRGBSurface (SDL_SWSURFACE, picture.w, picture.h, 32,
            0x000000ff, 0x0000ff00, 0x00ff0000, 0xff000000);
   SDL_BlitSurface (picture, null, picture_again, null);
   
   /* Message */
   writef ( "Rotating and zooming, with interpolation\n");
   RotatePicture (screen, picture_again, 1, SMOOTHING_ON);
   
   /* Message */
   writef ( "Just zooming (angle=0), with interpolation\n");
   RotatePicture (screen, picture_again, 0, SMOOTHING_ON);
   
   SDL_FreeSurface (picture_again);
   
   /* New source surface is 32bit with defined ABGR ordering */
   /* Much faster to do this once rather than the routine on the fly */
   writef ( "Converting 24bit image into 32bit ABGR surface ...\n");
   picture_again =
      SDL_CreateRGBSurface (SDL_SWSURFACE, picture.w, picture.h, 32,
            0x000000ff, 0x0000ff00, 0x00ff0000, 0xff000000);
   SDL_BlitSurface (picture, null, picture_again, null);
   
   /* Message */
   writef ( "Rotating and zooming, with interpolation\n");
   RotatePicture (screen, picture_again, 1, SMOOTHING_ON);
   
   /* Message */
   writef ( "Just zooming (angle=0), with interpolation\n");
   RotatePicture (screen, picture_again, 0, SMOOTHING_ON);
   
   SDL_FreeSurface (picture_again);
   
   /* Free the picture */
   SDL_FreeSurface (picture);
   
   return;
}


int main ()
   {

   try
   {
      DerelictSDL_Load(); 
   }
   catch(Exception e)
   {
      e.print();
      exit(0); 
   }


   SDL_Surface *screen;
   int w, h;
   int desired_bpp;
   Uint32 video_flags;
   
   /* Title */
   writef ( "SDL_rotozoom test\n");
   
   /* Set default options and check command-line */
   w = 640;
   h = 480;
   desired_bpp = 0;
   video_flags = 0;
   
   /* Force double buffering */
   video_flags |= SDL_DOUBLEBUF;
   
   /* Initialize SDL */
   if (SDL_Init (SDL_INIT_VIDEO) < 0)
      {
         writef ( "Couldn't initialize SDL: %s\n", SDL_GetError ());
         exit (1);
      }


   
   /* Initialize the display */
   screen = SDL_SetVideoMode (w, h, desired_bpp, video_flags);
   if (screen is null)
      {
         writef ( "Couldn't set %dx%dx%d video mode: %s\n",
            w, h, desired_bpp, SDL_GetError ());
         exit (1);
      }
   

   /* Show some info */
   printf ("Set %dx%dx%d mode\n",
      screen.w, screen.h, screen.format.BitsPerPixel);

   //printf ("Video surface located in %s memory.\n",
    //  (screen.flags & SDL_HWSURFACE) ? "video" : "system");
   
   /* Check for double buffering */
   //if (screen.flags & SDL_DOUBLEBUF)
    //  {
     //    printf ("Double-buffering enabled - good!\n");
    //  }
   
   /* Set the window manager title bar */
   SDL_WM_SetCaption ("SDL_rotozoom test", "rotozoom");
   
   /* Do all the drawing work */
   Draw (screen);
   
   SDL_Quit(); 

   return (0);
}


import core.window;
import core.input;

import raknet.client,
       raknet.server,
       raknet.bitstream;

import std.string;
import std.stdio;

import core.math.util;
import std.c.time;


import derelict.opengl.gl;
import derelict.sdl.sdl;

const ubyte PACKET_ID_LINE = 100;




struct Line
{
   float x1, y1, x2, y2;
   int r, g, b;

   void generateColor()
   {
      r = random_range(0, 255);
      g = random_range(0, 255);
      b = random_range(0, 255);
   }
   
   void print()
   {
      writefln(x1, " ",  y1, " ", x2, " ", y2);
   }

   void draw()
   {
      glColor3ub(r,g,b);
      
      glBegin(GL_LINES);

         glVertex2f(x1, y1);
         glVertex2f(x2, y2);
   
      glEnd();
   }
}

class ClientConnection
{
  private:
   Line[] lines;

   this(char *serverIP, char *portString)
   {
      // init client and connect to server
      raknet.client.initialize();
      
      raknet.client.connect(serverIP, atoi(portString), 0, 0, 0);
   }

   ~this()
   {
      // destroy client
      raknet.client.disconnect(300);
      raknet.client.destroy();
   }

   // client will keep track of all lines added by itself and the server   
   void addLocalLine(float x1, float y1, float x2, float y2, int r, int g, int b)
   {
      Line line;

      line.x1 = x1;
      line.x2 = x2;
      line.y1 = y1;
      line.y2 = y2;
      line.r = r;
      line.g = g;
      line.b = b;

      lines ~= line;
   }

   void sendLineToServer(float x1, float y1, float x2, float y2, int r, int g, int b)
   {
      raknet.bitstream.start();
      
      raknet.bitstream.write(PACKET_ID_LINE);
      raknet.bitstream.write(x1);
      raknet.bitstream.write(y1);
      raknet.bitstream.write(x2);
      raknet.bitstream.write(y2);
      raknet.bitstream.write(r);
      raknet.bitstream.write(g);
      raknet.bitstream.write(b);
      
      raknet.client.sendBitstream(PacketPriority.HIGH_PRIORITY, PacketReliability.RELIABLE_ORDERED, 0);
      
      raknet.bitstream.end();
   }

   // draw all lines to screen
   void drawLines()
   {
      foreach(Line line; lines)
      {
         line.draw();
      }
   }

   // check to see if any packets coming from the server are waiting to be handled by the client
   void listenForPackets()
   { 
      Packet * p = raknet.client.receivePacket();
      
      if(p !is null) {
         handlePacket(p);
         
         raknet.client.deallocatePacket(p);
      }
   }
   
   // will then decode the packet, which should be information about a line, and add a line to the list of lines to draw
   void handlePacket(Packet * p)
   {
      raknet.bitstream.start(cast(char*)p.data, p.length, false);

      ubyte packetID;
   
      raknet.bitstream.read(packetID);
   
      switch(packetID) {
      case PACKET_ID_LINE:
         float x1, y1, x2, y2;
         int r, g, b;
      
         raknet.bitstream.read(x1);
         raknet.bitstream.read(y1);
         raknet.bitstream.read(x2);
         raknet.bitstream.read(y2);
         raknet.bitstream.read(r);
         raknet.bitstream.read(g);
         raknet.bitstream.read(b);
      
         addLocalLine(x1, y1, x2, y2, r, g, b);
      break;
      default:
      break;
      }

   }
}


int main()
{
   ClientConnection clientConnect = new ClientConnection("192.168.2.3", "6881");

   int lineCount = 0;

   core.window.open("window.lua");
   core.window.mode2D();
   
   core.input.open();

   float lastX, lastY; 
   
   while (!(core.input.keyDown(SDL_QUIT) || core.input.keyDown(SDLK_ESCAPE)))
   {
      core.input.process();

      if (core.input.mouseHit(LEFT))
      {
         lineCount++;

         // every other click is a new line
         if ((lineCount % 2) == 0)
         {
            int r = random_range(50,255);
            int g = random_range(50,255);
            int b = random_range(50,255);

            clientConnect.addLocalLine(lastX, lastY, core.input.mouseX2D, core.input.mouseY2D,r,g,b);
            clientConnect.sendLineToServer(lastX, lastY, core.input.mouseX2D, core.input.mouseY2D,r,g,b);
         }
         else
         {  
            lastX = core.input.mouseX2D; 
            lastY = core.input.mouseY2D;
         }

      }

      clientConnect.drawLines();
      clientConnect.listenForPackets();

      SDL_GL_SwapBuffers();
   }
   
   core.window.close();

   return 0;
}



extern(C):


char *gets( char *str );
int atoi( char *str );





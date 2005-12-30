
import arc.io.window,
       arc.io.input,
       arc.phy.util;        

import raknet.client,
       raknet.server,
       raknet.bitstream;

import std.string;
import std.stdio;

import std.c.time;


import derelict.opengl.gl;
import derelict.sdl.sdl;

const ubyte PACKET_ID_LINE = 100;
const ubyte PACKET_ID_NUM = 101;
const ubyte PACKET_ID_NUM_REQUEST = 102; 

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
   int playerNum = 0;

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

   // send player ID to server and wait to recieve player number
   void getPlayerNum()
   {
      // get player ID
      PlayerID pid = raknet.client.playerID(); 

      // request player num based on player ID from server
      raknet.bitstream.start();
   
      raknet.bitstream.write(PACKET_ID_NUM_REQUEST); 
      raknet.bitstream.write(pid.binaryAddress);
      raknet.bitstream.write(pid.port); 

      raknet.client.sendBitstream(PacketPriority.HIGH_PRIORITY, PacketReliability.RELIABLE_ORDERED, 0);

      raknet.bitstream.end();

      debug writefln("getPlayerNum: sent request");
      
      // wait until recieve player number from server
      ubyte packetID = 0;

      do 
      {
         Packet * p = raknet.client.receivePacket();
         
         if(p !is null) {

         // decode packet
         raknet.bitstream.start(cast(char*)p.data, p.length, false);
      
         // read packet ID
         raknet.bitstream.read(packetID);
      
         debug writefln("recieved packet ", packetID);
      
         // if we found it, read its data 
         if (packetID == PACKET_ID_NUM)
         {
            raknet.bitstream.read(playerNum); 
            debug writefln("player ", playerNum, " connected");
         }
            
         // otherwise deallocate and wait some more
         raknet.client.deallocatePacket(p);

         } // p !is unll

      } while (packetID != PACKET_ID_NUM)
   

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
   ClientConnection clientConnect = new ClientConnection("127.0.0.1", "6881");

   // send PID to 
   clientConnect.getPlayerNum();
   
   int lineCount = 0;

   arc.io.window.open("window.lua"); 
   arc.io.input.open();

   float lastX, lastY; 
   
   while (!(arc.io.input.keyDown(SDL_QUIT) || arc.io.input.keyDown(SDLK_ESCAPE)))
   {
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
      arc.io.input.process();

      if (arc.io.input.mouseHit(LEFT))
      {
         lineCount++;

         // every other click is a new line
         if ((lineCount % 2) == 0)
         {
            int r = random_range(50,255);
            int g = random_range(50,255);
            int b = random_range(50,255);

            clientConnect.addLocalLine(lastX, lastY, arc.io.input.mouseX, 
                                       arc.io.input.mouseY,r,g,b);
            clientConnect.sendLineToServer(lastX, lastY, 
                                       arc.io.input.mouseX, arc.io.input.mouseY,r,g,b);
         }
         else
         {  
            lastX = arc.io.input.mouseX; 
            lastY = arc.io.input.mouseY;
         }

      }

      clientConnect.drawLines();
      clientConnect.listenForPackets();

      SDL_GL_SwapBuffers();
   }
   
   arc.io.window.close();

   return 0;
}



extern(C):


char *gets( char *str );
int atoi( char *str );





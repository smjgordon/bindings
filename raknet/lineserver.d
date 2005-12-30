// line server code
import raknet.server,
       raknet.bitstream;

import std.string;
import std.stdio;
import std.c.time;

// packet identifier so we know packet is a line
const ubyte PACKET_ID_LINE = 100;
const ubyte PACKET_ID_NUM = 101;
const ubyte PACKET_ID_NUM_REQUEST = 102; 

int num = 0;

void sendLineToClients(PlayerID clientToExclude, float x1, float y1, float x2, float y2, int r, int g, int b)
{
   // allocates bitstream
   raknet.bitstream.start();      
 
   raknet.bitstream.write(PACKET_ID_LINE);
   raknet.bitstream.write(x1);
   raknet.bitstream.write(y1);
   raknet.bitstream.write(x2);
   raknet.bitstream.write(y2);
   raknet.bitstream.write(r);
   raknet.bitstream.write(g);
   raknet.bitstream.write(b);

   raknet.server.sendBitstream(PacketPriority.HIGH_PRIORITY, PacketReliability.RELIABLE_ORDERED, 0, clientToExclude, true);

   // deallocates bitstream
   raknet.bitstream.end();
}

void sendNumToClients(PlayerID pid, int num)
{
   // allocates bitstream
   raknet.bitstream.start();      
 
   // send info & packet ID
   raknet.bitstream.write(PACKET_ID_NUM);
   raknet.bitstream.write(num);

   raknet.server.sendBitstream(PacketPriority.HIGH_PRIORITY, PacketReliability.RELIABLE_ORDERED, 0, pid, false);

   // deallocates bitstream
   raknet.bitstream.end();
}

void handlePacket(Packet * p)
{
   ubyte packetID;
   
   // allocate bitstream
   raknet.bitstream.start(cast(char*)p.data, p.length, false);

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
      
      sendLineToClients(p.playerId, x1, y1, x2, y2, r, g, b);
   break;

   // on incoming connection tell player which number it is 
   case ID_NEW_INCOMING_CONNECTION:
      debug writefln("player ", p.playerIndex, " connected");

      sendNumToClients(p.playerId, p.playerIndex);
   break; 


   default:
      printf("Unhandled packet (not a problem): %i\n", cast(int)packetID);
   }

   // deallocate bitstream
   raknet.bitstream.end();
}

int main()
{
   raknet.server.initialize();

   Packet * packet = null;
    
   int port = 6881;

   if(raknet.server.start(32, 0, 0, port)) 
   {
      printf("Server started successfully.\n");
      printf("Server is now listening on port %i.\n\n", port);
      printf("^C to close server.\n");
   }
   else 
   {
      printf("There was an error starting the server.");     
      return 0;
   }

   while(true) 
   {
      packet = raknet.server.receivePacket();
      
      if(packet !is null) {
         handlePacket(packet);
         
         raknet.server.deallocatePacket(packet);
      }
   }

    raknet.server.disconnect(300);
    raknet.server.destroy();
        
    printf("Server closed successfully.\n");
        
   return 0;
}


import raknet.client;
import raknet.server; 

import std.string;
import std.stdio;


int main()
{
   Packet *packet; 

   char[512] str;


   printf("(C)lient or (S)erver?\n");
   gets(str);
   if (str[0]=='c' || str[0]=='C')
   {
      raknet.client.initialize();
      writefln("Init client");
   }
   else
   {
      raknet.server.initialize();
      writefln("Init server");
   }
   // above works ///////////////////////////////////////


   if (raknet.server.isServer())
   {
      // Running in server mode on port 60000
      // this seems to work only in C
      if (raknet.server.start(32, 0, 0, 60000))
         printf("Starting the server.\n");
      else
         printf("Failed to start the server.\n");

      raknet.server.REG_AS_RPC("PrintMessage", &PrintMessage);
   }
   else
   {
      // Running in client mode
      printf("Enter server IP or hit enter for 127.0.0.1\n");
      gets(str);
      // 127.0.0.1 designates the feedback loop so we can test on one computer
      if (str[0]==0)
      {
         strcpy(str, "127.0.0.1");
      
         for (int i = 0; i < strlen(str); i++)
            writef(str[i]);
   
         writef("\n");
      }

      if (raknet.client.connect(str, 60000, 0, 0, 0))
         printf("Starting the client.\n");
      else
         printf("Failed to start the client.\n");

      raknet.client.REG_AS_RPC("PrintMessage", &PrintMessage);
   }


   while (1)
   {

      if (raknet.client.isClient())
      {
         //printf("Enter a string or hit enter to display incoming strings\n");
         gets(str);
         // Two tricky things here.  First, you have to remember to send the NULL terminator so you need strlen(str)+1
         // Second, if you didn't read the docs you might not realize RPC takes the number of bits rather than the number of bytes.
         // You have to multiply the number of bytes by 8
         if (str[0])
         {
            raknet.client.RPC("PrintMessage", str, (strlen(str)+1)*8, PacketPriority.HIGH_PRIORITY, PacketReliability.RELIABLE_ORDERED, 0, false);
         }
      }

      if (raknet.server.isServer())
         packet=raknet.server.receivePacket();
      else
         packet=raknet.client.receivePacket();

      while (packet !is null)
      {
         switch (packet.data[0])
         {
         case ID_REMOTE_DISCONNECTION_NOTIFICATION:
            printf("Another client has disconnected.\n");
            break;
         case ID_REMOTE_CONNECTION_LOST:
            printf("Another client has lost the connection.\n");
            break;
         case ID_REMOTE_NEW_INCOMING_CONNECTION:
            printf("Another client has connected.\n");
            break;
         case ID_CONNECTION_REQUEST_ACCEPTED:
            debug printf("Our connection request has been accepted.\n");
            //printf("Enter a string to show on the server: ");
            //cin >> str;
            // Two tricky things here.  First, you have to remember to send the NULL terminator so you need strlen(str)+1
            // Second, if you didn't read the docs you might not realize RPC takes the number of bits rather than the number of bytes.
            // You have to multiply the number of bytes by 8
            //rakClientInterface->RPC("PrintMessage", str, (strlen(str)+1)*8, HIGH_PRIORITY, RELIABLE_ORDERED, 0, false);
            break;

         case ID_NEW_INCOMING_CONNECTION:
            printf("A connection is incoming.\n");
            break;
         case ID_NO_FREE_INCOMING_CONNECTIONS:
            printf("The server is full.\n");
            break;
         case ID_DISCONNECTION_NOTIFICATION:
            if (raknet.server.isServer())
               printf("A client has disconnected.\n");
            else
               printf("We have been disconnected.\n");
            break;
         case ID_CONNECTION_LOST:
            if (raknet.server.isServer())
               printf("A client lost the connection.\n");
            else
               printf("Connection lost.\n");
            break;
         case ID_RECEIVED_STATIC_DATA:
            debug printf("Got static data.\n");
            break;
         default:
            printf("Message with identifier %i has arrived.\n", packet.data[0]);
            break;
         }

         if (raknet.server.isServer())
            raknet.server.deallocatePacket(packet);
         else
            raknet.client.deallocatePacket(packet);


         // Stay in the loop as long as there are more packets.
         if (raknet.server.isServer())
            packet=raknet.server.receivePacket();
         else
            packet=raknet.client.receivePacket();
      }
   }

   if (raknet.client.isClient())
      raknet.client.destroy();
   else if (raknet.server.isServer())
      raknet.server.destroy();


   return 0;
}

/*
version(Windows)
{
		extern(Windows):
}
else
{
		extern(C):
}
*/

extern(C):


char *gets( char *str );


void PrintMessage(char *input, int numberOfBitsOfData, PlayerID sender)
{
  printf("%s\n",input);

  if (raknet.server.isServer())
  {
	 raknet.server.RPC("PrintMessage", input, numberOfBitsOfData, PacketPriority.HIGH_PRIORITY, PacketReliability.RELIABLE_ORDERED, 0, sender, true, false);
  }
}






module raknet.server;

import raknet.raknet; 


bool RPC(char *uniqueID, char *data, uint bitLength, PacketPriority priority, PacketReliability reliability, char orderingChannel, PlayerID playerId, bool broadcast, bool shiftTimestamp)
{        
   return rakServerInterface_RPC(uniqueID, data, bitLength, priority, reliability, orderingChannel, playerId, broadcast, shiftTimestamp);
}

bool start(ushort AllowedPlayers, uint connectionValidationInteger, int threadSleepTimer, ushort port)
{
   return rakServerInterface_Start(AllowedPlayers, connectionValidationInteger, threadSleepTimer, port);
}

void initialize()
{  
   rakServerInterface_Initialize();
}

bool isServer()
{
   return isRakServerInterface();
}

Packet* receivePacket()
{
   return rakServerInterface_ReceivePacket();
}

void deallocatePacket(Packet *p)
{
   rakServerInterface_DeallocatePacket(p);
}

void destroy()
{
   RakServerInterface_Destroy();
}

void disconnect( uint blockDuration )
{
   rakServerInterface_Disconnect(blockDuration);
}

bool sendBitstream(PacketPriority priority, PacketReliability reliability, char orderingChannel, 
                   PlayerID playerId, bool broadcast)
{
   return rakServerInterface_SendBitstream(priority, reliability, orderingChannel, playerId, broadcast);
}

int getIndexFromPlayerID(PlayerID pid)
{
   return rakServerInterface_GetIndexFromPlayerID(pid);
}

// will crash if not alias'd
alias rakServerInterface_REG_AS_RPC REG_AS_RPC;

extern(C):


private
{
// hide ugly function names
bool rakServerInterface_RPC(char *uniqueID, char *data, uint bitLength, PacketPriority priority, PacketReliability reliability, char orderingChannel, PlayerID playerId, bool broadcast, bool shiftTimestamp);
bool rakServerInterface_Start(ushort AllowedPlayers, uint connectionValidationInteger, int threadSleepTimer, ushort port);
void rakServerInterface_Initialize();
void rakServerInterface_REG_AS_RPC(char* uniqueID, void ( *functionName ) ( char *input, int numberOfBitsOfData, PlayerID sender )  );
bool isRakServerInterface();
Packet* rakServerInterface_ReceivePacket();
void rakServerInterface_DeallocatePacket(Packet *);
void RakServerInterface_Destroy();
bool rakServerInterface_SendBitstream(PacketPriority priority, PacketReliability reliability, char orderingChannel, PlayerID playerId, bool broadcast);
void rakServerInterface_Disconnect( uint blockDuration );
int rakServerInterface_GetIndexFromPlayerID(PlayerID pid);
}


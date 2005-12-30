
#include "rakserver.h" 


extern "C" {

RakServerInterface *rakServerInterface;

// external bitstream server can send
extern RakNet::BitStream *dataStream;

bool rakServerInterface_RPC(char *uniqueID, char *data, unsigned long bitLength, PacketPriority priority, PacketReliability reliability, char orderingChannel, PlayerID playerId, bool broadcast, bool shiftTimestamp)
{
   return rakServerInterface->RPC(uniqueID, data, bitLength, priority, reliability, orderingChannel, playerId, broadcast, shiftTimestamp);
}

bool rakServerInterface_Start(unsigned short AllowedPlayers, unsigned long connectionValidationInteger, int threadSleepTimer, unsigned short port)
{
   printf("%d %d %d %d\n", AllowedPlayers, connectionValidationInteger, threadSleepTimer, port);
   return rakServerInterface->Start(AllowedPlayers, connectionValidationInteger, threadSleepTimer, port);
}

void rakServerInterface_Initialize()
{
   rakServerInterface=RakNetworkFactory::GetRakServerInterface();
}

void rakServerInterface_REG_AS_RPC(char* uniqueID, void ( *functionName ) ( char *input, int numberOfBitsOfData, PlayerID sender ))
{
   rakServerInterface->RegisterAsRemoteProcedureCall(uniqueID, functionName);
}

// C interface to raknet
bool isRakServerInterface()
{
   if (rakServerInterface != NULL)
      return true;

   return false; 
}

Packet * rakServerInterface_ReceivePacket()
{
   return rakServerInterface->Receive();
}

void rakServerInterface_DeallocatePacket(Packet *p)
{
   rakServerInterface->DeallocatePacket(p);
}


void RakServerInterface_Destroy()
{  
   RakNetworkFactory::DestroyRakServerInterface(rakServerInterface);
}


bool rakServerInterface_SendBitstream(PacketPriority priority, PacketReliability reliability, char orderingChannel, PlayerID playerId, bool broadcast)
{
   return rakServerInterface->Send(dataStream, priority, reliability, orderingChannel, playerId, broadcast);
}

void rakServerInterface_Disconnect( unsigned blockDuration )
{
   rakServerInterface->Disconnect(blockDuration);
}

int rakServerInterface_GetIndexFromPlayerID(PlayerID pid)
{
   return rakServerInterface->GetIndexFromPlayerID(pid); 
}

}


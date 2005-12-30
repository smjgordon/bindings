
#include "rakclient.h" 

// Moved out of main - needs global scope

extern "C" {

RakClientInterface *rakClientInterface;

// external bitstream server can send
extern RakNet::BitStream *dataStream;

void rakClientInterface_DeallocatePacket(Packet *p)
{
   rakClientInterface->DeallocatePacket(p);
}

Packet* rakClientInterface_ReceivePacket()
{
   return rakClientInterface->Receive();
}

bool isRakClientInterface()
{
   if (rakClientInterface)
      return true;

   return false; 
}

void rakClientInterface_Initialize()
{
   rakClientInterface=RakNetworkFactory::GetRakClientInterface();
}


bool rakClientInterface_Connect(char *host, unsigned short serverPort, unsigned short clientPort, unsigned long connectionValidationInteger, int threadSleepTimer)
{
   return rakClientInterface->Connect(host, serverPort, clientPort, connectionValidationInteger, threadSleepTimer);
}

bool rakClientInterface_RPC(char *uniqueID, char *data, unsigned long bitLength, PacketPriority priority, PacketReliability reliability, char orderingChannel, bool shiftTimestamp)
{
   return rakClientInterface->RPC(uniqueID, data, bitLength, priority, reliability, orderingChannel, shiftTimestamp);
}


void RakClientInterface_Destroy()
{
   RakNetworkFactory::DestroyRakClientInterface(rakClientInterface);
}

void rakClientInterface_REG_AS_RPC(char* uniqueID, void ( *functionName ) ( char *input, int numberOfBitsOfData, PlayerID sender ))
{
   rakClientInterface->RegisterAsRemoteProcedureCall(uniqueID, functionName);
}

void rakClientInterface_Disconnect (unsigned blockDuration)
{
   rakClientInterface->Disconnect(blockDuration); 
}

bool rakClientInterface_SendBitstream(PacketPriority priority, PacketReliability reliability, char orderingChannel)
{
   return rakClientInterface->Send(dataStream, priority, reliability, orderingChannel);
}

PlayerID  rakClientInterface_GetPlayerID()
{
   return rakClientInterface->GetPlayerID(); 
}


}


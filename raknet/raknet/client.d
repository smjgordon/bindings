
module raknet.client;

import raknet.raknet; 


bool isClient()
{
   return isRakClientInterface();
}

void initialize()
{
   rakClientInterface_Initialize();
}

bool connect(char *host, ushort serverPort, ushort clientPort, uint connectionValidationInteger, int threadSleepTimer)
{
   return rakClientInterface_Connect(host, serverPort, clientPort, connectionValidationInteger, threadSleepTimer);
}

bool RPC(char *uniqueID, char *data, uint bitLength, PacketPriority priority, PacketReliability reliability, char orderingChannel, bool shiftTimestamp)
{
   return rakClientInterface_RPC(uniqueID, data, bitLength, priority, reliability, orderingChannel, shiftTimestamp);
}

void deallocatePacket(Packet *p)
{
   rakClientInterface_DeallocatePacket(p);
}

void destroy()
{
   RakClientInterface_Destroy();
}

Packet* receivePacket()
{
   return rakClientInterface_ReceivePacket();
}

void disconnect (uint blockDuration)
{
   rakClientInterface_Disconnect(blockDuration); 
}

void sendBitstream(PacketPriority priority, PacketReliability reliability, char orderingChannel)
{
   rakClientInterface_SendBitstream(priority, reliability, orderingChannel);
}

PlayerID playerID() 
{
   return rakClientInterface_GetPlayerID();
}

// will crash if not alias'd
alias rakClientInterface_REG_AS_RPC REG_AS_RPC;


extern(C):

//  ugly names
private {
bool isRakClientInterface();

void rakClientInterface_Initialize();

bool rakClientInterface_Connect(char *host, ushort serverPort, ushort clientPort, uint connectionValidationInteger, int threadSleepTimer);

bool rakClientInterface_RPC(char *uniqueID, char *data, uint bitLength, PacketPriority priority, PacketReliability reliability, char orderingChannel, bool shiftTimestamp);

void rakClientInterface_DeallocatePacket(Packet *);

void RakClientInterface_Destroy();

Packet* rakClientInterface_ReceivePacket();

void rakClientInterface_REG_AS_RPC(char* uniqueID, void ( *functionName ) ( char *input, int numberOfBitsOfData, PlayerID sender ));

void rakClientInterface_Disconnect (uint blockDuration);

void rakClientInterface_SendBitstream(PacketPriority priority, PacketReliability reliability, char orderingChannel);

PlayerID  rakClientInterface_GetPlayerID(); 
}

